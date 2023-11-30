

#include "basemul_core.inc"
#include "butterflies.inc"
#include "permute.inc"

#include "params.h"

#define __asm_cyclic_FFT16 NAME(__asm_cyclic_FFT16)
#define ___asm_cyclic_FFT16 NAME(___asm_cyclic_FFT16)
#define __asm_cyclic_FFT16_precompute NAME(__asm_cyclic_FFT16_precompute)
#define ___asm_cyclic_FFT16_precompute NAME(___asm_cyclic_FFT16_precompute)
#define __asm_negacyclic_FFT16 NAME(__asm_negacyclic_FFT16)
#define ___asm_negacyclic_FFT16 NAME(___asm_negacyclic_FFT16)

.text

.if 0

result of x^8 - 1

0x000
0x020
0x040
0x060
0x080
0x0a0
0x0c0
0x0e0

buffer for one of the polynomial in x^8 + 1

0x100
0x120
0x140
0x160
0x180
0x1a0
0x1c0
0x1e0

result of x^8 + 1

0x200
0x220
0x240
0x260
0x280
0x2a0
0x2c0
0x2e0

buffer for karatsuba negacyclic 8 x 8

0x300
0x320
0x340
0x360
0x380
0x3a0
0x3c0
0x3e0

0x400
0x420
0x440
0x460
0x480
0x4a0
0x4c0
0x4e0

0x500
0x520
0x540
0x560
0x580
0x5a0
0x5c0
0x5e0

.endif

.global __asm_cyclic_FFT16_precompute
.global ___asm_cyclic_FFT16_precompute
__asm_cyclic_FFT16_precompute:
___asm_cyclic_FFT16_precompute:

        push   %rbp
        mov    %rsp, %rbp
        and    $0xffffffffffffffe0, %rsp
        sub    $0x600, %rsp

        vmovdqu 0x000(%rsi),  %ymm0
        vmovdqu 0x020(%rsi),  %ymm1
        vmovdqu 0x040(%rsi),  %ymm2
        vmovdqu 0x060(%rsi),  %ymm3
        vmovdqu 0x080(%rsi),  %ymm4
        vmovdqu 0x0a0(%rsi),  %ymm5
        vmovdqu 0x0c0(%rsi),  %ymm6
        vmovdqu 0x0e0(%rsi),  %ymm7

        vpsubw  0x100(%rsi),  %ymm0,  %ymm8
        vpaddw  0x100(%rsi),  %ymm0,  %ymm0
        vpsubw  0x120(%rsi),  %ymm1,  %ymm9
        vpaddw  0x120(%rsi),  %ymm1,  %ymm1
        vpsubw  0x140(%rsi),  %ymm2, %ymm10
        vpaddw  0x140(%rsi),  %ymm2,  %ymm2
        vpsubw  0x160(%rsi),  %ymm3, %ymm11
        vpaddw  0x160(%rsi),  %ymm3,  %ymm3
        vpsubw  0x180(%rsi),  %ymm4, %ymm12
        vpaddw  0x180(%rsi),  %ymm4,  %ymm4
        vpsubw  0x1a0(%rsi),  %ymm5, %ymm13
        vpaddw  0x1a0(%rsi),  %ymm5,  %ymm5
        vpsubw  0x1c0(%rsi),  %ymm6, %ymm14
        vpaddw  0x1c0(%rsi),  %ymm6,  %ymm6
        vpsubw  0x1e0(%rsi),  %ymm7, %ymm15
        vpaddw  0x1e0(%rsi),  %ymm7,  %ymm7

        vmovdqu       %ymm8, 0x100(%rsp)
        vmovdqu       %ymm9, 0x120(%rsp)
        vmovdqu      %ymm10, 0x140(%rsp)
        vmovdqu      %ymm11, 0x160(%rsp)
        vmovdqu      %ymm12, 0x180(%rsp)
        vmovdqu      %ymm13, 0x1a0(%rsp)
        vmovdqu      %ymm14, 0x1c0(%rsp)
        vmovdqu      %ymm15, 0x1e0(%rsp)

        vpaddw        %ymm4,  %ymm0,  %ymm8
        vpsubw        %ymm4,  %ymm0, %ymm12
        vpaddw        %ymm5,  %ymm1,  %ymm9
        vpsubw        %ymm5,  %ymm1, %ymm13
        vpaddw        %ymm6,  %ymm2, %ymm10
        vpsubw        %ymm6,  %ymm2, %ymm14
        vpaddw        %ymm7,  %ymm3, %ymm11
        vpsubw        %ymm7,  %ymm3, %ymm15

        vmovdqu      %ymm12, 0x080(%rsp)
        vmovdqu      %ymm13, 0x0a0(%rsp)
        vmovdqu      %ymm14, 0x0c0(%rsp)
        vmovdqu      %ymm15, 0x0e0(%rsp)

        vmovdqu 0x000( %r8), %ymm12
        vmovdqu 0x020( %r8), %ymm13

