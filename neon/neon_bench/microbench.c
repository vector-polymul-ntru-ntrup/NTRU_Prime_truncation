
#include <stdio.h>
#include <stdint.h>
#include <assert.h>
#include <memory.h>

#include "tools.h"
#include "naive_mult.h"

#include "params.h"
#include "NTT_params.h"

#include "ring.h"

#include "__neon_basemul.h"
#include "polymul.h"

#include "hal.h"

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

int main(void){

    int16_t poly1[_POLY_N];
    int16_t poly1_NTT[_POLY_N], poly2_NTT[_POLY_N];
    int16_t res[_POLY_N];
    int16_t res_NTT[_POLY_N];

    SETUP_COUNTER();

    WRAP_FUNC("__asm_rader17_primitive: " CYCLE_TYPE "\n",
            cycles, time0, time1,
            __asm_rader17_primitive(poly1_NTT, poly1, twiddle_rader17_permuted, const_buff));

    WRAP_FUNC("__asm_3x2_twistx2: " CYCLE_TYPE "\n",
            cycles, time0, time1,
            __asm_3x2_twistx2(poly1_NTT, twist_table_lohi, twist_16x6x16_table_lohi, _3x2_twiddle));

    WRAP_FUNC("__asm_cyclic_Toeplitz16_doubling_full: " CYCLE_TYPE "\n",
            cycles, time0, time1,
            __asm_cyclic_Toeplitz16_doubling_full(res_NTT, poly1_NTT, poly2_NTT, const_buff));

    WRAP_FUNC("__asm_negacyclic_Toeplitz16_doubling_full: " CYCLE_TYPE "\n",
            cycles, time0, time1,
            __asm_negacyclic_Toeplitz16_doubling_full(res_NTT + 16, poly1_NTT + 16, poly2_NTT + 16, const_buff));

    WRAP_FUNC("__asm_irader17_primitive: " CYCLE_TYPE "\n",
            cycles, time0, time1,
            __asm_irader17_primitive(res, res_NTT, twiddle_irader17_permuted, const_buff));


    printf("microbench finished!\n");


}


