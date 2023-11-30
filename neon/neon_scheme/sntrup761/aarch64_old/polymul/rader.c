
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <stddef.h>
#include <string.h>
#include <assert.h>

#include <arm_neon.h>

#include "NTT_params.h"

#include "poly_basic.h"
#include "poly_vec.h"

#include "rader.h"

// g = 3
// map x to g^x
size_t rader_in_permute[17] = {
0,
3, 9, 10, 13,
5, 15, 11, 16,
14, 8, 7, 4,
12, 2, 6, 1
};
// map x to g^{16 - x}
size_t rader_out_permute[17] = {
0,
6, 2, 12, 4,
7, 8, 14, 16,
11, 15, 5, 13,
10, 9, 3, 1
};

int16_t twiddle_table[17][17] = {
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080},
{1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1678, 2189, 1950, -2080, -842, 286},
{1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, -1080, 305, 1678, 1269, -2080, -1283},
{1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1401, -1283, 1152, 1678, 1950, -842},
{1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1205, 1950, -1283, 305, 2189, 342},
{1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 286, 1205, 1401, -1080, 1678, -2080},
{1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1950, -1080, 245, -842, -2147, 1401},
{1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, -2147, -2080, 305, 1401, 1152, 1950},
{1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, -1283, 245, 286, 2189, -1080, 1269},
{1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1269, 1152, -2080, 1205, -1283, 2189},
{1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 305, -842, 2189, 1152, 342, 245},
{1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, -842, 1269, -2147, 286, 1401, 1678},
{1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 2189, -2147, -1080, 342, 1269, 1205},
{1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1152, 286, 342, 1950, 245, -2147},
{1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 342, 1401, 1269, 245, 1205, 305},
{1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152}
};
int16_t twiddle_inv_table[17][17] = {
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152},
{1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 342, 1401, 1269, 245, 1205, 305},
{1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1152, 286, 342, 1950, 245, -2147},
{1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 2189, -2147, -1080, 342, 1269, 1205},
{1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, -842, 1269, -2147, 286, 1401, 1678},
{1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 305, -842, 2189, 1152, 342, 245},
{1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1269, 1152, -2080, 1205, -1283, 2189},
{1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, -1283, 245, 286, 2189, -1080, 1269},
{1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, -2147, -2080, 305, 1401, 1152, 1950},
{1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1950, -1080, 245, -842, -2147, 1401},
{1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 286, 1205, 1401, -1080, 1678, -2080},
{1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1205, 1950, -1283, 305, 2189, 342},
{1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1401, -1283, 1152, 1678, 1950, -842},
{1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, -1080, 305, 1678, 1269, -2080, -1283},
{1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1678, 2189, 1950, -2080, -842, 286},
{1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080}
};

int16_t twiddle_permuted[17] = {
0, 1808, 487, -787, 472, -2286, -1440, 1837, -2150, -1045, -2045, -1784, 1728, 1586, 1400, 1843, -1145
};
int16_t twiddle_inv_permuted[17] = {
0, 1808, 487, -787, 472, -2286, -1440, 1837, -2150, 1045, 2045, 1784, -1728, -1586, -1400, -1843, 1145
};

