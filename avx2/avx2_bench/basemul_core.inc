#ifndef BASEMUL_CORE_INC
#define BASEMUL_CORE_INC


#include "permute.inc"

.macro montgomery_mul des, src1, src2, _q, _qinv, lo, hi

        vpmullw  %ymm\src2, %ymm\src1,  %ymm\lo
        vpmulhw  %ymm\src2, %ymm\src1,  %ymm\hi
        vpmullw %ymm\_qinv,   %ymm\lo,  %ymm\lo
        vpmulhw    %ymm\_q,   %ymm\lo,  %ymm\lo
        vpsubw     %ymm\lo,   %ymm\hi, %ymm\des

.endm

.macro montgomery_mulx2 des0, des1, src01, src11, src02, src12, _q, _qinv, lo0, lo1, hi0, hi1

        vpmullw %ymm\src02, %ymm\src01,  %ymm\lo0
        vpmullw %ymm\src12, %ymm\src11,  %ymm\lo1
        vpmulhw %ymm\src02, %ymm\src01,  %ymm\hi0
        vpmulhw %ymm\src12, %ymm\src11,  %ymm\hi1
        vpmullw %ymm\_qinv,   %ymm\lo0,  %ymm\lo0
        vpmullw %ymm\_qinv,   %ymm\lo1,  %ymm\lo1
        vpmulhw    %ymm\_q,   %ymm\lo0,  %ymm\lo0
        vpmulhw    %ymm\_q,   %ymm\lo1,  %ymm\lo1
        vpsubw    %ymm\lo0,   %ymm\hi0, %ymm\des0
        vpsubw    %ymm\lo1,   %ymm\hi1, %ymm\des1

.endm

.macro montgomery_mul_precompute des, src1, src2, src2inv, _q, lo, hi

        vpmullw  %ymm\src2inv, %ymm\src1,  %ymm\lo
        vpmulhw     %ymm\src2, %ymm\src1,  %ymm\hi
        vpmulhw       %ymm\_q,   %ymm\lo,  %ymm\lo
        vpsubw        %ymm\lo,   %ymm\hi, %ymm\des

.endm

.macro montgomery_mul_precompute_mem des, src1, src2, src2inv_mem, _q, lo, hi

        vpmullw  \src2inv_mem, %ymm\src1,  %ymm\lo
        vpmulhw     %ymm\src2, %ymm\src1,  %ymm\hi
        vpmulhw       %ymm\_q,   %ymm\lo,  %ymm\lo
        vpsubw        %ymm\lo,   %ymm\hi, %ymm\des

.endm

.macro montgomery_mul_constmem des, src1, src2, _q_mem, _qinv_mem, lo, hi

        vpmullw  %ymm\src2, %ymm\src1,  %ymm\lo
        vpmulhw  %ymm\src2, %ymm\src1,  %ymm\hi
        vpmullw \_qinv_mem,   %ymm\lo,  %ymm\lo
        vpmulhw    \_q_mem,   %ymm\lo,  %ymm\lo
        vpsubw     %ymm\lo,   %ymm\hi, %ymm\des

.endm

.macro montgomery_mul_constmemx2 des0, des1, src01, src11, src02, src12, _q_mem, _qinv_mem, lo0, lo1, hi0, hi1

        vpmullw %ymm\src02, %ymm\src01,  %ymm\lo0
        vpmullw %ymm\src12, %ymm\src11,  %ymm\lo1
        vpmulhw %ymm\src02, %ymm\src01,  %ymm\hi0
        vpmulhw %ymm\src12, %ymm\src11,  %ymm\hi1
        vpmullw \_qinv_mem,   %ymm\lo0,  %ymm\lo0
        vpmullw \_qinv_mem,   %ymm\lo1,  %ymm\lo1
        vpmulhw    \_q_mem,   %ymm\lo0,  %ymm\lo0
        vpmulhw    \_q_mem,   %ymm\lo1,  %ymm\lo1
        vpsubw    %ymm\lo0,   %ymm\hi0, %ymm\des0
        vpsubw    %ymm\lo1,   %ymm\hi1, %ymm\des1

.endm

.macro montgomery_mul_mem des, src1, src2_mem, _q_mem, _qinv_mem, lo, hi

        vpmullw  \src2_mem, %ymm\src1,  %ymm\lo
        vpmulhw  \src2_mem, %ymm\src1,  %ymm\hi
        vpmullw \_qinv_mem,   %ymm\lo,  %ymm\lo
        vpmulhw    \_q_mem,   %ymm\lo,  %ymm\lo
        vpsubw     %ymm\lo,   %ymm\hi, %ymm\des

.endm

.macro montgomery_mul_memx2 des0, des1, src01, src11, src02_mem, src12_mem, _q_mem, _qinv_mem, lo0, lo1, hi0, hi1

        vpmullw  \src02_mem, %ymm\src01,  %ymm\lo0
        vpmullw  \src12_mem, %ymm\src11,  %ymm\lo1
        vpmulhw  \src02_mem, %ymm\src01,  %ymm\hi0
        vpmulhw  \src12_mem, %ymm\src11,  %ymm\hi1
        vpmullw  \_qinv_mem,   %ymm\lo0,  %ymm\lo0
        vpmullw  \_qinv_mem,   %ymm\lo1,  %ymm\lo1
        vpmulhw     \_q_mem,   %ymm\lo0,  %ymm\lo0
        vpmulhw     \_q_mem,   %ymm\lo1,  %ymm\lo1
        vpsubw     %ymm\lo0,   %ymm\hi0, %ymm\des0
        vpsubw     %ymm\lo1,   %ymm\hi1, %ymm\des1

.endm

.macro barrett_reduce des, src, _q, _qbar, t

        vpmulhrsw %ymm\src, %ymm\_qbar,   %ymm\t
        vpmullw     %ymm\t,    %ymm\_q,   %ymm\t
        vpsubw      %ymm\t,   %ymm\src, %ymm\des

.endm

.macro barrett_reducex2 des0, des1, src0, src1, _q, _qbar, t0, t1

        vpmulhrsw %ymm\src0,  %ymm\_qbar,   %ymm\t0
        vpmulhrsw %ymm\src1,  %ymm\_qbar,   %ymm\t1
        vpmullw     %ymm\t0,     %ymm\_q,   %ymm\t0
        vpmullw     %ymm\t1,     %ymm\_q,   %ymm\t1
        vpsubw      %ymm\t0,   %ymm\src0, %ymm\des0
        vpsubw      %ymm\t1,   %ymm\src1, %ymm\des1

.endm

.macro barrett_reducex3 des0, des1, des2, src0, src1, src2, _q, _qbar, t0, t1, t2

        vpmulhrsw %ymm\src0,  %ymm\_qbar,   %ymm\t0
        vpmulhrsw %ymm\src1,  %ymm\_qbar,   %ymm\t1
        vpmulhrsw %ymm\src2,  %ymm\_qbar,   %ymm\t2
        vpmullw     %ymm\t0,     %ymm\_q,   %ymm\t0
        vpmullw     %ymm\t1,     %ymm\_q,   %ymm\t1
        vpmullw     %ymm\t2,     %ymm\_q,   %ymm\t2
        vpsubw      %ymm\t0,   %ymm\src0, %ymm\des0
        vpsubw      %ymm\t1,   %ymm\src1, %ymm\des1
        vpsubw      %ymm\t2,   %ymm\src2, %ymm\des2

.endm

.macro barrett_reduce_constmem des, src, _q_mem, _qbar_mem, t

        vpmulhrsw \_qbar_mem,  %ymm\src,   %ymm\t
        vpmullw      \_q_mem,    %ymm\t,   %ymm\t
        vpsubw        %ymm\t,  %ymm\src, %ymm\des

.endm

