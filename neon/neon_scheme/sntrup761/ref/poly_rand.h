#ifndef POLY_RAND_H
#define POLY_RAND_H

#include "poly_type.h"

/* ----- sorting to generate short polynomial */

void Short_fromlist(small *out,const uint32 *in);

/* ----- higher-level randomness */

uint32 urandom32(void);
void Short_random(small *out);
void Small_random(small *out);


#endif

