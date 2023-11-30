

.macro butterfly3 a0, a1, a2, wlo, whi, mod, t0, t1, t2, t3

    sub      \t0\().8H, \a1\().8H, \a2\().8H
    mul      \t3\().8H, \t0\().8H, \wlo
    sqrdmulh \t2\().8H, \t0\().8H, \whi
    mls      \t3\().8H, \t2\().8H, \mod
    sub      \t1\().8H, \a0\().8H, \a2\().8H
    sub      \t2\().8H, \a0\().8H, \a1\().8H
    add      \a0\().8H, \a0\().8H, \a1\().8H
    add      \a0\().8H, \a0\().8H, \a2\().8H
    add      \a1\().8H, \t1\().8H, \t3\().8H
    sub      \a2\().8H, \t2\().8H, \t3\().8H

.endm

.macro barrett_reduce a, barrett_factor mod, t

    sqdmulh \t\().8H, \a\().8H, \barrett_factor
    srshr   \t\().8H, \t\().8H, #12
    mls     \a\().8H, \t\().8H, \mod

.endm

.macro radix32_core a0, a1, a2, a3, a4, a5, ra0, ra1, ra2, ra3, ra4, ra5, mem0, mem1, mem2, mem3, mem4, mem5, t0, t1, t2, rt0, rt1, rt2, t3, t4, t5, t6

    ldr \ra0, [x0, \mem0]
    ldr \ra1, [x0, \mem1]
    ldr \ra2, [x0, \mem2]
    ldr \ra3, [x0, \mem3]
    ldr \ra4, [x0, \mem4]
    ldr \ra5, [x0, \mem5]

    sqdmulh \t0\().8H, \a0\().8H, v0.H[4]
    sqdmulh \t1\().8H, \a1\().8H, v0.H[4]
    sqdmulh \t2\().8H, \a2\().8H, v0.H[4]
    sqdmulh \t4\().8H, \a3\().8H, v0.H[4]
    sqdmulh \t5\().8H, \a4\().8H, v0.H[4]
    sqdmulh \t6\().8H, \a5\().8H, v0.H[4]

    srshr   \t0\().8H, \t0\().8H, #12
    srshr   \t1\().8H, \t1\().8H, #12
    srshr   \t2\().8H, \t2\().8H, #12
    srshr   \t4\().8H, \t4\().8H, #12
    srshr   \t5\().8H, \t5\().8H, #12
    srshr   \t6\().8H, \t6\().8H, #12

    mls     \a0\().8H, \t0\().8H, v0.H[0]
    mls     \a1\().8H, \t1\().8H, v0.H[0]
    mls     \a2\().8H, \t2\().8H, v0.H[0]
    mls     \a3\().8H, \t4\().8H, v0.H[0]
    mls     \a4\().8H, \t5\().8H, v0.H[0]
    mls     \a5\().8H, \t6\().8H, v0.H[0]

    sub      \t3\().8H, \a1\().8H, \a2\().8H
    mul      \t6\().8H, \t3\().8H, v0.H[2]
    sqrdmulh \t5\().8H, \t3\().8H, v0.H[3]
    mls      \t6\().8H, \t5\().8H, v0.H[0]
    sub      \t4\().8H, \a0\().8H, \a2\().8H
    sub      \t5\().8H, \a0\().8H, \a1\().8H
    add      \a0\().8H, \a0\().8H, \a1\().8H
    add      \a0\().8H, \a0\().8H, \a2\().8H
    add      \a1\().8H, \t4\().8H, \t6\().8H
    sub      \a2\().8H, \t5\().8H, \t6\().8H

    sub      \t3\().8H, \a4\().8H, \a5\().8H
    mul      \t6\().8H, \t3\().8H, v0.H[2]
    sqrdmulh \t5\().8H, \t3\().8H, v0.H[3]
    mls      \t6\().8H, \t5\().8H, v0.H[0]
    sub      \t4\().8H, \a3\().8H, \a5\().8H
    sub      \t5\().8H, \a3\().8H, \a4\().8H
    add      \a3\().8H, \a3\().8H, \a4\().8H
    add      \a3\().8H, \a3\().8H, \a5\().8H
    add      \a4\().8H, \t4\().8H, \t6\().8H
    sub      \a5\().8H, \t5\().8H, \t6\().8H

    add \t0\().8H, \a0\().8H, \a3\().8H
    sub \a3\().8H, \a0\().8H, \a3\().8H

    sqdmulh \t3\().8H, \t0\().8H, v0.H[4]
    add  \t1\().8H, \a1\().8H, \a4\().8H
    sqdmulh \t4\().8H, \a3\().8H, v0.H[4]
    sub  \a4\().8H, \a1\().8H, \a4\().8H

    srshr   \t3\().8H, \t3\().8H, #12
    sqdmulh \t5\().8H, \t1\().8H, v0.H[4]
    srshr   \t4\().8H, \t4\().8H, #12
    sqdmulh \t6\().8H, \a4\().8H, v0.H[4]

    mls     \t0\().8H, \t3\().8H, v0.H[0]
    add  \t2\().8H, \a2\().8H, \a5\().8H
    str \rt0, [x0, \mem0]
    mls     \a3\().8H, \t4\().8H, v0.H[0]
    sub  \a5\().8H, \a2\().8H, \a5\().8H
    str \ra3, [x0, \mem3]

    srshr   \t5\().8H, \t5\().8H, #12
    sqdmulh \t3\().8H, \t2\().8H, v0.H[4]
    srshr   \t6\().8H, \t6\().8H, #12
    sqdmulh \t4\().8H, \a5\().8H, v0.H[4]

    mls     \t1\().8H, \t5\().8H, v0.H[0]
    srshr   \t3\().8H, \t3\().8H, #12
    str \rt1, [x0, \mem1]
    mls     \a4\().8H, \t6\().8H, v0.H[0]
    srshr   \t4\().8H, \t4\().8H, #12
    str \ra4, [x0, \mem4]

    mls     \t2\().8H, \t3\().8H, v0.H[0]
    mls     \a5\().8H, \t4\().8H, v0.H[0]

    str \rt2, [x0, \mem2]
    str \ra5, [x0, \mem5]

