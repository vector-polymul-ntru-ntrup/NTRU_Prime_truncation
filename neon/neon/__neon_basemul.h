#ifndef __NEON_BASEMUL_H
#define __NEON_BASEMUL_H

#include <stdint.h>
#include <stddef.h>

extern
int16_t const_buff[8];

extern
void __asm_cyclic_Toeplitz16_doubling_full(int16_t*, int16_t*, int16_t*, int16_t*);

extern
void __asm_negacyclic_Toeplitz16_doubling_full(int16_t*, int16_t*, int16_t*, int16_t*);

#endif

