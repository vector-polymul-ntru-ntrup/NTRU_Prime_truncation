#ifndef POLY_MASK_H
#define POLY_MASK_H

#include "poly_type.h"

/* return -1 if x!=0; else return 0 */
inline int int16_nonzero_mask(int16 x)
{
  uint16 u = x; /* 0, else 1...65535 */
  uint32 v = u; /* 0, else 1...65535 */
  v = -v; /* 0, else 2^32-65535...2^32-1 */
  v >>= 31; /* 0, else 1 */
  return -v; /* 0, else -1 */
}

/* return -1 if x<0; otherwise return 0 */
inline int int16_negative_mask(int16 x)
{
  uint16 u = x;
  u >>= 15;
  return -(int) u;
  /* alternative with gcc -fwrapv: */
  /* x>>15 compiles to CPU's arithmetic right shift */
}
/* ----- small polynomials */

/* 0 if Weightw_is(r), else -1 */
int Weightw_mask(small *r);

#endif