.macro barrett_reduce_constmemx2 des0, des1, src0, src1, _q_mem, _qbar_mem, t0, t1

        vpmulhrsw \_qbar_mem, %ymm\src0,  %ymm\t0
        vpmulhrsw \_qbar_mem, %ymm\src1,  %ymm\t1
        vpmullw      \_q_mem,   %ymm\t0,  %ymm\t0
        vpmullw      \_q_mem,   %ymm\t1,  %ymm\t1
        vpsubw       %ymm\t0, %ymm\src0, %ymm\des0
        vpsubw       %ymm\t1, %ymm\src1, %ymm\des1

.endm

.macro barrett_reduce_constmemx3 des0, des1, des2, src0, src1, src2, _q_mem, _qbar_mem, t0, t1, t2

        vpmulhrsw \_qbar_mem, %ymm\src0,  %ymm\t0
        vpmulhrsw \_qbar_mem, %ymm\src1,  %ymm\t1
        vpmulhrsw \_qbar_mem, %ymm\src2,  %ymm\t2
        vpmullw      \_q_mem,   %ymm\t0,  %ymm\t0
        vpmullw      \_q_mem,   %ymm\t1,  %ymm\t1
        vpmullw      \_q_mem,   %ymm\t2,  %ymm\t2
        vpsubw       %ymm\t0, %ymm\src0, %ymm\des0
        vpsubw       %ymm\t1, %ymm\src1, %ymm\des1
        vpsubw       %ymm\t2, %ymm\src2, %ymm\des2

.endm

.macro barrett_reduce_constmemx4 des0, des1, des2, des3, src0, src1, src2, src3, _q_mem, _qbar_mem, t0, t1, t2, t3

        vpmulhrsw \_qbar_mem, %ymm\src0,  %ymm\t0
        vpmulhrsw \_qbar_mem, %ymm\src1,  %ymm\t1
        vpmulhrsw \_qbar_mem, %ymm\src2,  %ymm\t2
        vpmulhrsw \_qbar_mem, %ymm\src3,  %ymm\t3
        vpmullw      \_q_mem,   %ymm\t0,  %ymm\t0
        vpmullw      \_q_mem,   %ymm\t1,  %ymm\t1
        vpmullw      \_q_mem,   %ymm\t2,  %ymm\t2
        vpmullw      \_q_mem,   %ymm\t3,  %ymm\t3
        vpsubw       %ymm\t0, %ymm\src0, %ymm\des0
        vpsubw       %ymm\t1, %ymm\src1, %ymm\des1
        vpsubw       %ymm\t2, %ymm\src2, %ymm\des2
        vpsubw       %ymm\t3, %ymm\src3, %ymm\des3

.endm

.macro barrett_reduce_neg des, src, _q, _qbar, t

        vpmulhrsw %ymm\src, %ymm\_qbar,   %ymm\t
        vpmullw     %ymm\t,    %ymm\_q,   %ymm\t
        vpsubw    %ymm\src,     %ymm\t, %ymm\des

.endm

.macro barrett_reduce_negx2 des0, des1, src0, src1, _q, _qbar, t0, t1

        vpmulhrsw %ymm\src0,  %ymm\_qbar,   %ymm\t0
        vpmulhrsw %ymm\src1,  %ymm\_qbar,   %ymm\t1
        vpmullw     %ymm\t0,     %ymm\_q,   %ymm\t0
        vpmullw     %ymm\t1,     %ymm\_q,   %ymm\t1
        vpsubw    %ymm\src0,     %ymm\t0, %ymm\des0
        vpsubw    %ymm\src1,     %ymm\t1, %ymm\des1

.endm

.macro barrett_reduce_negx3 des0, des1, des2, src0, src1, src2, _q, _qbar, t0, t1, t2

        vpmulhrsw %ymm\src0,  %ymm\_qbar,   %ymm\t0
        vpmulhrsw %ymm\src1,  %ymm\_qbar,   %ymm\t1
        vpmulhrsw %ymm\src2,  %ymm\_qbar,   %ymm\t2
        vpmullw     %ymm\t0,     %ymm\_q,   %ymm\t0
        vpmullw     %ymm\t1,     %ymm\_q,   %ymm\t1
        vpmullw     %ymm\t2,     %ymm\_q,   %ymm\t2
        vpsubw    %ymm\src0,     %ymm\t0, %ymm\des0
        vpsubw    %ymm\src1,     %ymm\t1, %ymm\des1
        vpsubw    %ymm\src2,     %ymm\t2, %ymm\des2

.endm

.macro __asm_schoolbook2_core des_ptr, des_i, \
        src1_0, src1_1, src2_0, src2_1, \
        _q, _qinv, \
        t0, t1, t2, t3, t4, t5, _zero

        montgomery_mul      \t1, \src1_0, \src2_1, \_q, \_qinv, \t4, \t5
        montgomery_mul      \t2, \src1_1, \src2_0, \_q, \_qinv, \t4, \t5
        vpaddw          %ymm\t2, %ymm\t1, %ymm\t1
        vmovdqu         %ymm\t1, (\des_i + 0x20)(\des_ptr)
        montgomery_mul      \t0, \src1_0, \src2_0, \_q, \_qinv, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x00)(\des_ptr)
        montgomery_mul      \t3, \src1_1, \src2_1, \_q, \_qinv, \t4, \t5
        vmovdqu         %ymm\t3, (\des_i + 0x40)(\des_ptr)

.endm

.macro __asm_cyclic_schoolbook2_core des_ptr, des_i, \
        src1_0, src1_1, src2_0, src2_1, \
        _q, _qinv, \
        t0, t1, t2, t3, t4, t5

        montgomery_mul      \t1, \src1_0, \src2_1, \_q, \_qinv, \t4, \t5
        montgomery_mul      \t2, \src1_1, \src2_0, \_q, \_qinv, \t4, \t5
        vpaddw          %ymm\t2, %ymm\t1, %ymm\t1
        vmovdqu         %ymm\t1, (\des_i + 0x20)(\des_ptr)
        montgomery_mul      \t0, \src1_0, \src2_0, \_q, \_qinv, \t4, \t5
        montgomery_mul      \t3, \src1_1, \src2_1, \_q, \_qinv, \t4, \t5
        vpaddw          %ymm\t3, %ymm\t0, %ymm\t0
        vmovdqu         %ymm\t0, (\des_i + 0x00)(\des_ptr)

.endm

.macro __asm_negacyclic_schoolbook2_core des_ptr, des_i, \
        src1_0, src1_1, src2_0, src2_1, \
        _q, _qinv, \
        t0, t1, t2, t3, t4, t5

        montgomery_mul      \t1, \src1_0, \src2_1, \_q, \_qinv, \t4, \t5
        montgomery_mul      \t2, \src1_1, \src2_0, \_q, \_qinv, \t4, \t5
        vpaddw          %ymm\t2, %ymm\t1, %ymm\t1
        vmovdqu         %ymm\t1, (\des_i + 0x20)(\des_ptr)
        montgomery_mul      \t0, \src1_0, \src2_0, \_q, \_qinv, \t4, \t5
        montgomery_mul      \t3, \src1_1, \src2_1, \_q, \_qinv, \t4, \t5
        vpsubw          %ymm\t3, %ymm\t0, %ymm\t0
        vmovdqu         %ymm\t0, (\des_i + 0x00)(\des_ptr)

.endm

