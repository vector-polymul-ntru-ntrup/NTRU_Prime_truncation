
#include <stddef.h>

#include <stdio.h>

#include <arm_neon.h>

#include "NTT_params.h"
#include "poly_basic.h"
#include "poly_vec.h"

int16x8_t cmod_int16x8(int16x8_t v){

    int16x8_t t;

    for(size_t i = 0; i < 8; i++){
        t[i] = cmod_int16(v[i]);
    }

    return t;

}

int16x8_t mulmod_int16x8(int16x8_t a, int16x8_t b){

    int16x8_t t;

    for(size_t i = 0; i < 8; i++){
        t[i] = mulmod_int16(a[i], b[i]);
    }

   return t;

}

void schoolbook_corex8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, size_t len){

    for(size_t i = 0; i < 2 * len; i++){
        des[i] = vdupq_n_s16(0);
    }

    for(size_t i = 0; i < len; i++){
        for(size_t j = 0; j < len; j++){
            des[i + j] = cmod_int16x8(des[i + j] + mulmod_int16x8(src1[i], src2[j]));
        }
    }

}

void weightedx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, int16x8_t zeta, size_t len){

    int16x8_t tmp[2 * len];
    schoolbook_corex8(tmp, src1, src2, len);

    for(size_t i = 2 * len - 1; i >= len; i--){
        des[i - len] = cmod_int16x8(tmp[i - len] + mulmod_int16x8(tmp[i], zeta));
    }

}

void cyclicx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, size_t len){
    int16x8_t zeta = {1, 1, 1, 1, 1, 1, 1, 1};
    weightedx8(des, src1, src2, zeta, len);
}

void negacyclicx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, size_t len){
    int16x8_t zeta = {-1, -1, -1, -1, -1, -1, -1, -1};
    weightedx8(des, src1, src2, zeta, len);
}

void schoolbook_Rmodx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, size_t len){

    int32x4_t lo, hi;
    int16x8_t t;

    for(size_t i = 0; i < len; i++){
        lo = hi = vdupq_n_s32(0);
        for(size_t j = 0; j <= i; j++){
            lo = vmlal_s16(lo, vget_low_s16(src1[j]), vget_low_s16(src2[i - j]));
            hi = vmlal_high_s16(hi, src1[j], src2[i - j]);
        }
        t = vuzp1q_s16((int16x8_t)lo, (int16x8_t)hi);
        t = vmulq_n_s16(t, Qprime);
        lo = vmlal_n_s16(lo, vget_low_s16(t), Q);
        hi = vmlal_high_n_s16(hi, t, Q);
        t = vuzp2q_s16((int16x8_t)lo, (int16x8_t)hi);
        des[i] = t;
    }

    for(size_t i = len; i < 2 * len - 1; i++){
        lo = hi = vdupq_n_s32(0);
        for(size_t j = i - len + 1; j < len; j++){
            lo = vmlal_s16(lo, vget_low_s16(src1[j]), vget_low_s16(src2[i - j]));
            hi = vmlal_high_s16(hi, src1[j], src2[i - j]);
        }
        t = vuzp1q_s16((int16x8_t)lo, (int16x8_t)hi);
        t = vmulq_n_s16(t, Qprime);
        lo = vmlal_n_s16(lo, vget_low_s16(t), Q);
        hi = vmlal_high_n_s16(hi, t, Q);
        t = vuzp2q_s16((int16x8_t)lo, (int16x8_t)hi);
        des[i] = t;
    }
    des[2 * len - 1] = vdupq_n_s16(0);

}