int16x8_t twiddle_permutedx8[17] = {
{0, 0, 0, 0, 0, 0, 0, 0},
{1808, 1808, 1808, 1808, 1808, 1808, 1808, 1808},
{487, 487, 487, 487, 487, 487, 487, 487},
{-787, -787, -787, -787, -787, -787, -787, -787},
{472, 472, 472, 472, 472, 472, 472, 472},
{-2286, -2286, -2286, -2286, -2286, -2286, -2286, -2286},
{-1440, -1440, -1440, -1440, -1440, -1440, -1440, -1440},
{1837, 1837, 1837, 1837, 1837, 1837, 1837, 1837},
{-2150, -2150, -2150, -2150, -2150, -2150, -2150, -2150},
{-1045, -1045, -1045, -1045, -1045, -1045, -1045, -1045},
{-2045, -2045, -2045, -2045, -2045, -2045, -2045, -2045},
{-1784, -1784, -1784, -1784, -1784, -1784, -1784, -1784},
{1728, 1728, 1728, 1728, 1728, 1728, 1728, 1728},
{1586, 1586, 1586, 1586, 1586, 1586, 1586, 1586},
{1400, 1400, 1400, 1400, 1400, 1400, 1400, 1400},
{1843, 1843, 1843, 1843, 1843, 1843, 1843, 1843},
{-1145, -1145, -1145, -1145, -1145, -1145, -1145, -1145}
};
int16x8_t twiddle_inv_permutedx8[17] = {
{0, 0, 0, 0, 0, 0, 0, 0},
{1808, 1808, 1808, 1808, 1808, 1808, 1808, 1808},
{487, 487, 487, 487, 487, 487, 487, 487},
{-787, -787, -787, -787, -787, -787, -787, -787},
{472, 472, 472, 472, 472, 472, 472, 472},
{-2286, -2286, -2286, -2286, -2286, -2286, -2286, -2286},
{-1440, -1440, -1440, -1440, -1440, -1440, -1440, -1440},
{1837, 1837, 1837, 1837, 1837, 1837, 1837, 1837},
{-2150, -2150, -2150, -2150, -2150, -2150, -2150, -2150},
{1045, 1045, 1045, 1045, 1045, 1045, 1045, 1045},
{2045, 2045, 2045, 2045, 2045, 2045, 2045, 2045},
{1784, 1784, 1784, 1784, 1784, 1784, 1784, 1784},
{-1728, -1728, -1728, -1728, -1728, -1728, -1728, -1728},
{-1586, -1586, -1586, -1586, -1586, -1586, -1586, -1586},
{-1400, -1400, -1400, -1400, -1400, -1400, -1400, -1400},
{-1843, -1843, -1843, -1843, -1843, -1843, -1843, -1843},
{1145, 1145, 1145, 1145, 1145, 1145, 1145, 1145}
};

void rader_in_tbl(int16x8_t *des, int16x8_t *src, size_t des_jump, size_t src_jump){

    int16x8_t buff[17];
    for(size_t i = 0; i < 17; i++){
        buff[i] = src[rader_in_permute[i] * src_jump];
    }
    for(size_t i = 0; i < 17; i++){
        des[i * des_jump] = buff[i];
    }

}

void rader_out_tbl(int16x8_t *des, int16x8_t *src, size_t des_jump, size_t src_jump){

    int16x8_t buff[17];
    for(size_t i = 0; i < 17; i++){
        buff[rader_out_permute[i]] = src[i * src_jump];
    }
    for(size_t i = 0; i < 17; i++){
        des[i * des_jump] = buff[i];
    }

}



