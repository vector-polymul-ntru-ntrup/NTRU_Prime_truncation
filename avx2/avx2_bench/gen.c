
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

int16_t twist[NTT_N];

void print_int16(int16_t *src, size_t len){

    for(size_t i = 0; i < len; i++){
        printf("%d%s", src[i], (i == len - 1)? ("\n"):(", "));
    }

}

int main(void){

    int16_t twiddle17[17];
    int16_t twiddle_buff[16];
    int16_t twiddle_tmp[16];
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

    for(size_t i = 0; i < 16; i++){
        twiddle_buff[rader_dlog_permute[i]] = twiddle_rader17[i + 1];
    }

    for(size_t i = 0; i < 8; i++){
        coeff_ring.addZ(twiddle_tmp + i + 0, twiddle_buff + i + 0, twiddle_buff + i + 8);
        coeff_ring.subZ(twiddle_tmp + i + 8, twiddle_buff + i + 0, twiddle_buff + i + 8);
    }
    memmove(twiddle_buff, twiddle_tmp, 16 * sizeof(int16_t));

    for(size_t i = 0; i < 4; i++){
        coeff_ring.addZ(twiddle_tmp + i + 0, twiddle_buff + i + 0, twiddle_buff + i + 4);
        coeff_ring.subZ(twiddle_tmp + i + 4, twiddle_buff + i + 0, twiddle_buff + i + 4);
    }
    memmove(twiddle_buff, twiddle_tmp, 8 * sizeof(int16_t));

    for(size_t i = 0; i < 2; i++){
        coeff_ring.addZ(twiddle_tmp + i + 0, twiddle_buff + i + 0, twiddle_buff + i + 2);
        coeff_ring.subZ(twiddle_tmp + i + 2, twiddle_buff + i + 0, twiddle_buff + i + 2);
    }
    memmove(twiddle_buff, twiddle_tmp, 4 * sizeof(int16_t));

    for(size_t i = 0; i < 1; i++){
        coeff_ring.addZ(twiddle_tmp + i + 0, twiddle_buff + i + 0, twiddle_buff + i + 1);
        coeff_ring.subZ(twiddle_tmp + i + 1, twiddle_buff + i + 0, twiddle_buff + i + 1);
    }
    memmove(twiddle_buff, twiddle_tmp, 2 * sizeof(int16_t));

    scale = 2;
    for(size_t i = 2; i < 4; i++){
        coeff_ring.mulZ(twiddle_buff + i, twiddle_buff + i, &scale);
    }

    scale = 4;
    for(size_t i = 4; i < 8; i++){
        coeff_ring.mulZ(twiddle_buff + i, twiddle_buff + i, &scale);
    }

    scale = 8;
    for(size_t i = 8; i < 16; i++){
        coeff_ring.mulZ(twiddle_buff + i, twiddle_buff + i, &scale);
    }

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

    for(size_t i = 0; i < 16; i++){
        twiddle_buff[(23 - rader_dlog_permute[i]) % 16] = twiddle_inv_rader17[i + 1];
    }

    for(size_t i = 0; i < 8; i++){
        coeff_ring.addZ(twiddle_tmp + i + 0, twiddle_buff + i + 0, twiddle_buff + i + 8);
        coeff_ring.subZ(twiddle_tmp + i + 8, twiddle_buff + i + 0, twiddle_buff + i + 8);
    }
    memmove(twiddle_buff, twiddle_tmp, 16 * sizeof(int16_t));

    for(size_t i = 0; i < 4; i++){
        coeff_ring.addZ(twiddle_tmp + i + 0, twiddle_buff + i + 0, twiddle_buff + i + 4);
        coeff_ring.subZ(twiddle_tmp + i + 4, twiddle_buff + i + 0, twiddle_buff + i + 4);
    }
    memmove(twiddle_buff, twiddle_tmp, 8 * sizeof(int16_t));

    for(size_t i = 0; i < 2; i++){
        coeff_ring.addZ(twiddle_tmp + i + 0, twiddle_buff + i + 0, twiddle_buff + i + 2);
        coeff_ring.subZ(twiddle_tmp + i + 2, twiddle_buff + i + 0, twiddle_buff + i + 2);
    }
    memmove(twiddle_buff, twiddle_tmp, 4 * sizeof(int16_t));

    for(size_t i = 0; i < 1; i++){
        coeff_ring.addZ(twiddle_tmp + i + 0, twiddle_buff + i + 0, twiddle_buff + i + 1);
        coeff_ring.subZ(twiddle_tmp + i + 1, twiddle_buff + i + 0, twiddle_buff + i + 1);
    }
    memmove(twiddle_buff, twiddle_tmp, 2 * sizeof(int16_t));

    scale = 2;
    for(size_t i = 2; i < 4; i++){
        coeff_ring.mulZ(twiddle_buff + i, twiddle_buff + i, &scale);
    }

    scale = 4;
    for(size_t i = 4; i < 8; i++){
        coeff_ring.mulZ(twiddle_buff + i, twiddle_buff + i, &scale);
    }

    scale = 8;
    for(size_t i = 8; i < 16; i++){
        coeff_ring.mulZ(twiddle_buff + i, twiddle_buff + i, &scale);
    }

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


