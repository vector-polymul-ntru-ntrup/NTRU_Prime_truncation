
#include "basemul_core.inc"
#include "permute.inc"

#include "params.h"

#define __asm_3x2 NAME(__asm_3x2)
#define ___asm_3x2 NAME(___asm_3x2)
#define __asm_3x2_pre NAME(__asm_3x2_pre)
#define ___asm_3x2_pre NAME(___asm_3x2_pre)
#define __asm_3x2_post NAME(__asm_3x2_post)
#define ___asm_3x2_post NAME(___asm_3x2_post)

.text

.if 0

a0 + w a1 + w^2 a2
a0 + w^2 a1 + w a2
=
a0 - a2 + (a1 - a2) w
a0 - a1 + (a2 - a1) w

.endif

.global __asm_3x2
.global ___asm_3x2
__asm_3x2:
___asm_3x2:

        vmovdqu 0x000(%rdx),  %ymm6
        vmovdqu 0x020(%rdx),  %ymm8
        vmovdqu 0x000(%rsi),  %ymm9

        mov  $16, %rax

        __asm_3x2_loop:

        vmovdqu 0x000(%rdi),  %ymm0
        vmovdqu 0x080(%rdi),  %ymm1
        vmovdqu 0x040(%rdi),  %ymm2
        vmovdqu 0x060(%rdi),  %ymm3
        vmovdqu 0x020(%rdi),  %ymm4
        vmovdqu 0x0a0(%rdi),  %ymm5

        vpaddw        %ymm3,  %ymm0, %ymm10
        vpsubw        %ymm3,  %ymm0, %ymm13
        vpaddw        %ymm4,  %ymm1, %ymm11
        vpsubw        %ymm4,  %ymm1, %ymm14
        vpaddw        %ymm5,  %ymm2, %ymm12
        vpsubw        %ymm5,  %ymm2, %ymm15

        vpaddw       %ymm11, %ymm10, %ymm0
        vpaddw       %ymm12,  %ymm0, %ymm0
        vpaddw       %ymm14, %ymm13, %ymm3
        vpaddw       %ymm15,  %ymm3, %ymm3

        vmovdqu       %ymm0, 0x000(%rdi)
        vmovdqu       %ymm3, 0x060(%rdi)

        vpsubw       %ymm12, %ymm10,  %ymm1
        vpsubw       %ymm15, %ymm13,  %ymm4
        vpsubw       %ymm11, %ymm10,  %ymm2
        vpsubw       %ymm14, %ymm13,  %ymm5
        vpsubw       %ymm12, %ymm11, %ymm11
        vpsubw       %ymm15, %ymm14, %ymm14

        montgomery_mul 11, 11, 9, 6, 8, 0, 12
        montgomery_mul 14, 14, 9, 6, 8, 3, 15

        vpaddw       %ymm11,  %ymm1,  %ymm1
        vpaddw       %ymm14,  %ymm4,  %ymm4
        vpsubw       %ymm11,  %ymm2,  %ymm2
        vpsubw       %ymm14,  %ymm5,  %ymm5

        vmovdqu       %ymm1, 0x080(%rdi)
        vmovdqu       %ymm2, 0x040(%rdi)
        vmovdqu       %ymm4, 0x020(%rdi)
        vmovdqu       %ymm5, 0x0a0(%rdi)

        add          $(0x020*6), %rdi

        dec          %rax
        cmp          $0, %rax
        jne          __asm_3x2_loop


        ret

.global __asm_3x2_pre
.global ___asm_3x2_pre
__asm_3x2_pre:
___asm_3x2_pre:

        vmovdqu 0x000(%rdx),  %ymm6
        vmovdqu 0x020(%rdx),  %ymm8
        vmovdqu 0x000(%rsi),  %ymm9

        mov  $16, %rax

        __asm_3x2_pre_loop:

        vmovdqu 0x000(%rcx), %ymm10
        vmovdqu 0x080(%rcx), %ymm11
        vmovdqu 0x040(%rcx), %ymm12

        vmovdqu 0x000(%rdi),  %ymm0
        vmovdqu 0x080(%rdi),  %ymm1
        vmovdqu 0x040(%rdi),  %ymm2

        montgomery_mul  0,  0, 10, 6, 8, 13, 14
        montgomery_mul  1,  1, 11, 6, 8, 13, 14
        montgomery_mul  2,  2, 12, 6, 8, 13, 14

        vmovdqu 0x060(%rcx), %ymm10
        vmovdqu 0x020(%rcx), %ymm11
        vmovdqu 0x0a0(%rcx), %ymm12

        vmovdqu 0x060(%rdi),  %ymm3
        vmovdqu 0x020(%rdi),  %ymm4
        vmovdqu 0x0a0(%rdi),  %ymm5

        montgomery_mul  3,  3, 10, 6, 8, 13, 14
        montgomery_mul  4,  4, 11, 6, 8, 13, 14
        montgomery_mul  5,  5, 12, 6, 8, 13, 14


        vpaddw        %ymm3,  %ymm0, %ymm10
        vpsubw        %ymm3,  %ymm0, %ymm13
        vpaddw        %ymm4,  %ymm1, %ymm11
        vpsubw        %ymm4,  %ymm1, %ymm14
        vpaddw        %ymm5,  %ymm2, %ymm12
        vpsubw        %ymm5,  %ymm2, %ymm15

        vpaddw       %ymm11, %ymm10, %ymm0
        vpaddw       %ymm12,  %ymm0, %ymm0
        vpaddw       %ymm14, %ymm13, %ymm3
        vpaddw       %ymm15,  %ymm3, %ymm3

        vmovdqu       %ymm0, 0x000(%rdi)
        vmovdqu       %ymm3, 0x060(%rdi)

        vpsubw       %ymm12, %ymm10,  %ymm1
        vpsubw       %ymm15, %ymm13,  %ymm4
        vpsubw       %ymm11, %ymm10,  %ymm2
        vpsubw       %ymm14, %ymm13,  %ymm5
        vpsubw       %ymm12, %ymm11, %ymm11
        vpsubw       %ymm15, %ymm14, %ymm14

        montgomery_mul 11, 11, 9, 6, 8, 0, 12
        montgomery_mul 14, 14, 9, 6, 8, 3, 15

        vpaddw       %ymm11,  %ymm1,  %ymm1
        vpaddw       %ymm14,  %ymm4,  %ymm4
        vpsubw       %ymm11,  %ymm2,  %ymm2
        vpsubw       %ymm14,  %ymm5,  %ymm5

        vmovdqu       %ymm1, 0x080(%rdi)
        vmovdqu       %ymm2, 0x040(%rdi)
        vmovdqu       %ymm4, 0x020(%rdi)
        vmovdqu       %ymm5, 0x0a0(%rdi)

        add          $(0x020*6), %rdi
        add          $(0x020*6), %rcx

        dec          %rax
        cmp          $0, %rax
        jne          __asm_3x2_pre_loop


        ret