// ================================
// x^4 - 1

        vmovdqu  0x040( %r8),  %ymm13
        barrett_reducex2 0, 1,  8,  9, 12, 13, 14, 15
        barrett_reducex2 2, 3, 10, 11, 12, 13, 14, 15

        vpsubw        %ymm2,  %ymm0, %ymm10
        vpaddw        %ymm2,  %ymm0,  %ymm0
        vpsubw        %ymm3,  %ymm1, %ymm11
        vpaddw        %ymm3,  %ymm1,  %ymm1
        vpaddw        %ymm1,  %ymm0,  %ymm8
        vpsubw        %ymm1,  %ymm0,  %ymm9

        vmovdqu 0x000(%rdx),  %ymm4
        vmovdqu 0x020(%rdx),  %ymm5
        vmovdqu 0x040(%rdx),  %ymm6
        vmovdqu 0x060(%rdx),  %ymm7

        vpmullw 0x000(%rcx),  %ymm8, %ymm14
        vpmullw 0x020(%rcx),  %ymm9, %ymm15
        vpmulhw       %ymm4,  %ymm8,  %ymm4
        vpmulhw       %ymm5,  %ymm9,  %ymm5
        vpmulhw      %ymm14, %ymm12, %ymm14
        vpmulhw      %ymm15, %ymm12, %ymm15
        vpsubw       %ymm14,  %ymm4,  %ymm4
        vpsubw       %ymm15,  %ymm5,  %ymm5

        vpmullw 0x040(%rcx), %ymm10, %ymm14
        vpmullw 0x060(%rcx), %ymm10, %ymm15
        vpmullw 0x040(%rcx), %ymm11,  %ymm8
        vpmullw 0x060(%rcx), %ymm11,  %ymm9
        vpmulhw       %ymm6, %ymm10,  %ymm0
        vpmulhw       %ymm7, %ymm10,  %ymm1
        vpmulhw       %ymm6, %ymm11,  %ymm2
        vpmulhw       %ymm7, %ymm11,  %ymm3
        vpmulhw      %ymm14, %ymm12, %ymm14
        vpmulhw      %ymm15, %ymm12, %ymm15
        vpmulhw       %ymm8, %ymm12,  %ymm8
        vpmulhw       %ymm9, %ymm12,  %ymm9
        vpsubw       %ymm14,  %ymm0,  %ymm0
        vpsubw       %ymm15,  %ymm1,  %ymm1
        vpsubw        %ymm8,  %ymm2,  %ymm2
        vpsubw        %ymm9,  %ymm3,  %ymm3

        vpsubw        %ymm3,  %ymm0, %ymm6
        vpaddw        %ymm2,  %ymm1, %ymm7

        vpaddw        %ymm5,  %ymm4,  %ymm0
        vpsubw        %ymm5,  %ymm4,  %ymm1
        vpsubw        %ymm6,  %ymm0,  %ymm2
        vpaddw        %ymm6,  %ymm0,  %ymm0
        vpsubw        %ymm7,  %ymm1,  %ymm3
        vpaddw        %ymm7,  %ymm1,  %ymm1

        vmovdqu  0x040( %r8),  %ymm13

        barrett_reducex2 0, 1, 0, 1, 12, 13, 14, 15
        barrett_reducex2 2, 3, 2, 3, 12, 13, 14, 15

        vmovdqu       %ymm0, 0x000(%rsp)
        vmovdqu       %ymm1, 0x020(%rsp)
        vmovdqu       %ymm2, 0x040(%rsp)
        vmovdqu       %ymm3, 0x060(%rsp)

        vmovdqu  0x020( %r8),  %ymm13

