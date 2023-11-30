
#include <stdio.h>

#include "rader.h"

#include "naive_mult.h"
#include "ring.h"

#include "NTT_params.h"

// map x to log_g x
size_t rader_dlog_permute[17] = {
0, 14, 1, 12,
5, 15, 11, 10,
2, 3, 7, 13,
4, 9, 6, 8
};

void rader_17_primitive(int16_t *des, int16_t *src, int16_t *twiddle_table, int16_t *twiddle_inv_table, size_t jump){

    int16_t buff[17];
    int16_t twiddle_permute[17];
    int16_t src_permute[17];

    int16_t twiddle;

    for(size_t i = 0; i < 16; i++){
        src_permute[(16 - rader_dlog_permute[i]) % 16] = src[i * jump];
        twiddle_permute[rader_dlog_permute[i]] = twiddle_table[i + 1];
    }

    twiddle = 1;
    naive_mulR(buff, src_permute, twiddle_permute, 16, &twiddle, coeff_ring);

    for(size_t i = 0; i < 16; i++){
        twiddle_permute[rader_dlog_permute[i]] = twiddle_inv_table[i + 1];
    }

    point_mul(buff, buff, twiddle_permute, 16, 1, coeff_ring);

    for(size_t i = 0; i < 16; i++){
        des[i * jump] = buff[rader_dlog_permute[i]];
    }

}

void rader_17_primitive_inv(int16_t *des, int16_t *src, int16_t *twiddle_inv_table, int16_t *twiddle_table, size_t jump){

    int16_t twiddle_permute[17];
    int16_t src_permute[17];
    int16_t twiddle_more_permute[17];

    int16_t twiddle;

    for(size_t i = 0; i < 16; i++){
        src_permute[rader_dlog_permute[i]] = src[i * jump];
    }

    for(size_t i = 0; i < 16; i++){
        twiddle_permute[rader_dlog_permute[i]] = twiddle_table[i + 1];
    }

    point_mul(src_permute, src_permute, twiddle_permute, 16, 1, coeff_ring);

    for(size_t i = 0; i < 16; i++){
        twiddle_permute[rader_dlog_permute[i]] = twiddle_inv_table[i + 1];
    }

    for(size_t i = 0; i < 8; i++){
        twiddle_more_permute[i] = twiddle_permute[7 - i];
    }
    for(size_t i = 8; i < 16; i++){
        twiddle_more_permute[i] = twiddle_permute[23 - i];
    }

    twiddle = 1;
    naive_mulR(src_permute, src_permute, twiddle_more_permute, 16, &twiddle, coeff_ring);

    for(size_t i = 0; i < 16; i++){
        des[i * jump] = src_permute[(16 - rader_dlog_permute[i] - 1) % 16];
    }


}












