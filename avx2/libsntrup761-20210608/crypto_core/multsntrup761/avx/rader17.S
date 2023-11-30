
#include "basemul_core.inc"
#include "butterflies.inc"
#include "permute.inc"

#include "params.h"

#define __asm_rader17_truncated NAME(__asm_rader17_truncated)
#define ___asm_rader17_truncated NAME(___asm_rader17_truncated)
#define __asm_irader17_truncated NAME(__asm_irader17_truncated)
#define ___asm_irader17_truncated NAME(___asm_irader17_truncated)

.if 0

i mapsto 16 - rader_dlog_permute[i] =
{
0, 2, 15, 4,
11, 1, 5, 6,
14, 13, 9, 3,
12, 7, 10, 8
}

16 - rader_dlog_permute[i] mapsto i =
{
0, 5, 1, 11,
3, 6, 7, 13,
15, 10, 14, 4,
12, 9, 8, 2
}

i mapsto rader_dlog_permute[i] =
{
0, 14, 1, 12,
5, 15, 11, 10,
2, 3, 7, 13,
4, 9, 6, 8
}

rader_dlog_permute[i] mapsto i =
{
0, 2, 8, 9,
12, 4, 14, 10,
15, 13, 7, 6,
3, 11, 1, 5
}

.endif



.global __asm_rader17_truncated
.global ___asm_rader17_truncated
__asm_rader17_truncated:
___asm_rader17_truncated:

        push   %rbp
        mov    %rsp, %rbp
        and    $0xffffffffffffffe0, %rsp
        sub    $0x600, %rsp

        .equ jump, 6

         vmovdqu (  0*jump)(%rsi),  %ymm0
         vmovdqu (160*jump)(%rsi),  %ymm1
         vmovdqu ( 32*jump)(%rsi),  %ymm2
         vmovdqu (352*jump)(%rsi),  %ymm3
         vmovdqu ( 96*jump)(%rsi),  %ymm4
         vmovdqu (192*jump)(%rsi),  %ymm5
         vmovdqu (224*jump)(%rsi),  %ymm6
         vmovdqu (416*jump)(%rsi),  %ymm7

         vpsubw  (480*jump)(%rsi),  %ymm0,  %ymm8
         vpaddw  (480*jump)(%rsi),  %ymm0,  %ymm0
         vpsubw  (320*jump)(%rsi),  %ymm1,  %ymm9
         vpaddw  (320*jump)(%rsi),  %ymm1,  %ymm1
         vpsubw  (448*jump)(%rsi),  %ymm2, %ymm10
         vpaddw  (448*jump)(%rsi),  %ymm2,  %ymm2
         vpsubw  (128*jump)(%rsi),  %ymm3, %ymm11
         vpaddw  (128*jump)(%rsi),  %ymm3,  %ymm3
         vpsubw  (384*jump)(%rsi),  %ymm4, %ymm12
         vpaddw  (384*jump)(%rsi),  %ymm4,  %ymm4
         vpsubw  (288*jump)(%rsi),  %ymm5, %ymm13
         vpaddw  (288*jump)(%rsi),  %ymm5,  %ymm5
         vpsubw  (256*jump)(%rsi),  %ymm6, %ymm14
         vpaddw  (256*jump)(%rsi),  %ymm6,  %ymm6
         vpsubw  ( 64*jump)(%rsi),  %ymm7, %ymm15
         vpaddw  ( 64*jump)(%rsi),  %ymm7,  %ymm7

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



        vmovdqu       %ymm0, (  0*jump)(%rdi)
        vmovdqu       %ymm1, ( 64*jump)(%rdi)
        vmovdqu       %ymm2, (256*jump)(%rdi)
        vmovdqu       %ymm3, (288*jump)(%rdi)
        vmovdqu       %ymm4, (384*jump)(%rdi)
        vmovdqu       %ymm5, (128*jump)(%rdi)
        vmovdqu       %ymm6, (448*jump)(%rdi)
        vmovdqu       %ymm7, (320*jump)(%rdi)
        vmovdqu       %ymm8, (480*jump)(%rdi)
        vmovdqu       %ymm9, (416*jump)(%rdi)
        vmovdqu      %ymm10, (224*jump)(%rdi)
        vmovdqu      %ymm11, (192*jump)(%rdi)
        vmovdqu      %ymm12, ( 96*jump)(%rdi)
        vmovdqu      %ymm13, (352*jump)(%rdi)
        vmovdqu      %ymm14, ( 32*jump)(%rdi)
        vmovdqu      %ymm15, (160*jump)(%rdi)



        vzeroupper
        leave
        ret

