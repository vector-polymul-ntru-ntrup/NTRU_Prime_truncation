#ifndef POLY_MULMOD_H
#define POLY_MULMOD_H

#include <arm_neon.h>

#include "poly_type.h"

/* F3 is always represented as -1,0,1 */
/* so ZZ_fromF3 is a no-op */
/* x must not be close to top int16 */
small F3_freeze(int16_t x);
int8x16_t F3_freezex16(int16x8_t x0, int16x8_t x1);
int16x8_t F3_freeze_int16x8_x8(int16x8_t x);

/* ----- arithmetic mod q */

/* always represented as -q12...q12 */
/* so ZZ_fromFq is a no-op */
/* x must not be close to top int32 */
Fq Fq_freeze(int32_t x);

int16x8_t Fq_freeze_shortx8(int16x8_t x);






#endif