// ================================
// x^4 + 1

        vmovdqu 0x080(%rsp),  %ymm8
        vmovdqu 0x0a0(%rsp),  %ymm9
        vmovdqu 0x0c0(%rsp), %ymm10
        vmovdqu 0x0e0(%rsp), %ymm11

        vpmullw 0x080(%rcx),  %ymm8,  %ymm0
        vpmullw 0x0a0(%rcx), %ymm11,  %ymm1
        vpmullw 0x0c0(%rcx), %ymm10,  %ymm2
        vpmullw 0x0e0(%rcx),  %ymm9,  %ymm3
        vpmulhw       %ymm0, %ymm12,  %ymm0
        vpmulhw       %ymm1, %ymm12,  %ymm1
        vpmulhw       %ymm2, %ymm12,  %ymm2
        vpmulhw       %ymm3, %ymm12,  %ymm3
        vpmulhw 0x080(%rdx),  %ymm8, %ymm12
        vpmulhw 0x0a0(%rdx), %ymm11, %ymm13
        vpmulhw 0x0c0(%rdx), %ymm10, %ymm14
        vpmulhw 0x0e0(%rdx),  %ymm9, %ymm15
        vpsubw        %ymm0, %ymm12,  %ymm0
        vpsubw        %ymm1, %ymm13,  %ymm1
        vpsubw        %ymm2, %ymm14,  %ymm2
        vpsubw        %ymm3, %ymm15,  %ymm3

        vmovdqu  0x000( %r8),  %ymm12
        vmovdqu  0x040( %r8),  %ymm13

        vpsubw        %ymm1,  %ymm0,  %ymm0
        vpsubw        %ymm2,  %ymm0,  %ymm0
        vpsubw        %ymm3,  %ymm0,  %ymm0

        barrett_reduce 0, 0, 12, 13, 14
        vmovdqu       %ymm0, 0x080(%rsp)

        vpmullw 0x080(%rcx),  %ymm9,  %ymm4
        vpmullw 0x0a0(%rcx),  %ymm8,  %ymm5
        vpmullw 0x0c0(%rcx), %ymm11,  %ymm6
        vpmullw 0x0e0(%rcx), %ymm10,  %ymm7
        vpmulhw       %ymm4, %ymm12,  %ymm4
        vpmulhw       %ymm5, %ymm12,  %ymm5
        vpmulhw       %ymm6, %ymm12,  %ymm6
        vpmulhw       %ymm7, %ymm12,  %ymm7
        vpmulhw 0x080(%rdx),  %ymm9, %ymm12
        vpmulhw 0x0a0(%rdx),  %ymm8, %ymm13
        vpmulhw 0x0c0(%rdx), %ymm11, %ymm14
        vpmulhw 0x0e0(%rdx), %ymm10, %ymm15
        vpsubw        %ymm4, %ymm12,  %ymm4
        vpsubw        %ymm5, %ymm13,  %ymm5
        vpsubw        %ymm6, %ymm14,  %ymm6
        vpsubw        %ymm7, %ymm15,  %ymm7

        vmovdqu  0x000( %r8),  %ymm12
        vmovdqu  0x040( %r8),  %ymm13

        vpaddw        %ymm5,  %ymm4,  %ymm4
        vpsubw        %ymm6,  %ymm4,  %ymm4
        vpsubw        %ymm7,  %ymm4,  %ymm4

        barrett_reduce 4, 4, 12, 13, 14
        vmovdqu       %ymm4, 0x0a0(%rsp)

        vpmullw 0x080(%rcx), %ymm10,  %ymm0
        vpmullw 0x0a0(%rcx),  %ymm9,  %ymm1
        vpmullw 0x0c0(%rcx),  %ymm8,  %ymm2
        vpmullw 0x0e0(%rcx), %ymm11,  %ymm3
        vpmulhw       %ymm0, %ymm12,  %ymm0
        vpmulhw       %ymm1, %ymm12,  %ymm1
        vpmulhw       %ymm2, %ymm12,  %ymm2
        vpmulhw       %ymm3, %ymm12,  %ymm3
        vpmulhw 0x080(%rdx), %ymm10, %ymm12
        vpmulhw 0x0a0(%rdx),  %ymm9, %ymm13
        vpmulhw 0x0c0(%rdx),  %ymm8, %ymm14
        vpmulhw 0x0e0(%rdx), %ymm11, %ymm15
        vpsubw        %ymm0, %ymm12,  %ymm0
        vpsubw        %ymm1, %ymm13,  %ymm1
        vpsubw        %ymm2, %ymm14,  %ymm2
        vpsubw        %ymm3, %ymm15,  %ymm3

        vmovdqu  0x000( %r8),  %ymm12
        vmovdqu  0x040( %r8),  %ymm13

        vpaddw        %ymm1,  %ymm0,  %ymm0
        vpaddw        %ymm2,  %ymm0,  %ymm0
        vpsubw        %ymm3,  %ymm0,  %ymm0

        barrett_reduce 0, 0, 12, 13, 14
        vmovdqu       %ymm0, 0x0c0(%rsp)

        vpmullw 0x080(%rcx), %ymm11,  %ymm4
        vpmullw 0x0a0(%rcx), %ymm10,  %ymm5
        vpmullw 0x0c0(%rcx),  %ymm9,  %ymm6
        vpmullw 0x0e0(%rcx),  %ymm8,  %ymm7
        vpmulhw       %ymm4, %ymm12,  %ymm4
        vpmulhw       %ymm5, %ymm12,  %ymm5
        vpmulhw       %ymm6, %ymm12,  %ymm6
        vpmulhw       %ymm7, %ymm12,  %ymm7
        vpmulhw 0x080(%rdx), %ymm11, %ymm12
        vpmulhw 0x0a0(%rdx), %ymm10, %ymm13
        vpmulhw 0x0c0(%rdx),  %ymm9, %ymm14
        vpmulhw 0x0e0(%rdx),  %ymm8, %ymm15
        vpsubw        %ymm4, %ymm12,  %ymm4
        vpsubw        %ymm5, %ymm13,  %ymm5
        vpsubw        %ymm6, %ymm14,  %ymm6
        vpsubw        %ymm7, %ymm15,  %ymm7

        vmovdqu  0x000( %r8),  %ymm12
        vmovdqu  0x040( %r8),  %ymm13

        vpaddw        %ymm5,  %ymm4,  %ymm4
        vpaddw        %ymm6,  %ymm4,  %ymm4
        vpaddw        %ymm7,  %ymm4,  %ymm4

        barrett_reduce 4, 4, 12, 13, 14
        vmovdqu       %ymm4, 0x0e0(%rsp)

