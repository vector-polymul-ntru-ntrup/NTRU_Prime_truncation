
#include <stdio.h>
#include <stdint.h>
#include <assert.h>
#include <memory.h>

#include "tools.h"
#include "naive_mult.h"

#include "params.h"
#include "NTT_params.h"

#include "ring.h"

#include "__avx2.h"
#include "__avx2_const.h"

#include "rader.h"

int16_t twist[NTT_N];

int16_t twiddle_rader17[17] = {
1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080
};

int16_t twiddle_rader17_inv[17] = {
1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152
};

int16_t twiddle_inv_rader17[17] = {
0, 1151, 304, -2148, 1204, 1677, 244, 2188, 1268, 1949, 1400, -2081, 341, -843, -1284, 285, -1081
};

int16_t id16[16] = {
1, 1, 1, 1,
1, 1, 1, 1,
1, 1, 1, 1,
1, 1, 1, 1
};

int16_t _3x2_table[6] = {
1, -OMEGA3, OMEGA3INV,
-1, OMEGA3, -OMEGA3INV
};

int16_t twist16[16] = {
1, OMEGA3, OMEGA3INV, 1,
OMEGA3, OMEGA3INV, 1, OMEGA3,
OMEGA3INV, 1, OMEGA3, OMEGA3INV,
1, OMEGA3, OMEGA3INV, 1
};

int16_t twist16inv[16] = {
1, OMEGA3INV, OMEGA3, 1,
OMEGA3INV, OMEGA3, 1, OMEGA3INV,
OMEGA3, 1, OMEGA3INV, OMEGA3,
1, OMEGA3INV, OMEGA3, 1
};

void print_int16(int16_t *src, size_t len){

    for(size_t i = 0; i < len; i++){
        printf("%d%s", src[i], (i == len - 1)? ("\n"):(", "));
    }

}

