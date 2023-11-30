#ifndef POLY_ARITH_H
#define POLY_ARITH_H

#include "params.h"
#include "poly_type.h"

/* return -1 if x!=0; else return 0 */
int int16_nonzero_mask(int16 x);

/* return -1 if x<0; otherwise return 0 */
int int16_negative_mask(int16 x);

/* 0 if Weightw_is(r), else -1 */
int Weightw_mask(small *r);


/* F3 is always represented as -1,0,1 */
/* so ZZ_fromF3 is a no-op */
/* x must not be close to top int16 */
small F3_freeze(int16 x);

/* always represented as -q12...q12 */
/* so ZZ_fromFq is a no-op */
/* x must not be close to top int32 */
Fq Fq_freeze(int32 x);

Fq Fq_recip(Fq a1);

void R3_fromRq(small *out,const Fq *r);

/* h = f*g in the ring R3 */
void R3_mult(small *h, small *f, small *g);

/* returns 0 if recip succeeded; else -1 */
int R3_recip(small *out,const small *in);

/* h = f*g in the ring Rq */
void Rq_mult_small(Fq *h, Fq *f, small *g);

/* h = 3f in Rq */
void Rq_mult3(Fq *h, Fq *f);

/* out = 1/(3*in) in Rq */
/* returns 0 if recip succeeded; else -1 */
int Rq_recip3(Fq *out,const small *in);

void Round(Fq *out,const Fq *a);

#endif

