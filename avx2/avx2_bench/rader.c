
#include <stdio.h>
#include <memory.h>

#include "rader.h"

#include "NTT_params.h"

#include "__avx2_wrap.h"
#include "__avx2_mulmod.h"

// // map x to log_g (x + 1)
// size_t rader_dlog_permute[16] = {
// 0, 14, 1, 12,
// 5, 15, 11, 10,
// 2, 3, 7, 13,
// 4, 9, 6, 8
// };

// void rader_17_primitive(int16_t *des, int16_t *src, int16_t *twiddle_table, size_t jump){

//     int16_t buff[17];
//     int16_t twiddle_permute[17];
//     int16_t src_permute[17];

//     int16_t twiddle;

//     for(size_t i = 0; i < 16; i++){
//         src_permute[(16 - rader_dlog_permute[i]) % 16] = src[i * jump];
//         twiddle_permute[rader_dlog_permute[i]] = twiddle_table[i + 1];
//     }

//     twiddle = 1;
//     naive_mulR(buff, src_permute, twiddle_permute, 16, &twiddle, coeff_ring);

//     for(size_t i = 0; i < 16; i++){
//         des[i * jump] = buff[rader_dlog_permute[i]];
//     }

// }

// void rader_17_primitive_inv(int16_t *des, int16_t *src, int16_t *twiddle_inv_table, size_t jump){

//     int16_t twiddle_permute[17];
//     int16_t src_permute[17];

//     int16_t twiddle;

//     for(size_t i = 0; i < 16; i++){
//         src_permute[rader_dlog_permute[i]] = src[i * jump];
//         twiddle_permute[(23 - rader_dlog_permute[i]) % 16] = twiddle_inv_table[i + 1];
//     }

//     twiddle = 1;
//     naive_mulR(src_permute, src_permute, twiddle_permute, 16, &twiddle, coeff_ring);

//     for(size_t i = 0; i < 16; i++){
//         des[i * jump] = src_permute[(15 - rader_dlog_permute[i]) % 16];
//     }

// }


// void rader_17_primitive_int16x16(int16_t *des, int16_t *src, int16_t *twiddle_table, int16_t *twiddle_qinv_table, size_t jump){

//     int16_t srcx16[16 * 16];
//     int16_t twiddlex16[16 * 16];
//     int16_t twiddle_qinvx16[16 * 16];
//     int16_t resx16[16 * 16];

//     for(size_t i = 0; i < 16; i++){
//         memmove(srcx16 + ( (16 - rader_dlog_permute[i]) % 16) * 16, src + i * jump, sizeof(int16x16_t));
//         store_int16x16((int16x16_t*)(twiddlex16 + i * 16), dup_const_int16x16(twiddle_table[i]));
//         store_int16x16((int16x16_t*)(twiddle_qinvx16 + i * 16), dup_const_int16x16(twiddle_qinv_table[i]));
//     }

//     __asm_cyclic_FFT16_precompute(resx16, srcx16, twiddlex16, twiddle_qinvx16, const_buff);

//     for(size_t i = 0; i < 16; i++){
//         memmove(des + i * jump, resx16 + rader_dlog_permute[i] * 16, sizeof(int16x16_t));
//     }

// }

// void rader_17_primitive_inv_int16x16(int16_t *des, int16_t *src, int16_t *twiddle_inv_table, int16_t *twiddle_inv_qinv_table, size_t jump){

//     int16_t srcx16[16 * 16];
//     int16_t twiddlex16[16 * 16];
//     int16_t twiddle_qinvx16[16 * 16];
//     int16_t resx16[16 * 16];

//     for(size_t i = 0; i < 16; i++){
//         memmove(srcx16 + rader_dlog_permute[i] * 16, src + i * jump, sizeof(int16x16_t));
//         store_int16x16((int16x16_t*)(twiddlex16 + i * 16), dup_const_int16x16(twiddle_inv_table[i]));
//         store_int16x16((int16x16_t*)(twiddle_qinvx16 + i * 16), dup_const_int16x16(twiddle_inv_qinv_table[i]));
//     }

//     __asm_cyclic_FFT16_precompute(resx16, srcx16, twiddlex16, twiddle_qinvx16, const_buff);

//     for(size_t i = 0; i < 16; i++){
//         memmove(des + i * jump, resx16 + ( (15 - rader_dlog_permute[i]) % 16) * 16, sizeof(int16x16_t));
//     }

// }














