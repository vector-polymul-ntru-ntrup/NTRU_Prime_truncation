#ifndef RING_H
#define RING_H

#include <stdint.h>
#include <stddef.h>

#include "tools.h"

extern int16_t mod;

void memberZ(void *des, const void *src);
void addZ(void *des, const void *src1, const void *src2);
void subZ(void *des, const void *src1, const void *src2);
void mulZ(void *des, const void *src1, const void *src2);
void expZ(void *des, const void *src, const size_t e);

extern struct ring coeff_ring;

void getExpVec(int16_t *des, int16_t w, size_t len);
void DFT(int16_t *des, int16_t *src, int16_t *w_exp, size_t len, size_t jump);

// len must be a prime
void DFT_primitive(int16_t *des, int16_t *src, int16_t *w_exp, size_t len);


#endif