// des should not overlap with src1 or src2
void weighted_Rmodx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2,
                     int16x8_t wlo, int16x8_t whi, size_t len){

    int32x4_t lo, hi;
    int16x8_t t, slo, shi;

    for(size_t i = 0; i < len; i++){
        lo = hi = vdupq_n_s32(0);
        for(size_t j = 0; j <= i; j++){
            lo = vmlal_s16(lo, vget_low_s16(src1[j]), vget_low_s16(src2[i - j]));
            hi = vmlal_high_s16(hi, src1[j], src2[i - j]);
        }
        t = vuzp1q_s16((int16x8_t)lo, (int16x8_t)hi);
        t = vmulq_n_s16(t, Qprime);
        lo = vmlal_n_s16(lo, vget_low_s16(t), Q);
        hi = vmlal_high_n_s16(hi, t, Q);
        t = vuzp2q_s16((int16x8_t)lo, (int16x8_t)hi);
        des[i] = t;
    }

    for(size_t i = len; i < 2 * len - 1; i++){
        lo = hi = vdupq_n_s32(0);
        for(size_t j = i - len + 1; j < len; j++){
            lo = vmlal_s16(lo, vget_low_s16(src1[j]), vget_low_s16(src2[i - j]));
            hi = vmlal_high_s16(hi, src1[j], src2[i - j]);
        }
        t = vuzp1q_s16((int16x8_t)lo, (int16x8_t)hi);
        t = vmulq_n_s16(t, Qprime);
        lo = vmlal_n_s16(lo, vget_low_s16(t), Q);
        hi = vmlal_high_n_s16(hi, t, Q);
        t = vuzp2q_s16((int16x8_t)lo, (int16x8_t)hi);
        slo = vmulq_s16(t, wlo);
        shi = vqrdmulhq_s16(t, whi);
        t = vmlsq_n_s16(slo, shi, Q);
        des[i - len] = vshlq_n_s16(des[i - len] + t, 1);
    }

    des[len - 1] = vshlq_n_s16(des[len - 1], 1);

}

void weighted_Rmod_16x16_x8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2,
                            int16x8_t wlo, int16x8_t whi){

    int16x8_t src1mi[8];
    int16x8_t src2mi[8];
    int16x8_t reslo[16], resmi[16], reshi[16];

    int16x8_t t0, t1;
    int16x8_t slo0, slo1;
    int16x8_t shi0, shi1;

    for(size_t i = 0; i < 8; i++){
        src1mi[i] = src1[i + 0 * 8] + src1[i + 1 * 8];
        src2mi[i] = src2[i + 0 * 8] + src2[i + 1 * 8];
    }

    __asm_schoolbook8x8(reslo, src1 + 0 * 8, src2 + 0 * 8);
    __asm_schoolbook8x8(reshi, src1 + 1 * 8, src2 + 1 * 8);
    __asm_schoolbook8x8(resmi, src1mi, src2mi);

    for(size_t i = 0; i < 8; i++){
        resmi[i + 0] = resmi[i + 0] - reslo[i + 0] - reshi[i + 0];
        resmi[i + 8] = resmi[i + 8] - reslo[i + 8] - reshi[i + 8];
        reslo[i + 8] = reslo[i + 8] + resmi[i + 0];
        reshi[i + 0] = reshi[i + 0] + resmi[i + 8];
        t0 = reshi[i + 0];
        t1 = reshi[i + 8];
        slo0 = vmulq_s16(t0, wlo);
        slo1 = vmulq_s16(t1, wlo);
        shi0 = vqrdmulhq_s16(t0, whi);
        shi1 = vqrdmulhq_s16(t1, whi);
        t0 = vmlsq_n_s16(slo0, shi0, Q);
        t1 = vmlsq_n_s16(slo1, shi1, Q);
        des[i + 0] = vshlq_n_s16(reslo[i + 0] + t0, 1);
        des[i + 8] = vshlq_n_s16(reslo[i + 8] + t1, 1);
    }

}

