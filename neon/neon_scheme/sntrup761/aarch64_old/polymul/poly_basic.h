#ifndef POLY_BASIC_H
#define POLY_BASIC_H


#include <stdint.h>
#include <stddef.h>

#include <arm_neon.h>

extern int16_t sqrt_table[8192];
extern int16_t inv_table[8192];


void setup_sqrt_table(void);
void setup_inv_table(void);


int16_t cmod_int16(int16_t v);
int32_t cmod_int32(int32_t v);
int16_t mulmod_int16(int16_t a, int16_t b);

void schoolbook_core(int16_t *des, int16_t *src1, int16_t *src2, size_t len);
void weighted(int16_t *des, int16_t *src1, int16_t *src2, int16_t zeta, size_t len);
void cyclic(int16_t *des, int16_t *src1, int16_t *src2, size_t len);
void negacyclic(int16_t *des, int16_t *src1, int16_t *src2, size_t len);




#endif