.if 0

i mapsto rader_dlog_permute[i] =
{
0, 14, 1, 12,
5, 15, 11, 10,
2, 3, 7, 13,
4, 9, 6, 8
}

rader_dlog_permute[i] mapsto i =
{
0, 2, 8, 9,
12, 4, 14, 10,
15, 13, 7, 6,
3, 11, 1, 5
}

i mapsto 15 - rader_dlog_permute[i] =
{
15, 1, 14, 3,
10, 0, 4, 5,
13, 12, 8, 2,
11, 6, 9, 7
}

15 - rader_dlog_permute[i] mapsto i =
{
5, 1, 11, 3,
6, 7, 13, 15,
10, 14, 4, 12,
9, 8, 2, 0
}



.endif



.global __asm_irader17_truncated
.global ___asm_irader17_truncated
__asm_irader17_truncated:
___asm_irader17_truncated:

        push   %rbp
        mov    %rsp, %rbp
        and    $0xffffffffffffffe0, %rsp
        sub    $0x600, %rsp

        .equ jump, 6

         vmovdqu (  0*jump)(%rsi),  %ymm0
         vmovdqu ( 64*jump)(%rsi),  %ymm1
         vmovdqu (256*jump)(%rsi),  %ymm2
         vmovdqu (288*jump)(%rsi),  %ymm3
         vmovdqu (384*jump)(%rsi),  %ymm4
         vmovdqu (128*jump)(%rsi),  %ymm5
         vmovdqu (448*jump)(%rsi),  %ymm6
         vmovdqu (320*jump)(%rsi),  %ymm7

         vpsubw  (480*jump)(%rsi),  %ymm0,  %ymm8
         vpaddw  (480*jump)(%rsi),  %ymm0,  %ymm0
         vpsubw  (416*jump)(%rsi),  %ymm1,  %ymm9
         vpaddw  (416*jump)(%rsi),  %ymm1,  %ymm1
         vpsubw  (224*jump)(%rsi),  %ymm2, %ymm10
         vpaddw  (224*jump)(%rsi),  %ymm2,  %ymm2
         vpsubw  (192*jump)(%rsi),  %ymm3, %ymm11
         vpaddw  (192*jump)(%rsi),  %ymm3,  %ymm3
         vpsubw  ( 96*jump)(%rsi),  %ymm4, %ymm12
         vpaddw  ( 96*jump)(%rsi),  %ymm4,  %ymm4
         vpsubw  (352*jump)(%rsi),  %ymm5, %ymm13
         vpaddw  (352*jump)(%rsi),  %ymm5,  %ymm5
         vpsubw  ( 32*jump)(%rsi),  %ymm6, %ymm14
         vpaddw  ( 32*jump)(%rsi),  %ymm6,  %ymm6
         vpsubw  (160*jump)(%rsi),  %ymm7, %ymm15
         vpaddw  (160*jump)(%rsi),  %ymm7,  %ymm7

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



        vmovdqu       %ymm0, (160*jump)(%rdi)
        vmovdqu       %ymm1, ( 32*jump)(%rdi)
        vmovdqu       %ymm2, (352*jump)(%rdi)
        vmovdqu       %ymm3, ( 96*jump)(%rdi)
        vmovdqu       %ymm4, (192*jump)(%rdi)
        vmovdqu       %ymm5, (224*jump)(%rdi)
        vmovdqu       %ymm6, (416*jump)(%rdi)
        vmovdqu       %ymm7, (480*jump)(%rdi)
        vmovdqu       %ymm8, (320*jump)(%rdi)
        vmovdqu       %ymm9, (448*jump)(%rdi)
        vmovdqu      %ymm10, (128*jump)(%rdi)
        vmovdqu      %ymm11, (384*jump)(%rdi)
        vmovdqu      %ymm12, (288*jump)(%rdi)
        vmovdqu      %ymm13, (256*jump)(%rdi)
        vmovdqu      %ymm14, ( 64*jump)(%rdi)
        vmovdqu      %ymm15, (  0*jump)(%rdi)



        vzeroupper
        leave
        ret




