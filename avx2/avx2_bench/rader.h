#ifndef RADER_H
#define RADER_H

#include <stddef.h>
#include <stdint.h>

// g = 3

extern size_t rader_dlog_permute[17];

extern
void __asm_cyclic_FFT16(int16_t *des, int16_t *src1, int16_t *src2, int16_t *_const_buff);

extern
void __asm_cyclic_FFT16_precompute(int16_t *des, int16_t *src1, int16_t *src2, int16_t *src2qinv, int16_t *_const_buff);

extern
void __asm_rader17_truncated(int16_t *des, int16_t *src1, int16_t *src2, int16_t *src2qinv, int16_t *_const_buff);

extern
void __asm_irader17_truncated(int16_t *des, int16_t *src1, int16_t *src2, int16_t *src2qinv, int16_t *_const_buff);

// void rader_17(int16_t *des, int16_t *src, int16_t *twiddle_table, size_t jump);

// void rader_17_primitive(int16_t *des, int16_t *src, int16_t *twiddle_table, size_t jump);
// void rader_17_primitive_inv(int16_t *des, int16_t *src, int16_t *twiddle_inv_table, size_t jump);

// void rader_17_primitive_int16x16(int16_t *des, int16_t *src, int16_t *twiddle_table, int16_t *twiddle_qinv_table, size_t jump);
// void rader_17_primitive_inv_int16x16(int16_t *des, int16_t *src, int16_t *twiddle_inv_table, int16_t *twiddle_inv_qinv_table, size_t jump);



#endif