.endm

.macro radix32_top a6, a7, a8, a9, a10, a11, ra6, ra7, ra8, ra9, ra10, ra11, \
                   mem6, mem7, mem8, mem9, mem10, mem11, \
                   t7, t8, t9, rt7, rt8, rt9, t10, t11, t12, t13

    ldr \ra6, [x0, \mem6]
    ldr \ra7, [x0, \mem7]
    ldr \ra8, [x0, \mem8]
    ldr \ra9, [x0, \mem9]
    ldr \ra10, [x0, \mem10]
    ldr \ra11, [x0, \mem11]

    sqdmulh \t7\().8H, \a6\().8H, v0.H[4]
    sqdmulh \t8\().8H, \a7\().8H, v0.H[4]
    sqdmulh \t9\().8H, \a8\().8H, v0.H[4]
    sqdmulh \t11\().8H, \a9\().8H, v0.H[4]
    sqdmulh \t12\().8H, \a10\().8H, v0.H[4]
    sqdmulh \t13\().8H, \a11\().8H, v0.H[4]

    srshr   \t7\().8H, \t7\().8H, #12
    srshr   \t8\().8H, \t8\().8H, #12
    srshr   \t9\().8H, \t9\().8H, #12
    srshr   \t11\().8H, \t11\().8H, #12
    srshr   \t12\().8H, \t12\().8H, #12
    srshr   \t13\().8H, \t13\().8H, #12

    mls     \a6\().8H, \t7\().8H, v0.H[0]
    mls     \a7\().8H, \t8\().8H, v0.H[0]
    mls     \a8\().8H, \t9\().8H, v0.H[0]
    mls     \a9\().8H, \t11\().8H, v0.H[0]
    mls     \a10\().8H, \t12\().8H, v0.H[0]
    mls     \a11\().8H, \t13\().8H, v0.H[0]

