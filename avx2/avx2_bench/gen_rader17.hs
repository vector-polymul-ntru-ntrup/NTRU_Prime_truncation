
pad_f_string _f_string _len = replicate (_len - length _f_string) ' ' ++ _f_string

src_ptr = "%rsi"
des_ptr = "%rdi"

-- load_permute  0 =  0
-- load_permute  1 =  5
-- load_permute  2 =  1
-- load_permute  3 = 11
-- load_permute  4 =  3
-- load_permute  5 =  6
-- load_permute  6 =  7
-- load_permute  7 = 13
-- load_permute  8 = 15
-- load_permute  9 = 10
-- load_permute 10 = 14
-- load_permute 11 =  4
-- load_permute 12 = 12
-- load_permute 13 =  9
-- load_permute 14 =  8
-- load_permute 15 =  2

-- store_permute  0 =  0
-- store_permute  1 =  2
-- store_permute  2 =  8
-- store_permute  3 =  9
-- store_permute  4 = 12
-- store_permute  5 =  4
-- store_permute  6 = 14
-- store_permute  7 = 10
-- store_permute  8 = 15
-- store_permute  9 = 13
-- store_permute 10 =  7
-- store_permute 11 =  6
-- store_permute 12 =  3
-- store_permute 13 = 11
-- store_permute 14 =  1
-- store_permute 15 =  5

-- f_name = "__asm_rader17_truncated"

load_permute  0 =  0
load_permute  1 =  2
load_permute  2 =  8
load_permute  3 =  9
load_permute  4 = 12
load_permute  5 =  4
load_permute  6 = 14
load_permute  7 = 10
load_permute  8 = 15
load_permute  9 = 13
load_permute 10 =  7
load_permute 11 =  6
load_permute 12 =  3
load_permute 13 = 11
load_permute 14 =  1
load_permute 15 =  5

store_permute  0 =  5
store_permute  1 =  1
store_permute  2 = 11
store_permute  3 =  3
store_permute  4 =  6
store_permute  5 =  7
store_permute  6 = 13
store_permute  7 = 15
store_permute  8 = 10
store_permute  9 = 14
store_permute 10 =  4
store_permute 11 = 12
store_permute 12 =  9
store_permute 13 =  8
store_permute 14 =  2
store_permute 15 =  0


f_name = "__asm_irader17_truncated"

load_map = \x -> "(" ++ pad_f_string (show(load_permute(x) * 32)) 3 ++ "*jump)(" ++ src_ptr ++ ")"
store_map = \x -> "(" ++ pad_f_string (show(store_permute(x) * 32)) 3 ++ "*jump)(" ++ des_ptr ++ ")"

head_f_string = "\
\\n\
\\n\
\.global " ++ f_name ++ "\n\
\.global _" ++ f_name ++ "\n\
\" ++ f_name ++ ":\n\
\_" ++ f_name ++ ":\n\
\\n\
\        push   %rbp\n\
\        mov    %rsp, %rbp\n\
\        and    $0xffffffffffffffe0, %rsp\n\
\        sub    $0x600, %rsp\n\
\\n\
\        .equ jump, 6\n\
\\n"

