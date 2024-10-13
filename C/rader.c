
#include "rader.h"

#include "naive_mult.h"
#include "ring.h"

#include "NTT_params.h"

// map x to log_g x
size_t rader_dlog_permute[16] = {
0, 14, 1, 12,
5, 15, 11, 10,
2, 3, 7, 13,
4, 9, 6, 8
};

// out-of-place
void rader_17_primitive_twiddle_permute(int16_t *des, const int16_t *src){
    for(size_t i = 0; i < 16; i++){
        des[rader_dlog_permute[i]] = src[i + 1];
    }
}

// in-place
void rader_17_primitive_inv_twiddle_permute(int16_t *des, const int16_t *src){
    int16_t buff[16];
    rader_17_primitive_twiddle_permute(buff, src);
    for(size_t i = 0; i < 8; i++){
        des[i] = buff[7 - i];
    }
    for(size_t i = 8; i < 16; i++){
        des[i] = buff[23 - i];
    }

}

// in-place
void add_sub(int16_t *a, int16_t *b){
    int16_t t = *a;
    coeff_ring.addZ(a, &t, b);
    coeff_ring.subZ(b, &t, b);
}

// in-place
void partial_cyclic_CT(int16_t *des, const int16_t *src){
    for(size_t i = 0; i < 16; i++){
        des[i] = src[i];
    }
    for(size_t i = 0; i < 8; i++){
        add_sub(des + i, des + i + 8);
    }
    for(size_t i = 0; i < 4; i++){
        add_sub(des + i, des + i + 4);
    }
    for(size_t i = 0; i < 2; i++){
        add_sub(des + i, des + i + 2);
    }
    add_sub(des + 0, des + 1);
}

// in-place
void partial_cyclic_GS(int16_t *des, const int16_t *src){
    for(size_t i = 0; i < 16; i++){
        des[i] = src[i];
    }
    add_sub(des + 0, des + 1);
    for(size_t i = 0; i < 2; i++){
        add_sub(des + i, des + i + 2);
    }
    for(size_t i = 0; i < 4; i++){
        add_sub(des + i, des + i + 4);
    }
    for(size_t i = 0; i < 8; i++){
        add_sub(des + i, des + i + 8);
    }
}

// in-place
void partial_cyclic_negacyclic_mul(int16_t *des, const int16_t *src1, const int16_t *src2){

    int16_t twiddle = -1;

    coeff_ring.mulZ(des + 0, src1 + 0, src2 + 0);
    coeff_ring.mulZ(des + 1, src1 + 1, src2 + 1);
    naive_mulR(des + 2, src1 + 2, src2 + 2, 2, &twiddle, coeff_ring);
    naive_mulR(des + 4, src1 + 4, src2 + 4, 4, &twiddle, coeff_ring);
    naive_mulR(des + 8, src1 + 8, src2 + 8, 8, &twiddle, coeff_ring);

}

// in-place
void partial_scale(int16_t *des, const int16_t *src){
    int16_t scale;
    for(size_t i = 0; i < 2; i++){
        des[i] = src[i];
    }
    scale = 2;
    for(size_t i = 2; i < 4; i++){
        coeff_ring.mulZ(des + i, src + i, &scale);
    }
    scale = 4;
    for(size_t i = 4; i < 8; i++){
        coeff_ring.mulZ(des + i, src + i, &scale);
    }
    scale = 8;
    for(size_t i = 8; i < 16; i++){
        coeff_ring.mulZ(des + i, src + i, &scale);
    }
}

// in-place
void partial_final_scale(int16_t *des, const int16_t *src){
    int16_t scale = INV16;
    for(size_t i = 0; i < 16; i++){
        coeff_ring.mulZ(des + i, src + i, &scale);
    }
}

// in-place
void cyclic_mul_partial_CT_GS(int16_t *des, const int16_t *src1, const int16_t *src2){

    int16_t buff1[16], buff2[16];

    partial_cyclic_CT(buff1, src1);
    partial_cyclic_CT(buff2, src2);
    partial_cyclic_negacyclic_mul(des, buff1, buff2);
    partial_scale(des, des);
    partial_cyclic_GS(des, des);
    partial_final_scale(des, des);

}

void rader_17_primitive(int16_t *des, int16_t *src, int16_t *twiddle_table, int16_t *twiddle_inv_table, size_t jump){

    int16_t twiddle_permuted[16];
    int16_t src_permuted[16];

    for(size_t i = 0; i < 16; i++){
        src_permuted[(16 - rader_dlog_permute[i]) % 16] = src[i * jump];
    }

    // We can precompute the following for the twiddle factors.
    rader_17_primitive_twiddle_permute(twiddle_permuted, twiddle_table);
    partial_cyclic_CT(twiddle_permuted, twiddle_permuted);
    partial_scale(twiddle_permuted, twiddle_permuted);

    partial_cyclic_CT(src_permuted, src_permuted);
    partial_cyclic_negacyclic_mul(src_permuted, src_permuted, twiddle_permuted);
    partial_cyclic_GS(src_permuted, src_permuted);
    // This scaling can be postponed.
    partial_final_scale(src_permuted, src_permuted);

    rader_17_primitive_twiddle_permute(twiddle_permuted, twiddle_inv_table);

    // This point_mul can be merged with twisting.
    point_mul(src_permuted, src_permuted, twiddle_permuted, 16, 1, coeff_ring);

    for(size_t i = 0; i < 16; i++){
        des[i * jump] = src_permuted[rader_dlog_permute[i]];
    }

}

void rader_17_primitive_inv(int16_t *des, int16_t *src, int16_t *twiddle_inv_table, int16_t *twiddle_table, size_t jump){

    int16_t twiddle_permuted[16];
    int16_t src_permuted[16];

    for(size_t i = 0; i < 16; i++){
        src_permuted[rader_dlog_permute[i]] = src[i * jump];
    }

    rader_17_primitive_twiddle_permute(twiddle_permuted, twiddle_table);

    // This point_mul can be merged with twisting.
    point_mul(src_permuted, src_permuted, twiddle_permuted, 16, 1, coeff_ring);

    // We can precompute the following for the twiddle factors.
    rader_17_primitive_inv_twiddle_permute(twiddle_permuted, twiddle_inv_table);
    partial_cyclic_CT(twiddle_permuted, twiddle_permuted);
    partial_scale(twiddle_permuted, twiddle_permuted);

    partial_cyclic_CT(src_permuted, src_permuted);
    partial_cyclic_negacyclic_mul(src_permuted, src_permuted, twiddle_permuted);
    partial_cyclic_GS(src_permuted, src_permuted);
    // This scaling can be postponed.
    partial_final_scale(src_permuted, src_permuted);

    for(size_t i = 0; i < 16; i++){
        des[i * jump] = src_permuted[(16 - rader_dlog_permute[i] - 1) % 16];
    }


}