void cyclic_Rmodx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, size_t len){

    int32x4_t lo, hi;
    int16x8_t t;

    for(size_t i = 0; i < len; i++){
        lo = hi = vdupq_n_s32(0);
        for(size_t j = 0; j <= i; j++){
            lo = vmlal_s16(lo, vget_low_s16(src1[j]), vget_low_s16(src2[i - j]));
            hi = vmlal_high_s16(hi, src1[j], src2[i - j]);
        }
        t = vuzp1q_s16((int16x8_t)lo, (int16x8_t)hi);
        t = vmulq_n_s16(t, Qprime);
        lo = vmlal_n_s16(lo, vget_low_s16(t), Q);
        hi = vmlal_high_n_s16(hi, t, Q);
        t = vuzp2q_s16((int16x8_t)lo, (int16x8_t)hi);
        des[i] = t;
    }

    for(size_t i = len; i < 2 * len - 1; i++){
        lo = hi = vdupq_n_s32(0);
        for(size_t j = i - len + 1; j < len; j++){
            lo = vmlal_s16(lo, vget_low_s16(src1[j]), vget_low_s16(src2[i - j]));
            hi = vmlal_high_s16(hi, src1[j], src2[i - j]);
        }
        t = vuzp1q_s16((int16x8_t)lo, (int16x8_t)hi);
        t = vmulq_n_s16(t, Qprime);
        lo = vmlal_n_s16(lo, vget_low_s16(t), Q);
        hi = vmlal_high_n_s16(hi, t, Q);
        t = vuzp2q_s16((int16x8_t)lo, (int16x8_t)hi);
        des[i - len] = des[i - len] + t;
    }

}

void negacyclic_Rmodx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, size_t len){

    int32x4_t lo, hi;
    int16x8_t t;

    for(size_t i = 0; i < len; i++){
        lo = hi = vdupq_n_s32(0);
        for(size_t j = 0; j <= i; j++){
            lo = vmlal_s16(lo, vget_low_s16(src1[j]), vget_low_s16(src2[i - j]));
            hi = vmlal_high_s16(hi, src1[j], src2[i - j]);
        }
        t = vuzp1q_s16((int16x8_t)lo, (int16x8_t)hi);
        t = vmulq_n_s16(t, Qprime);
        lo = vmlal_n_s16(lo, vget_low_s16(t), Q);
        hi = vmlal_high_n_s16(hi, t, Q);
        t = vuzp2q_s16((int16x8_t)lo, (int16x8_t)hi);
        des[i] = t;
    }

    for(size_t i = len; i < 2 * len - 1; i++){
        lo = hi = vdupq_n_s32(0);
        for(size_t j = i - len + 1; j < len; j++){
            lo = vmlal_s16(lo, vget_low_s16(src1[j]), vget_low_s16(src2[i - j]));
            hi = vmlal_high_s16(hi, src1[j], src2[i - j]);
        }
        t = vuzp1q_s16((int16x8_t)lo, (int16x8_t)hi);
        t = vmulq_n_s16(t, Qprime);
        lo = vmlal_n_s16(lo, vget_low_s16(t), Q);
        hi = vmlal_high_n_s16(hi, t, Q);
        t = vuzp2q_s16((int16x8_t)lo, (int16x8_t)hi);
        des[i - len] = des[i - len] - t;
    }

}

void interleave16x8(int16_t *des,
                int16_t *src0, int16_t *src1, int16_t *src2, int16_t *src3,
                int16_t *src4, int16_t *src5, int16_t *src6, int16_t *src7,
                size_t len){

    for(size_t i = 0; i < len; i++){
        des[i * 8 + 0] = src0[i];
        des[i * 8 + 1] = src1[i];
        des[i * 8 + 2] = src2[i];
        des[i * 8 + 3] = src3[i];
        des[i * 8 + 4] = src4[i];
        des[i * 8 + 5] = src5[i];
        des[i * 8 + 6] = src6[i];
        des[i * 8 + 7] = src7[i];
    }

}

void deinterleave16x8(int16_t *des0, int16_t *des1, int16_t *des2, int16_t *des3,
                      int16_t *des4, int16_t *des5, int16_t *des6, int16_t *des7,
                int16_t *src, size_t len){

    for(size_t i = 0; i < len; i++){
        des0[i] = src[i * 8 + 0];
        des1[i] = src[i * 8 + 1];
        des2[i] = src[i * 8 + 2];
        des3[i] = src[i * 8 + 3];
        des4[i] = src[i * 8 + 4];
        des5[i] = src[i * 8 + 5];
        des6[i] = src[i * 8 + 6];
        des7[i] = src[i * 8 + 7];
    }

}




