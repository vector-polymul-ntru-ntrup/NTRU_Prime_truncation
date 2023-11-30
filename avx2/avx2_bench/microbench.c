
#include <stdio.h>
#include <stdint.h>
#include <assert.h>
#include <memory.h>

#include "tools.h"
#include "naive_mult.h"

#include "params.h"
#include "NTT_params.h"

#include "ring.h"

#include "rader.h"

#include "__avx2.h"
#include "__avx2_const.h"
#include "__avx2_wrap.h"

#include "cpucycles.h"


#define ITERATIONS 100000

uint64_t cycles[ITERATIONS + 1];
uint64_t t0, t1;

static int cmp_uint64(const void *a, const void *b){
    return (*(uint64_t*)a) - (*(uint64_t*)b);
}

// w17 = = w17^(FACTOR96 * 96) = (w17^FACTOR96)^96
#define FACTOR96 (14)

int main(void){

    int16_t poly1[ARRAY_N];
    int16_t poly1_NTT[ARRAY_N];
    int16_t res[ARRAY_N];
    int16_t res_NTT[ARRAY_N];
    int16_t permute1p[256 * 3], permute1n[256 * 3];
    int16_t permute2p[256 * 3], permute2n[256 * 3];
    int16_t permuteresp[256 * 3], permuteresn[256 * 3];
    int16_t twiddle_buff[ARRAY_N];

// ================

    for(size_t i = 0; i < ITERATIONS; i++){
        t0 = cpucycles();
        __asm_rader17_truncated(poly1_NTT, poly1, twiddle_rader17_full, twiddle_rader17_qinv_full, const_buff);
        __asm_rader17_truncated(poly1_NTT, poly1, twiddle_rader17_full, twiddle_rader17_qinv_full, const_buff);
        __asm_rader17_truncated(poly1_NTT, poly1, twiddle_rader17_full, twiddle_rader17_qinv_full, const_buff);
        __asm_rader17_truncated(poly1_NTT, poly1, twiddle_rader17_full, twiddle_rader17_qinv_full, const_buff);
        __asm_rader17_truncated(poly1_NTT, poly1, twiddle_rader17_full, twiddle_rader17_qinv_full, const_buff);
        __asm_rader17_truncated(poly1_NTT, poly1, twiddle_rader17_full, twiddle_rader17_qinv_full, const_buff);
        __asm_rader17_truncated(poly1_NTT, poly1, twiddle_rader17_full, twiddle_rader17_qinv_full, const_buff);
        __asm_rader17_truncated(poly1_NTT, poly1, twiddle_rader17_full, twiddle_rader17_qinv_full, const_buff);
        t1 = cpucycles();
        cycles[i] = t1 - t0;
    }
    qsort(cycles, ITERATIONS, sizeof(uint64_t), cmp_uint64);
    printf("__asm_rader17_truncated (x128) cycles: ");
    printf("%lu, %lu, %lu\n",
            cycles[ITERATIONS >> 2], cycles[ITERATIONS >> 1], cycles[(ITERATIONS >> 1) + (ITERATIONS >> 2)]);

// ================

    for(size_t i = 0; i < ITERATIONS; i++){
        t0 = cpucycles();
        __asm_3x2_pre(poly1_NTT, OMEGA3_buff, const_buff, twist96_table);
        __asm_3x2_pre(poly1_NTT, OMEGA3_buff, const_buff, twist96_table);
        __asm_3x2_pre(poly1_NTT, OMEGA3_buff, const_buff, twist96_table);
        __asm_3x2_pre(poly1_NTT, OMEGA3_buff, const_buff, twist96_table);
        __asm_3x2_pre(poly1_NTT, OMEGA3_buff, const_buff, twist96_table);
        __asm_3x2_pre(poly1_NTT, OMEGA3_buff, const_buff, twist96_table);
        __asm_3x2_pre(poly1_NTT, OMEGA3_buff, const_buff, twist96_table);
        __asm_3x2_pre(poly1_NTT, OMEGA3_buff, const_buff, twist96_table);
        t1 = cpucycles();
        cycles[i] = t1 - t0;
    }
    qsort(cycles, ITERATIONS, sizeof(uint64_t), cmp_uint64);
    printf("__asm_3x2_pre (256x8) cycles: ");
    printf("%lu, %lu, %lu\n",
            cycles[ITERATIONS >> 2], cycles[ITERATIONS >> 1], cycles[(ITERATIONS >> 1) + (ITERATIONS >> 2)]);

// ================

    for(size_t i = 0; i < ITERATIONS; i++){
        t0 = cpucycles();
        twist_transpose_pre((int16_t (*)[16])permute1p, (int16_t (*)[16])(poly1_NTT), twist_full_pre);
        twist_transpose_pre((int16_t (*)[16])permute1p, (int16_t (*)[16])(poly1_NTT), twist_full_pre);
        twist_transpose_pre((int16_t (*)[16])permute1p, (int16_t (*)[16])(poly1_NTT), twist_full_pre);
        twist_transpose_pre((int16_t (*)[16])permute1p, (int16_t (*)[16])(poly1_NTT), twist_full_pre);
        twist_transpose_pre((int16_t (*)[16])permute1p, (int16_t (*)[16])(poly1_NTT), twist_full_pre);
        twist_transpose_pre((int16_t (*)[16])permute1p, (int16_t (*)[16])(poly1_NTT), twist_full_pre);
        twist_transpose_pre((int16_t (*)[16])permute1p, (int16_t (*)[16])(poly1_NTT), twist_full_pre);
        twist_transpose_pre((int16_t (*)[16])permute1p, (int16_t (*)[16])(poly1_NTT), twist_full_pre);
        t1 = cpucycles();
        cycles[i] = t1 - t0;
    }
    qsort(cycles, ITERATIONS, sizeof(uint64_t), cmp_uint64);
    printf("twist_transpose_pre (x8, 16x16) cycles: ");
    printf("%lu, %lu, %lu\n",
            cycles[ITERATIONS >> 2], cycles[ITERATIONS >> 1], cycles[(ITERATIONS >> 1) + (ITERATIONS >> 2)]);

// ================

    for(size_t i = 0; i < ITERATIONS; i++){
        t0 = cpucycles();
        __asm_cyclic_FFT16(permuteresp, permute1p, permute2p, const_buff);
        __asm_cyclic_FFT16(permuteresp, permute1p, permute2p, const_buff);
        __asm_cyclic_FFT16(permuteresp, permute1p, permute2p, const_buff);
        __asm_cyclic_FFT16(permuteresp, permute1p, permute2p, const_buff);
        __asm_cyclic_FFT16(permuteresp, permute1p, permute2p, const_buff);
        __asm_cyclic_FFT16(permuteresp, permute1p, permute2p, const_buff);
        __asm_cyclic_FFT16(permuteresp, permute1p, permute2p, const_buff);
        __asm_cyclic_FFT16(permuteresp, permute1p, permute2p, const_buff);
        t1 = cpucycles();
        cycles[i] = t1 - t0;
    }
    qsort(cycles, ITERATIONS, sizeof(uint64_t), cmp_uint64);
    printf("__asm_cyclic_FFT16 (x128) cycles: ");
    printf("%lu, %lu, %lu\n",
            cycles[ITERATIONS >> 2], cycles[ITERATIONS >> 1], cycles[(ITERATIONS >> 1) + (ITERATIONS >> 2)]);

    for(size_t i = 0; i < ITERATIONS; i++){
        t0 = cpucycles();
        __asm_negacyclic_FFT16(permuteresn, permute1n, permute2n, const_buff);
        __asm_negacyclic_FFT16(permuteresn, permute1n, permute2n, const_buff);
        __asm_negacyclic_FFT16(permuteresn, permute1n, permute2n, const_buff);
        __asm_negacyclic_FFT16(permuteresn, permute1n, permute2n, const_buff);
        __asm_negacyclic_FFT16(permuteresn, permute1n, permute2n, const_buff);
        __asm_negacyclic_FFT16(permuteresn, permute1n, permute2n, const_buff);
        __asm_negacyclic_FFT16(permuteresn, permute1n, permute2n, const_buff);
        __asm_negacyclic_FFT16(permuteresn, permute1n, permute2n, const_buff);
        t1 = cpucycles();
        cycles[i] = t1 - t0;
    }
    qsort(cycles, ITERATIONS, sizeof(uint64_t), cmp_uint64);
    printf("__asm_negacyclic_FFT16 (x128) cycles: ");
    printf("%lu, %lu, %lu\n",
            cycles[ITERATIONS >> 2], cycles[ITERATIONS >> 1], cycles[(ITERATIONS >> 1) + (ITERATIONS >> 2)]);

    for(size_t i = 0; i < ITERATIONS; i++){
        t0 = cpucycles();
        __asm_weighted_karatsuba16(permuteresp, permute1p, permute2p, const_buff, twiddle_buff);
        __asm_weighted_karatsuba16(permuteresp, permute1p, permute2p, const_buff, twiddle_buff);
        __asm_weighted_karatsuba16(permuteresp, permute1p, permute2p, const_buff, twiddle_buff);
        __asm_weighted_karatsuba16(permuteresp, permute1p, permute2p, const_buff, twiddle_buff);
        __asm_weighted_karatsuba16(permuteresp, permute1p, permute2p, const_buff, twiddle_buff);
        __asm_weighted_karatsuba16(permuteresp, permute1p, permute2p, const_buff, twiddle_buff);
        __asm_weighted_karatsuba16(permuteresp, permute1p, permute2p, const_buff, twiddle_buff);
        __asm_weighted_karatsuba16(permuteresp, permute1p, permute2p, const_buff, twiddle_buff);
        t1 = cpucycles();
        cycles[i] = t1 - t0;
    }
    qsort(cycles, ITERATIONS, sizeof(uint64_t), cmp_uint64);
    printf("__asm_weighted_karatsuba16 (x128) cycles: ");
    printf("%lu, %lu, %lu\n",
            cycles[ITERATIONS >> 2], cycles[ITERATIONS >> 1], cycles[(ITERATIONS >> 1) + (ITERATIONS >> 2)]);

// ================

    for(size_t i = 0; i < ITERATIONS; i++){
        t0 = cpucycles();
        twist_transpose_post((int16_t (*)[16])(res_NTT), (int16_t (*)[16])permuteresp, twist_full_post);
        twist_transpose_post((int16_t (*)[16])(res_NTT), (int16_t (*)[16])permuteresp, twist_full_post);
        twist_transpose_post((int16_t (*)[16])(res_NTT), (int16_t (*)[16])permuteresp, twist_full_post);
        twist_transpose_post((int16_t (*)[16])(res_NTT), (int16_t (*)[16])permuteresp, twist_full_post);
        twist_transpose_post((int16_t (*)[16])(res_NTT), (int16_t (*)[16])permuteresp, twist_full_post);
        twist_transpose_post((int16_t (*)[16])(res_NTT), (int16_t (*)[16])permuteresp, twist_full_post);
        twist_transpose_post((int16_t (*)[16])(res_NTT), (int16_t (*)[16])permuteresp, twist_full_post);
        twist_transpose_post((int16_t (*)[16])(res_NTT), (int16_t (*)[16])permuteresp, twist_full_post);
        t1 = cpucycles();
        cycles[i] = t1 - t0;
    }
    qsort(cycles, ITERATIONS, sizeof(uint64_t), cmp_uint64);
    printf("twist_transpose_post (x8, 16x16) cycles: ");
    printf("%lu, %lu, %lu\n",
            cycles[ITERATIONS >> 2], cycles[ITERATIONS >> 1], cycles[(ITERATIONS >> 1) + (ITERATIONS >> 2)]);

// ================

    for(size_t i = 0; i < ITERATIONS; i++){
        t0 = cpucycles();
        __asm_3x2_post(res_NTT, OMEGA3INV_buff, const_buff, twist96_inv_table);
        __asm_3x2_post(res_NTT, OMEGA3INV_buff, const_buff, twist96_inv_table);
        __asm_3x2_post(res_NTT, OMEGA3INV_buff, const_buff, twist96_inv_table);
        __asm_3x2_post(res_NTT, OMEGA3INV_buff, const_buff, twist96_inv_table);
        __asm_3x2_post(res_NTT, OMEGA3INV_buff, const_buff, twist96_inv_table);
        __asm_3x2_post(res_NTT, OMEGA3INV_buff, const_buff, twist96_inv_table);
        __asm_3x2_post(res_NTT, OMEGA3INV_buff, const_buff, twist96_inv_table);
        __asm_3x2_post(res_NTT, OMEGA3INV_buff, const_buff, twist96_inv_table);
        t1 = cpucycles();
        cycles[i] = t1 - t0;
    }
    qsort(cycles, ITERATIONS, sizeof(uint64_t), cmp_uint64);
    printf("__asm_3x2_post (256x8) cycles: ");
    printf("%lu, %lu, %lu\n",
            cycles[ITERATIONS >> 2], cycles[ITERATIONS >> 1], cycles[(ITERATIONS >> 1) + (ITERATIONS >> 2)]);

// ================

    for(size_t i = 0; i < ITERATIONS; i++){
        t0 = cpucycles();
        __asm_irader17_truncated(res, res_NTT, twiddle_irader17_full, twiddle_irader17_qinv_full, const_buff);
        __asm_irader17_truncated(res, res_NTT, twiddle_irader17_full, twiddle_irader17_qinv_full, const_buff);
        __asm_irader17_truncated(res, res_NTT, twiddle_irader17_full, twiddle_irader17_qinv_full, const_buff);
        __asm_irader17_truncated(res, res_NTT, twiddle_irader17_full, twiddle_irader17_qinv_full, const_buff);
        __asm_irader17_truncated(res, res_NTT, twiddle_irader17_full, twiddle_irader17_qinv_full, const_buff);
        __asm_irader17_truncated(res, res_NTT, twiddle_irader17_full, twiddle_irader17_qinv_full, const_buff);
        __asm_irader17_truncated(res, res_NTT, twiddle_irader17_full, twiddle_irader17_qinv_full, const_buff);
        __asm_irader17_truncated(res, res_NTT, twiddle_irader17_full, twiddle_irader17_qinv_full, const_buff);
        t1 = cpucycles();
        cycles[i] = t1 - t0;
    }
    qsort(cycles, ITERATIONS, sizeof(uint64_t), cmp_uint64);
    printf("__asm_irader17_truncated (x128) cycles: ");
    printf("%lu, %lu, %lu\n",
            cycles[ITERATIONS >> 2], cycles[ITERATIONS >> 1], cycles[(ITERATIONS >> 1) + (ITERATIONS >> 2)]);

// ================

}