int main(void){

    int16_t twiddle17[17];
    int16_t twiddle_buff[16];
    int16_t twiddlex16[16 * 16];
    int16_t twiddle, t, scale, omega;

// ================

    omega = OMEGA17;
    getExpVec(twiddle17, omega, 17);
    assert(memcmp(twiddle_rader17, twiddle17, 17 * sizeof(int16_t)) == 0);

    omega = OMEGA17INV;
    getExpVec(twiddle17, omega, 17);
    assert(memcmp(twiddle_rader17_inv, twiddle17, 17 * sizeof(int16_t)) == 0);

    t = 1;
    for(size_t i = 0; i < 17; i++){
        coeff_ring.subZ(twiddle17 + i, twiddle_rader17 + i, &t);
    }
    assert(memcmp(twiddle_inv_rader17, twiddle17, 17 * sizeof(int16_t)) == 0);

// ================

    rader_17_primitive_twiddle_permute(twiddle_buff, twiddle_rader17);

    partial_cyclic_CT(twiddle_buff, twiddle_buff);
    partial_scale(twiddle_buff, twiddle_buff);

    for(size_t i = 0; i < 16; i++){
        for(size_t j = 0; j < 16; j++){
            twiddlex16[i * 16 + j] = twiddle_buff[i];
        }
    }

    assert(memcmp(twiddle_rader17_full, twiddlex16, 16 * 16 * sizeof(int16_t)) == 0);

    scale = Qinv;
    for(size_t i = 0; i < 16; i++){
        twiddle_buff[i] = twiddle_buff[i] * scale;
    }

    for(size_t i = 0; i < 16; i++){
        for(size_t j = 0; j < 16; j++){
            twiddlex16[i * 16 + j] = twiddle_buff[i];
        }
    }

    assert(memcmp(twiddle_rader17_qinv_full, twiddlex16, 16 * 16 * sizeof(int16_t)) == 0);

// ================

    rader_17_primitive_inv_twiddle_permute(twiddle_buff, twiddle_inv_rader17);

    partial_cyclic_CT(twiddle_buff, twiddle_buff);
    partial_scale(twiddle_buff, twiddle_buff);

    for(size_t i = 0; i < 16; i++){
        for(size_t j = 0; j < 16; j++){
            twiddlex16[i * 16 + j] = twiddle_buff[i];
        }
    }

    assert(memcmp(twiddle_irader17_full, twiddlex16, 16 * 16 * sizeof(int16_t)) == 0);

    scale = Qinv;
    for(size_t i = 0; i < 16; i++){
        twiddle_buff[i] = twiddle_buff[i] * scale;
    }

    for(size_t i = 0; i < 16; i++){
        for(size_t j = 0; j < 16; j++){
            twiddlex16[i * 16 + j] = twiddle_buff[i];
        }
    }

    assert(memcmp(twiddle_irader17_qinv_full, twiddlex16, 16 * 16 * sizeof(int16_t)) == 0);

// ================

    for(size_t i = 0; i < 16; i++){
        twiddle = twiddle_rader17[i + 1];
        coeff_ring.expZ(&twiddle, &twiddle, 14);
        twist[i * 96 + 0] = 1;
        for(size_t j = 1; j < 96; j++){
            coeff_ring.mulZ(twist + i * 96 + j, twist + i * 96 + (j - 1), &twiddle);
        }
    }

    for(size_t i = 0; i < 16; i++){
        scale = twiddle_rader17_inv[i + 1];
        for(size_t j = 0; j < 96; j++){
            coeff_ring.mulZ(twist + i * 96 + j, twist + i * 96 + j, &scale);
        }
    }

    scale = RmodQ;
    for(size_t i = 0; i < NTT_N; i++){
        coeff_ring.mulZ(twist + i, twist + i, &scale);
    }

    assert(memcmp(twist96_table, twist, 1536 * sizeof(int16_t)) == 0);

    for(size_t i = 0; i < 16; i++){
        twiddle = twiddle_rader17_inv[i + 1];
        coeff_ring.expZ(&twiddle, &twiddle, 14);
        twist[i * 96 + 0] = 1;
        for(size_t j = 1; j < 96; j++){
            coeff_ring.mulZ(twist + i * 96 + j, twist + i * 96 + (j - 1), &twiddle);
        }
    }

    for(size_t i = 0; i < 16; i++){
        scale = twiddle_rader17[i + 1];
        for(size_t j = 0; j < 96; j++){
            coeff_ring.mulZ(twist + i * 96 + j, twist + i * 96 + j, &scale);
        }
    }

    scale = RmodQ;
    for(size_t i = 0; i < NTT_N; i++){
        coeff_ring.mulZ(twist + i, twist + i, &scale);
    }

    assert(memcmp(twist96_inv_table, twist, 1536 * sizeof(int16_t)) == 0);

// ================

    for(size_t i = 0; i < NTT_N; i += 96){
        memmove(twist + i + 0 * 16,       id16, 16 * sizeof(int16_t));
        memmove(twist + i + 1 * 16,    twist16, 16 * sizeof(int16_t));
        memmove(twist + i + 2 * 16, twist16inv, 16 * sizeof(int16_t));
        memmove(twist + i + 3 * 16,       id16, 16 * sizeof(int16_t));
        memmove(twist + i + 4 * 16,    twist16, 16 * sizeof(int16_t));
        memmove(twist + i + 5 * 16, twist16inv, 16 * sizeof(int16_t));
    }

    scale = RmodQ;
    for(size_t i = 0; i < NTT_N; i++){
        coeff_ring.mulZ(twist + i, twist + i, &scale);
    }

    assert(memcmp(twist_full_pre, twist, NTT_N * sizeof(int16_t)) == 0);

    for(size_t i = 0; i < NTT_N; i += 96){
        memmove(twist + i + 0 * 16,       id16, 16 * sizeof(int16_t));
        memmove(twist + i + 1 * 16, twist16inv, 16 * sizeof(int16_t));
        memmove(twist + i + 2 * 16,    twist16, 16 * sizeof(int16_t));
        memmove(twist + i + 3 * 16,       id16, 16 * sizeof(int16_t));
        memmove(twist + i + 4 * 16, twist16inv, 16 * sizeof(int16_t));
        memmove(twist + i + 5 * 16,    twist16, 16 * sizeof(int16_t));
    }

    scale = INV4;
    for(size_t i = 0; i < NTT_N; i += 96){
        for(size_t j = 0; j < 16; j++){
            coeff_ring.mulZ(twist + i + j + 0 * 16, twist + i + j + 0 * 16, &scale);
            coeff_ring.mulZ(twist + i + j + 2 * 16, twist + i + j + 2 * 16, &scale);
            coeff_ring.mulZ(twist + i + j + 4 * 16, twist + i + j + 4 * 16, &scale);
        }
    }

    scale = INV2;
    for(size_t i = 0; i < NTT_N; i += 96){
        for(size_t j = 0; j < 16; j++){
            coeff_ring.mulZ(twist + i + j + 1 * 16, twist + i + j + 1 * 16, &scale);
            coeff_ring.mulZ(twist + i + j + 3 * 16, twist + i + j + 3 * 16, &scale);
            coeff_ring.mulZ(twist + i + j + 5 * 16, twist + i + j + 5 * 16, &scale);
        }
    }

    scale = RmodQ;
    for(size_t i = 0; i < NTT_N; i++){
        coeff_ring.mulZ(twist + i, twist + i, &scale);
    }

    assert(memcmp(twist_full_post, twist, NTT_N * sizeof(int16_t)) == 0);

// ================

    printf("gen finished!\n");

}