.global __asm_3x2_post
.global ___asm_3x2_post
__asm_3x2_post:
___asm_3x2_post:

        vmovdqu 0x000(%rdx),  %ymm6
        vmovdqu 0x020(%rdx),  %ymm8
        vmovdqu 0x000(%rsi),  %ymm9

        mov  $16, %rax

        __asm_3x2_post_loop:

        vmovdqu 0x000(%rdi),  %ymm0
        vmovdqu 0x080(%rdi),  %ymm1
        vmovdqu 0x040(%rdi),  %ymm2
        vmovdqu 0x060(%rdi),  %ymm3
        vmovdqu 0x020(%rdi),  %ymm4
        vmovdqu 0x0a0(%rdi),  %ymm5

        vpaddw        %ymm3,  %ymm0, %ymm10
        vpsubw        %ymm3,  %ymm0, %ymm13
        vpaddw        %ymm4,  %ymm1, %ymm11
        vpsubw        %ymm4,  %ymm1, %ymm14
        vpaddw        %ymm5,  %ymm2, %ymm12
        vpsubw        %ymm5,  %ymm2, %ymm15

        vmovdqu 0x000(%rcx),  %ymm1
        vmovdqu 0x060(%rcx),  %ymm4

        vpaddw       %ymm11, %ymm10, %ymm0
        vpaddw       %ymm12,  %ymm0, %ymm0
        vpaddw       %ymm14, %ymm13, %ymm3
        vpaddw       %ymm15,  %ymm3, %ymm3

        montgomery_mul  0,  0, 1, 6, 8, 2, 5
        montgomery_mul  3,  3, 4, 6, 8, 2, 5

        vmovdqu       %ymm0, 0x000(%rdi)
        vmovdqu       %ymm3, 0x060(%rdi)

        vpsubw       %ymm12, %ymm10,  %ymm1
        vpsubw       %ymm15, %ymm13,  %ymm4
        vpsubw       %ymm11, %ymm10,  %ymm2
        vpsubw       %ymm14, %ymm13,  %ymm5
        vpsubw       %ymm12, %ymm11, %ymm11
        vpsubw       %ymm15, %ymm14, %ymm14

        vmovdqu 0x080(%rcx), %ymm10
        vmovdqu 0x020(%rcx), %ymm13

        montgomery_mul 11, 11, 9, 6, 8, 0, 12
        montgomery_mul 14, 14, 9, 6, 8, 3, 15

        vpaddw       %ymm11,  %ymm1,  %ymm1
        vpaddw       %ymm14,  %ymm4,  %ymm4
        vpsubw       %ymm11,  %ymm2,  %ymm2
        vpsubw       %ymm14,  %ymm5,  %ymm5

        vmovdqu 0x040(%rcx), %ymm12
        vmovdqu 0x0a0(%rcx), %ymm15

        montgomery_mul  1,  1, 10, 6, 8, 0, 3
        montgomery_mul  4,  4, 13, 6, 8, 0, 3

        vmovdqu       %ymm1, 0x080(%rdi)
        vmovdqu       %ymm4, 0x020(%rdi)

        montgomery_mul  2,  2, 12, 6, 8, 0, 3
        montgomery_mul  5,  5, 15, 6, 8, 0, 3

        vmovdqu       %ymm2, 0x040(%rdi)
        vmovdqu       %ymm5, 0x0a0(%rdi)

        add          $(0x020*6), %rdi
        add          $(0x020*6), %rcx

        dec          %rax
        cmp          $0, %rax
        jne          __asm_3x2_post_loop


        ret