.macro __asm_schoolbook4_core des_ptr, des_i, \
        src1_0, src1_1, src1_2, src1_3, \
        src2_0, src2_1, src2_2, src2_3, \
        _q, _qinv, _qinv_r, _qbar_r, \
        t0, t1, t2, t3, t4, t5

        montgomery_mul      \t0, \src1_0, \src2_0, \_q, \_qinv, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x00)(\des_ptr)

        montgomery_mul      \t0, \src1_0, \src2_1, \_q, \_qinv, \t4, \t5
        montgomery_mul      \t1, \src1_1, \src2_0, \_q, \_qinv, \t4, \t5
        vpaddw          %ymm\t1, %ymm\t0, %ymm\t0
        vmovdqu         %ymm\t0, (\des_i + 0x20)(\des_ptr)

        vpmullw     %ymm\src1_0, %ymm\src2_2, %ymm\t4
        vpmulhw     %ymm\src1_0, %ymm\src2_2, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5
        vpmullw     %ymm\src1_1, %ymm\src2_1, %ymm\t4
        vpmulhw     %ymm\src1_1, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd          %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd          %ymm\t3,  %ymm\t1,  %ymm\t1
        vpmullw     %ymm\src1_2, %ymm\src2_0, %ymm\t4
        vpmulhw     %ymm\src1_2, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd          %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd          %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor        %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv
        vmovdqu        \_qinv_r, %ymm\_qinv
        vpmullw         %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw         %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw          %ymm\t4,    %ymm\t5,  %ymm\t0
        vmovdqu        \_qinv_r, %ymm\_qinv
        vmovdqu         %ymm\t0, (\des_i + 0x40)(\des_ptr)

        vpmullw     %ymm\src1_0, %ymm\src2_3, %ymm\t4
        vpmulhw     %ymm\src1_0, %ymm\src2_3, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5
        vpmullw     %ymm\src1_1, %ymm\src2_2, %ymm\t4
        vpmulhw     %ymm\src1_1, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd          %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd          %ymm\t3,  %ymm\t1,  %ymm\t1
        vpmullw     %ymm\src1_2, %ymm\src2_1, %ymm\t4
        vpmulhw     %ymm\src1_2, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd          %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd          %ymm\t3,  %ymm\t1,  %ymm\t1
        vpmullw     %ymm\src1_3, %ymm\src2_0, %ymm\t4
        vpmulhw     %ymm\src1_3, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd          %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd          %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor        %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv
        vmovdqu        \_qinv_r, %ymm\_qinv
        vpmullw         %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw         %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw          %ymm\t4,    %ymm\t5,  %ymm\t0
        vmovdqu        \_qinv_r, %ymm\_qinv
        vmovdqu         %ymm\t0, (\des_i + 0x60)(\des_ptr)

        vpmullw     %ymm\src1_1, %ymm\src2_3, %ymm\t4
        vpmulhw     %ymm\src1_1, %ymm\src2_3, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5
        vpmullw     %ymm\src1_2, %ymm\src2_2, %ymm\t4
        vpmulhw     %ymm\src1_2, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd          %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd          %ymm\t3,  %ymm\t1,  %ymm\t1
        vpmullw     %ymm\src1_3, %ymm\src2_1, %ymm\t4
        vpmulhw     %ymm\src1_3, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd          %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd          %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor        %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv
        vmovdqu        \_qinv_r, %ymm\_qinv
        vpmullw         %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw         %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw          %ymm\t4,    %ymm\t5,  %ymm\t0
        vmovdqu        \_qinv_r, %ymm\_qinv
        vmovdqu         %ymm\t0, (\des_i + 0x80)(\des_ptr)

        montgomery_mul      \t0, \src1_2, \src2_3, \_q, \_qinv, \t4, \t5
        montgomery_mul      \t1, \src1_3, \src2_2, \_q, \_qinv, \t4, \t5
        vpaddw          %ymm\t1, %ymm\t0, %ymm\t0
        vmovdqu         %ymm\t0, (\des_i + 0xa0)(\des_ptr)

        montgomery_mul      \t0, \src1_3, \src2_3, \_q, \_qinv, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0xc0)(\des_ptr)

.endm

.macro __asm_schoolbook4_precompute_core des_ptr, src2inv_ptr, des_i, src2inv_i, \
        src1_0, src1_1, src1_2, src1_3, \
        src2_0, src2_1, src2_2, src2_3, \
        _q, _qinv, _qinv_r, _qbar_r, \
        t0, t1, t2, t3, t4, t5

        montgomery_mul_precompute_mem \t0, \src1_0, \src2_0, (\src2inv_i + 0x000)(\src2inv_ptr), \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x00)(\des_ptr)

        montgomery_mul_precompute_mem \t0, \src1_0, \src2_1, (\src2inv_i + 0x020)(\src2inv_ptr), \_q, \t4, \t5
        montgomery_mul_precompute_mem \t1, \src1_1, \src2_0, (\src2inv_i + 0x000)(\src2inv_ptr), \_q, \t4, \t5
        vpaddw          %ymm\t1, %ymm\t0, %ymm\t0
        vmovdqu         %ymm\t0, (\des_i + 0x20)(\des_ptr)

        montgomery_mul_precompute_mem \t0, \src1_0, \src2_2, (\src2inv_i + 0x040)(\src2inv_ptr), \_q, \t4, \t5
        montgomery_mul_precompute_mem \t1, \src1_1, \src2_1, (\src2inv_i + 0x020)(\src2inv_ptr), \_q, \t4, \t5
        montgomery_mul_precompute_mem \t2, \src1_2, \src2_0, (\src2inv_i + 0x000)(\src2inv_ptr), \_q, \t4, \t5
        vpaddw          %ymm\t1, %ymm\t0, %ymm\t0
        vpaddw          %ymm\t2, %ymm\t0, %ymm\t0
        vmovdqu         %ymm\t0, (\des_i + 0x40)(\des_ptr)

        montgomery_mul_precompute_mem \t0, \src1_0, \src2_3, (\src2inv_i + 0x060)(\src2inv_ptr), \_q, \t4, \t5
        montgomery_mul_precompute_mem \t1, \src1_1, \src2_2, (\src2inv_i + 0x040)(\src2inv_ptr), \_q, \t4, \t5
        montgomery_mul_precompute_mem \t2, \src1_2, \src2_1, (\src2inv_i + 0x020)(\src2inv_ptr), \_q, \t4, \t5
        montgomery_mul_precompute_mem \t3, \src1_3, \src2_0, (\src2inv_i + 0x000)(\src2inv_ptr), \_q, \t4, \t5
        vpaddw          %ymm\t1, %ymm\t0, %ymm\t0
        vpaddw          %ymm\t2, %ymm\t0, %ymm\t0
        vpaddw          %ymm\t3, %ymm\t0, %ymm\t0
        vmovdqu        \_qbar_r, %ymm\_qinv
        barrett_reduce      \t0,      \t0,    \_q, \_qinv, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x60)(\des_ptr)

        montgomery_mul_precompute_mem \t0, \src1_1, \src2_3, (\src2inv_i + 0x060)(\src2inv_ptr), \_q, \t4, \t5
        montgomery_mul_precompute_mem \t1, \src1_2, \src2_2, (\src2inv_i + 0x040)(\src2inv_ptr), \_q, \t4, \t5
        montgomery_mul_precompute_mem \t2, \src1_3, \src2_1, (\src2inv_i + 0x020)(\src2inv_ptr), \_q, \t4, \t5
        vpaddw          %ymm\t1, %ymm\t0, %ymm\t0
        vpaddw          %ymm\t2, %ymm\t0, %ymm\t0
        vmovdqu         %ymm\t0, (\des_i + 0x80)(\des_ptr)

        montgomery_mul_precompute_mem \t0, \src1_2, \src2_3, (\src2inv_i + 0x060)(\src2inv_ptr), \_q, \t4, \t5
        montgomery_mul_precompute_mem \t1, \src1_3, \src2_2, (\src2inv_i + 0x040)(\src2inv_ptr), \_q, \t4, \t5
        vpaddw          %ymm\t1, %ymm\t0, %ymm\t0
        vmovdqu         %ymm\t0, (\des_i + 0xa0)(\des_ptr)

        montgomery_mul_precompute_mem \t0, \src1_3, \src2_3, (\src2inv_i + 0x060)(\src2inv_ptr), \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0xc0)(\des_ptr)

.endm

