#ifndef RADER_H
#define RADER_H

// g = 3
// map x to g^x
extern size_t rader_in_permute[17];
// map x to g^{16 - x}
extern size_t rader_out_permute[17];

extern int16_t twiddle_table[17][17];
extern int16_t twiddle_inv_table[17][17];

extern int16_t twiddle_permuted[17];
extern int16_t twiddle_inv_permuted[17];

extern int16x8_t twiddle_permutedx8[17];
extern int16x8_t twiddle_inv_permutedx8[17];

void rader_in_tbl(int16x8_t *des, int16x8_t *src, size_t des_jump, size_t src_jump);
void rader_out_tbl(int16x8_t *des, int16x8_t *src, size_t des_jump, size_t src_jump);
void rader_17_tbl(int16x8_t *des, int16x8_t *src, int16x8_t *tablex8, int16_t *in_table, int16_t *out_table);

void rader_17_tbl_pre_tbl(int16x8_t *head_ptr, int16x8_t *des, int16x8_t *src, int16_t *in_table);
void rader_17_tbl_mul(int16x8_t *des, int16x8_t *tablex8);
void rader_17_tbl_post_tbl(int16x8_t *des, int16x8_t *head_ptr, int16x8_t *src, int16_t *out_table);

extern void __asm_rader_17_post(int16x8_t *des, int16x8_t *head_ptr, int16x8_t *src);

extern void __asm_rader_17_pre_tbl(int16x8_t *head_ptr, int16x8_t *des, int16x8_t *src, int16_t *in_table);
extern void __asm_rader_17_post_tbl(int16x8_t *des, int16x8_t *head_ptr, int16x8_t *src, int16_t *out_table);

extern void __asm_rader_17_mix_pre(int16x8_t*, int16x8_t*, int16_t*, int16x8_t*);
extern void __asm_rader_17_mix_post(int16x8_t*, int16x8_t*, int16_t*, int16x8_t*);

void radix_17(int16x8_t *des, int16x8_t *src, int16_t table[][17], size_t jump);
void setup_twiddle(int16_t table[][17], int16_t omega);

void rader_17(int16x8_t *des, int16x8_t *src, int16x8_t *tablex8, size_t jump);
void setup_rader_17(void);

#endif