.endm

.macro radix32_bot a0, a1, a2, a3, a4, a5, ra0, ra1, ra2, ra3, ra4, ra5, \
                   mem0, mem1, mem2, mem3, mem4, mem5, \
                   t0, t1, t2, rt0, rt1, rt2, t3, t4, t5, t6

    sub      \t3\().8H, \a1\().8H, \a2\().8H
    mul      \t6\().8H, \t3\().8H, v0.H[2]
    sqrdmulh \t5\().8H, \t3\().8H, v0.H[3]
    mls      \t6\().8H, \t5\().8H, v0.H[0]
    sub      \t4\().8H, \a0\().8H, \a2\().8H
    sub      \t5\().8H, \a0\().8H, \a1\().8H
    add      \a0\().8H, \a0\().8H, \a1\().8H
    add      \a0\().8H, \a0\().8H, \a2\().8H
    add      \a1\().8H, \t4\().8H, \t6\().8H
    sub      \a2\().8H, \t5\().8H, \t6\().8H

    sub      \t3\().8H, \a4\().8H, \a5\().8H
    mul      \t6\().8H, \t3\().8H, v0.H[2]
    sqrdmulh \t5\().8H, \t3\().8H, v0.H[3]
    mls      \t6\().8H, \t5\().8H, v0.H[0]
    sub      \t4\().8H, \a3\().8H, \a5\().8H
    sub      \t5\().8H, \a3\().8H, \a4\().8H
    add      \a3\().8H, \a3\().8H, \a4\().8H
    add      \a3\().8H, \a3\().8H, \a5\().8H
    add      \a4\().8H, \t4\().8H, \t6\().8H
    sub      \a5\().8H, \t5\().8H, \t6\().8H

    add \t0\().8H, \a0\().8H, \a3\().8H
    sub \a3\().8H, \a0\().8H, \a3\().8H

    sqdmulh \t3\().8H, \t0\().8H, v0.H[4]
    add  \t1\().8H, \a1\().8H, \a4\().8H
    sqdmulh \t4\().8H, \a3\().8H, v0.H[4]
    sub  \a4\().8H, \a1\().8H, \a4\().8H

    srshr   \t3\().8H, \t3\().8H, #12
    sqdmulh \t5\().8H, \t1\().8H, v0.H[4]
    srshr   \t4\().8H, \t4\().8H, #12
    sqdmulh \t6\().8H, \a4\().8H, v0.H[4]

    mls     \t0\().8H, \t3\().8H, v0.H[0]
    add  \t2\().8H, \a2\().8H, \a5\().8H
    str \rt0, [x0, \mem0]
    mls     \a3\().8H, \t4\().8H, v0.H[0]
    sub  \a5\().8H, \a2\().8H, \a5\().8H
    str \ra3, [x0, \mem3]

    srshr   \t5\().8H, \t5\().8H, #12
    sqdmulh \t3\().8H, \t2\().8H, v0.H[4]
    srshr   \t6\().8H, \t6\().8H, #12
    sqdmulh \t4\().8H, \a5\().8H, v0.H[4]

    mls     \t1\().8H, \t5\().8H, v0.H[0]
    srshr   \t3\().8H, \t3\().8H, #12
    str \rt1, [x0, \mem1]
    mls     \a4\().8H, \t6\().8H, v0.H[0]
    srshr   \t4\().8H, \t4\().8H, #12
    str \ra4, [x0, \mem4]

    mls     \t2\().8H, \t3\().8H, v0.H[0]
    mls     \a5\().8H, \t4\().8H, v0.H[0]

    str \rt2, [x0, \mem2]
    str \ra5, [x0, \mem5]

.endm

