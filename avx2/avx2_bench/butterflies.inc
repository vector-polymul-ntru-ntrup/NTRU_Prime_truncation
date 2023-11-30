
#include "basemul_core.inc"

// 6, 8
.macro Bruun c0, c1, c2, c3, a0, a1, a2, a3, twiddle_mem, _q_mem, _qinv_mem

        vpsubw      %ymm\a2, %ymm\a0, %ymm\a0
        vpaddw      %ymm\a3, %ymm\a1, %ymm\a1

        montgomery_mul_mem \a3, \a3, \twiddle_mem, \_q_mem, \_qinv_mem, \c0, \c2
        montgomery_mul_mem \a2, \a2, \twiddle_mem, \_q_mem, \_qinv_mem, \c1, \c3

        vpaddw       %ymm\a3,  %ymm\a0,  %ymm\c0
        vpsubw       %ymm\a3,  %ymm\a0,  %ymm\c2
        vpsubw       %ymm\a2,  %ymm\a1,  %ymm\c1
        vpaddw       %ymm\a2,  %ymm\a1,  %ymm\c3

.endm

// 12, 16
.macro Bruunx2 c0, c1, c2, c3, a0, a1, a2, a3, c4, c5, c6, c7, a4, a5, a6, a7, twiddle_mem, _q_mem, _qinv_mem

        vpsubw      %ymm\a2, %ymm\a0, %ymm\a0
        vpaddw      %ymm\a3, %ymm\a1, %ymm\a1

        vpsubw      %ymm\a6, %ymm\a4, %ymm\a4
        vpaddw      %ymm\a7, %ymm\a5, %ymm\a5

        montgomery_mul_mem \a3, \a3, \twiddle_mem, \_q_mem, \_qinv_mem, \c1, \c3
        montgomery_mul_mem \a2, \a2, \twiddle_mem, \_q_mem, \_qinv_mem, \c0, \c2

        montgomery_mul_mem \a7, \a7, \twiddle_mem, \_q_mem, \_qinv_mem, \c5, \c7
        montgomery_mul_mem \a6, \a6, \twiddle_mem, \_q_mem, \_qinv_mem, \c4, \c6

        vpaddw       %ymm\a3,  %ymm\a0,  %ymm\c0
        vpsubw       %ymm\a3,  %ymm\a0,  %ymm\c2
        vpsubw       %ymm\a2,  %ymm\a1,  %ymm\c1
        vpaddw       %ymm\a2,  %ymm\a1,  %ymm\c3

        vpaddw       %ymm\a7,  %ymm\a4,  %ymm\c4
        vpsubw       %ymm\a7,  %ymm\a4,  %ymm\c6
        vpsubw       %ymm\a6,  %ymm\a5,  %ymm\c5
        vpaddw       %ymm\a6,  %ymm\a5,  %ymm\c7

.endm

// notice that c2 and c3 should be swapped after this call
// 6, 8
.macro iBruun c0, c1, c2, c3, a0, a1, a2, a3, twiddle_mem, _q_mem, _qinv_mem

        vpaddw       %ymm\a2,  %ymm\a0,  %ymm\c0
        vpsubw       %ymm\a2,  %ymm\a0,  %ymm\c2
        vpaddw       %ymm\a1,  %ymm\a3,  %ymm\c1
        vpsubw       %ymm\a1,  %ymm\a3,  %ymm\c3

        montgomery_mul_mem \c2, \c2, \twiddle_mem, \_q_mem, \_qinv_mem, \a0, \a2
        montgomery_mul_mem \c3, \c3, \twiddle_mem, \_q_mem, \_qinv_mem, \a1, \a3

        vpaddw       %ymm\c3,  %ymm\c0,  %ymm\c0
        vpsubw       %ymm\c2,  %ymm\c1,  %ymm\c1

.endm

// notice that c2 and c3 should be swapped, same for c6 and c7
// 12, 16
.macro iBruunx2 c0, c1, c2, c3, a0, a1, a2, a3, c4, c5, c6, c7, a4, a5, a6, a7, twiddle_mem, _q_mem, _qinv_mem

        vpaddw       %ymm\a2,  %ymm\a0,  %ymm\c0
        vpsubw       %ymm\a2,  %ymm\a0,  %ymm\c2
        vpaddw       %ymm\a1,  %ymm\a3,  %ymm\c1
        vpsubw       %ymm\a1,  %ymm\a3,  %ymm\c3

        vpaddw       %ymm\a6,  %ymm\a4,  %ymm\c4
        vpsubw       %ymm\a6,  %ymm\a4,  %ymm\c6
        vpaddw       %ymm\a5,  %ymm\a7,  %ymm\c5
        vpsubw       %ymm\a5,  %ymm\a7,  %ymm\c7

        montgomery_mul_mem \c2, \c2, \twiddle_mem, \_q_mem, \_qinv_mem, \a0, \a2
        montgomery_mul_mem \c3, \c3, \twiddle_mem, \_q_mem, \_qinv_mem, \a1, \a3

        montgomery_mul_mem \c6, \c6, \twiddle_mem, \_q_mem, \_qinv_mem, \a4, \a6
        montgomery_mul_mem \c7, \c7, \twiddle_mem, \_q_mem, \_qinv_mem, \a5, \a7

        vpaddw       %ymm\c3,  %ymm\c0,  %ymm\c0
        vpsubw       %ymm\c2,  %ymm\c1,  %ymm\c1

        vpaddw       %ymm\c7,  %ymm\c4,  %ymm\c4
        vpsubw       %ymm\c6,  %ymm\c5,  %ymm\c5

.endm




