
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

#include "__avx2_wrap.h"
#include "__avx2.h"

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

    int16_t poly1[ARRAY_N], poly2[ARRAY_N];
    int16_t res[ARRAY_N];

// ================

    for(size_t i = 0; i < ITERATIONS; i++){
        t0 = cpucycles();
        mulcore(res, poly1, poly2);
        t1 = cpucycles();
        cycles[i] = t1 - t0;
    }
    qsort(cycles, ITERATIONS, sizeof(uint64_t), cmp_uint64);
    printf("mulcore cycles: ");
    printf("%lu, %lu, %lu\n",
            cycles[ITERATIONS >> 2], cycles[ITERATIONS >> 1], cycles[(ITERATIONS >> 1) + (ITERATIONS >> 2)]);

// ================

}