.macro radix32_mix a0, a1, a2, a3, a4, a5, ra0, ra1, ra2, ra3, ra4, ra5, \
                   mem0, mem1, mem2, mem3, mem4, mem5, \
                   t0, t1, t2, rt0, rt1, rt2, t3, t4, t5, t6, \
                   a6, a7, a8, a9, a10, a11, ra6, ra7, ra8, ra9, ra10, ra11, \
                   mem6, mem7, mem8, mem9, mem10, mem11, \
                   t7, t8, t9, rt7, rt8, rt9, t10, t11, t12, t13

    ldr \ra6, [x0, \mem6]
    sub      \t3\().8H, \a1\().8H, \a2\().8H
    ldr \ra7, [x0, \mem7]
    mul      \t6\().8H, \t3\().8H, v0.H[2]
    ldr \ra8, [x0, \mem8]
    sqrdmulh \t5\().8H, \t3\().8H, v0.H[3]
    ldr \ra9, [x0, \mem9]
    mls      \t6\().8H, \t5\().8H, v0.H[0]
    ldr \ra10, [x0, \mem10]
    sqdmulh \t7\().8H, \a6\().8H, v0.H[4]
    sub      \t4\().8H, \a0\().8H, \a2\().8H
    ldr \ra11, [x0, \mem11]
    sqdmulh \t8\().8H, \a7\().8H, v0.H[4]
    sub      \t5\().8H, \a0\().8H, \a1\().8H
    sqdmulh \t9\().8H, \a8\().8H, v0.H[4]
    add      \a0\().8H, \a0\().8H, \a1\().8H
    sqdmulh \t11\().8H, \a9\().8H, v0.H[4]
    add      \a0\().8H, \a0\().8H, \a2\().8H
    sqdmulh \t12\().8H, \a10\().8H, v0.H[4]
    add      \a1\().8H, \t4\().8H, \t6\().8H
    sqdmulh \t13\().8H, \a11\().8H, v0.H[4]
    sub      \a2\().8H, \t5\().8H, \t6\().8H

    sub      \t3\().8H, \a4\().8H, \a5\().8H
    mul      \t6\().8H, \t3\().8H, v0.H[2]
    srshr   \t7\().8H, \t7\().8H, #12
    sqrdmulh \t5\().8H, \t3\().8H, v0.H[3]
    srshr   \t8\().8H, \t8\().8H, #12
    mls      \t6\().8H, \t5\().8H, v0.H[0]
    srshr   \t9\().8H, \t9\().8H, #12
    sub      \t4\().8H, \a3\().8H, \a5\().8H
    mls     \a6\().8H, \t7\().8H, v0.H[0]
    sub      \t5\().8H, \a3\().8H, \a4\().8H
    mls     \a7\().8H, \t8\().8H, v0.H[0]
    add      \a3\().8H, \a3\().8H, \a4\().8H
    mls     \a8\().8H, \t9\().8H, v0.H[0]
    add      \a3\().8H, \a3\().8H, \a5\().8H
    add      \a4\().8H, \t4\().8H, \t6\().8H
    sub      \a5\().8H, \t5\().8H, \t6\().8H

    srshr   \t11\().8H, \t11\().8H, #12
    srshr   \t12\().8H, \t12\().8H, #12
    srshr   \t13\().8H, \t13\().8H, #12

    mls     \a9\().8H, \t11\().8H, v0.H[0]
    mls     \a10\().8H, \t12\().8H, v0.H[0]
    mls     \a11\().8H, \t13\().8H, v0.H[0]

    add \t0\().8H, \a0\().8H, \a3\().8H
    sub \a3\().8H, \a0\().8H, \a3\().8H

    sqdmulh \t3\().8H, \t0\().8H, v0.H[4]
    add  \t1\().8H, \a1\().8H, \a4\().8H
    sqdmulh \t4\().8H, \a3\().8H, v0.H[4]
    sub  \a4\().8H, \a1\().8H, \a4\().8H

    srshr   \t3\().8H, \t3\().8H, #12
    sqdmulh \t5\().8H, \t1\().8H, v0.H[4]
    srshr   \t4\().8H, \t4\().8H, #12
    sqdmulh \t6\().8H, \a4\().8H, v0.H[4]

    mls     \t0\().8H, \t3\().8H, v0.H[0]
    add  \t2\().8H, \a2\().8H, \a5\().8H
    str \rt0, [x0, \mem0]
    mls     \a3\().8H, \t4\().8H, v0.H[0]
    sub  \a5\().8H, \a2\().8H, \a5\().8H
    str \ra3, [x0, \mem3]

    srshr   \t5\().8H, \t5\().8H, #12
    sqdmulh \t3\().8H, \t2\().8H, v0.H[4]
    srshr   \t6\().8H, \t6\().8H, #12
    sqdmulh \t4\().8H, \a5\().8H, v0.H[4]

    mls     \t1\().8H, \t5\().8H, v0.H[0]
    srshr   \t3\().8H, \t3\().8H, #12
    str \rt1, [x0, \mem1]
    mls     \a4\().8H, \t6\().8H, v0.H[0]
    srshr   \t4\().8H, \t4\().8H, #12
    str \ra4, [x0, \mem4]

    mls     \t2\().8H, \t3\().8H, v0.H[0]
    mls     \a5\().8H, \t4\().8H, v0.H[0]

    str \rt2, [x0, \mem2]
    str \ra5, [x0, \mem5]

