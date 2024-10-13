#ifndef RADER_H
#define RADER_H

#include <stddef.h>
#include <stdint.h>

// g = 3
// map x to g^x
// extern size_t rader_in_permute[17];
// // map x to g^{16 - x}
// extern size_t rader_out_permute[17];

extern size_t rader_dlog_permute[16];

// in-place
void add_sub(int16_t *a, int16_t *b);

// in-place
void partial_cyclic_CT(int16_t *des, const int16_t *src);
// in-place
void partial_cyclic_GS(int16_t *des, const int16_t *src);
// in-place
void partial_cyclic_negacyclic_mul(int16_t *des, const int16_t *src1, const int16_t *src2);
// in-place
void partial_scale(int16_t *des, const int16_t *src);
// in-place
void partial_final_scale(int16_t *des, const int16_t *src);
// in-place
void cyclic_mul_partial_CT_GS(int16_t *des, const int16_t *src1, const int16_t *src2);

// out-of-place
void rader_17_primitive_twiddle_permute(int16_t *des, const int16_t *src);
// in-place
void rader_17_primitive_inv_twiddle_permute(int16_t *des, const int16_t *src);

void rader_17_primitive(int16_t *des, int16_t *src, int16_t *twiddle_table, int16_t *twiddle_inv_table, size_t jump);
void rader_17_primitive_inv(int16_t *des, int16_t *src, int16_t *twiddle_inv_table, int16_t *twiddle_table, size_t jump);


#endif

