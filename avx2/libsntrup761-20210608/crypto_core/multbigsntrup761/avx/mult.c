
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

int crypto_core(unsigned char *outbytes,const unsigned char *inbytes,const unsigned char *kbytes,const unsigned char *cbytes)
{

    int16_t poly1[NTT_N];
    int16_t poly2[NTT_N];
    int16_t *buff = poly1;

    int16x16_t scale;
    int16x16_t ti, tip, tip1;

    crypto_decode_pxint16(poly1, inbytes);
    crypto_decode_pxint16(poly2, kbytes);

    for(size_t i = p; i < NTT_N; i++){
        poly1[i] = 0;
    }
    for(size_t i = p; i < NTT_N; i++){
        poly2[i] = 0;
    }

    mulcore(buff, poly1, poly2);

    scale = dup_const_int16x16(FINAL_SCALE_Rmod);

    buff[0] -= buff[p - 1];
    for(size_t i = 0; i < 768; i += 16){
        ti = load_int16x16((int16x16_t*)(buff + i));
        tip = load_int16x16((int16x16_t*)(buff + i + p));
        tip1 = load_int16x16((int16x16_t*)(buff + i + p - 1));
        ti = add_int16x16(ti, add_int16x16(tip, tip1));
        ti = montmulmod_int16x16(ti, scale);
        store_int16x16((int16x16_t*)(buff + i), ti);
    }
    crypto_encode_pxint16(outbytes, buff);


    return 0;
}
