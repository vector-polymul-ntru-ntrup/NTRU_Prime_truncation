
#include "NTT_params.h"
#include "ring.h"

int16_t mod = Q;

void memberZ(void *des, const void *src){
    cmod_int16(des, src, &mod);
}

void addZ(void *des, const void *src1, const void *src2){
    addmod_int16(des, src1, src2, &mod);
}

void subZ(void *des, const void *src1, const void *src2){
    submod_int16(des, src1, src2, &mod);
}

void mulZ(void *des, const void *src1, const void *src2){
    mulmod_int16(des, src1, src2, &mod);
}

void expZ(void *des, const void *src, const size_t e){
    expmod_int16(des, src, e, &mod);
}

struct ring coeff_ring = {
    .sizeZ = sizeof(int16_t),
    .memberZ = memberZ,
    .addZ = addZ,
    .subZ = subZ,
    .mulZ = mulZ,
    .expZ = expZ
};

void getExpVec(int16_t *des, int16_t w, size_t len){

    des[0] = 1;
    for(size_t i = 1; i < len; i++){
        coeff_ring.mulZ(des + i, des + i - 1, &w);
    }

}

void DFT(int16_t *des, int16_t *src, int16_t *w_exp, size_t len, size_t jump){

    int16_t row[len];
    int16_t buff[len];

    int16_t t;

    for(size_t i = 0; i < len; i++){
        getExpVec(row, w_exp[i], len);
        buff[i] = 0;
        for(size_t j = 0; j < len; j++){
            coeff_ring.mulZ(&t, row + j, src + j * jump);
            coeff_ring.addZ(buff + i, buff + i, &t);
        }
    }

    for(size_t i = 0; i < len; i++){
        des[i * jump] = buff[i];
    }

}

// len must be a prime
void DFT_primitive(int16_t *des, int16_t *src, int16_t *w_exp, size_t len){

    int16_t row[len];
    int16_t buff[len];

    int16_t t;

    for(size_t i = 1; i < len; i++){
        getExpVec(row, w_exp[i], len);
        buff[i] = 0;
        for(size_t j = 0; j < len - 1; j++){
            coeff_ring.mulZ(&t, row + j, src + j);
            coeff_ring.addZ(buff + i, buff + i, &t);
        }
    }

    for(size_t i = 0; i < len - 1; i++){
        des[i] = buff[i + 1];
    }

}