// ================================
// x^8 + 1

        __asm_negacyclic_karatsuba8_precompute_core \
                %rsp, %rsp, %rdx, %rcx, %rsp, 0x200, 0x100, 0x100, 0x100, 0x300, \
                0x000( %r8), 0x020( %r8), 0x040( %r8)

        vmovdqu 0x000(%rsp),  %ymm0
        vmovdqu 0x020(%rsp),  %ymm1
        vmovdqu 0x040(%rsp),  %ymm2
        vmovdqu 0x060(%rsp),  %ymm3

        vpsubw  0x080(%rsp),  %ymm0,  %ymm4
        vpaddw  0x080(%rsp),  %ymm0,  %ymm0
        vpsubw  0x0a0(%rsp),  %ymm1,  %ymm5
        vpaddw  0x0a0(%rsp),  %ymm1,  %ymm1
        vpsubw  0x0c0(%rsp),  %ymm2,  %ymm6
        vpaddw  0x0c0(%rsp),  %ymm2,  %ymm2
        vpsubw  0x0e0(%rsp),  %ymm3,  %ymm7
        vpaddw  0x0e0(%rsp),  %ymm3,  %ymm3

        vpsubw  0x200(%rsp),  %ymm0,  %ymm8
        vpaddw  0x200(%rsp),  %ymm0,  %ymm0
        vpsubw  0x220(%rsp),  %ymm1,  %ymm9
        vpaddw  0x220(%rsp),  %ymm1,  %ymm1
        vpsubw  0x240(%rsp),  %ymm2, %ymm10
        vpaddw  0x240(%rsp),  %ymm2,  %ymm2
        vpsubw  0x260(%rsp),  %ymm3, %ymm11
        vpaddw  0x260(%rsp),  %ymm3,  %ymm3
        vpsubw  0x280(%rsp),  %ymm4, %ymm12
        vpaddw  0x280(%rsp),  %ymm4,  %ymm4
        vpsubw  0x2a0(%rsp),  %ymm5, %ymm13
        vpaddw  0x2a0(%rsp),  %ymm5,  %ymm5
        vpsubw  0x2c0(%rsp),  %ymm6, %ymm14
        vpaddw  0x2c0(%rsp),  %ymm6,  %ymm6
        vpsubw  0x2e0(%rsp),  %ymm7, %ymm15
        vpaddw  0x2e0(%rsp),  %ymm7,  %ymm7

        vmovdqu       %ymm0, 0x000(%rdi)
        vmovdqu       %ymm1, 0x020(%rdi)
        vmovdqu       %ymm2, 0x040(%rdi)
        vmovdqu       %ymm3, 0x060(%rdi)
        vmovdqu       %ymm4, 0x080(%rdi)
        vmovdqu       %ymm5, 0x0a0(%rdi)
        vmovdqu       %ymm6, 0x0c0(%rdi)
        vmovdqu       %ymm7, 0x0e0(%rdi)
        vmovdqu       %ymm8, 0x100(%rdi)
        vmovdqu       %ymm9, 0x120(%rdi)
        vmovdqu      %ymm10, 0x140(%rdi)
        vmovdqu      %ymm11, 0x160(%rdi)
        vmovdqu      %ymm12, 0x180(%rdi)
        vmovdqu      %ymm13, 0x1a0(%rdi)
        vmovdqu      %ymm14, 0x1c0(%rdi)
        vmovdqu      %ymm15, 0x1e0(%rdi)



        vzeroupper
        leave
        ret

.global __asm_cyclic_FFT16
.global ___asm_cyclic_FFT16
__asm_cyclic_FFT16:
___asm_cyclic_FFT16:

        push   %rbp
        mov    %rsp, %rbp
        and    $0xffffffffffffffe0, %rsp
        sub    $0xb00, %rsp

        vmovdqu 0x000(%rdx),  %ymm0
        vmovdqu 0x020(%rdx),  %ymm1
        vmovdqu 0x040(%rdx),  %ymm2
        vmovdqu 0x060(%rdx),  %ymm3
        vmovdqu 0x080(%rdx),  %ymm4
        vmovdqu 0x0a0(%rdx),  %ymm5
        vmovdqu 0x0c0(%rdx),  %ymm6
        vmovdqu 0x0e0(%rdx),  %ymm7

        vpsubw  0x100(%rdx),  %ymm0,  %ymm8
        vpsubw  0x120(%rdx),  %ymm1,  %ymm9
        vpsubw  0x140(%rdx),  %ymm2, %ymm10
        vpsubw  0x160(%rdx),  %ymm3, %ymm11
        vpsubw  0x180(%rdx),  %ymm4, %ymm12
        vpsubw  0x1a0(%rdx),  %ymm5, %ymm13
        vpsubw  0x1c0(%rdx),  %ymm6, %ymm14
        vpsubw  0x1e0(%rdx),  %ymm7, %ymm15

        vpaddw  0x100(%rdx),  %ymm0,  %ymm0
        vpaddw  0x120(%rdx),  %ymm1,  %ymm1
        vpaddw  0x140(%rdx),  %ymm2,  %ymm2
        vpaddw  0x160(%rdx),  %ymm3,  %ymm3
        vpaddw  0x180(%rdx),  %ymm4,  %ymm4
        vpaddw  0x1a0(%rdx),  %ymm5,  %ymm5
        vpaddw  0x1c0(%rdx),  %ymm6,  %ymm6
        vpaddw  0x1e0(%rdx),  %ymm7,  %ymm7

        vmovdqu       %ymm8, 0x300(%rsp)
        vmovdqu       %ymm9, 0x320(%rsp)
        vmovdqu      %ymm10, 0x340(%rsp)
        vmovdqu      %ymm11, 0x360(%rsp)
        vmovdqu      %ymm12, 0x380(%rsp)
        vmovdqu      %ymm13, 0x3a0(%rsp)
        vmovdqu      %ymm14, 0x3c0(%rsp)
        vmovdqu      %ymm15, 0x3e0(%rsp)

        vpsubw        %ymm4,  %ymm0, %ymm12
        vpaddw        %ymm4,  %ymm0,  %ymm8
        vpsubw        %ymm5,  %ymm1, %ymm13
        vpaddw        %ymm5,  %ymm1,  %ymm9
        vpsubw        %ymm6,  %ymm2, %ymm14
        vpaddw        %ymm6,  %ymm2, %ymm10
        vpsubw        %ymm7,  %ymm3, %ymm15
        vpaddw        %ymm7,  %ymm3, %ymm11

        vmovdqu       %ymm8, 0x200(%rsp)
        vmovdqu       %ymm9, 0x220(%rsp)
        vmovdqu      %ymm10, 0x240(%rsp)
        vmovdqu      %ymm11, 0x260(%rsp)
        vmovdqu      %ymm12, 0x280(%rsp)
        vmovdqu      %ymm13, 0x2a0(%rsp)
        vmovdqu      %ymm14, 0x2c0(%rsp)
        vmovdqu      %ymm15, 0x2e0(%rsp)

        vmovdqu 0x000(%rsi),  %ymm0
        vmovdqu 0x020(%rsi),  %ymm1
        vmovdqu 0x040(%rsi),  %ymm2
        vmovdqu 0x060(%rsi),  %ymm3
        vmovdqu 0x080(%rsi),  %ymm4
        vmovdqu 0x0a0(%rsi),  %ymm5
        vmovdqu 0x0c0(%rsi),  %ymm6
        vmovdqu 0x0e0(%rsi),  %ymm7

        vpsubw  0x100(%rsi),  %ymm0,  %ymm8
        vpsubw  0x120(%rsi),  %ymm1,  %ymm9
        vpsubw  0x140(%rsi),  %ymm2, %ymm10
        vpsubw  0x160(%rsi),  %ymm3, %ymm11
        vpsubw  0x180(%rsi),  %ymm4, %ymm12
        vpsubw  0x1a0(%rsi),  %ymm5, %ymm13
        vpsubw  0x1c0(%rsi),  %ymm6, %ymm14
        vpsubw  0x1e0(%rsi),  %ymm7, %ymm15

        vpaddw  0x100(%rsi),  %ymm0,  %ymm0
        vpaddw  0x120(%rsi),  %ymm1,  %ymm1
        vpaddw  0x140(%rsi),  %ymm2,  %ymm2
        vpaddw  0x160(%rsi),  %ymm3,  %ymm3
        vpaddw  0x180(%rsi),  %ymm4,  %ymm4
        vpaddw  0x1a0(%rsi),  %ymm5,  %ymm5
        vpaddw  0x1c0(%rsi),  %ymm6,  %ymm6
        vpaddw  0x1e0(%rsi),  %ymm7,  %ymm7

        vmovdqu       %ymm8, 0x100(%rsp)
        vmovdqu       %ymm9, 0x120(%rsp)
        vmovdqu      %ymm10, 0x140(%rsp)
        vmovdqu      %ymm11, 0x160(%rsp)
        vmovdqu      %ymm12, 0x180(%rsp)
        vmovdqu      %ymm13, 0x1a0(%rsp)
        vmovdqu      %ymm14, 0x1c0(%rsp)
        vmovdqu      %ymm15, 0x1e0(%rsp)

        vpsubw        %ymm4,  %ymm0, %ymm12
        vpaddw        %ymm4,  %ymm0,  %ymm8
        vpsubw        %ymm5,  %ymm1, %ymm13
        vpaddw        %ymm5,  %ymm1,  %ymm9
        vpsubw        %ymm6,  %ymm2, %ymm14
        vpaddw        %ymm6,  %ymm2, %ymm10
        vpsubw        %ymm7,  %ymm3, %ymm15
        vpaddw        %ymm7,  %ymm3, %ymm11

