#ifndef PERMUTE_INC
#define PERMUTE_INC

.macro __asm_interleave cl, ch, al, ah

        vpunpcklwd %ymm\ah, %ymm\al, %ymm\cl
        vpunpckhwd %ymm\ah, %ymm\al, %ymm\ch

.endm

.macro __asm_deinterleave al, ah, cl, ch, tl, th, _zero

        vpblendw   $0xaa, %ymm\_zero, %ymm\cl, %ymm\tl
        vpblendw   $0xaa, %ymm\_zero, %ymm\ch, %ymm\th

        vpackusdw  %ymm\th, %ymm\tl, %ymm\al

        vpsrld     $16, %ymm\cl, %ymm\cl
        vpsrld     $16, %ymm\ch, %ymm\ch

        vpackusdw  %ymm\ch, %ymm\cl, %ymm\ah

.endm

#endif

