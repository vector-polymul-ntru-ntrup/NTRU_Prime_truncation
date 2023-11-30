
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include "api.h"
#include "params.h"
#include "crypto_kem.h"
#include "poly_arith.h"
#include "polymul/NTT_params.h"
#include "polymul/polymul.h"
#include "polymul/rader.h"
#include "polymul/poly_basic.h"
#include "polymul/poly_vec.h"

#define NTESTS 1000

uint64_t time0, time1;
uint64_t cycles[NTESTS];

#ifdef __APPLE__

#include "m1cycles.h"
#define __AVERAGE__
#define SETUP_COUNTER() {(void)cycles; setup_rdtsc();}
#define CYCLE_TYPE "%lld"
#define GET_TIME rdtsc()

#else

#include "hal.h"
#undef __AVERAGE__
#define __MEDIAN__
#define SETUP_COUNTER() {}
#define CYCLE_TYPE "%ld"
#define GET_TIME hal_get_time()


static int cmp_uint64(const void *a, const void *b){
    return ((*((const uint64_t*)a)) - ((*((const uint64_t*)b))));
}

#endif

#ifdef __AVERAGE__

#define LOOP_INIT(__clock0, __clock1) { \
    __clock0 = GET_TIME; \
}
#define LOOP_TAIL(__f_string, records, __clock0, __clock1) { \
    __clock1 = GET_TIME; \
    printf(__f_string, (__clock1 - __clock0) / NTESTS); \
}
#define BODY_INIT(__clock0, __clock1) {}
#define BODY_TAIL(records, __clock0, __clock1) {}

#elif defined(__MEDIAN__)

#define LOOP_INIT(__clock0, __clock1) {}
#define LOOP_TAIL(__f_string, records, __clock0, __clock1) { \
    qsort(records, sizeof(uint64_t), NTESTS, cmp_uint64); \
    printf(__f_string, records[NTESTS >> 1]); \
}
#define BODY_INIT(__clock0, __clock1) { \
    __clock0 = GET_TIME; \
}
#define BODY_TAIL(records, __clock0, __clock1) { \
    __clock1 = GET_TIME; \
    records[i] = __clock1 - __clock0; \
}

#endif

#define WRAP_FUNC(__f_string, records, __clock0, __clock1, func){ \
    LOOP_INIT(__clock0, __clock1); \
    for(size_t i = 0; i < NTESTS; i++){ \
        BODY_INIT(__clock0, __clock1); \
        func; \
        BODY_TAIL(records, __clock0, __clock1); \
    } \
    LOOP_TAIL(__f_string, records, __clock0, __clock1); \
}



int main()
{


    SETUP_COUNTER();

    int16_t src1[POLY_N], src2[POLY_N];
    int16_t des[POLY_N];

    int16_t poly1_NTT[51 * 32];
    int16x8_t poly1_CT[24 * 4], poly2_CT[24 * 4];
    int16x8_t poly1_Bruun[24 * 4], poly2_Bruun[24 * 4];
    int16x8_t buff0[32];
    int16x8_t buff1[32];
    int16x8_t buff2[32];
    // int16_t t_res[POLY_N];
    int16_t *res_NTT = poly1_NTT;
    int16x8_t *res_CT = poly1_CT;
    int16x8_t *res_Bruun = poly1_Bruun;
    int16x8_t *poly1_CT_ptr;
    int16x8_t *poly2_CT_ptr;
    int16x8_t *res_CT_ptr;
    int16x8_t *poly1_Bruun_ptr;
    int16x8_t *poly2_Bruun_ptr;
    int16x8_t *res_Bruun_ptr;
    int16x8_t *twiddle_ptr;

    WRAP_FUNC("polymul (Z_q[x] / (x^1632 - 1)): " CYCLE_TYPE " \n",
            cycles, time0, time1,
            polymul(des, src1, src2));

    WRAP_FUNC("Rader-17 (x24): " CYCLE_TYPE " (x24)\n",
            cycles, time0, time1,
            __asm_rader_17_mix_pre((int16x8_t*)(poly1_NTT), (int16x8_t*)src1, in_table[0], twiddle_permutedx8));


    WRAP_FUNC("Radix-(3, 2) (x2): " CYCLE_TYPE " (x2)\n",
            cycles, time0, time1,
            __asm_radix32(poly1_NTT, radix3_args));

    WRAP_FUNC("CT + transpose (x2): " CYCLE_TYPE " (x2)\n",
            cycles, time0, time1,
            __asm_transpose_CT(poly1_CT, poly1_NTT, (int16x8_t*)streamlined_CT_table, Q));


    WRAP_FUNC("Bruun + transpose (x2): " CYCLE_TYPE " (x2)\n",
            cycles, time0, time1,
             __asm_transpose_Bruun(poly1_Bruun, poly1_NTT + 16, (int16x8_t*)streamlined_Bruun_table, Q));

    poly1_CT_ptr = poly1_CT;
    poly2_CT_ptr = poly2_CT;
    res_CT_ptr = poly1_CT_ptr;
    twiddle_ptr = (int16x8_t*)streamlined_CT_mul_table;
    WRAP_FUNC("weighted 8x8 (x12): " CYCLE_TYPE " (x12)\n",
            cycles, time0, time1,
            __asm_weighted8x8(res_CT_ptr + 0 * 8, poly1_CT_ptr + 0 * 8, poly2_CT_ptr + 0 * 8, twiddle_ptr + 0));

    poly1_Bruun_ptr = poly1_Bruun;
    poly2_Bruun_ptr = poly2_Bruun;
    res_Bruun_ptr = poly1_Bruun_ptr;
    twiddle_ptr = (int16x8_t*)streamlined_Bruun_table;
    WRAP_FUNC("trinomial 8x8 (x12): " CYCLE_TYPE " (x12)\n",
            cycles, time0, time1,
            __asm_Bruun_GF_mul(res_Bruun_ptr + 0 * 8, poly1_Bruun_ptr + 0 * 8, poly2_Bruun_ptr + 0 * 8, twiddle_ptr + 8));

    WRAP_FUNC("transpose + GS (x1): " CYCLE_TYPE " (x1)\n",
            cycles, time0, time1,
            __asm_transpose_GS(res_NTT, res_CT, (int16x8_t*)streamlined_GS_table, Q));


    WRAP_FUNC("transpose + iBruun (x1): " CYCLE_TYPE " (x1)\n",
            cycles, time0, time1,
            __asm_transpose_iBruun(res_NTT + 16, res_Bruun, (int16x8_t*)streamlined_Bruun_table, Q));


    WRAP_FUNC("weighted 16x16 (x1): " CYCLE_TYPE " (x1)\n",
            cycles, time0, time1,
            weighted_Rmod_16x16_x8(buff2, buff0, buff1, lastwlo, lastwhi));

    WRAP_FUNC("Radix-(3, 2) inverse (x1): " CYCLE_TYPE " (x1)\n",
            cycles, time0, time1,
            __asm_radix32(res_NTT, iradix3_args));


    WRAP_FUNC("Radix-17 inverse (x12): " CYCLE_TYPE " (x12)\n",
            cycles, time0, time1,
            __asm_rader_17_mix_post((int16x8_t*)(des), (int16x8_t*)(res_NTT), in_table[0], twiddle_inv_permutedx8));






  return 0;

}