// ================================

        vmovdqu 0x000(%rcx),  %ymm4
        vmovdqu 0x020(%rcx),  %ymm5

        __asm_cyclic_schoolbook4_mem_core %rsp, 0x400, \
                0x200(%rsp), 0x220(%rsp), 0x240(%rsp), 0x260(%rsp), \
                8, 9, 10, 11, \
                4, 5, 0x20(%rcx), 0x40(%rcx), \
                0, 1, 2, 3, 6, 7

        __asm_negacyclic_schoolbook4_mem_core %rsp, 0x480, \
                0x280(%rsp), 0x2a0(%rsp), 0x2c0(%rsp), 0x2e0(%rsp), \
                12, 13, 14, 15, \
                4, 5, 0x20(%rcx), 0x40(%rcx), \
                8, 9, 10, 11, 6, 7

// ================================
// x^8 + 1

        __asm_negacyclic_karatsuba8_core \
                %rsp, %rsp, %rsp, %rsp, 0x500, 0x100, 0x300, 0x600, \
                0x000(%rcx), 0x020(%rcx), 0x040(%rcx)

        vmovdqu 0x400(%rsp),  %ymm0
        vmovdqu 0x480(%rsp),  %ymm1
        vmovdqu 0x420(%rsp), %ymm12
        vmovdqu 0x4a0(%rsp), %ymm13
        vmovdqu 0x500(%rsp),  %ymm2
        vmovdqu 0x580(%rsp),  %ymm3
        vmovdqu 0x520(%rsp), %ymm14
        vmovdqu 0x5a0(%rsp), %ymm15

        barrett_reduce_constmemx2  0,  1,  0,  1, 0x000(%rcx), 0x040(%rcx),  6,  7
        barrett_reduce_constmemx2 12, 13, 12, 13, 0x000(%rcx), 0x040(%rcx), 10, 11

        vpaddw        %ymm2,  %ymm2,  %ymm2
        vpaddw        %ymm3,  %ymm3,  %ymm3
        vpaddw       %ymm14, %ymm14, %ymm14
        vpaddw       %ymm15, %ymm15, %ymm15

        vpaddw        %ymm1,  %ymm0,  %ymm4
        vpsubw        %ymm1,  %ymm0,  %ymm5
        vpaddw       %ymm13, %ymm12,  %ymm8
        vpsubw       %ymm13, %ymm12,  %ymm9

        vpaddw        %ymm2,  %ymm4,  %ymm0
        vpsubw        %ymm2,  %ymm4,  %ymm2
        vpaddw        %ymm3,  %ymm5,  %ymm1
        vpsubw        %ymm3,  %ymm5,  %ymm3
        vpaddw       %ymm14,  %ymm8, %ymm12
        vpsubw       %ymm14,  %ymm8, %ymm14
        vpaddw       %ymm15,  %ymm9, %ymm13
        vpsubw       %ymm15,  %ymm9, %ymm15

        vmovdqu       %ymm0, 0x000(%rdi)
        vmovdqu       %ymm1, 0x080(%rdi)
        vmovdqu       %ymm2, 0x100(%rdi)
        vmovdqu       %ymm3, 0x180(%rdi)
        vmovdqu      %ymm12, 0x020(%rdi)
        vmovdqu      %ymm13, 0x0a0(%rdi)
        vmovdqu      %ymm14, 0x120(%rdi)
        vmovdqu      %ymm15, 0x1a0(%rdi)

        vmovdqu 0x440(%rsp),  %ymm0
        vmovdqu 0x4c0(%rsp),  %ymm1
        vmovdqu 0x460(%rsp), %ymm12
        vmovdqu 0x4e0(%rsp), %ymm13
        vmovdqu 0x540(%rsp),  %ymm2
        vmovdqu 0x5c0(%rsp),  %ymm3
        vmovdqu 0x560(%rsp), %ymm14
        vmovdqu 0x5e0(%rsp), %ymm15

        barrett_reduce_constmemx2  0,  1,  0,  1, 0x000(%rcx), 0x040(%rcx),  6,  7
        barrett_reduce_constmemx2 12, 13, 12, 13, 0x000(%rcx), 0x040(%rcx), 10, 11

        vpaddw        %ymm2,  %ymm2,  %ymm2
        vpaddw        %ymm3,  %ymm3,  %ymm3
        vpaddw       %ymm14, %ymm14, %ymm14
        vpaddw       %ymm15, %ymm15, %ymm15

        vpaddw        %ymm1,  %ymm0,  %ymm4
        vpsubw        %ymm1,  %ymm0,  %ymm5
        vpaddw       %ymm13, %ymm12,  %ymm8
        vpsubw       %ymm13, %ymm12,  %ymm9

        vpaddw        %ymm2,  %ymm4,  %ymm0
        vpsubw        %ymm2,  %ymm4,  %ymm2
        vpaddw        %ymm3,  %ymm5,  %ymm1
        vpsubw        %ymm3,  %ymm5,  %ymm3
        vpaddw       %ymm14,  %ymm8, %ymm12
        vpsubw       %ymm14,  %ymm8, %ymm14
        vpaddw       %ymm15,  %ymm9, %ymm13
        vpsubw       %ymm15,  %ymm9, %ymm15

        vmovdqu       %ymm0, 0x040(%rdi)
        vmovdqu       %ymm1, 0x0c0(%rdi)
        vmovdqu       %ymm2, 0x140(%rdi)
        vmovdqu       %ymm3, 0x1c0(%rdi)
        vmovdqu      %ymm12, 0x060(%rdi)
        vmovdqu      %ymm13, 0x0e0(%rdi)
        vmovdqu      %ymm14, 0x160(%rdi)
        vmovdqu      %ymm15, 0x1e0(%rdi)


        vzeroupper
        leave
        ret

