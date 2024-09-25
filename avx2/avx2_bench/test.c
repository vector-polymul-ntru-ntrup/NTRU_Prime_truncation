
#include <stdio.h>
#include <stdint.h>
#include <assert.h>
#include <memory.h>

#include "tools.h"
#include "naive_mult.h"

#include "params.h"
#include "NTT_params.h"

#include "ring.h"

#include "__avx2_wrap.h"
#include "__avx2.h"

// w17 = = w17^(FACTOR96 * 96) = (w17^FACTOR96)^96
#define FACTOR96 (14)

void print_int16(int16_t *src, size_t len){

    for(size_t i = 0; i < len; i++){
        printf("%d%s", src[i], (i == len - 1)? ("\n"):(", "));
    }

}

int main(void){

    int16_t poly1[ARRAY_N], poly2[ARRAY_N];
    int16_t ref[ARRAY_N], res[ARRAY_N];
    int16_t twiddle, t, scale;

    for(size_t i = 0; i < NTRU_P; i++){
        t = rand() % Q;
        coeff_ring.memberZ(poly1 + i, &t);
        t = rand() % Q;
        coeff_ring.memberZ(poly2 + i, &t);
    }
    for(size_t i = NTRU_P; i < ARRAY_N; i++){
        poly1[i] = poly2[i] = 0;
    }

// ================

    twiddle = 1;
    naive_mulR(ref, poly1, poly2, ARRAY_N, &twiddle, coeff_ring);

    for(size_t i = NTT_N; i < ARRAY_N; i++){
        for(size_t j = 0; j < 16; j++){
            coeff_ring.subZ(ref + i - j * 96, ref + i - j * 96, ref + i);
        }
        ref[i] = 0;
    }

// ================

    mulcore(res, poly1, poly2);

// ================

    scale = FINAL_SCALE;
    for(size_t i = 0; i < NTT_N; i++){
        coeff_ring.mulZ(res + i, res + i, &scale);
    }

    for(size_t i = 0; i < NTT_N; i++){
        assert(ref[i] == res[i]);
    }

    printf("mulcore finished!\n");

// ================

    for(size_t i = p + p - 2; i >=p; i--){
        coeff_ring.addZ(ref + i - p, ref + i - p, ref + i);
        coeff_ring.addZ(ref + i - p + 1, ref + i - p + 1, ref + i);
    }

    polymul(res, poly1, poly2);

    for(size_t i = 0; i < p; i++){
        coeff_ring.memberZ(res + i, res + i);
    }

    for(size_t i = 0; i < p; i++){
        assert(ref[i] == res[i]);
    }

    printf("polymul finished!\n");

}