load_f_string = "\
\        vmovdqu " ++ (load_map  0) ++ ",  %ymm0\n\
\        vmovdqu " ++ (load_map  1) ++ ",  %ymm1\n\
\        vmovdqu " ++ (load_map  2) ++ ",  %ymm2\n\
\        vmovdqu " ++ (load_map  3) ++ ",  %ymm3\n\
\        vmovdqu " ++ (load_map  4) ++ ",  %ymm4\n\
\        vmovdqu " ++ (load_map  5) ++ ",  %ymm5\n\
\        vmovdqu " ++ (load_map  6) ++ ",  %ymm6\n\
\        vmovdqu " ++ (load_map  7) ++ ",  %ymm7\n\
\\n\
\        vpsubw  " ++ (load_map  8) ++ ",  %ymm0,  %ymm8\n\
\        vpaddw  " ++ (load_map  8) ++ ",  %ymm0,  %ymm0\n\
\        vpsubw  " ++ (load_map  9) ++ ",  %ymm1,  %ymm9\n\
\        vpaddw  " ++ (load_map  9) ++ ",  %ymm1,  %ymm1\n\
\        vpsubw  " ++ (load_map 10) ++ ",  %ymm2, %ymm10\n\
\        vpaddw  " ++ (load_map 10) ++ ",  %ymm2,  %ymm2\n\
\        vpsubw  " ++ (load_map 11) ++ ",  %ymm3, %ymm11\n\
\        vpaddw  " ++ (load_map 11) ++ ",  %ymm3,  %ymm3\n\
\        vpsubw  " ++ (load_map 12) ++ ",  %ymm4, %ymm12\n\
\        vpaddw  " ++ (load_map 12) ++ ",  %ymm4,  %ymm4\n\
\        vpsubw  " ++ (load_map 13) ++ ",  %ymm5, %ymm13\n\
\        vpaddw  " ++ (load_map 13) ++ ",  %ymm5,  %ymm5\n\
\        vpsubw  " ++ (load_map 14) ++ ",  %ymm6, %ymm14\n\
\        vpaddw  " ++ (load_map 14) ++ ",  %ymm6,  %ymm6\n\
\        vpsubw  " ++ (load_map 15) ++ ",  %ymm7, %ymm15\n\
\        vpaddw  " ++ (load_map 15) ++ ",  %ymm7,  %ymm7\n\
\\n"

