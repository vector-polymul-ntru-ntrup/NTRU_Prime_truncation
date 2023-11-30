
#include "poly_mask.h"
#include "params.h"
#include "poly_type.h"

/* ----- small polynomials */

/* 0 if Weightw_is(r), else -1 */
int Weightw_mask(small *r)
{
  int weight = 0;
  int i;

  for (i = 0;i < p;++i) weight += r[i]&1;
  return int16_nonzero_mask(weight-w);
}




