
#include <stddef.h>

#include "poly_recip.h"
#include "params.h"
#include "poly_mulmod.h"
#include "poly_mask.h"


// signed Z3
static inline void mul_Z3_bitsliced(uint64_t *ptr_clo, uint64_t *ptr_chi,
    uint64_t *ptr_alo, uint64_t *ptr_ahi, uint64_t *ptr_blo, uint64_t *ptr_bhi){

    uint64_t alo, ahi;
    uint64_t blo, bhi;
    uint64_t nonzero;

    alo = *ptr_alo;
    ahi = *ptr_ahi;
    blo = *ptr_blo;
    bhi = *ptr_bhi;

    nonzero = blo | bhi;

    *ptr_clo = alo & nonzero;
    *ptr_chi = (ahi ^ (bhi & alo)) & nonzero;

}

static inline void mul_Z3_bitsliced_uint8x16(uint8x16_t *ptr_clo, uint8x16_t *ptr_chi,
    uint8x16_t *ptr_alo, uint8x16_t *ptr_ahi, uint8x16_t *ptr_blo, uint8x16_t *ptr_bhi){

    uint8x16_t alo, ahi;
    uint8x16_t blo, bhi;
    uint8x16_t nonzero;

    alo = *ptr_alo;
    ahi = *ptr_ahi;
    blo = *ptr_blo;
    bhi = *ptr_bhi;

    nonzero = blo | bhi;

    *ptr_clo = alo & nonzero;
    *ptr_chi = (ahi ^ (bhi & alo)) & nonzero;

}

// signed Z3
static inline void add_Z3_bitsliced(uint64_t *ptr_clo, uint64_t *ptr_chi,
    uint64_t *ptr_alo, uint64_t *ptr_ahi, uint64_t *ptr_blo, uint64_t *ptr_bhi){

    uint64_t alo, ahi;
    uint64_t blo, bhi;
    uint64_t t0, t1, t2, t3;

    alo = *ptr_alo;
    ahi = *ptr_ahi;
    blo = *ptr_blo;
    bhi = *ptr_bhi;

    t0 = (~alo) & (~ahi) & (blo);
    t1 = (alo) & (~bhi);
    t2 = t1 & (~ahi);
    t3 = t1 & (ahi) & (~blo);

    *ptr_clo = (t0) |
               (t2) |
               (t3) |
               ((alo) & (ahi) & (blo) & (bhi));

    *ptr_chi = (t3) | (t2 & (blo)) | (t0 & (bhi));

}

static inline void add_Z3_bitsliced_uint8x16(uint8x16_t *ptr_clo, uint8x16_t *ptr_chi,
    uint8x16_t *ptr_alo, uint8x16_t *ptr_ahi, uint8x16_t *ptr_blo, uint8x16_t *ptr_bhi){

    uint8x16_t alo, ahi;
    uint8x16_t blo, bhi;
    uint8x16_t t0, t1, t2, t3;

    alo = *ptr_alo;
    ahi = *ptr_ahi;
    blo = *ptr_blo;
    bhi = *ptr_bhi;

    t0 = (~alo) & (~ahi) & (blo);
    t1 = (alo) & (~bhi);
    t2 = t1 & (~ahi);
    t3 = t1 & (ahi) & (~blo);

    *ptr_clo = (t0) |
               (t2) |
               (t3) |
               ((alo) & (ahi) & (blo) & (bhi));

    *ptr_chi = (t3) | (t2 & (blo)) | (t0 & (bhi));

}

Fq Fq_recip(Fq a1)
{
  int i = 1;
  Fq ai = a1;

  while (i < q-2) {
    ai = Fq_freeze(a1*(int32)ai);
    i += 1;
  }
  return ai;
}

