
#include "poly_mulmod.h"

#include "params.h"

/* ----- arithmetic mod 3 */
/* F3 is always represented as -1,0,1 */
/* so ZZ_fromF3 is a no-op */
/* x must not be close to top int16 */
small F3_freeze(int16_t x)
{

    int32_t t;
    t = (int32_t)x * 21845;
    t = (t + (1LL << 15)) >> 16;
    return x - (int16_t)t * 3;
}

int8x16_t F3_freezex16(int16x8_t x0, int16x8_t x1){

    int16x8_t t0, t1;

    t0 = vqrdmulhq_n_s16(x0, 10923);
    t0 = vmlsq_n_s16(x0, t0, 3);

    t1 = vqrdmulhq_n_s16(x1, 10923);
    t1 = vmlsq_n_s16(x1, t1, 3);

    return vuzp1q_s8((int8x16_t)t0, (int8x16_t)t1);

}

int16x8_t F3_freeze_int16x8_x8(int16x8_t x){

    int16x8_t t;

    t = vqrdmulhq_n_s16(x, 10923);
    t = vmlsq_n_s16(x, t, 3);

    return t;

}

/* ----- arithmetic mod q */

Fq Fq_freeze(int32_t x)
{

    int64_t t;
    t = (int64_t)x * 935519;
    t = (t + (1LL << 31)) >> 32;

    return x - (int32_t)t * q;

}

int16x8_t Fq_freeze_shortx8(int16x8_t x){

  int16x8_t hi;
  hi = vqdmulhq_n_s16(x, 29235);
  hi = vrshrq_n_s16(hi, 12);
  return vmlsq_n_s16(x, hi, q);

}