.macro __asm_schoolbook4_mem_core des_ptr, des_i, \
        src1_0, src1_1, src1_2, src1_3, \
        src2_0_mem, src2_1_mem, src2_2_mem, src2_3_mem, \
        _q_mem, _qinv_mem, _qbar_mem, \
        t0, t1, t2, t3, t4, t5

        montgomery_mul_mem  \t0, \src1_0, \src2_0_mem, \_q_mem, \_qinv_mem, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x00)(\des_ptr)

        montgomery_mul_mem  \t0, \src1_0, \src2_1_mem, \_q_mem, \_qinv_mem, \t4, \t5
        montgomery_mul_mem  \t1, \src1_1, \src2_0_mem, \_q_mem, \_qinv_mem, \t4, \t5
        vpaddw          %ymm\t1, %ymm\t0, %ymm\t0
        vmovdqu         %ymm\t0, (\des_i + 0x20)(\des_ptr)

        montgomery_mul_mem  \t0, \src1_0, \src2_2_mem, \_q_mem, \_qinv_mem, \t4, \t5
        montgomery_mul_mem  \t1, \src1_1, \src2_1_mem, \_q_mem, \_qinv_mem, \t4, \t5
        montgomery_mul_mem  \t2, \src1_2, \src2_0_mem, \_q_mem, \_qinv_mem, \t4, \t5
        vpaddw          %ymm\t1, %ymm\t0, %ymm\t0
        vpaddw          %ymm\t2, %ymm\t0, %ymm\t0
        vmovdqu         %ymm\t0, (\des_i + 0x40)(\des_ptr)

        montgomery_mul_mem  \t0, \src1_0, \src2_3_mem, \_q_mem, \_qinv_mem, \t4, \t5
        montgomery_mul_mem  \t1, \src1_1, \src2_2_mem, \_q_mem, \_qinv_mem, \t4, \t5
        montgomery_mul_mem  \t2, \src1_2, \src2_1_mem, \_q_mem, \_qinv_mem, \t4, \t5
        montgomery_mul_mem  \t3, \src1_3, \src2_0_mem, \_q_mem, \_qinv_mem, \t4, \t5
        vpaddw          %ymm\t1, %ymm\t0, %ymm\t0
        vpaddw          %ymm\t2, %ymm\t0, %ymm\t0
        vpaddw          %ymm\t3, %ymm\t0, %ymm\t0
        barrett_reduce_constmem  \t0,     \t0,    \_q_mem, \_qbar_mem, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x60)(\des_ptr)

        montgomery_mul_mem  \t0, \src1_1, \src2_3_mem, \_q_mem, \_qinv_mem, \t4, \t5
        montgomery_mul_mem  \t1, \src1_2, \src2_2_mem, \_q_mem, \_qinv_mem, \t4, \t5
        montgomery_mul_mem  \t2, \src1_3, \src2_1_mem, \_q_mem, \_qinv_mem, \t4, \t5
        vpaddw          %ymm\t1, %ymm\t0, %ymm\t0
        vpaddw          %ymm\t2, %ymm\t0, %ymm\t0
        vmovdqu         %ymm\t0, (\des_i + 0x80)(\des_ptr)

        montgomery_mul_mem  \t0, \src1_2, \src2_3_mem, \_q_mem, \_qinv_mem, \t4, \t5
        montgomery_mul_mem  \t1, \src1_3, \src2_2_mem, \_q_mem, \_qinv_mem, \t4, \t5
        vpaddw          %ymm\t1, %ymm\t0, %ymm\t0
        vmovdqu         %ymm\t0, (\des_i + 0xa0)(\des_ptr)

        montgomery_mul_mem  \t0, \src1_3, \src2_3_mem, \_q_mem, \_qinv_mem, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0xc0)(\des_ptr)

.endm

.macro __asm_cyclic_schoolbook4_core des_ptr, des_i, \
        src1_0, src1_1, src1_2, src1_3, \
        src2_0, src2_1, src2_2, src2_3, \
        _q, _qinv, _qinv_r, _qbar_r, \
        t0, t1, t2, t3, t4, t5

        vpmullw        %ymm\src1_0, %ymm\src2_0, %ymm\t4
        vpmulhw        %ymm\src1_0, %ymm\src2_0, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw        %ymm\src1_1, %ymm\src2_3, %ymm\t4
        vpmulhw        %ymm\src1_1, %ymm\src2_3, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_2, %ymm\src2_2, %ymm\t4
        vpmulhw        %ymm\src1_2, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_3, %ymm\src2_1, %ymm\t4
        vpmulhw        %ymm\src1_3, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x00)(\des_ptr)

//

        vpmullw        %ymm\src1_0, %ymm\src2_1, %ymm\t4
        vpmulhw        %ymm\src1_0, %ymm\src2_1, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw        %ymm\src1_1, %ymm\src2_0, %ymm\t4
        vpmulhw        %ymm\src1_1, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_2, %ymm\src2_3, %ymm\t4
        vpmulhw        %ymm\src1_2, %ymm\src2_3, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_3, %ymm\src2_2, %ymm\t4
        vpmulhw        %ymm\src1_3, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x20)(\des_ptr)

//

        vpmullw        %ymm\src1_0, %ymm\src2_2, %ymm\t4
        vpmulhw        %ymm\src1_0, %ymm\src2_2, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw        %ymm\src1_1, %ymm\src2_1, %ymm\t4
        vpmulhw        %ymm\src1_1, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_2, %ymm\src2_0, %ymm\t4
        vpmulhw        %ymm\src1_2, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_3, %ymm\src2_3, %ymm\t4
        vpmulhw        %ymm\src1_3, %ymm\src2_3, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x40)(\des_ptr)

//

        vpmullw        %ymm\src1_0, %ymm\src2_3, %ymm\t4
        vpmulhw        %ymm\src1_0, %ymm\src2_3, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw        %ymm\src1_1, %ymm\src2_2, %ymm\t4
        vpmulhw        %ymm\src1_1, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_2, %ymm\src2_1, %ymm\t4
        vpmulhw        %ymm\src1_2, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_3, %ymm\src2_0, %ymm\t4
        vpmulhw        %ymm\src1_3, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x60)(\des_ptr)

.endm

.macro __asm_cyclic_schoolbook4_mem_core des_ptr, des_i, \
        src1_mem0, src1_mem1, src1_mem2, src1_mem3, \
        src2_0, src2_1, src2_2, src2_3, \
        _q, _qinv, _qinv_r, _qbar_r, \
        t0, t1, t2, t3, t4, t5

        vpmullw     \src1_mem0, %ymm\src2_0, %ymm\t4
        vpmulhw     \src1_mem0, %ymm\src2_0, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw     \src1_mem1, %ymm\src2_3, %ymm\t4
        vpmulhw     \src1_mem1, %ymm\src2_3, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem2, %ymm\src2_2, %ymm\t4
        vpmulhw     \src1_mem2, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem3, %ymm\src2_1, %ymm\t4
        vpmulhw     \src1_mem3, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x00)(\des_ptr)

//

        vpmullw     \src1_mem0, %ymm\src2_1, %ymm\t4
        vpmulhw     \src1_mem0, %ymm\src2_1, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw     \src1_mem1, %ymm\src2_0, %ymm\t4
        vpmulhw     \src1_mem1, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem2, %ymm\src2_3, %ymm\t4
        vpmulhw     \src1_mem2, %ymm\src2_3, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem3, %ymm\src2_2, %ymm\t4
        vpmulhw     \src1_mem3, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x20)(\des_ptr)

//

        vpmullw     \src1_mem0, %ymm\src2_2, %ymm\t4
        vpmulhw     \src1_mem0, %ymm\src2_2, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw     \src1_mem1, %ymm\src2_1, %ymm\t4
        vpmulhw     \src1_mem1, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem2, %ymm\src2_0, %ymm\t4
        vpmulhw     \src1_mem2, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem3, %ymm\src2_3, %ymm\t4
        vpmulhw     \src1_mem3, %ymm\src2_3, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x40)(\des_ptr)

