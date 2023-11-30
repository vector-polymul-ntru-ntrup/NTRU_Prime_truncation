
#include <stdio.h>
#include <arm_neon.h>

#include "poly_type.h"
#include "poly_arith.h"
#include "poly_mulmod.h"

#include "polymul/NTT_params.h"
#include "polymul/polymul.h"


/* R3_fromR(R_fromRq(r)) */
void R3_fromRq(small *out,const Fq *r)
{

    for(size_t i = 0; i < 768; i += 16){
        vst1q_s8(out + i, F3_freezex16(vld1q_s16(r + i + 0 * 8), vld1q_s16(r + i + 1 * 8)));
    }

}

/* h = f*g in the ring Rq */
void Rq_mult_small(Fq *h, Fq *f, small *g)
{

  int16_t poly2[POLY_N];

  size_t i;

  for(i = 0; i < p; i++){
    poly2[i] = g[i];
  }
  for(; i < POLY_N; i++){
    f[i] = poly2[i] = 0;
  }
  polymul(h, f, poly2);

}

/* h = f*g in the ring R3 */
void R3_mult(small *h, small *f, small *g)
{

    Fq h_16[POLY_N];
    Fq f_16[POLY_N];

    for(size_t i = 0; i < p; i++){
        f_16[i] = f[i];
    }
    Rq_mult_small(h_16, f_16, g);

    for(size_t i = 0; i < 768; i += 16){
        vst1q_s8(h + i, F3_freezex16(vld1q_s16(h_16 + i + 0 * 8), vld1q_s16(h_16 + i + 1 * 8)));
    }

}
/* h = 3f in Rq */
void Rq_mult3(Fq *h, Fq *f)
{

    for(size_t i = 0; i < 768; i += 8){
        vst1q_s16(h + i, Fq_freeze_shortx8(vmulq_n_s16(vld1q_s16(f + i), 3)));
    }

}

void Round(Fq *out,const Fq *a)
{

    int16x8_t t;

    for(size_t i = 0; i < 768; i += 8){
        t = vld1q_s16(a + i);
        vst1q_s16(out + i, t - F3_freeze_int16x8_x8(t));
    }

}



