#ifndef POLY_ARITH_H
#define POLY_ARITH_H

#include "params.h"
#include "poly_type.h"

void R3_fromRq(small *out,const Fq *r);

/* h = f*g in the ring R3 */
void R3_mult(small *h, small *f, small *g);

/* h = f*g in the ring Rq */
void Rq_mult_small(Fq *h, Fq *f, small *g);
void Rq_mult_ref(Fq *h, Fq *f, small *g);

/* h = 3f in Rq */
void Rq_mult3(Fq *h, Fq *f);

void Round(Fq *out,const Fq *a);

#endif

