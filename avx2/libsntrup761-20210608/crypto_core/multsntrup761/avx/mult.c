
#include <stdint.h>
#include <stddef.h>

#include "crypto_core.h"
#include "params.h"

#include "__avx2_wrap.h"
#include "__avx2.h"
#include "__avx2_mulmod.h"
#include "NTT_params.h"

#include "crypto_int8.h"
#include "crypto_int16.h"
#include "crypto_int32.h"
#define int8 crypto_int8
#define int16 crypto_int16
#define int32 crypto_int32
typedef int8 small;

typedef int16 Fq;
/* always represented as -(q-1)/2...(q-1)/2 */

#define q18 57 /* closest integer to 2^18/q */
#define q27 29235 /* closest integer to 2^27/q */

#include "crypto_decode_761xint16.h"
#define crypto_decode_pxint16 crypto_decode_761xint16

#include "crypto_encode_761xint16.h"
#define crypto_encode_pxint16 crypto_encode_761xint16

static inline int16x16_t squeeze_4591_x16(int16x16_t x){
    return sub_int16x16(x, mullo_int16x16(mulhrs_int16x16(x,dup_const_int16x16(7)),dup_const_int16x16(4591)));
}

#define signmask_x16(x) _mm256_srai_epi16((x),15)
static inline int16x16_t freeze_4591_x16(int16x16_t x){
    int16x16_t mask, xq;
    x = add_int16x16(x, dup_const_int16x16(q) & signmask_x16(x));
    mask = signmask_x16(sub_int16x16(x, dup_const_int16x16((q + 1) / 2)));
    xq = sub_int16x16(x, dup_const_int16x16(q));
    x = _mm256_blendv_epi8(xq, x, mask);
    return x;
}

int crypto_core(unsigned char *outbytes,const unsigned char *inbytes,const unsigned char *kbytes,const unsigned char *cbytes)
{

    int16_t poly1[NTT_N];
    int16_t poly2[NTT_N];
    int16_t *buff = poly1;

    int16x16_t scale;
    int16x16_t ti, tip, tip1;

    int16x16_t x;

    x = dup_const_int16x16(0);
    for (size_t i = p&~15; i < NTT_N; i += 16){
        store_int16x16((int16x16_t*)&poly1[i],x);
    }
    for (size_t i = p&~15; i < NTT_N; i += 16){
        store_int16x16((int16x16_t*)&poly2[i],x);
    }

    crypto_decode_pxint16(poly1, inbytes);

    for (size_t i = 0;i < 768;i += 16) {
        x = load_int16x16((int16x16_t*)&poly1[i]);
        x = freeze_4591_x16(squeeze_4591_x16(x));
        store_int16x16((int16x16_t*)&poly1[i],x);
    }
    for (size_t i = 0;i < p;++i) {
        int8_t gi = kbytes[i];
        int8_t gi0 = gi&1;
        poly2[i] = gi0-(gi&(gi0<<1));
    }

    mulcore(buff, poly1, poly2);

    scale = dup_const_int16x16(FINAL_SCALE_Rmod);

    buff[0] -= buff[p - 1];
    for(size_t i = 0; i < 768; i += 16){
        ti = load_int16x16((int16x16_t*)(buff + i));
        tip = load_int16x16((int16x16_t*)(buff + i + p));
        tip1 = load_int16x16((int16x16_t*)(buff + i + p - 1));
        ti = add_int16x16(ti, add_int16x16(tip, tip1));
        ti = freeze_4591_x16(montmulmod_int16x16(ti, scale));
        store_int16x16((int16x16_t*)(buff + i), ti);
    }
    crypto_encode_pxint16(outbytes, buff);

    return 0;
}