.if 0

src1mid

0x000
0x020
0x040
0x060
0x080
0x0a0
0x0c0
0x0e0

src2mid

0x100
0x120
0x140
0x160
0x180
0x1a0
0x1c0
0x1e0

desmid

0x200
0x220
0x240
0x260
0x280
0x2a0
0x2c0
0x2e0
0x300
0x320
0x340
0x360
0x380
0x3a0
0x3c0
0x3e0

deshi

0x400
0x420
0x440
0x460
0x480
0x4a0
0x4c0
0x4e0
0x500
0x520
0x540
0x560
0x580
0x5a0
0x5c0
0x5e0

.endif

.global __asm_negacyclic_FFT16
.global ___asm_negacyclic_FFT16
__asm_negacyclic_FFT16:
___asm_negacyclic_FFT16:

        push   %rbp
        mov    %rsp, %rbp
        and    $0xffffffffffffffe0, %rsp
        sub    $0xa00, %rsp

// ================================

        vmovdqu 0x000(%rsi),  %ymm0
        vmovdqu 0x040(%rsi),  %ymm2
        vmovdqu 0x080(%rsi),  %ymm4
        vmovdqu 0x0c0(%rsi),  %ymm6
        vmovdqu 0x100(%rsi),  %ymm8
        vmovdqu 0x140(%rsi), %ymm10
        vmovdqu 0x180(%rsi), %ymm12
        vmovdqu 0x1c0(%rsi), %ymm14

        Bruunx2  1,  5,  9, 13,  0,  4,  8, 12,  3,  7, 11, 15,  2,  6, 10, 14, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx)

        vmovdqu       %ymm1, 0x000(%rsp)
        vmovdqu       %ymm3, 0x040(%rsp)
        vmovdqu       %ymm5, 0x080(%rsp)
        vmovdqu       %ymm7, 0x0c0(%rsp)
        vmovdqu       %ymm9, 0x100(%rsp)
        vmovdqu      %ymm11, 0x140(%rsp)
        vmovdqu      %ymm13, 0x180(%rsp)
        vmovdqu      %ymm15, 0x1c0(%rsp)

        vmovdqu 0x020(%rsi),  %ymm0
        vmovdqu 0x060(%rsi),  %ymm2
        vmovdqu 0x0a0(%rsi),  %ymm4
        vmovdqu 0x0e0(%rsi),  %ymm6
        vmovdqu 0x120(%rsi),  %ymm8
        vmovdqu 0x160(%rsi), %ymm10
        vmovdqu 0x1a0(%rsi), %ymm12
        vmovdqu 0x1e0(%rsi), %ymm14

        Bruunx2  1,  5,  9, 13,  0,  4,  8, 12,  3,  7, 11, 15,  2,  6, 10, 14, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx)

        vmovdqu       %ymm1, 0x020(%rsp)
        vmovdqu       %ymm3, 0x060(%rsp)
        vmovdqu       %ymm5, 0x0a0(%rsp)
        vmovdqu       %ymm7, 0x0e0(%rsp)
        vmovdqu       %ymm9, 0x120(%rsp)
        vmovdqu      %ymm11, 0x160(%rsp)
        vmovdqu      %ymm13, 0x1a0(%rsp)
        vmovdqu      %ymm15, 0x1e0(%rsp)

        vmovdqu 0x000(%rdx),  %ymm0
        vmovdqu 0x040(%rdx),  %ymm2
        vmovdqu 0x080(%rdx),  %ymm4
        vmovdqu 0x0c0(%rdx),  %ymm6
        vmovdqu 0x100(%rdx),  %ymm8
        vmovdqu 0x140(%rdx), %ymm10
        vmovdqu 0x180(%rdx), %ymm12
        vmovdqu 0x1c0(%rdx), %ymm14

        Bruunx2  1,  5,  9, 13,  0,  4,  8, 12,  3,  7, 11, 15,  2,  6, 10, 14, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx)

        vmovdqu       %ymm1, 0x200(%rsp)
        vmovdqu       %ymm3, 0x240(%rsp)
        vmovdqu       %ymm5, 0x280(%rsp)
        vmovdqu       %ymm7, 0x2c0(%rsp)
        vmovdqu       %ymm9, 0x300(%rsp)
        vmovdqu      %ymm11, 0x340(%rsp)
        vmovdqu      %ymm13, 0x380(%rsp)
        vmovdqu      %ymm15, 0x3c0(%rsp)

        vmovdqu 0x020(%rdx),  %ymm0
        vmovdqu 0x060(%rdx),  %ymm2
        vmovdqu 0x0a0(%rdx),  %ymm4
        vmovdqu 0x0e0(%rdx),  %ymm6
        vmovdqu 0x120(%rdx),  %ymm8
        vmovdqu 0x160(%rdx), %ymm10
        vmovdqu 0x1a0(%rdx), %ymm12
        vmovdqu 0x1e0(%rdx), %ymm14

        Bruunx2  1,  5,  9, 13,  0,  4,  8, 12,  3,  7, 11, 15,  2,  6, 10, 14, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx)

        vmovdqu       %ymm1, 0x220(%rsp)
        vmovdqu       %ymm3, 0x260(%rsp)
        vmovdqu       %ymm5, 0x2a0(%rsp)
        vmovdqu       %ymm7, 0x2e0(%rsp)
        vmovdqu       %ymm9, 0x320(%rsp)
        vmovdqu      %ymm11, 0x360(%rsp)
        vmovdqu      %ymm13, 0x3a0(%rsp)
        vmovdqu      %ymm15, 0x3e0(%rsp)

