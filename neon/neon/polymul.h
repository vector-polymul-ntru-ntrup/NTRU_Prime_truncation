#ifndef POLYMUL_H
#define POLYMUL_H

#include <stdint.h>
#include <stddef.h>

#include "NTT_params.h"

extern
void __asm_3x2_twistx2(int16_t*, int16_t*, int16_t*, int16_t*);

extern
void __asm_3x2_post_twist(int16_t*, int16_t*, int16_t*, int16_t*);

extern
void __asm_rader17_primitive(int16_t*, int16_t*, int16_t*, int16_t*);

extern
void __asm_irader17_primitive(int16_t*, int16_t*, int16_t*, int16_t*);


extern
int16_t _3x2_twiddle[8];

extern
int16_t _3x2_itwiddle[8];

extern
int16_t twiddle_rader17_permuted[16];

extern
int16_t twiddle_irader17_permuted[16];

extern
int16_t twist_table_lohi[2 * 16 * 96];

extern
int16_t twist_inv_table_lohi[2 * 16 * 96];

extern
int16_t twist_16x6x16_table_lohi[2 * 16 * 6 * 16];

extern
int16_t twist_16x6x16_inv_table_lohi[2 * 16 * 6 * 16];

void mulcore(int16_t *des, int16_t *src1, int16_t *src2);
void polymul(int16_t *des, int16_t *src1, int16_t *src2);


#endif