body_f_string = "\
\        vmovdqu       %ymm8, 0x100(%rsp)\n\
\        vmovdqu       %ymm9, 0x120(%rsp)\n\
\        vmovdqu      %ymm10, 0x140(%rsp)\n\
\        vmovdqu      %ymm11, 0x160(%rsp)\n\
\        vmovdqu      %ymm12, 0x180(%rsp)\n\
\        vmovdqu      %ymm13, 0x1a0(%rsp)\n\
\        vmovdqu      %ymm14, 0x1c0(%rsp)\n\
\        vmovdqu      %ymm15, 0x1e0(%rsp)\n\
\\n\
\        vpaddw        %ymm4,  %ymm0,  %ymm8\n\
\        vpsubw        %ymm4,  %ymm0, %ymm12\n\
\        vpaddw        %ymm5,  %ymm1,  %ymm9\n\
\        vpsubw        %ymm5,  %ymm1, %ymm13\n\
\        vpaddw        %ymm6,  %ymm2, %ymm10\n\
\        vpsubw        %ymm6,  %ymm2, %ymm14\n\
\        vpaddw        %ymm7,  %ymm3, %ymm11\n\
\        vpsubw        %ymm7,  %ymm3, %ymm15\n\
\\n\
\        vmovdqu      %ymm12, 0x080(%rsp)\n\
\        vmovdqu      %ymm13, 0x0a0(%rsp)\n\
\        vmovdqu      %ymm14, 0x0c0(%rsp)\n\
\        vmovdqu      %ymm15, 0x0e0(%rsp)\n\
\\n\
\        vmovdqu 0x000( %r8), %ymm12\n\
\        vmovdqu 0x020( %r8), %ymm13\n\
\\n\
\// ================================\n\
\// x^4 - 1\n\
\\n\
\        vmovdqu  0x040( %r8),  %ymm13\n\
\        barrett_reducex2 0, 1,  8,  9, 12, 13, 14, 15\n\
\        barrett_reducex2 2, 3, 10, 11, 12, 13, 14, 15\n\
\\n\
\        vpsubw        %ymm2,  %ymm0, %ymm10\n\
\        vpaddw        %ymm2,  %ymm0,  %ymm0\n\
\        vpsubw        %ymm3,  %ymm1, %ymm11\n\
\        vpaddw        %ymm3,  %ymm1,  %ymm1\n\
\        vpaddw        %ymm1,  %ymm0,  %ymm8\n\
\        vpsubw        %ymm1,  %ymm0,  %ymm9\n\
\\n\
\        vmovdqu 0x000(%rdx),  %ymm4\n\
\        vmovdqu 0x020(%rdx),  %ymm5\n\
\        vmovdqu 0x040(%rdx),  %ymm6\n\
\        vmovdqu 0x060(%rdx),  %ymm7\n\
\\n\
\        vpmullw 0x000(%rcx),  %ymm8, %ymm14\n\
\        vpmullw 0x020(%rcx),  %ymm9, %ymm15\n\
\        vpmulhw       %ymm4,  %ymm8,  %ymm4\n\
\        vpmulhw       %ymm5,  %ymm9,  %ymm5\n\
\        vpmulhw      %ymm14, %ymm12, %ymm14\n\
\        vpmulhw      %ymm15, %ymm12, %ymm15\n\
\        vpsubw       %ymm14,  %ymm4,  %ymm4\n\
\        vpsubw       %ymm15,  %ymm5,  %ymm5\n\
\\n\
\        vpmullw 0x040(%rcx), %ymm10, %ymm14\n\
\        vpmullw 0x060(%rcx), %ymm10, %ymm15\n\
\        vpmullw 0x040(%rcx), %ymm11,  %ymm8\n\
\        vpmullw 0x060(%rcx), %ymm11,  %ymm9\n\
\        vpmulhw       %ymm6, %ymm10,  %ymm0\n\
\        vpmulhw       %ymm7, %ymm10,  %ymm1\n\
\        vpmulhw       %ymm6, %ymm11,  %ymm2\n\
\        vpmulhw       %ymm7, %ymm11,  %ymm3\n\
\        vpmulhw      %ymm14, %ymm12, %ymm14\n\
\        vpmulhw      %ymm15, %ymm12, %ymm15\n\
\        vpmulhw       %ymm8, %ymm12,  %ymm8\n\
\        vpmulhw       %ymm9, %ymm12,  %ymm9\n\
\        vpsubw       %ymm14,  %ymm0,  %ymm0\n\
\        vpsubw       %ymm15,  %ymm1,  %ymm1\n\
\        vpsubw        %ymm8,  %ymm2,  %ymm2\n\
\        vpsubw        %ymm9,  %ymm3,  %ymm3\n\
\\n\
\        vpsubw        %ymm3,  %ymm0, %ymm6\n\
\        vpaddw        %ymm2,  %ymm1, %ymm7\n\
\\n\
\        vpaddw        %ymm5,  %ymm4,  %ymm0\n\
\        vpsubw        %ymm5,  %ymm4,  %ymm1\n\
\        vpsubw        %ymm6,  %ymm0,  %ymm2\n\
\        vpaddw        %ymm6,  %ymm0,  %ymm0\n\
\        vpsubw        %ymm7,  %ymm1,  %ymm3\n\
\        vpaddw        %ymm7,  %ymm1,  %ymm1\n\
\\n\
\        vmovdqu  0x040( %r8),  %ymm13\n\
\\n\
\        barrett_reducex2 0, 1, 0, 1, 12, 13, 14, 15\n\
\        barrett_reducex2 2, 3, 2, 3, 12, 13, 14, 15\n\
\\n\
\        vmovdqu       %ymm0, 0x000(%rsp)\n\
\        vmovdqu       %ymm1, 0x020(%rsp)\n\
\        vmovdqu       %ymm2, 0x040(%rsp)\n\
\        vmovdqu       %ymm3, 0x060(%rsp)\n\
\\n\
\        vmovdqu  0x020( %r8),  %ymm13\n\
\\n\
\// ================================\n\
\// x^4 + 1\n\
\\n\
\        vmovdqu 0x080(%rsp),  %ymm8\n\
\        vmovdqu 0x0a0(%rsp),  %ymm9\n\
\        vmovdqu 0x0c0(%rsp), %ymm10\n\
\        vmovdqu 0x0e0(%rsp), %ymm11\n\
\\n\
\        vpmullw 0x080(%rcx),  %ymm8,  %ymm0\n\
\        vpmullw 0x0a0(%rcx), %ymm11,  %ymm1\n\
\        vpmullw 0x0c0(%rcx), %ymm10,  %ymm2\n\
\        vpmullw 0x0e0(%rcx),  %ymm9,  %ymm3\n\
\        vpmulhw       %ymm0, %ymm12,  %ymm0\n\
\        vpmulhw       %ymm1, %ymm12,  %ymm1\n\
\        vpmulhw       %ymm2, %ymm12,  %ymm2\n\
\        vpmulhw       %ymm3, %ymm12,  %ymm3\n\
\        vpmulhw 0x080(%rdx),  %ymm8, %ymm12\n\
\        vpmulhw 0x0a0(%rdx), %ymm11, %ymm13\n\
\        vpmulhw 0x0c0(%rdx), %ymm10, %ymm14\n\
\        vpmulhw 0x0e0(%rdx),  %ymm9, %ymm15\n\
\        vpsubw        %ymm0, %ymm12,  %ymm0\n\
\        vpsubw        %ymm1, %ymm13,  %ymm1\n\
\        vpsubw        %ymm2, %ymm14,  %ymm2\n\
\        vpsubw        %ymm3, %ymm15,  %ymm3\n\
\\n\
\        vmovdqu  0x000( %r8),  %ymm12\n\
\        vmovdqu  0x040( %r8),  %ymm13\n\
\\n\
\        vpsubw        %ymm1,  %ymm0,  %ymm0\n\
\        vpsubw        %ymm2,  %ymm0,  %ymm0\n\
\        vpsubw        %ymm3,  %ymm0,  %ymm0\n\
\\n\
\        barrett_reduce 0, 0, 12, 13, 14\n\
\        vmovdqu       %ymm0, 0x080(%rsp)\n\
\\n\
\        vpmullw 0x080(%rcx),  %ymm9,  %ymm4\n\
\        vpmullw 0x0a0(%rcx),  %ymm8,  %ymm5\n\
\        vpmullw 0x0c0(%rcx), %ymm11,  %ymm6\n\
\        vpmullw 0x0e0(%rcx), %ymm10,  %ymm7\n\
\        vpmulhw       %ymm4, %ymm12,  %ymm4\n\
\        vpmulhw       %ymm5, %ymm12,  %ymm5\n\
\        vpmulhw       %ymm6, %ymm12,  %ymm6\n\
\        vpmulhw       %ymm7, %ymm12,  %ymm7\n\
\        vpmulhw 0x080(%rdx),  %ymm9, %ymm12\n\
\        vpmulhw 0x0a0(%rdx),  %ymm8, %ymm13\n\
\        vpmulhw 0x0c0(%rdx), %ymm11, %ymm14\n\
\        vpmulhw 0x0e0(%rdx), %ymm10, %ymm15\n\
\        vpsubw        %ymm4, %ymm12,  %ymm4\n\
\        vpsubw        %ymm5, %ymm13,  %ymm5\n\
\        vpsubw        %ymm6, %ymm14,  %ymm6\n\
\        vpsubw        %ymm7, %ymm15,  %ymm7\n\
\\n\
\        vmovdqu  0x000( %r8),  %ymm12\n\
\        vmovdqu  0x040( %r8),  %ymm13\n\
\\n\
\        vpaddw        %ymm5,  %ymm4,  %ymm4\n\
\        vpsubw        %ymm6,  %ymm4,  %ymm4\n\
\        vpsubw        %ymm7,  %ymm4,  %ymm4\n\
\\n\
\        barrett_reduce 4, 4, 12, 13, 14\n\
\        vmovdqu       %ymm4, 0x0a0(%rsp)\n\
\\n\
\        vpmullw 0x080(%rcx), %ymm10,  %ymm0\n\
\        vpmullw 0x0a0(%rcx),  %ymm9,  %ymm1\n\
\        vpmullw 0x0c0(%rcx),  %ymm8,  %ymm2\n\
\        vpmullw 0x0e0(%rcx), %ymm11,  %ymm3\n\
\        vpmulhw       %ymm0, %ymm12,  %ymm0\n\
\        vpmulhw       %ymm1, %ymm12,  %ymm1\n\
\        vpmulhw       %ymm2, %ymm12,  %ymm2\n\
\        vpmulhw       %ymm3, %ymm12,  %ymm3\n\
\        vpmulhw 0x080(%rdx), %ymm10, %ymm12\n\
\        vpmulhw 0x0a0(%rdx),  %ymm9, %ymm13\n\
\        vpmulhw 0x0c0(%rdx),  %ymm8, %ymm14\n\
\        vpmulhw 0x0e0(%rdx), %ymm11, %ymm15\n\
\        vpsubw        %ymm0, %ymm12,  %ymm0\n\
\        vpsubw        %ymm1, %ymm13,  %ymm1\n\
\        vpsubw        %ymm2, %ymm14,  %ymm2\n\
\        vpsubw        %ymm3, %ymm15,  %ymm3\n\
\\n\
\        vmovdqu  0x000( %r8),  %ymm12\n\
\        vmovdqu  0x040( %r8),  %ymm13\n\
\\n\
\        vpaddw        %ymm1,  %ymm0,  %ymm0\n\
\        vpaddw        %ymm2,  %ymm0,  %ymm0\n\
\        vpsubw        %ymm3,  %ymm0,  %ymm0\n\
\\n\
\        barrett_reduce 0, 0, 12, 13, 14\n\
\        vmovdqu       %ymm0, 0x0c0(%rsp)\n\
\\n\
\        vpmullw 0x080(%rcx), %ymm11,  %ymm4\n\
\        vpmullw 0x0a0(%rcx), %ymm10,  %ymm5\n\
\        vpmullw 0x0c0(%rcx),  %ymm9,  %ymm6\n\
\        vpmullw 0x0e0(%rcx),  %ymm8,  %ymm7\n\
\        vpmulhw       %ymm4, %ymm12,  %ymm4\n\
\        vpmulhw       %ymm5, %ymm12,  %ymm5\n\
\        vpmulhw       %ymm6, %ymm12,  %ymm6\n\
\        vpmulhw       %ymm7, %ymm12,  %ymm7\n\
\        vpmulhw 0x080(%rdx), %ymm11, %ymm12\n\
\        vpmulhw 0x0a0(%rdx), %ymm10, %ymm13\n\
\        vpmulhw 0x0c0(%rdx),  %ymm9, %ymm14\n\
\        vpmulhw 0x0e0(%rdx),  %ymm8, %ymm15\n\
\        vpsubw        %ymm4, %ymm12,  %ymm4\n\
\        vpsubw        %ymm5, %ymm13,  %ymm5\n\
\        vpsubw        %ymm6, %ymm14,  %ymm6\n\
\        vpsubw        %ymm7, %ymm15,  %ymm7\n\
\\n\
\        vmovdqu  0x000( %r8),  %ymm12\n\
\        vmovdqu  0x040( %r8),  %ymm13\n\
\\n\
\        vpaddw        %ymm5,  %ymm4,  %ymm4\n\
\        vpaddw        %ymm6,  %ymm4,  %ymm4\n\
\        vpaddw        %ymm7,  %ymm4,  %ymm4\n\
\\n\
\        barrett_reduce 4, 4, 12, 13, 14\n\
\        vmovdqu       %ymm4, 0x0e0(%rsp)\n\
\\n\
\// ================================\n\
\// x^8 + 1\n\
\\n\
\        __asm_negacyclic_karatsuba8_precompute_core \\\n\
\                %rsp, %rsp, %rdx, %rcx, %rsp, 0x200, 0x100, 0x100, 0x100, 0x300, \\\n\
\                0x000( %r8), 0x020( %r8), 0x040( %r8)\n\
\\n\
\        vmovdqu 0x000(%rsp),  %ymm0\n\
\        vmovdqu 0x020(%rsp),  %ymm1\n\
\        vmovdqu 0x040(%rsp),  %ymm2\n\
\        vmovdqu 0x060(%rsp),  %ymm3\n\
\\n\
\        vpsubw  0x080(%rsp),  %ymm0,  %ymm4\n\
\        vpaddw  0x080(%rsp),  %ymm0,  %ymm0\n\
\        vpsubw  0x0a0(%rsp),  %ymm1,  %ymm5\n\
\        vpaddw  0x0a0(%rsp),  %ymm1,  %ymm1\n\
\        vpsubw  0x0c0(%rsp),  %ymm2,  %ymm6\n\
\        vpaddw  0x0c0(%rsp),  %ymm2,  %ymm2\n\
\        vpsubw  0x0e0(%rsp),  %ymm3,  %ymm7\n\
\        vpaddw  0x0e0(%rsp),  %ymm3,  %ymm3\n\
\\n\
\        vpsubw  0x200(%rsp),  %ymm0,  %ymm8\n\
\        vpaddw  0x200(%rsp),  %ymm0,  %ymm0\n\
\        vpsubw  0x220(%rsp),  %ymm1,  %ymm9\n\
\        vpaddw  0x220(%rsp),  %ymm1,  %ymm1\n\
\        vpsubw  0x240(%rsp),  %ymm2, %ymm10\n\
\        vpaddw  0x240(%rsp),  %ymm2,  %ymm2\n\
\        vpsubw  0x260(%rsp),  %ymm3, %ymm11\n\
\        vpaddw  0x260(%rsp),  %ymm3,  %ymm3\n\
\        vpsubw  0x280(%rsp),  %ymm4, %ymm12\n\
\        vpaddw  0x280(%rsp),  %ymm4,  %ymm4\n\
\        vpsubw  0x2a0(%rsp),  %ymm5, %ymm13\n\
\        vpaddw  0x2a0(%rsp),  %ymm5,  %ymm5\n\
\        vpsubw  0x2c0(%rsp),  %ymm6, %ymm14\n\
\        vpaddw  0x2c0(%rsp),  %ymm6,  %ymm6\n\
\        vpsubw  0x2e0(%rsp),  %ymm7, %ymm15\n\
\        vpaddw  0x2e0(%rsp),  %ymm7,  %ymm7\n\
\\n\
\\n"