void rader_17(int16x8_t *des, int16x8_t *src, int16x8_t *tablex8, size_t jump){

    int16x8_t buff0[17];
    int16x8_t buff1[17];
    int16x8_t t0, t1, t2, t3;
    int16x8_t a0, a1, a2, a3;
    int16x8_t head;

    int16_t mul_args[4] = {1,
        Qprime, Q};

    head = src[0];

    // (1, 5, 9, 13) <- (3, 5, 14, 12)
    t0 = src[3 * jump] + src[14 * jump];
    t2 = src[3 * jump] - src[14 * jump];
    t1 = src[5 * jump] + src[12 * jump];
    t3 = src[5 * jump] - src[12 * jump];

    a0 = t0 + t1;
    a1 = t0 - t1;
    a2 = t2;
    a3 = t3;

    buff0[1] = a0;
    buff0[5] = a1;
    buff0[9] = a2;
    buff0[13] = a3;

    // (2, 6, 10, 14) <- (9, 15, 8, 2)
    t0 = src[9 * jump] + src[8 * jump];
    t2 = src[9 * jump] - src[8 * jump];
    t1 = src[15 * jump] + src[2 * jump];
    t3 = src[15 * jump] - src[2 * jump];

    a0 = t0 + t1;
    a1 = t0 - t1;
    a2 = t2;
    a3 = t3;

    buff0[2] = a0;
    buff0[6] = a1;
    buff0[10] = a2;
    buff0[14] = a3;

    // (3, 7, 11, 15) <- (10, 11, 7, 6)
    t0 = src[10 * jump] + src[7 * jump];
    t2 = src[10 * jump] - src[7 * jump];
    t1 = src[11 * jump] + src[6 * jump];
    t3 = src[11 * jump] - src[6 * jump];

    a0 = t0 + t1;
    a1 = t0 - t1;
    a2 = t2;
    a3 = t3;

    buff0[3] = a0;
    buff0[7] = a1;
    buff0[11] = a2;
    buff0[15] = a3;

    // (4, 8, 12, 16) <- (13, 16, 4, 1)
    t0 = src[13 * jump] + src[4 * jump];
    t2 = src[13 * jump] - src[4 * jump];
    t1 = src[16 * jump] + src[1 * jump];
    t3 = src[16 * jump] - src[1 * jump];

    a0 = t0 + t1;
    a1 = t0 - t1;
    a2 = t2;
    a3 = t3;

    buff0[4] = a0;
    buff0[8] = a1;
    buff0[12] = a2;
    buff0[16] = a3;

    des[0] = head + buff0[1] + buff0[2];
    t1 = vqdmulhq_n_s16(des[0], 29235);
    t1 = vrshrq_n_s16(t1, 12);
    des[0] = vmlsq_n_s16(des[0], t1, Q);
    des[0] = buff0[3] + buff0[4] + des[0];
    t1 = vqdmulhq_n_s16(des[0], 29235);
    t1 = vrshrq_n_s16(t1, 12);
    des[0] = vmlsq_n_s16(des[0], t1, Q);

    __asm_cyclic_negacyclic_basemul4x4(buff1 + 1, buff0 + 1, tablex8 + 1, mul_args + 1);
    __asm_negacyclic_basemul8x8(buff1 + 9, buff0 + 9, tablex8 + 9, mul_args + 1);

    // (6, 7, 11, 10) <- (1, 5, 9, 13)
    t0 = buff1[1] + buff1[5] + head;
    t1 = buff1[1] - buff1[5] + head;

    des[6 * jump] = t0 + buff1[9];
    des[11 * jump] = t0 - buff1[9];
    des[7 * jump] = t1 + buff1[13];
    des[10 * jump] = t1 - buff1[13];

    // (2, 8, 15, 9) <- (2, 6, 10, 14)
    t0 = buff1[2] + buff1[6] + head;
    t1 = buff1[2] - buff1[6] + head;

    des[2 * jump] = t0 + buff1[10];
    des[15 * jump] = t0 - buff1[10];
    des[8 * jump] = t1 + buff1[14];
    des[9 * jump] = t1 - buff1[14];

    // (12, 14, 5, 3) <- (3, 7, 11, 15)
    t0 = buff1[3] + buff1[7] + head;
    t1 = buff1[3] - buff1[7] + head;

    des[12 * jump] = t0 + buff1[11];
    des[5 * jump] = t0 - buff1[11];
    des[14 * jump] = t1 + buff1[15];
    des[3 * jump] = t1 - buff1[15];

    // (4, 16, 13, 1) <- (4, 8, 12, 16)
    t0 = buff1[4] + buff1[8] + head;
    t1 = buff1[4] - buff1[8] + head;

    des[4 * jump] = t0 + buff1[12];
    des[13 * jump] = t0 - buff1[12];
    des[16 * jump] = t1 + buff1[16];
    des[1 * jump] = t1 - buff1[16];


}