.endm


.align 6
.global __asm_radix32
.global ___asm_radix32
__asm_radix32:
___asm_radix32:

    sub sp, sp, #(4*16)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr q0, [x1]

.rept 4

    radix32_top v16, v20, v24, v18, v22, v26, q16, q20, q24, q18, q22, q26, #(0*12+0)*16, #(0*12+4)*16, #(0*12+8)*16, #(0*12+2)*16, #(0*12+6)*16, #(0*12+10)*16, v4, v6, v8, q4, q6, q8, v28, v29, v30, v31

    radix32_mix v16, v20, v24, v18, v22, v26, q16, q20, q24, q18, q22, q26, \
                #(0*12+0)*16, #(0*12+4)*16, #(0*12+8)*16, #(0*12+2)*16, #(0*12+6)*16, #(0*12+10)*16, \
                v4, v6, v8, q4, q6, q8, v28, v29, v30, v31, \
                v17, v21, v25, v19, v23, v27, q17, q21, q25, q19, q23, q27, \
                #(0*12+1)*16, #(0*12+5)*16, #(0*12+9)*16, #(0*12+3)*16, #(0*12+7)*16, #(0*12+11)*16, \
                v5, v7, v9, q5, q7, q9, v12, v13, v14, v15

    radix32_mix v17, v21, v25, v19, v23, v27, q17, q21, q25, q19, q23, q27, \
                #(0*12+1)*16, #(0*12+5)*16, #(0*12+9)*16, #(0*12+3)*16, #(0*12+7)*16, #(0*12+11)*16, \
                v5, v7, v9, q5, q7, q9, v12, v13, v14, v15, \
                v16, v20, v24, v18, v22, v26, q16, q20, q24, q18, q22, q26, \
                #(1*12+0)*16, #(1*12+4)*16, #(1*12+8)*16, #(1*12+2)*16, #(1*12+6)*16, #(1*12+10)*16, \
                v4, v6, v8, q4, q6, q8, v28, v29, v30, v31

    radix32_mix v16, v20, v24, v18, v22, v26, q16, q20, q24, q18, q22, q26, \
                #(1*12+0)*16, #(1*12+4)*16, #(1*12+8)*16, #(1*12+2)*16, #(1*12+6)*16, #(1*12+10)*16, \
                v4, v6, v8, q4, q6, q8, v28, v29, v30, v31, \
                v17, v21, v25, v19, v23, v27, q17, q21, q25, q19, q23, q27, \
                #(1*12+1)*16, #(1*12+5)*16, #(1*12+9)*16, #(1*12+3)*16, #(1*12+7)*16, #(1*12+11)*16, \
                v5, v7, v9, q5, q7, q9, v12, v13, v14, v15

    radix32_mix v17, v21, v25, v19, v23, v27, q17, q21, q25, q19, q23, q27, \
                #(1*12+1)*16, #(1*12+5)*16, #(1*12+9)*16, #(1*12+3)*16, #(1*12+7)*16, #(1*12+11)*16, \
                v5, v7, v9, q5, q7, q9, v12, v13, v14, v15, \
                v16, v20, v24, v18, v22, v26, q16, q20, q24, q18, q22, q26, \
                #(2*12+0)*16, #(2*12+4)*16, #(2*12+8)*16, #(2*12+2)*16, #(2*12+6)*16, #(2*12+10)*16, \
                v4, v6, v8, q4, q6, q8, v28, v29, v30, v31

    radix32_mix v16, v20, v24, v18, v22, v26, q16, q20, q24, q18, q22, q26, \
                #(2*12+0)*16, #(2*12+4)*16, #(2*12+8)*16, #(2*12+2)*16, #(2*12+6)*16, #(2*12+10)*16, \
                v4, v6, v8, q4, q6, q8, v28, v29, v30, v31, \
                v17, v21, v25, v19, v23, v27, q17, q21, q25, q19, q23, q27, \
                #(2*12+1)*16, #(2*12+5)*16, #(2*12+9)*16, #(2*12+3)*16, #(2*12+7)*16, #(2*12+11)*16, \
                v5, v7, v9, q5, q7, q9, v12, v13, v14, v15

    radix32_mix v17, v21, v25, v19, v23, v27, q17, q21, q25, q19, q23, q27, \
                #(2*12+1)*16, #(2*12+5)*16, #(2*12+9)*16, #(2*12+3)*16, #(2*12+7)*16, #(2*12+11)*16, \
                v5, v7, v9, q5, q7, q9, v12, v13, v14, v15, \
                v16, v20, v24, v18, v22, v26, q16, q20, q24, q18, q22, q26, \
                #(3*12+0)*16, #(3*12+4)*16, #(3*12+8)*16, #(3*12+2)*16, #(3*12+6)*16, #(3*12+10)*16, \
                v4, v6, v8, q4, q6, q8, v28, v29, v30, v31

    radix32_mix v16, v20, v24, v18, v22, v26, q16, q20, q24, q18, q22, q26, \
                #(3*12+0)*16, #(3*12+4)*16, #(3*12+8)*16, #(3*12+2)*16, #(3*12+6)*16, #(3*12+10)*16, \
                v4, v6, v8, q4, q6, q8, v28, v29, v30, v31, \
                v17, v21, v25, v19, v23, v27, q17, q21, q25, q19, q23, q27, \
                #(3*12+1)*16, #(3*12+5)*16, #(3*12+9)*16, #(3*12+3)*16, #(3*12+7)*16, #(3*12+11)*16, \
                v5, v7, v9, q5, q7, q9, v12, v13, v14, v15

    radix32_bot v17, v21, v25, v19, v23, v27, q17, q21, q25, q19, q23, q27, \
                #(3*12+1)*16, #(3*12+5)*16, #(3*12+9)*16, #(3*12+3)*16, #(3*12+7)*16, #(3*12+11)*16, \
                v5, v7, v9, q5, q7, q9, v12, v13, v14, v15

    add x0, x0, #4*192

.endr

.rept 1

    radix32_core v16, v20, v24, v18, v22, v26, q16, q20, q24, q18, q22, q26, #(0*12+0)*16, #(0*12+4)*16, #(0*12+8)*16, #(0*12+2)*16, #(0*12+6)*16, #(0*12+10)*16, v4, v6, v8, q4, q6, q8, v28, v29, v30, v31

    radix32_core v17, v21, v25, v19, v23, v27, q17, q21, q25, q19, q23, q27, #(0*12+1)*16, #(0*12+5)*16, #(0*12+9)*16, #(0*12+3)*16, #(0*12+7)*16, #(0*12+11)*16, v5, v7, v9, q5, q7, q9, v12, v13, v14, v15

    add x0, x0, #192

.endr

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(4*16)

    br lr