//

        vpmullw     \src1_mem0, %ymm\src2_3, %ymm\t4
        vpmulhw     \src1_mem0, %ymm\src2_3, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw     \src1_mem1, %ymm\src2_2, %ymm\t4
        vpmulhw     \src1_mem1, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem2, %ymm\src2_1, %ymm\t4
        vpmulhw     \src1_mem2, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem3, %ymm\src2_0, %ymm\t4
        vpmulhw     \src1_mem3, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x60)(\des_ptr)

.endm

.macro __asm_negacyclic_schoolbook4_core des_ptr, des_i, \
        src1_0, src1_1, src1_2, src1_3, \
        src2_0, src2_1, src2_2, src2_3, \
        _q, _qinv, _qinv_r, _qbar_r, \
        t0, t1, t2, t3, t4, t5

        vpmullw        %ymm\src1_0, %ymm\src2_0, %ymm\t4
        vpmulhw        %ymm\src1_0, %ymm\src2_0, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw        %ymm\src1_1, %ymm\src2_3, %ymm\t4
        vpmulhw        %ymm\src1_1, %ymm\src2_3, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpsubd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpsubd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_2, %ymm\src2_2, %ymm\t4
        vpmulhw        %ymm\src1_2, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpsubd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpsubd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_3, %ymm\src2_1, %ymm\t4
        vpmulhw        %ymm\src1_3, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpsubd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpsubd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x00)(\des_ptr)

//

        vpmullw        %ymm\src1_0, %ymm\src2_1, %ymm\t4
        vpmulhw        %ymm\src1_0, %ymm\src2_1, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw        %ymm\src1_1, %ymm\src2_0, %ymm\t4
        vpmulhw        %ymm\src1_1, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_2, %ymm\src2_3, %ymm\t4
        vpmulhw        %ymm\src1_2, %ymm\src2_3, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpsubd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpsubd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_3, %ymm\src2_2, %ymm\t4
        vpmulhw        %ymm\src1_3, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpsubd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpsubd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x20)(\des_ptr)

//

        vpmullw        %ymm\src1_0, %ymm\src2_2, %ymm\t4
        vpmulhw        %ymm\src1_0, %ymm\src2_2, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw        %ymm\src1_1, %ymm\src2_1, %ymm\t4
        vpmulhw        %ymm\src1_1, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_2, %ymm\src2_0, %ymm\t4
        vpmulhw        %ymm\src1_2, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_3, %ymm\src2_3, %ymm\t4
        vpmulhw        %ymm\src1_3, %ymm\src2_3, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpsubd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpsubd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x40)(\des_ptr)

//

        vpmullw        %ymm\src1_0, %ymm\src2_3, %ymm\t4
        vpmulhw        %ymm\src1_0, %ymm\src2_3, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw        %ymm\src1_1, %ymm\src2_2, %ymm\t4
        vpmulhw        %ymm\src1_1, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_2, %ymm\src2_1, %ymm\t4
        vpmulhw        %ymm\src1_2, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw        %ymm\src1_3, %ymm\src2_0, %ymm\t4
        vpmulhw        %ymm\src1_3, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x60)(\des_ptr)

.endm

.macro __asm_negacyclic_schoolbook4_mem_core des_ptr, des_i, \
        src1_mem0, src1_mem1, src1_mem2, src1_mem3, \
        src2_0, src2_1, src2_2, src2_3, \
        _q, _qinv, _qinv_r, _qbar_r, \
        t0, t1, t2, t3, t4, t5

        vpmullw     \src1_mem0, %ymm\src2_0, %ymm\t4
        vpmulhw     \src1_mem0, %ymm\src2_0, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw     \src1_mem1, %ymm\src2_3, %ymm\t4
        vpmulhw     \src1_mem1, %ymm\src2_3, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpsubd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpsubd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem2, %ymm\src2_2, %ymm\t4
        vpmulhw     \src1_mem2, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpsubd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpsubd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem3, %ymm\src2_1, %ymm\t4
        vpmulhw     \src1_mem3, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpsubd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpsubd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x00)(\des_ptr)

//

        vpmullw     \src1_mem0, %ymm\src2_1, %ymm\t4
        vpmulhw     \src1_mem0, %ymm\src2_1, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw     \src1_mem1, %ymm\src2_0, %ymm\t4
        vpmulhw     \src1_mem1, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem2, %ymm\src2_3, %ymm\t4
        vpmulhw     \src1_mem2, %ymm\src2_3, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpsubd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpsubd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem3, %ymm\src2_2, %ymm\t4
        vpmulhw     \src1_mem3, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpsubd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpsubd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x20)(\des_ptr)

//

        vpmullw     \src1_mem0, %ymm\src2_2, %ymm\t4
        vpmulhw     \src1_mem0, %ymm\src2_2, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw     \src1_mem1, %ymm\src2_1, %ymm\t4
        vpmulhw     \src1_mem1, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem2, %ymm\src2_0, %ymm\t4
        vpmulhw     \src1_mem2, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem3, %ymm\src2_3, %ymm\t4
        vpmulhw     \src1_mem3, %ymm\src2_3, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpsubd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpsubd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x40)(\des_ptr)

//

        vpmullw     \src1_mem0, %ymm\src2_3, %ymm\t4
        vpmulhw     \src1_mem0, %ymm\src2_3, %ymm\t5
        __asm_interleave \t0, \t1, \t4, \t5

        vpmullw     \src1_mem1, %ymm\src2_2, %ymm\t4
        vpmulhw     \src1_mem1, %ymm\src2_2, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem2, %ymm\src2_1, %ymm\t4
        vpmulhw     \src1_mem2, %ymm\src2_1, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpmullw     \src1_mem3, %ymm\src2_0, %ymm\t4
        vpmulhw     \src1_mem3, %ymm\src2_0, %ymm\t5
        __asm_interleave \t2, \t3, \t4, \t5
        vpaddd         %ymm\t2,  %ymm\t0,  %ymm\t0
        vpaddd         %ymm\t3,  %ymm\t1,  %ymm\t1

        vpxor          %ymm\_qinv, %ymm\_qinv, %ymm\_qinv
        __asm_deinterleave \t4, \t5, \t0, \t1, \t2, \t3, \_qinv

        vmovdqu       \_qinv_r, %ymm\_qinv

        vpmullw       %ymm\t4, %ymm\_qinv,  %ymm\t4
        vpmulhw       %ymm\t4,    %ymm\_q,  %ymm\t4
        vpsubw        %ymm\t4,    %ymm\t5,  %ymm\t0

        vmovdqu         \_qbar_r, %ymm\t4
        barrett_reduce      \t0,      \t0,    \_q, \t4, \t5
        vmovdqu         %ymm\t0, (\des_i + 0x60)(\des_ptr)

.endm