/* returns 0 if recip succeeded; else -1 */
int R3_recip(small *out,const small *in)
{

    uint64_t flo[12], fhi[12];
    uint64_t glo[12], ghi[12];
    uint64_t vlo[12], vhi[12];
    uint64_t rlo[12], rhi[12];

    small g[768];
    small v[768];

    uint64_t swapx64;
    uint64_t t0x64, t1x64;
    uint64_t tlo, thi;
    uint64_t signlo, signhi;

    uint8x16_t swapx128;
    uint8x16_t tlol, thil;
    uint8x16_t signlol, signhil;
    uint8x16_t t0x128, t1x128;

    size_t i, loop, offset;
    int16_t delta;
    int16_t swap;
    int8_t sign;
    int8_t f0, g0;

    uint8x16_t *flol, *fhil;
    uint8x16_t *glol, *ghil;
    uint8x16_t *vlol, *vhil;
    uint8x16_t *rlol, *rhil;

    flol = (uint8x16_t*)flo;
    fhil = (uint8x16_t*)fhi;
    glol = (uint8x16_t*)glo;
    ghil = (uint8x16_t*)ghi;
    vlol = (uint8x16_t*)vlo;
    vhil = (uint8x16_t*)vhi;
    rlol = (uint8x16_t*)rlo;
    rhil = (uint8x16_t*)rhi;

    for(i = 0; i < 12; i++){
        flo[i] = 0;
        fhi[i] = 0;
        glo[i] = 0;
        ghi[i] = 0;
        vlo[i] = 0;
        vhi[i] = 0;
        rlo[i] = 0;
        rhi[i] = 0;
    }
    rlo[0] = 1;
    flo[0] = 1;
    flo[0] = 1;
    flo[11] = 0x300000000000000;
    fhi[11] = 0x300000000000000;

    for (i = 0;i < p;++i) {
        g[p-1-i] = in[i];
    }
    g[p] = 0;

    for(i = 0; i < p; i++){
        glo[i / 64] |= (((uint64_t)(g[i] & 1)) >> 0) << (i % 64);
        ghi[i / 64] |= (((uint64_t)(g[i] & 2)) >> 1) << (i % 64);
    }

    delta = 1;

    for (loop = 0;loop < 2 * p - 1; ++loop) {

        for(i = 11; i > 0; i--){
            vlo[i] = (vlo[i] << 1) | (vlo[i - 1] >> 63);
            vhi[i] = (vhi[i] << 1) | (vhi[i - 1] >> 63);
        }
        vlo[0] <<= 1;
        vhi[0] <<= 1;

        g0 = (glo[0] & 1) | (-(int8_t)(ghi[0] & 1));
        f0 = (flo[0] & 1) | (-(int8_t)(fhi[0] & 1));

        sign = -g0*f0;
        swap = -(int16_t)( (((uint16_t)(-delta)) >> 15) & g0 & 1);
        delta ^= swap & (delta ^ -delta);
        delta += 1;

        signlo = (uint64_t)(-((int64_t)((sign & 1) >> 0)));
        signhi = (uint64_t)(-((int64_t)((sign & 2) >> 1)));
        swapx64 = (uint64_t)((int64_t)swap);
        signlol = (uint8x16_t)vdupq_n_s16(-((sign & 1) >> 0));
        signhil = (uint8x16_t)vdupq_n_s16(-((sign & 2) >> 1));
        swapx128 = (uint8x16_t)vdupq_n_s16(swap);

        offset = 0;
        t0x128 = swapx128 & (flol[offset] ^ glol[offset]);
        t1x128 = swapx128 & (vlol[offset] ^ rlol[offset]);
        flol[offset] ^= t0x128;
        glol[offset] ^= t0x128;
        vlol[offset] ^= t1x128;
        rlol[offset] ^= t1x128;
        t0x128 = swapx128 & (fhil[offset] ^ ghil[offset]);
        t1x128 = swapx128 & (vhil[offset] ^ rhil[offset]);
        fhil[offset] ^= t0x128;
        ghil[offset] ^= t0x128;
        vhil[offset] ^= t1x128;
        rhil[offset] ^= t1x128;
        mul_Z3_bitsliced_uint8x16(&tlol, &thil, &signlol, &signhil, flol + offset, fhil + offset);
        add_Z3_bitsliced_uint8x16(glol + offset, ghil + offset, glol + offset, ghil + offset, &tlol, &thil);
        mul_Z3_bitsliced_uint8x16(&tlol, &thil, &signlol, &signhil, vlol + offset, vhil + offset);
        add_Z3_bitsliced_uint8x16(rlol + offset, rhil + offset, rlol + offset, rhil + offset, &tlol, &thil);

        offset = 6;
        t0x64 = swapx64 & (flo[offset] ^ glo[offset]);
        t1x64 = swapx64 & (vlo[offset] ^ rlo[offset]);
        flo[offset] ^= t0x64;
        glo[offset] ^= t0x64;
        vlo[offset] ^= t1x64;
        rlo[offset] ^= t1x64;
        t0x64 = swapx64 & (fhi[offset] ^ ghi[offset]);
        t1x64 = swapx64 & (vhi[offset] ^ rhi[offset]);
        fhi[offset] ^= t0x64;
        ghi[offset] ^= t0x64;
        vhi[offset] ^= t1x64;
        rhi[offset] ^= t1x64;
        mul_Z3_bitsliced(&tlo, &thi, &signlo, &signhi, flo + offset, fhi + offset);
        add_Z3_bitsliced(glo + offset, ghi + offset, glo + offset, ghi + offset, &tlo, &thi);
        mul_Z3_bitsliced(&tlo, &thi, &signlo, &signhi, vlo + offset, vhi + offset);
        add_Z3_bitsliced(rlo + offset, rhi + offset, rlo + offset, rhi + offset, &tlo, &thi);
        offset = 7;
        t0x64 = swapx64 & (flo[offset] ^ glo[offset]);
        t1x64 = swapx64 & (vlo[offset] ^ rlo[offset]);
        flo[offset] ^= t0x64;
        glo[offset] ^= t0x64;
        vlo[offset] ^= t1x64;
        rlo[offset] ^= t1x64;
        t0x64 = swapx64 & (fhi[offset] ^ ghi[offset]);
        t1x64 = swapx64 & (vhi[offset] ^ rhi[offset]);
        fhi[offset] ^= t0x64;
        ghi[offset] ^= t0x64;
        vhi[offset] ^= t1x64;
        rhi[offset] ^= t1x64;
        mul_Z3_bitsliced(&tlo, &thi, &signlo, &signhi, flo + offset, fhi + offset);
        add_Z3_bitsliced(glo + offset, ghi + offset, glo + offset, ghi + offset, &tlo, &thi);
        mul_Z3_bitsliced(&tlo, &thi, &signlo, &signhi, vlo + offset, vhi + offset);
        add_Z3_bitsliced(rlo + offset, rhi + offset, rlo + offset, rhi + offset, &tlo, &thi);

        offset = 1;
        t0x128 = swapx128 & (flol[offset] ^ glol[offset]);
        t1x128 = swapx128 & (vlol[offset] ^ rlol[offset]);
        flol[offset] ^= t0x128;
        glol[offset] ^= t0x128;
        vlol[offset] ^= t1x128;
        rlol[offset] ^= t1x128;
        t0x128 = swapx128 & (fhil[offset] ^ ghil[offset]);
        t1x128 = swapx128 & (vhil[offset] ^ rhil[offset]);
        fhil[offset] ^= t0x128;
        ghil[offset] ^= t0x128;
        vhil[offset] ^= t1x128;
        rhil[offset] ^= t1x128;
        mul_Z3_bitsliced_uint8x16(&tlol, &thil, &signlol, &signhil, flol + offset, fhil + offset);
        add_Z3_bitsliced_uint8x16(glol + offset, ghil + offset, glol + offset, ghil + offset, &tlol, &thil);
        mul_Z3_bitsliced_uint8x16(&tlol, &thil, &signlol, &signhil, vlol + offset, vhil + offset);
        add_Z3_bitsliced_uint8x16(rlol + offset, rhil + offset, rlol + offset, rhil + offset, &tlol, &thil);

        offset = 8;
        t0x64 = swapx64 & (flo[offset] ^ glo[offset]);
        t1x64 = swapx64 & (vlo[offset] ^ rlo[offset]);
        flo[offset] ^= t0x64;
        glo[offset] ^= t0x64;
        vlo[offset] ^= t1x64;
        rlo[offset] ^= t1x64;
        t0x64 = swapx64 & (fhi[offset] ^ ghi[offset]);
        t1x64 = swapx64 & (vhi[offset] ^ rhi[offset]);
        fhi[offset] ^= t0x64;
        ghi[offset] ^= t0x64;
        vhi[offset] ^= t1x64;
        rhi[offset] ^= t1x64;
        mul_Z3_bitsliced(&tlo, &thi, &signlo, &signhi, flo + offset, fhi + offset);
        add_Z3_bitsliced(glo + offset, ghi + offset, glo + offset, ghi + offset, &tlo, &thi);
        mul_Z3_bitsliced(&tlo, &thi, &signlo, &signhi, vlo + offset, vhi + offset);
        add_Z3_bitsliced(rlo + offset, rhi + offset, rlo + offset, rhi + offset, &tlo, &thi);
        offset = 9;
        t0x64 = swapx64 & (flo[offset] ^ glo[offset]);
        t1x64 = swapx64 & (vlo[offset] ^ rlo[offset]);
        flo[offset] ^= t0x64;
        glo[offset] ^= t0x64;
        vlo[offset] ^= t1x64;
        rlo[offset] ^= t1x64;
        t0x64 = swapx64 & (fhi[offset] ^ ghi[offset]);
        t1x64 = swapx64 & (vhi[offset] ^ rhi[offset]);
        fhi[offset] ^= t0x64;
        ghi[offset] ^= t0x64;
        vhi[offset] ^= t1x64;
        rhi[offset] ^= t1x64;
        mul_Z3_bitsliced(&tlo, &thi, &signlo, &signhi, flo + offset, fhi + offset);
        add_Z3_bitsliced(glo + offset, ghi + offset, glo + offset, ghi + offset, &tlo, &thi);
        mul_Z3_bitsliced(&tlo, &thi, &signlo, &signhi, vlo + offset, vhi + offset);
        add_Z3_bitsliced(rlo + offset, rhi + offset, rlo + offset, rhi + offset, &tlo, &thi);

        offset = 2;
        t0x128 = swapx128 & (flol[offset] ^ glol[offset]);
        t1x128 = swapx128 & (vlol[offset] ^ rlol[offset]);
        flol[offset] ^= t0x128;
        glol[offset] ^= t0x128;
        vlol[offset] ^= t1x128;
        rlol[offset] ^= t1x128;
        t0x128 = swapx128 & (fhil[offset] ^ ghil[offset]);
        t1x128 = swapx128 & (vhil[offset] ^ rhil[offset]);
        fhil[offset] ^= t0x128;
        ghil[offset] ^= t0x128;
        vhil[offset] ^= t1x128;
        rhil[offset] ^= t1x128;
        mul_Z3_bitsliced_uint8x16(&tlol, &thil, &signlol, &signhil, flol + offset, fhil + offset);
        add_Z3_bitsliced_uint8x16(glol + offset, ghil + offset, glol + offset, ghil + offset, &tlol, &thil);
        mul_Z3_bitsliced_uint8x16(&tlol, &thil, &signlol, &signhil, vlol + offset, vhil + offset);
        add_Z3_bitsliced_uint8x16(rlol + offset, rhil + offset, rlol + offset, rhil + offset, &tlol, &thil);

        offset = 10;
        t0x64 = swapx64 & (flo[offset] ^ glo[offset]);
        t1x64 = swapx64 & (vlo[offset] ^ rlo[offset]);
        flo[offset] ^= t0x64;
        glo[offset] ^= t0x64;
        vlo[offset] ^= t1x64;
        rlo[offset] ^= t1x64;
        t0x64 = swapx64 & (fhi[offset] ^ ghi[offset]);
        t1x64 = swapx64 & (vhi[offset] ^ rhi[offset]);
        fhi[offset] ^= t0x64;
        ghi[offset] ^= t0x64;
        vhi[offset] ^= t1x64;
        rhi[offset] ^= t1x64;
        mul_Z3_bitsliced(&tlo, &thi, &signlo, &signhi, flo + offset, fhi + offset);
        add_Z3_bitsliced(glo + offset, ghi + offset, glo + offset, ghi + offset, &tlo, &thi);
        mul_Z3_bitsliced(&tlo, &thi, &signlo, &signhi, vlo + offset, vhi + offset);
        add_Z3_bitsliced(rlo + offset, rhi + offset, rlo + offset, rhi + offset, &tlo, &thi);
        offset = 11;
        t0x64 = swapx64 & (flo[offset] ^ glo[offset]);
        t1x64 = swapx64 & (vlo[offset] ^ rlo[offset]);
        flo[offset] ^= t0x64;
        glo[offset] ^= t0x64;
        vlo[offset] ^= t1x64;
        rlo[offset] ^= t1x64;
        t0x64 = swapx64 & (fhi[offset] ^ ghi[offset]);
        t1x64 = swapx64 & (vhi[offset] ^ rhi[offset]);
        fhi[offset] ^= t0x64;
        ghi[offset] ^= t0x64;
        vhi[offset] ^= t1x64;
        rhi[offset] ^= t1x64;
        mul_Z3_bitsliced(&tlo, &thi, &signlo, &signhi, flo + offset, fhi + offset);
        add_Z3_bitsliced(glo + offset, ghi + offset, glo + offset, ghi + offset, &tlo, &thi);
        mul_Z3_bitsliced(&tlo, &thi, &signlo, &signhi, vlo + offset, vhi + offset);
        add_Z3_bitsliced(rlo + offset, rhi + offset, rlo + offset, rhi + offset, &tlo, &thi);

        for(i = 0; i < 11; i++){
            glo[i] = (glo[i] >> 1) | (glo[i + 1] << 63);
            ghi[i] = (ghi[i] >> 1) | (ghi[i + 1] << 63);
        }
        glo[11] >>= 1;
        ghi[11] >>= 1;
    }

    for(i = 0; i < p; i++){
      v[i] = ((vlo[i / 64] >> (i % 64)) & 1) | (-(int64_t)((vhi[i / 64] >> (i % 64)) & 1));
    }

    sign = (flo[0] & 1) | (-(int8_t)(fhi[0] & 1));
    for (i = 0;i < p;++i)
        out[i] = sign*v[p-1-i];

    return int16_nonzero_mask(delta);
}