void rader_17_tbl(int16x8_t *des, int16x8_t *src, int16x8_t *tablex8, int16_t *out_table, int16_t *in_table){

    int16x8_t buff0[17];
    int16x8_t buff1[17];
    int16x8_t t0, t1, t2, t3;
    int16x8_t a0, a1, a2, a3;
    int16x8_t head;

    int16_t mul_args[4] = {1,
        Qprime, Q};

    head = src[in_table[0]];

    // (1, 5, 9, 13) <- (3, 5, 14, 12)
    t0 = src[in_table[3]] + src[in_table[14]];
    t2 = src[in_table[3]] - src[in_table[14]];
    t1 = src[in_table[5]] + src[in_table[12]];
    t3 = src[in_table[5]] - src[in_table[12]];

    a0 = t0 + t1;
    a1 = t0 - t1;
    a2 = t2;
    a3 = t3;

    buff0[1] = a0;
    buff0[5] = a1;
    buff0[9] = a2;
    buff0[13] = a3;

    // (2, 6, 10, 14) <- (9, 15, 8, 2)
    t0 = src[in_table[9]] + src[in_table[8]];
    t2 = src[in_table[9]] - src[in_table[8]];
    t1 = src[in_table[15]] + src[in_table[2]];
    t3 = src[in_table[15]] - src[in_table[2]];

    a0 = t0 + t1;
    a1 = t0 - t1;
    a2 = t2;
    a3 = t3;

    buff0[2] = a0;
    buff0[6] = a1;
    buff0[10] = a2;
    buff0[14] = a3;

    // (3, 7, 11, 15) <- (10, 11, 7, 6)
    t0 = src[in_table[10]] + src[in_table[7]];
    t2 = src[in_table[10]] - src[in_table[7]];
    t1 = src[in_table[11]] + src[in_table[6]];
    t3 = src[in_table[11]] - src[in_table[6]];

    a0 = t0 + t1;
    a1 = t0 - t1;
    a2 = t2;
    a3 = t3;

    buff0[3] = a0;
    buff0[7] = a1;
    buff0[11] = a2;
    buff0[15] = a3;

    // (4, 8, 12, 16) <- (13, 16, 4, 1)
    t0 = src[in_table[13]] + src[in_table[4]];
    t2 = src[in_table[13]] - src[in_table[4]];
    t1 = src[in_table[16]] + src[in_table[1]];
    t3 = src[in_table[16]] - src[in_table[1]];

    a0 = t0 + t1;
    a1 = t0 - t1;
    a2 = t2;
    a3 = t3;

    buff0[4] = a0;
    buff0[8] = a1;
    buff0[12] = a2;
    buff0[16] = a3;

    des[out_table[0]] = head + buff0[1] + buff0[2];
    t1 = vqdmulhq_n_s16(des[out_table[0]], 29235);
    t1 = vrshrq_n_s16(t1, 12);
    des[out_table[0]] = vmlsq_n_s16(des[out_table[0]], t1, Q);
    des[out_table[0]] = buff0[3] + buff0[4] + des[out_table[0]];
    t1 = vqdmulhq_n_s16(des[out_table[0]], 29235);
    t1 = vrshrq_n_s16(t1, 12);
    des[out_table[0]] = vmlsq_n_s16(des[out_table[0]], t1, Q);

    __asm_cyclic_negacyclic_basemul4x4(buff1 + 1, buff0 + 1, tablex8 + 1, mul_args + 1);
    __asm_negacyclic_basemul8x8(buff1 + 9, buff0 + 9, tablex8 + 9, mul_args + 1);

    // (6, 7, 11, 10) <- (1, 5, 9, 13)
    t0 = buff1[1] + buff1[5] + head;
    t1 = buff1[1] - buff1[5] + head;

    des[out_table[6]] = t0 + buff1[9];
    des[out_table[11]] = t0 - buff1[9];
    des[out_table[7]] = t1 + buff1[13];
    des[out_table[10]] = t1 - buff1[13];

    // (2, 8, 15, 9) <- (2, 6, 10, 14)
    t0 = buff1[2] + buff1[6] + head;
    t1 = buff1[2] - buff1[6] + head;

    des[out_table[2]] = t0 + buff1[10];
    des[out_table[15]] = t0 - buff1[10];
    des[out_table[8]] = t1 + buff1[14];
    des[out_table[9]] = t1 - buff1[14];

    // (12, 14, 5, 3) <- (3, 7, 11, 15)
    t0 = buff1[3] + buff1[7] + head;
    t1 = buff1[3] - buff1[7] + head;

    des[out_table[12]] = t0 + buff1[11];
    des[out_table[5]] = t0 - buff1[11];
    des[out_table[14]] = t1 + buff1[15];
    des[out_table[3]] = t1 - buff1[15];

    // (4, 16, 13, 1) <- (4, 8, 12, 16)
    t0 = buff1[4] + buff1[8] + head;
    t1 = buff1[4] - buff1[8] + head;


    des[out_table[4]] = t0 + buff1[12];
    des[out_table[13]] = t0 - buff1[12];
    des[out_table[16]] = t1 + buff1[16];
    des[out_table[1]] = t1 - buff1[16];


}

void rader_17_tbl_pre_tbl(int16x8_t *head_ptr, int16x8_t *des, int16x8_t *src, int16_t *in_table){

    __asm_rader_17_pre_tbl(head_ptr, des, src, in_table);

}

void rader_17_tbl_mul(int16x8_t *des, int16x8_t *tablex8){

    int16_t mul_args[4] = {Qprime, Q};

    __asm_cyclic_negacyclic_basemul4x4(des + 1, des + 1, tablex8 + 1, mul_args);
    __asm_negacyclic_basemul8x8(des + 9, des + 9, tablex8 + 9, mul_args);

}

