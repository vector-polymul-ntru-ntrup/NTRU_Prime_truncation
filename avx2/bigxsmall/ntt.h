#ifndef ntt_H
#define ntt_H

#include <stdint.h>

extern void ntt512_7681(int16_t *,int);
extern void ntt512_10753(int16_t *,int);
extern void invntt512_7681(int16_t *,int);
extern void invntt512_10753(int16_t *,int);

#endif
