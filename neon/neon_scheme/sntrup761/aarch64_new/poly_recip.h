#ifndef POLY_RECIP_H
#define POLY_RECIP_H

#include <arm_neon.h>

#include "poly_type.h"

#include "poly_recip.h"
#include "params.h"

Fq Fq_recip(Fq a1);

/* returns 0 if recip succeeded; else -1 */
int R3_recip(small *out,const small *in);

extern void __asm_mul_f0g0(int16_t*, int16_t*, int32_t, int16_t);
/* out = 1/(3*in) in Rq */
/* returns 0 if recip succeeded; else -1 */
int Rq_recip3(Fq *out,const small *in);


#endif







