#ifndef __AVX2_H
#define __AVX2_H

#include "params.h"
#include "NTT_params.h"

#define twist_transpose_pre NAME(twist_transpose_pre)
#define twist_transpose_post NAME(twist_transpose_post)

#define __asm_3x2 NAME(__asm_3x2)
#define ___asm_3x2 NAME(___asm_3x2)
#define __asm_3x2_pre NAME(__asm_3x2_pre)
#define ___asm_3x2_pre NAME(___asm_3x2_pre)
#define __asm_3x2_post NAME(__asm_3x2_post)
#define ___asm_3x2_post NAME(___asm_3x2_post)

#define __asm_cyclic_FFT16 NAME(__asm_cyclic_FFT16)
#define ___asm_cyclic_FFT16 NAME(___asm_cyclic_FFT16)
#define __asm_cyclic_FFT16_precompute NAME(__asm_cyclic_FFT16_precompute)
#define ___asm_cyclic_FFT16_precompute NAME(___asm_cyclic_FFT16_precompute)
#define __asm_negacyclic_FFT16 NAME(__asm_negacyclic_FFT16)
#define ___asm_negacyclic_FFT16 NAME(___asm_negacyclic_FFT16)

#define __asm_rader17_truncated NAME(__asm_rader17_truncated)
#define ___asm_rader17_truncated NAME(___asm_rader17_truncated)
#define __asm_irader17_truncated NAME(__asm_irader17_truncated)
#define ___asm_irader17_truncated NAME(___asm_irader17_truncated)

#define mulcore NAME(mulcore)
#define polymul NAME(polymul)

void twist_transpose_pre(int16_t out[16][16], const int16_t in[31][16], int16_t *twist_table);
void twist_transpose_post(int16_t out[31][16], const int16_t in[16][16], int16_t *twist_table);

extern
void __asm_3x2(int16_t*, int16_t*, int16_t*);

extern
void __asm_3x2_pre(int16_t*, int16_t*, int16_t*, int16_t*);

extern
void __asm_3x2_post(int16_t*, int16_t*, int16_t*, int16_t*);

extern
void __asm_cyclic_FFT16(int16_t *des, int16_t *src1, int16_t *src2, int16_t *_const_buff);

extern
void __asm_cyclic_FFT16_precompute(int16_t *des, int16_t *src1, int16_t *src2, int16_t *src2qinv, int16_t *_const_buff);

extern
void __asm_negacyclic_FFT16(int16_t *des, int16_t *src1, int16_t *src2, int16_t *_const_buff);

extern
void __asm_rader17_truncated(int16_t *des, int16_t *src1, int16_t *src2, int16_t *src2qinv, int16_t *_const_buff);

extern
void __asm_irader17_truncated(int16_t *des, int16_t *src1, int16_t *src2, int16_t *src2qinv, int16_t *_const_buff);

extern
void __asm_weighted_karatsuba16(int16_t *des, int16_t *src1, int16_t *src2, int16_t *_const_buff, int16_t *twiddle);

void mulcore(int16_t *des, int16_t *src1, int16_t *src2);

void polymul(int16_t *des, int16_t *src1, int16_t *src2);

#endif