/* out = 1/(3*in) in Rq */
/* returns 0 if recip succeeded; else -1 */
int Rq_recip3(Fq *out,const small *in)
{
  Fq f[768];
  Fq g[768];
  Fq v[768];
  Fq r[768];
  int i,loop,delta;
  int16_t swap, t;
  int16_t f0, g0;
  Fq scale;

  for (i = 0;i < p+1;++i)
    v[i] = 0;
  for (i = 0;i < p+1;++i)
    r[i] = 0;
  r[0] = -1530;
  for (i = 0;i < p;++i)
    f[i] = 0;
  f[0] = 1; f[p-1] = f[p] = -1;
  for (i = 0;i < p;++i)
    g[p-1-i] = in[i];
  g[p] = 0;

  delta = 1;

  for (loop = 0;loop < 2*p-1;++loop) {
    for (i = p;i > 0;--i)
      v[i] = v[i-1];
    v[0] = 0;

    swap = (int16_t)(int16_negative_mask(-delta) & int16_nonzero_mask(g[0]));
    delta ^= swap & (delta ^ -delta);
    delta += 1;

    f0 = f[0];
    g0 = g[0];
    t = swap & (f0 ^ g0);
    f0 ^= t;
    g0 ^= t;
    __asm_mul_f0g0(g, f, (int32_t)((g0 << 16) | (f0 & 0xffff)), swap);
    __asm_mul_f0g0(r, v, (int32_t)((g0 << 16) | (f0 & 0xffff)), swap);

    for(i = 0; i < p; i++){
      g[i] = g[i+1];
    }
    g[p] = 0;
  }

  scale = Fq_recip(f[0]);
  for(i = 0; i < p; i++){
    out[i] = Fq_freeze(scale * (int32) v[p - 1 - i]);
  }
  for(; i < p; i++){
    out[i] = Fq_freeze(scale * (int32) v[p - 1 - i]);
  }

  return int16_nonzero_mask(delta);
}