.macro __asm_karatsuba8_core des_ptr, src1_ptr, src2_ptr, buff_ptr, des_i, src1_i, src2_i, buff_i, \
        _q_r, _qinv_r, _qbar_r

        vmovdqu  (\src1_i + 0x00)(\src1_ptr),  %ymm0
        vmovdqu  (\src1_i + 0x20)(\src1_ptr),  %ymm1
        vmovdqu  (\src1_i + 0x40)(\src1_ptr),  %ymm2
        vmovdqu  (\src1_i + 0x60)(\src1_ptr),  %ymm3

        vpaddw   (\src1_i + 0x80)(\src1_ptr),  %ymm0,  %ymm8
        vpaddw   (\src1_i + 0xa0)(\src1_ptr),  %ymm1,  %ymm9
        vpaddw   (\src1_i + 0xc0)(\src1_ptr),  %ymm2, %ymm10
        vpaddw   (\src1_i + 0xe0)(\src1_ptr),  %ymm3, %ymm11

        vmovdqu  (\src2_i + 0x00)(\src2_ptr),  %ymm0
        vmovdqu  (\src2_i + 0x20)(\src2_ptr),  %ymm1
        vmovdqu  (\src2_i + 0x40)(\src2_ptr),  %ymm2
        vmovdqu  (\src2_i + 0x60)(\src2_ptr),  %ymm3

        vpaddw   (\src2_i + 0x80)(\src2_ptr),  %ymm0, %ymm12
        vpaddw   (\src2_i + 0xa0)(\src2_ptr),  %ymm1, %ymm13
        vpaddw   (\src2_i + 0xc0)(\src2_ptr),  %ymm2, %ymm14
        vpaddw   (\src2_i + 0xe0)(\src2_ptr),  %ymm3, %ymm15

        vmovdqu      \_q_r,  %ymm6
        vmovdqu   \_qinv_r,  %ymm7

        __asm_schoolbook4_core \buff_ptr, \buff_i + 0x000, \
                8, 9, 10, 11, \
                12, 13, 14, 15, \
                6, 7, \_qinv_r, \_qbar_r, \
                0, 1, 2, 3, 4, 5

        vmovdqu  (\src1_i + 0x000)(\src1_ptr),  %ymm8
        vmovdqu  (\src1_i + 0x020)(\src1_ptr),  %ymm9
        vmovdqu  (\src1_i + 0x040)(\src1_ptr), %ymm10
        vmovdqu  (\src1_i + 0x060)(\src1_ptr), %ymm11
        vmovdqu  (\src2_i + 0x000)(\src2_ptr), %ymm12
        vmovdqu  (\src2_i + 0x020)(\src2_ptr), %ymm13
        vmovdqu  (\src2_i + 0x040)(\src2_ptr), %ymm14
        vmovdqu  (\src2_i + 0x060)(\src2_ptr), %ymm15

        __asm_schoolbook4_core \des_ptr, \des_i + 0x000, \
                8, 9, 10, 11, \
                12, 13, 14, 15, \
                6, 7, \_qinv_r, \_qbar_r, \
                0, 1, 2, 3, 4, 5

        vmovdqu  (\src1_i + 0x080)(\src1_ptr),  %ymm8
        vmovdqu  (\src1_i + 0x0a0)(\src1_ptr),  %ymm9
        vmovdqu  (\src1_i + 0x0c0)(\src1_ptr), %ymm10
        vmovdqu  (\src1_i + 0x0e0)(\src1_ptr), %ymm11
        vmovdqu  (\src2_i + 0x080)(\src2_ptr), %ymm12
        vmovdqu  (\src2_i + 0x0a0)(\src2_ptr), %ymm13
        vmovdqu  (\src2_i + 0x0c0)(\src2_ptr), %ymm14
        vmovdqu  (\src2_i + 0x0e0)(\src2_ptr), %ymm15

        __asm_schoolbook4_core \des_ptr, \des_i + 0x100, \
                8, 9, 10, 11, \
                12, 13, 14, 15, \
                6, 7, \_qinv_r, \_qbar_r, \
                0, 1, 2, 3, 4, 5

        vmovdqu (\buff_i + 0x000)(\buff_ptr),  %ymm0
        vmovdqu (\buff_i + 0x020)(\buff_ptr),  %ymm1
        vmovdqu (\buff_i + 0x040)(\buff_ptr),  %ymm2
        vmovdqu (\buff_i + 0x060)(\buff_ptr),  %ymm3
        vmovdqu (\buff_i + 0x080)(\buff_ptr),  %ymm4
        vmovdqu (\buff_i + 0x0a0)(\buff_ptr),  %ymm5
        vmovdqu (\buff_i + 0x0c0)(\buff_ptr),  %ymm6

        vpsubw  (\des_i + 0x000)(\des_ptr),  %ymm0,  %ymm0
        vpsubw  (\des_i + 0x020)(\des_ptr),  %ymm1,  %ymm1
        vpsubw  (\des_i + 0x040)(\des_ptr),  %ymm2,  %ymm2
        vpsubw  (\des_i + 0x060)(\des_ptr),  %ymm3,  %ymm3
        vpsubw  (\des_i + 0x080)(\des_ptr),  %ymm4,  %ymm4
        vpsubw  (\des_i + 0x0a0)(\des_ptr),  %ymm5,  %ymm5
        vpsubw  (\des_i + 0x0c0)(\des_ptr),  %ymm6,  %ymm6

        vpsubw  (\des_i + 0x100)(\des_ptr),  %ymm0,  %ymm0
        vpsubw  (\des_i + 0x120)(\des_ptr),  %ymm1,  %ymm1
        vpsubw  (\des_i + 0x140)(\des_ptr),  %ymm2,  %ymm2
        vpsubw  (\des_i + 0x160)(\des_ptr),  %ymm3,  %ymm3
        vpsubw  (\des_i + 0x180)(\des_ptr),  %ymm4,  %ymm4
        vpsubw  (\des_i + 0x1a0)(\des_ptr),  %ymm5,  %ymm5
        vpsubw  (\des_i + 0x1c0)(\des_ptr),  %ymm6,  %ymm6

        vmovdqu       \_q_r,  %ymm12
        vmovdqu    \_qbar_r,  %ymm13

        barrett_reduce 3, 3, 12, 13, 14
        vmovdqu       %ymm3, (\des_i + 0x0e0)(\des_ptr)

        vpaddw  (\des_i + 0x080)(\des_ptr),  %ymm0,  %ymm0
        vpaddw  (\des_i + 0x0a0)(\des_ptr),  %ymm1,  %ymm1
        vpaddw  (\des_i + 0x0c0)(\des_ptr),  %ymm2,  %ymm2

        vpaddw  (\des_i + 0x100)(\des_ptr),  %ymm4,  %ymm4
        vpaddw  (\des_i + 0x120)(\des_ptr),  %ymm5,  %ymm5
        vpaddw  (\des_i + 0x140)(\des_ptr),  %ymm6,  %ymm6

        barrett_reducex2 0, 4, 0, 4, 12, 13, 14, 15
        barrett_reducex2 1, 5, 1, 5, 12, 13, 14, 15
        barrett_reducex2 2, 6, 2, 6, 12, 13, 14, 15

        vmovdqu       %ymm0, (\des_i + 0x080)(\des_ptr)
        vmovdqu       %ymm1, (\des_i + 0x0a0)(\des_ptr)
        vmovdqu       %ymm2, (\des_i + 0x0c0)(\des_ptr)
        vmovdqu       %ymm4, (\des_i + 0x100)(\des_ptr)
        vmovdqu       %ymm5, (\des_i + 0x120)(\des_ptr)
        vmovdqu       %ymm6, (\des_i + 0x140)(\des_ptr)

.endm

