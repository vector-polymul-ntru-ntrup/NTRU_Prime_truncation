#ifndef RADER_H
#define RADER_H

#include <stddef.h>
#include <stdint.h>

// g = 3
// map x to g^x
extern size_t rader_in_permute[17];
// map x to g^{16 - x}
extern size_t rader_out_permute[17];

extern size_t rader_dlog_permute[17];

extern int16_t const_twiddle17[17];
extern int16_t const_twiddle17inv[17];

void rader_17(int16_t *des, int16_t *src, int16_t *twiddle_table, size_t jump);

void rader_17_primitive(int16_t *des, int16_t *src, int16_t *twiddle_table, int16_t *twiddle_inv_table, size_t jump);
void rader_17_primitive_inv(int16_t *des, int16_t *src, int16_t *twiddle_inv_table, int16_t *twiddle_table, size_t jump);


#endif

