#ifndef __AVX2_BASEMUL_H
#define __AVX2_BASEMUL_H

#include "params.h"
#include "NTT_params.h"
#include "__avx2_wrap.h"

static inline
int16x16_t montmulmod_int16x16(int16x16_t src1, int16x16_t src2){

    int16x16_t lo, hi;
    int16x16_t qx16, qinvx16;

    qx16 = dup_const_int16x16(Q);
    qinvx16 = dup_const_int16x16(Qinv);

    lo = mullo_int16x16(src2, qinvx16);
    hi = mulhi_int16x16(src1, src2);
    lo = mullo_int16x16(src1, lo);
    lo = mulhi_int16x16(lo, qx16);

    return sub_int16x16(hi, lo);
}

#endif