store_f_string = "\
\\n\
\        vmovdqu       %ymm0, " ++ store_map  0 ++ "\n\
\        vmovdqu       %ymm1, " ++ store_map  1 ++ "\n\
\        vmovdqu       %ymm2, " ++ store_map  2 ++ "\n\
\        vmovdqu       %ymm3, " ++ store_map  3 ++ "\n\
\        vmovdqu       %ymm4, " ++ store_map  4 ++ "\n\
\        vmovdqu       %ymm5, " ++ store_map  5 ++ "\n\
\        vmovdqu       %ymm6, " ++ store_map  6 ++ "\n\
\        vmovdqu       %ymm7, " ++ store_map  7 ++ "\n\
\        vmovdqu       %ymm8, " ++ store_map  8 ++ "\n\
\        vmovdqu       %ymm9, " ++ store_map  9 ++ "\n\
\        vmovdqu      %ymm10, " ++ store_map 10 ++ "\n\
\        vmovdqu      %ymm11, " ++ store_map 11 ++ "\n\
\        vmovdqu      %ymm12, " ++ store_map 12 ++ "\n\
\        vmovdqu      %ymm13, " ++ store_map 13 ++ "\n\
\        vmovdqu      %ymm14, " ++ store_map 14 ++ "\n\
\        vmovdqu      %ymm15, " ++ store_map 15 ++ "\n\
\\n\
\\n"

tail_f_string = "\
\\n\
\        vzeroupper\n\
\        leave\n\
\        ret\n\
\\n\
\\n"

get_f_string = head_f_string ++ load_f_string ++ body_f_string ++ store_f_string ++ tail_f_string