// ================================

        __asm_karatsuba8_core \
                %rsp, %rsp, %rsp, %rsp, 0x400, 0x000, 0x200, 0x700, \
                0x00(%rcx), 0x20(%rcx), 0x40(%rcx)

        vmovdqu 0x400(%rsp),  %ymm0
        vmovdqu 0x420(%rsp),  %ymm1
        vmovdqu 0x440(%rsp),  %ymm2
        vmovdqu 0x460(%rsp),  %ymm3
        vmovdqu 0x480(%rsp),  %ymm4
        vmovdqu 0x4a0(%rsp),  %ymm5
        vmovdqu 0x4c0(%rsp),  %ymm6

        vmovdqu 0x500(%rsp),  %ymm8
        vmovdqu 0x520(%rsp),  %ymm9
        vmovdqu 0x540(%rsp), %ymm10
        vmovdqu 0x560(%rsp), %ymm11
        vmovdqu 0x580(%rsp), %ymm12
        vmovdqu 0x5a0(%rsp), %ymm13
        vmovdqu 0x5c0(%rsp), %ymm14

        vpsubw       %ymm12,  %ymm4,  %ymm4
        vpsubw       %ymm13,  %ymm5,  %ymm5
        vpsubw       %ymm14,  %ymm6,  %ymm6

        montgomery_mul_mem 12, 12, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15
        montgomery_mul_mem 13, 13, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15
        montgomery_mul_mem 14, 14, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15

        vpsubw       %ymm12,  %ymm8,  %ymm8
        vpsubw       %ymm13,  %ymm9,  %ymm9
        vpsubw       %ymm14, %ymm10, %ymm10

        vpsubw        %ymm8,  %ymm0,  %ymm0
        vpsubw        %ymm9,  %ymm1,  %ymm1
        vpsubw       %ymm10,  %ymm2,  %ymm2
        vpsubw       %ymm11,  %ymm3,  %ymm3

        montgomery_mul_mem  8,  8, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15
        montgomery_mul_mem  9,  9, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15
        montgomery_mul_mem 10, 10, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15
        montgomery_mul_mem 11, 11, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15

        vmovdqu 0x4e0(%rsp),  %ymm7

        vpsubw        %ymm8,  %ymm4,  %ymm4
        vpsubw        %ymm9,  %ymm5,  %ymm5
        vpsubw       %ymm10,  %ymm6,  %ymm6
        vpsubw       %ymm11,  %ymm7,  %ymm7

        vmovdqu       %ymm0, 0x400(%rsp)
        vmovdqu       %ymm1, 0x420(%rsp)
        vmovdqu       %ymm2, 0x440(%rsp)
        vmovdqu       %ymm3, 0x460(%rsp)
        vmovdqu       %ymm4, 0x480(%rsp)
        vmovdqu       %ymm5, 0x4a0(%rsp)
        vmovdqu       %ymm6, 0x4c0(%rsp)
        vmovdqu       %ymm7, 0x4e0(%rsp)