.macro __asm_negacyclic_karatsuba8_core des_ptr, src1_ptr, src2_ptr, buff_ptr, des_i, src1_i, src2_i, buff_i, \
        _q_r, _qinv_r, _qbar_r

        vmovdqu  (\src1_i + 0x00)(\src1_ptr),  %ymm0
        vmovdqu  (\src1_i + 0x20)(\src1_ptr),  %ymm1
        vmovdqu  (\src1_i + 0x40)(\src1_ptr),  %ymm2
        vmovdqu  (\src1_i + 0x60)(\src1_ptr),  %ymm3

        vpaddw   (\src1_i + 0x80)(\src1_ptr),  %ymm0,  %ymm8
        vpaddw   (\src1_i + 0xa0)(\src1_ptr),  %ymm1,  %ymm9
        vpaddw   (\src1_i + 0xc0)(\src1_ptr),  %ymm2, %ymm10
        vpaddw   (\src1_i + 0xe0)(\src1_ptr),  %ymm3, %ymm11

        vmovdqu  (\src2_i + 0x00)(\src2_ptr),  %ymm0
        vmovdqu  (\src2_i + 0x20)(\src2_ptr),  %ymm1
        vmovdqu  (\src2_i + 0x40)(\src2_ptr),  %ymm2
        vmovdqu  (\src2_i + 0x60)(\src2_ptr),  %ymm3

        vpaddw   (\src2_i + 0x80)(\src2_ptr),  %ymm0, %ymm12
        vpaddw   (\src2_i + 0xa0)(\src2_ptr),  %ymm1, %ymm13
        vpaddw   (\src2_i + 0xc0)(\src2_ptr),  %ymm2, %ymm14
        vpaddw   (\src2_i + 0xe0)(\src2_ptr),  %ymm3, %ymm15

        vmovdqu      \_q_r,  %ymm6
        vmovdqu   \_qinv_r,  %ymm7

        __asm_schoolbook4_core \buff_ptr, \buff_i + 0x00, \
                8, 9, 10, 11, \
                12, 13, 14, 15, \
                6, 7, \_qinv_r, \_qbar_r, \
                0, 1, 2, 3, 4, 5

        vmovdqu  (\src1_i + 0x000)(\src1_ptr),  %ymm8
        vmovdqu  (\src1_i + 0x020)(\src1_ptr),  %ymm9
        vmovdqu  (\src1_i + 0x040)(\src1_ptr), %ymm10
        vmovdqu  (\src1_i + 0x060)(\src1_ptr), %ymm11
        vmovdqu  (\src2_i + 0x000)(\src2_ptr), %ymm12
        vmovdqu  (\src2_i + 0x020)(\src2_ptr), %ymm13
        vmovdqu  (\src2_i + 0x040)(\src2_ptr), %ymm14
        vmovdqu  (\src2_i + 0x060)(\src2_ptr), %ymm15

        __asm_schoolbook4_core \buff_ptr, \buff_i + 0x100, \
                8, 9, 10, 11, \
                12, 13, 14, 15, \
                6, 7, \_qinv_r, \_qbar_r, \
                0, 1, 2, 3, 4, 5

        vmovdqu  (\src1_i + 0x080)(\src1_ptr),  %ymm8
        vmovdqu  (\src1_i + 0x0a0)(\src1_ptr),  %ymm9
        vmovdqu  (\src1_i + 0x0c0)(\src1_ptr), %ymm10
        vmovdqu  (\src1_i + 0x0e0)(\src1_ptr), %ymm11
        vmovdqu  (\src2_i + 0x080)(\src2_ptr), %ymm12
        vmovdqu  (\src2_i + 0x0a0)(\src2_ptr), %ymm13
        vmovdqu  (\src2_i + 0x0c0)(\src2_ptr), %ymm14
        vmovdqu  (\src2_i + 0x0e0)(\src2_ptr), %ymm15

        __asm_schoolbook4_core \buff_ptr, \buff_i + 0x200, \
                8, 9, 10, 11, \
                12, 13, 14, 15, \
                6, 7, \_qinv_r, \_qbar_r, \
                0, 1, 2, 3, 4, 5

        vmovdqu       \_q_r,  %ymm2
        vmovdqu    \_qbar_r,  %ymm3

        // des[7] = barrett_int16x16(sub_int16x16(sub_int16x16(desmid[3], des[3]), deshi[3]));
        // des[3] = barrett_int16x16(sub_int16x16(des[3], deshi[3]));

        vmovdqu (\buff_i + 0x060)(\buff_ptr),  %ymm5
        vmovdqu (\buff_i + 0x160)(\buff_ptr),  %ymm4

        vpsubw        %ymm4,  %ymm5,  %ymm5
        vpsubw  (\buff_i + 0x260)(\buff_ptr),  %ymm5,  %ymm5
        vpsubw  (\buff_i + 0x260)(\buff_ptr),  %ymm4,  %ymm4

        barrett_reducex2 4, 5, 4, 5, 2, 3, 0, 1

        vmovdqu       %ymm4,  (\des_i + 0x60)(\des_ptr)
        vmovdqu       %ymm5,  (\des_i + 0xe0)(\des_ptr)

.if 0

        for(size_t i = 0; i < 3; i++){
                deshi[i] = sub_int16x16(des[i + 4], deshi[i]);
                deshi[i + 4] = add_int16x16(des[i], deshi[i + 4]);
                des[i]     = barrett_int16x16(
                                    add_int16x16(sub_int16x16(deshi[i], desmid[i + 4]), deshi[i + 4]));
                des[i + 4] = barrett_int16x16(
                                    sub_int16x16(add_int16x16(deshi[i], desmid[i]), deshi[i + 4]));
        }

.endif

        vmovdqu (\buff_i + 0x200)(\buff_ptr),  %ymm4
        vmovdqu (\buff_i + 0x220)(\buff_ptr),  %ymm8
        vmovdqu (\buff_i + 0x240)(\buff_ptr), %ymm12
        vmovdqu (\buff_i + 0x280)(\buff_ptr),  %ymm5
        vmovdqu (\buff_i + 0x2a0)(\buff_ptr),  %ymm9
        vmovdqu (\buff_i + 0x2c0)(\buff_ptr), %ymm13

        vpsubw  (\buff_i + 0x180)(\buff_ptr),  %ymm4,  %ymm4
        vpsubw  (\buff_i + 0x1a0)(\buff_ptr),  %ymm8,  %ymm8
        vpsubw  (\buff_i + 0x1c0)(\buff_ptr), %ymm12, %ymm12
        vpaddw  (\buff_i + 0x100)(\buff_ptr),  %ymm5,  %ymm5
        vpaddw  (\buff_i + 0x120)(\buff_ptr),  %ymm9,  %ymm9
        vpaddw  (\buff_i + 0x140)(\buff_ptr), %ymm13, %ymm13

        vpaddw  (\buff_i + 0x080)(\buff_ptr),  %ymm4,  %ymm6
        vpaddw  (\buff_i + 0x0a0)(\buff_ptr),  %ymm8, %ymm10
        vpaddw  (\buff_i + 0x0c0)(\buff_ptr), %ymm12, %ymm14
        vpsubw        %ymm6,  %ymm5,  %ymm6
        vpsubw       %ymm10,  %ymm9, %ymm10
        vpsubw       %ymm14, %ymm13, %ymm14

        vpsubw  (\buff_i + 0x000)(\buff_ptr),  %ymm4,  %ymm7
        vpsubw  (\buff_i + 0x020)(\buff_ptr),  %ymm8, %ymm11
        vpsubw  (\buff_i + 0x040)(\buff_ptr), %ymm12, %ymm15
        vpaddw        %ymm5,  %ymm7,  %ymm7
        vpaddw        %ymm9, %ymm11, %ymm11
        vpaddw       %ymm13, %ymm15, %ymm15

        barrett_reducex3 6, 10, 14, 6, 10, 14, 2, 3, 4, 8, 12
        barrett_reduce_negx3 7, 11, 15, 7, 11, 15, 2, 3, 5, 9, 13

        vmovdqu      %ymm6, (\des_i + 0x00)(\des_ptr)
        vmovdqu     %ymm10, (\des_i + 0x20)(\des_ptr)
        vmovdqu     %ymm14, (\des_i + 0x40)(\des_ptr)
        vmovdqu      %ymm7, (\des_i + 0x80)(\des_ptr)
        vmovdqu     %ymm11, (\des_i + 0xa0)(\des_ptr)
        vmovdqu     %ymm15, (\des_i + 0xc0)(\des_ptr)

.endm