void rader_17_tbl_post_tbl(int16x8_t *des, int16x8_t *head_ptr, int16x8_t *src, int16_t *out_table){

    __asm_rader_17_post_tbl(des, head_ptr, src, out_table);


}

void radix_17(int16x8_t *des, int16x8_t *src, int16_t table[][17], size_t jump){

    int16x8_t tmp[17];

    for(size_t i = 0; i < 17; i++){

        tmp[i] = vdupq_n_s16(0);
        for(size_t j = 0; j < 17; j++){
            tmp[i] = cmod_int16x8(tmp[i] + mulmod_int16x8(vdupq_n_s16(table[i][j]), src[j * jump]));
        }

    }

    for(size_t i = 0; i < 17; i++){
        des[i * jump] = tmp[i];
    }

}

void setup_twiddle(int16_t table[][17], int16_t omega){

    int16_t t;

    for(size_t i = 0; i < 17; i++){
        table[i][0] = table[0][i] = 1;
    }

    table[1][1] = omega;

    for(size_t i = 2; i < 17; i++){
        table[i][1] = mulmod_int16(table[i - 1][1], omega);
    }

    for(size_t i = 1; i < 17; i++){
        t = table[i][1];
        for(size_t j = 2; j < 17; j++){
            table[i][j] = mulmod_int16(table[i][j - 1], t);
        }
    }

}

void setup_rader_17(void){

    int16_t t;

    setup_twiddle(twiddle_table, OMEGA);
    setup_twiddle(twiddle_inv_table, twiddle_table[1][16]);

    for(size_t i = 1; i < 17; i++){
        twiddle_permuted[i] = twiddle_table[1][rader_in_permute[17 - i]];
        twiddle_inv_permuted[i] = twiddle_inv_table[1][rader_in_permute[17 - i]];
    }

    // one layer of CT for twiddle
    for(size_t i = 1; i < 9; i++){
        t = cmod_int16(twiddle_permuted[i] + twiddle_permuted[i + 8]);
        twiddle_permuted[i + 8] = cmod_int16(twiddle_permuted[i] - twiddle_permuted[i + 8]);
        twiddle_permuted[i] = t;
    }
    for(size_t i = 1; i < 9; i++){
        t = cmod_int16(twiddle_inv_permuted[i] + twiddle_inv_permuted[i + 8]);
        twiddle_inv_permuted[i + 8] = cmod_int16(twiddle_inv_permuted[i] - twiddle_inv_permuted[i + 8]);
        twiddle_inv_permuted[i] = t;
    }

    // one layer of CT for twiddle
    for(size_t i = 1; i < 5; i++){
        t = cmod_int16(twiddle_permuted[i] + twiddle_permuted[i + 4]);
        twiddle_permuted[i + 4] = cmod_int16(twiddle_permuted[i] - twiddle_permuted[i + 4]);
        twiddle_permuted[i] = t;
    }
    for(size_t i = 1; i < 5; i++){
        t = cmod_int16(twiddle_inv_permuted[i] + twiddle_inv_permuted[i + 4]);
        twiddle_inv_permuted[i + 4] = cmod_int16(twiddle_inv_permuted[i] - twiddle_inv_permuted[i + 4]);
        twiddle_inv_permuted[i] = t;
    }

    // scale for one layer of CT and a pair of (x^8 - 1, x^8 + 1)
    for(size_t i = 1; i < 17; i++){
        twiddle_permuted[i] = mulmod_int16(twiddle_permuted[i], TWOINV);
        twiddle_permuted[i] = mulmod_int16(twiddle_permuted[i], RmodQ);
        twiddle_inv_permuted[i] = mulmod_int16(twiddle_inv_permuted[i], TWOINV);
        twiddle_inv_permuted[i] = mulmod_int16(twiddle_inv_permuted[i], RmodQ);
    }

    for(size_t i = 1; i < 9; i++){
        twiddle_permuted[i] = mulmod_int16(twiddle_permuted[i], TWOINV);
        twiddle_inv_permuted[i] = mulmod_int16(twiddle_inv_permuted[i], TWOINV);
    }

    for(size_t i = 1; i < 17; i++){
        twiddle_permutedx8[i] = vdupq_n_s16(twiddle_permuted[i]);
        twiddle_inv_permutedx8[i] = vdupq_n_s16(twiddle_inv_permuted[i]);
    }


}