// ================

        __asm_karatsuba8_core \
                %rsp, %rsp, %rsp, %rsp, 0x500, 0x100, 0x300, 0x700, \
                0x00(%rcx), 0x20(%rcx), 0x40(%rcx)

        vmovdqu 0x500(%rsp),  %ymm0
        vmovdqu 0x520(%rsp),  %ymm1
        vmovdqu 0x540(%rsp),  %ymm2
        vmovdqu 0x560(%rsp),  %ymm3
        vmovdqu 0x580(%rsp),  %ymm4
        vmovdqu 0x5a0(%rsp),  %ymm5
        vmovdqu 0x5c0(%rsp),  %ymm6

        vmovdqu 0x600(%rsp),  %ymm8
        vmovdqu 0x620(%rsp),  %ymm9
        vmovdqu 0x640(%rsp), %ymm10
        vmovdqu 0x660(%rsp), %ymm11
        vmovdqu 0x680(%rsp), %ymm12
        vmovdqu 0x6a0(%rsp), %ymm13
        vmovdqu 0x6c0(%rsp), %ymm14

        vpsubw       %ymm12,  %ymm4,  %ymm4
        vpsubw       %ymm13,  %ymm5,  %ymm5
        vpsubw       %ymm14,  %ymm6,  %ymm6

        montgomery_mul_mem 12, 12, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15
        montgomery_mul_mem 13, 13, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15
        montgomery_mul_mem 14, 14, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15

        vpaddw       %ymm12,  %ymm8,  %ymm8
        vpaddw       %ymm13,  %ymm9,  %ymm9
        vpaddw       %ymm14, %ymm10, %ymm10

        vpsubw        %ymm8,  %ymm0,  %ymm0
        vpsubw        %ymm9,  %ymm1,  %ymm1
        vpsubw       %ymm10,  %ymm2,  %ymm2
        vpsubw       %ymm11,  %ymm3,  %ymm3

        montgomery_mul_mem  8,  8, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15
        montgomery_mul_mem  9,  9, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15
        montgomery_mul_mem 10, 10, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15
        montgomery_mul_mem 11, 11, 0x060(%rcx), 0x000(%rcx), 0x020(%rcx), 7, 15

        vmovdqu 0x5e0(%rsp),  %ymm7

        vpaddw        %ymm8,  %ymm4,  %ymm4
        vpaddw        %ymm9,  %ymm5,  %ymm5
        vpaddw       %ymm10,  %ymm6,  %ymm6
        vpaddw       %ymm11,  %ymm7,  %ymm7

        vmovdqu       %ymm0, 0x500(%rsp)
        vmovdqu       %ymm1, 0x520(%rsp)
        vmovdqu       %ymm2, 0x540(%rsp)
        vmovdqu       %ymm3, 0x560(%rsp)
        vmovdqu       %ymm4, 0x580(%rsp)
        vmovdqu       %ymm5, 0x5a0(%rsp)
        vmovdqu       %ymm6, 0x5c0(%rsp)
        vmovdqu       %ymm7, 0x5e0(%rsp)

// ================================

        vmovdqu 0x400(%rsp),  %ymm0
        vmovdqu 0x480(%rsp),  %ymm1
        vmovdqu 0x500(%rsp),  %ymm2
        vmovdqu 0x580(%rsp),  %ymm3
        vmovdqu 0x420(%rsp),  %ymm8
        vmovdqu 0x4a0(%rsp),  %ymm9
        vmovdqu 0x520(%rsp), %ymm10
        vmovdqu 0x5a0(%rsp), %ymm11

        iBruunx2  4,  5,  6,  7,  0,  1,  2,  3, 12, 13, 14, 15,  8,  9, 10, 11, 0x080(%rcx), 0x000(%rcx), 0x020(%rcx)

        vmovdqu       %ymm4, 0x000(%rdi)
        vmovdqu       %ymm5, 0x080(%rdi)
        vmovdqu       %ymm7, 0x100(%rdi)
        vmovdqu       %ymm6, 0x180(%rdi)
        vmovdqu      %ymm12, 0x020(%rdi)
        vmovdqu      %ymm13, 0x0a0(%rdi)
        vmovdqu      %ymm15, 0x120(%rdi)
        vmovdqu      %ymm14, 0x1a0(%rdi)

// ================

        vmovdqu 0x440(%rsp),  %ymm0
        vmovdqu 0x4c0(%rsp),  %ymm1
        vmovdqu 0x540(%rsp),  %ymm2
        vmovdqu 0x5c0(%rsp),  %ymm3
        vmovdqu 0x460(%rsp),  %ymm8
        vmovdqu 0x4e0(%rsp),  %ymm9
        vmovdqu 0x560(%rsp), %ymm10
        vmovdqu 0x5e0(%rsp), %ymm11

        iBruunx2  4,  5,  6,  7,  0,  1,  2,  3, 12, 13, 14, 15,  8,  9, 10, 11, 0x080(%rcx), 0x000(%rcx), 0x020(%rcx)

        vmovdqu       %ymm4, 0x040(%rdi)
        vmovdqu       %ymm5, 0x0c0(%rdi)
        vmovdqu       %ymm7, 0x140(%rdi)
        vmovdqu       %ymm6, 0x1c0(%rdi)
        vmovdqu      %ymm12, 0x060(%rdi)
        vmovdqu      %ymm13, 0x0e0(%rdi)
        vmovdqu      %ymm15, 0x160(%rdi)
        vmovdqu      %ymm14, 0x1e0(%rdi)

// ================================

        vzeroupper
        leave
        ret

