.macro __asm_negacyclic_karatsuba8_precompute_core \
        des_ptr, src1_ptr, src2_ptr, src2inv_ptr, buff_ptr, \
        des_i, src1_i, src2_i, src2inv_i, buff_i, \
        _q_r, _qinv_r, _qbar_r

        vmovdqu  (\src1_i + 0x00)(\src1_ptr),  %ymm0
        vmovdqu  (\src1_i + 0x20)(\src1_ptr),  %ymm1
        vmovdqu  (\src1_i + 0x40)(\src1_ptr),  %ymm2
        vmovdqu  (\src1_i + 0x60)(\src1_ptr),  %ymm3

        vpaddw   (\src1_i + 0x80)(\src1_ptr),  %ymm0,  %ymm8
        vpaddw   (\src1_i + 0xa0)(\src1_ptr),  %ymm1,  %ymm9
        vpaddw   (\src1_i + 0xc0)(\src1_ptr),  %ymm2, %ymm10
        vpaddw   (\src1_i + 0xe0)(\src1_ptr),  %ymm3, %ymm11

        vmovdqu  (\src2_i + 0x00)(\src2_ptr),  %ymm0
        vmovdqu  (\src2_i + 0x20)(\src2_ptr),  %ymm1
        vmovdqu  (\src2_i + 0x40)(\src2_ptr),  %ymm2
        vmovdqu  (\src2_i + 0x60)(\src2_ptr),  %ymm3

        vpaddw   (\src2_i + 0x80)(\src2_ptr),  %ymm0, %ymm12
        vpaddw   (\src2_i + 0xa0)(\src2_ptr),  %ymm1, %ymm13
        vpaddw   (\src2_i + 0xc0)(\src2_ptr),  %ymm2, %ymm14
        vpaddw   (\src2_i + 0xe0)(\src2_ptr),  %ymm3, %ymm15

        vmovdqu      \_q_r,  %ymm6
        vmovdqu   \_qinv_r,  %ymm7

        __asm_schoolbook4_core \buff_ptr, \buff_i + 0x00, \
                8, 9, 10, 11, \
                12, 13, 14, 15, \
                6, 7, \_qinv_r, \_qbar_r, \
                0, 1, 2, 3, 4, 5

        vmovdqu    \_qbar_r,  %ymm7

        vmovdqu  (\src1_i + 0x000)(\src1_ptr),  %ymm8
        vmovdqu  (\src1_i + 0x020)(\src1_ptr),  %ymm9
        vmovdqu  (\src1_i + 0x040)(\src1_ptr), %ymm10
        vmovdqu  (\src1_i + 0x060)(\src1_ptr), %ymm11
        vmovdqu  (\src2_i + 0x000)(\src2_ptr), %ymm12
        vmovdqu  (\src2_i + 0x020)(\src2_ptr), %ymm13
        vmovdqu  (\src2_i + 0x040)(\src2_ptr), %ymm14
        vmovdqu  (\src2_i + 0x060)(\src2_ptr), %ymm15

        __asm_schoolbook4_precompute_core \buff_ptr, \src2inv_ptr, \buff_i + 0x100, \src2inv_i + 0x000, \
                8, 9, 10, 11, \
                12, 13, 14, 15, \
                6, 7, \_qinv_r, \_qbar_r, \
                0, 1, 2, 3, 4, 5

        vmovdqu  (\src1_i + 0x080)(\src1_ptr),  %ymm8
        vmovdqu  (\src1_i + 0x0a0)(\src1_ptr),  %ymm9
        vmovdqu  (\src1_i + 0x0c0)(\src1_ptr), %ymm10
        vmovdqu  (\src1_i + 0x0e0)(\src1_ptr), %ymm11
        vmovdqu  (\src2_i + 0x080)(\src2_ptr), %ymm12
        vmovdqu  (\src2_i + 0x0a0)(\src2_ptr), %ymm13
        vmovdqu  (\src2_i + 0x0c0)(\src2_ptr), %ymm14
        vmovdqu  (\src2_i + 0x0e0)(\src2_ptr), %ymm15

        __asm_schoolbook4_precompute_core \buff_ptr, \src2inv_ptr, \buff_i + 0x200, \src2inv_i + 0x080, \
                8, 9, 10, 11, \
                12, 13, 14, 15, \
                6, 7, \_qinv_r, \_qbar_r, \
                0, 1, 2, 3, 4, 5

        vmovdqu       \_q_r,  %ymm2
        vmovdqu    \_qbar_r,  %ymm3

        // des[7] = barrett_int16x16(sub_int16x16(sub_int16x16(desmid[3], des[3]), deshi[3]));
        // des[3] = barrett_int16x16(sub_int16x16(des[3], deshi[3]));

        vmovdqu (\buff_i + 0x060)(\buff_ptr),  %ymm5
        vmovdqu (\buff_i + 0x160)(\buff_ptr),  %ymm4

        vpsubw        %ymm4,  %ymm5,  %ymm5
        vpsubw  (\buff_i + 0x260)(\buff_ptr),  %ymm5,  %ymm5
        vpsubw  (\buff_i + 0x260)(\buff_ptr),  %ymm4,  %ymm4

        barrett_reducex2 4, 5, 4, 5, 2, 3, 0, 1

        vmovdqu       %ymm4,  (\des_i + 0x60)(\des_ptr)
        vmovdqu       %ymm5,  (\des_i + 0xe0)(\des_ptr)

.if 0

        for(size_t i = 0; i < 3; i++){
                deshi[i] = sub_int16x16(des[i + 4], deshi[i]);
                deshi[i + 4] = add_int16x16(des[i], deshi[i + 4]);
                des[i]     = barrett_int16x16(
                                    add_int16x16(sub_int16x16(deshi[i], desmid[i + 4]), deshi[i + 4]));
                des[i + 4] = barrett_int16x16(
                                    sub_int16x16(add_int16x16(deshi[i], desmid[i]), deshi[i + 4]));
        }

.endif

        vmovdqu (\buff_i + 0x200)(\buff_ptr),  %ymm4
        vmovdqu (\buff_i + 0x220)(\buff_ptr),  %ymm8
        vmovdqu (\buff_i + 0x240)(\buff_ptr), %ymm12
        vmovdqu (\buff_i + 0x280)(\buff_ptr),  %ymm5
        vmovdqu (\buff_i + 0x2a0)(\buff_ptr),  %ymm9
        vmovdqu (\buff_i + 0x2c0)(\buff_ptr), %ymm13

        vpsubw  (\buff_i + 0x180)(\buff_ptr),  %ymm4,  %ymm4
        vpsubw  (\buff_i + 0x1a0)(\buff_ptr),  %ymm8,  %ymm8
        vpsubw  (\buff_i + 0x1c0)(\buff_ptr), %ymm12, %ymm12
        vpaddw  (\buff_i + 0x100)(\buff_ptr),  %ymm5,  %ymm5
        vpaddw  (\buff_i + 0x120)(\buff_ptr),  %ymm9,  %ymm9
        vpaddw  (\buff_i + 0x140)(\buff_ptr), %ymm13, %ymm13

        vpaddw  (\buff_i + 0x080)(\buff_ptr),  %ymm4,  %ymm6
        vpaddw  (\buff_i + 0x0a0)(\buff_ptr),  %ymm8, %ymm10
        vpaddw  (\buff_i + 0x0c0)(\buff_ptr), %ymm12, %ymm14
        vpsubw        %ymm6,  %ymm5,  %ymm6
        vpsubw       %ymm10,  %ymm9, %ymm10
        vpsubw       %ymm14, %ymm13, %ymm14

        vpsubw  (\buff_i + 0x000)(\buff_ptr),  %ymm4,  %ymm7
        vpsubw  (\buff_i + 0x020)(\buff_ptr),  %ymm8, %ymm11
        vpsubw  (\buff_i + 0x040)(\buff_ptr), %ymm12, %ymm15
        vpaddw        %ymm5,  %ymm7,  %ymm7
        vpaddw        %ymm9, %ymm11, %ymm11
        vpaddw       %ymm13, %ymm15, %ymm15

        barrett_reducex3 6, 10, 14, 6, 10, 14, 2, 3, 4, 8, 12
        barrett_reduce_negx3 7, 11, 15, 7, 11, 15, 2, 3, 5, 9, 13

        vmovdqu      %ymm6, (\des_i + 0x00)(\des_ptr)
        vmovdqu     %ymm10, (\des_i + 0x20)(\des_ptr)
        vmovdqu     %ymm14, (\des_i + 0x40)(\des_ptr)
        vmovdqu      %ymm7, (\des_i + 0x80)(\des_ptr)
        vmovdqu     %ymm11, (\des_i + 0xa0)(\des_ptr)
        vmovdqu     %ymm15, (\des_i + 0xc0)(\des_ptr)

.endm


#endif



