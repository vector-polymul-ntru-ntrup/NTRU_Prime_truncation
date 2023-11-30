
.macro trn2x2 t0, t1, a0, a1

    trn1 \t0\().2D, \a0\().2D, \a1\().2D
    trn2 \t1\().2D, \a0\().2D, \a1\().2D

.endm

.macro trn4x4 a0, a1, a2, a3, t0, t1, t2, t3

    trn2x2 \t0, \t2, \a0, \a2
    trn2x2 \t1, \t3, \a1, \a3

    trn1 \a0\().4S, \t0\().4S, \t1\().4S
    trn2 \a1\().4S, \t0\().4S, \t1\().4S
    trn1 \a2\().4S, \t2\().4S, \t3\().4S
    trn2 \a3\().4S, \t2\().4S, \t3\().4S

.endm

.macro trn8x8 t0, t1, t2, t3, t4, t5, t6, t7, a0, a1, a2, a3, a4, a5, a6, a7

    trn4x4 \a0, \a2, \a4, \a6, \t0, \t2, \t4, \t6
    trn4x4 \a1, \a3, \a5, \a7, \t1, \t3, \t5, \t7

    trn1 \t0\().8H, \a0\().8H, \a1\().8H
    trn2 \t1\().8H, \a0\().8H, \a1\().8H
    trn1 \t2\().8H, \a2\().8H, \a3\().8H
    trn2 \t3\().8H, \a2\().8H, \a3\().8H
    trn1 \t4\().8H, \a4\().8H, \a5\().8H
    trn2 \t5\().8H, \a4\().8H, \a5\().8H
    trn1 \t6\().8H, \a6\().8H, \a7\().8H
    trn2 \t7\().8H, \a6\().8H, \a7\().8H

.endm

// distance between coefficients:
// 192 bytes / 96 coefficients for 16-bit
.align 6
.global __asm_transpose_CT
.global ___asm_transpose_CT
__asm_transpose_CT:
___asm_transpose_CT:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    mov v2.H[0], w3

    mov x9, #2
    __asm_CT_loop:

    ldp q0, q1, [x2]
    add x2, x2, #2*16

    ldr q24, [x1, #(0*192+16)]
    ldr q28, [x1, #(4*192+16)]
    ldr q25, [x1, #(1*192+16)]
    ldr q29, [x1, #(5*192+16)]
    ldr q26, [x1, #(2*192+16)]
    ldr q30, [x1, #(6*192+16)]
    ldr q27, [x1, #(3*192+16)]
    ldr q31, [x1, #(7*192+16)]

    trn1   v8.2D, v24.2D, v28.2D
    trn2  v12.2D, v24.2D, v28.2D
    ldr q16, [x1, #0*192]
    trn1   v9.2D, v25.2D, v29.2D
    trn2  v13.2D, v25.2D, v29.2D
    ldr q20, [x1, #4*192]
    trn1  v10.2D, v26.2D, v30.2D
    trn2  v14.2D, v26.2D, v30.2D
    ldr q17, [x1, #1*192]
    trn1  v11.2D, v27.2D, v31.2D
    trn2  v15.2D, v27.2D, v31.2D
    ldr q21, [x1, #5*192]

    trn1  v24.4S,  v8.4S, v10.4S
    trn2  v26.4S,  v8.4S, v10.4S
    ldr q18, [x1, #2*192]
    trn1  v25.4S,  v9.4S, v11.4S
    trn2  v27.4S,  v9.4S, v11.4S
    ldr q22, [x1, #6*192]
    trn1  v28.4S, v12.4S, v14.4S
    trn2  v30.4S, v12.4S, v14.4S
    ldr q19, [x1, #3*192]
    trn1  v29.4S, v13.4S, v15.4S
    trn2  v31.4S, v13.4S, v15.4S
    ldr q23, [x1, #7*192]
    add x1, x1, #32*2

    trn1   v8.8H, v24.8H, v25.8H
    trn2   v9.8H, v24.8H, v25.8H
    trn1  v10.8H, v26.8H, v27.8H
    trn2  v11.8H, v26.8H, v27.8H
    trn1  v12.8H, v28.8H, v29.8H
    trn2  v13.8H, v28.8H, v29.8H
    trn1  v14.8H, v30.8H, v31.8H
    trn2  v15.8H, v30.8H, v31.8H


    sqrdmulh  v4.8H,  v8.8H,  v1.8H
    trn1  v24.2D, v16.2D, v20.2D
    sqrdmulh  v5.8H,  v9.8H,  v1.8H
    trn2  v28.2D, v16.2D, v20.2D
    sqrdmulh  v6.8H, v10.8H,  v1.8H
    trn1  v25.2D, v17.2D, v21.2D
    sqrdmulh  v7.8H, v11.8H,  v1.8H
    trn2  v29.2D, v17.2D, v21.2D
    mul       v8.8H,  v8.8H,  v0.8H
    trn1  v26.2D, v18.2D, v22.2D
    mul       v9.8H,  v9.8H,  v0.8H
    trn2  v30.2D, v18.2D, v22.2D
    mul      v10.8H, v10.8H,  v0.8H
    trn1  v27.2D, v19.2D, v23.2D
    mul      v11.8H, v11.8H,  v0.8H
    trn2  v31.2D, v19.2D, v23.2D

    mls       v8.8H,  v4.8H,  v2.H[0]
    trn1  v16.4S, v24.4S, v26.4S
    mls       v9.8H,  v5.8H,  v2.H[0]
    trn2  v18.4S, v24.4S, v26.4S
    mls      v10.8H,  v6.8H,  v2.H[0]
    trn1  v17.4S, v25.4S, v27.4S
    mls      v11.8H,  v7.8H,  v2.H[0]
    trn2  v19.4S, v25.4S, v27.4S
    sqrdmulh  v4.8H, v12.8H,  v1.8H
    trn1  v20.4S, v28.4S, v30.4S
    sqrdmulh  v5.8H, v13.8H,  v1.8H
    trn2  v22.4S, v28.4S, v30.4S
    sqrdmulh  v6.8H, v14.8H,  v1.8H
    trn1  v21.4S, v29.4S, v31.4S
    sqrdmulh  v7.8H, v15.8H,  v1.8H
    trn2  v23.4S, v29.4S, v31.4S

    mul      v12.8H, v12.8H,  v0.8H
    trn1  v24.8H, v16.8H, v17.8H
    mul      v13.8H, v13.8H,  v0.8H
    trn2  v25.8H, v16.8H, v17.8H
    mul      v14.8H, v14.8H,  v0.8H
    trn1  v26.8H, v18.8H, v19.8H
    mul      v15.8H, v15.8H,  v0.8H
    trn2  v27.8H, v18.8H, v19.8H
    mls      v12.8H,  v4.8H,  v2.H[0]
    trn1  v28.8H, v20.8H, v21.8H
    mls      v13.8H,  v5.8H,  v2.H[0]
    trn2  v29.8H, v20.8H, v21.8H
    mls      v14.8H,  v6.8H,  v2.H[0]
    trn1  v30.8H, v22.8H, v23.8H
    mls      v15.8H,  v7.8H,  v2.H[0]
    trn2  v31.8H, v22.8H, v23.8H

    ldp q0, q1, [x2]
    add x2, x2, #2*16
    sub       v5.8H, v24.8H,  v8.8H
    add       v8.8H, v24.8H,  v8.8H
    ldr q24, [x1, #(0*192+16)]
    sub       v7.8H, v25.8H,  v9.8H
    add       v9.8H, v25.8H,  v9.8H
    ldr q25, [x1, #(1*192+16)]

    str  q8, [x0, #0*16]
    sub      v18.8H, v26.8H, v10.8H
    add      v10.8H, v26.8H, v10.8H
    ldr q26, [x1, #(2*192+16)]
    str  q5, [x0, #8*16]
    sub      v19.8H, v27.8H, v11.8H
    add      v11.8H, v27.8H, v11.8H
    ldr q27, [x1, #(3*192+16)]
    str  q9, [x0, #1*16]
    sub      v20.8H, v28.8H, v12.8H
    add      v12.8H, v28.8H, v12.8H
    ldr q28, [x1, #(4*192+16)]
    str  q7, [x0, #9*16]
    sub      v21.8H, v29.8H, v13.8H
    add      v13.8H, v29.8H, v13.8H
    ldr q29, [x1, #(5*192+16)]
    str q10, [x0, #2*16]
    sub      v22.8H, v30.8H, v14.8H
    add      v14.8H, v30.8H, v14.8H
    ldr q30, [x1, #(6*192+16)]
    str q18, [x0, #10*16]
    sub      v23.8H, v31.8H, v15.8H
    add      v15.8H, v31.8H, v15.8H
    ldr q31, [x1, #(7*192+16)]

    str q11, [x0, #3*16]
    str q21, [x0, #13*16]
    str q20, [x0, #12*16]

    str q12, [x0, #4*16]
    trn1   v8.2D, v24.2D, v28.2D
    ldr q16, [x1, #0*192]
    trn2  v12.2D, v24.2D, v28.2D
    str q13, [x0, #5*16]
    trn1   v9.2D, v25.2D, v29.2D
    ldr q20, [x1, #4*192]
    trn2  v13.2D, v25.2D, v29.2D
    str q14, [x0, #6*16]
    trn1  v10.2D, v26.2D, v30.2D
    ldr q17, [x1, #1*192]
    trn2  v14.2D, v26.2D, v30.2D
    str q15, [x0, #7*16]
    trn1  v11.2D, v27.2D, v31.2D
    ldr q21, [x1, #5*192]
    trn2  v15.2D, v27.2D, v31.2D

    str q22, [x0, #14*16]
    trn1  v24.4S,  v8.4S, v10.4S
    ldr q18, [x1, #2*192]
    trn2  v26.4S,  v8.4S, v10.4S
    str q19, [x0, #11*16]
    trn1  v25.4S,  v9.4S, v11.4S
    ldr q22, [x1, #6*192]
    trn2  v27.4S,  v9.4S, v11.4S
    str q23, [x0, #15*16]
    trn1  v28.4S, v12.4S, v14.4S
    ldr q19, [x1, #3*192]
    trn2  v30.4S, v12.4S, v14.4S
    trn1  v29.4S, v13.4S, v15.4S
    ldr q23, [x1, #7*192]
    trn2  v31.4S, v13.4S, v15.4S
    add x1, x1, #32*2

    add x0, x0, #16*16


    trn1   v8.8H, v24.8H, v25.8H
    trn2   v9.8H, v24.8H, v25.8H
    trn1  v10.8H, v26.8H, v27.8H
    trn2  v11.8H, v26.8H, v27.8H
    trn1  v12.8H, v28.8H, v29.8H
    trn2  v13.8H, v28.8H, v29.8H
    trn1  v14.8H, v30.8H, v31.8H
    trn2  v15.8H, v30.8H, v31.8H


    sqrdmulh  v4.8H,  v8.8H,  v1.8H
    trn1  v24.2D, v16.2D, v20.2D
    sqrdmulh  v5.8H,  v9.8H,  v1.8H
    trn2  v28.2D, v16.2D, v20.2D
    sqrdmulh  v6.8H, v10.8H,  v1.8H
    trn1  v25.2D, v17.2D, v21.2D
    sqrdmulh  v7.8H, v11.8H,  v1.8H
    trn2  v29.2D, v17.2D, v21.2D
    mul       v8.8H,  v8.8H,  v0.8H
    trn1  v26.2D, v18.2D, v22.2D
    mul       v9.8H,  v9.8H,  v0.8H
    trn2  v30.2D, v18.2D, v22.2D
    mul      v10.8H, v10.8H,  v0.8H
    trn1  v27.2D, v19.2D, v23.2D
    mul      v11.8H, v11.8H,  v0.8H
    trn2  v31.2D, v19.2D, v23.2D

    mls       v8.8H,  v4.8H,  v2.H[0]
    trn1  v16.4S, v24.4S, v26.4S
    mls       v9.8H,  v5.8H,  v2.H[0]
    trn2  v18.4S, v24.4S, v26.4S
    mls      v10.8H,  v6.8H,  v2.H[0]
    trn1  v17.4S, v25.4S, v27.4S
    mls      v11.8H,  v7.8H,  v2.H[0]
    trn2  v19.4S, v25.4S, v27.4S
    sqrdmulh  v4.8H, v12.8H,  v1.8H
    trn1  v20.4S, v28.4S, v30.4S
    sqrdmulh  v5.8H, v13.8H,  v1.8H
    trn2  v22.4S, v28.4S, v30.4S
    sqrdmulh  v6.8H, v14.8H,  v1.8H
    trn1  v21.4S, v29.4S, v31.4S
    sqrdmulh  v7.8H, v15.8H,  v1.8H
    trn2  v23.4S, v29.4S, v31.4S

    mul      v12.8H, v12.8H,  v0.8H
    trn1  v24.8H, v16.8H, v17.8H
    mul      v13.8H, v13.8H,  v0.8H
    trn2  v25.8H, v16.8H, v17.8H
    mul      v14.8H, v14.8H,  v0.8H
    trn1  v26.8H, v18.8H, v19.8H
    mul      v15.8H, v15.8H,  v0.8H
    trn2  v27.8H, v18.8H, v19.8H
    mls      v12.8H,  v4.8H,  v2.H[0]
    trn1  v28.8H, v20.8H, v21.8H
    mls      v13.8H,  v5.8H,  v2.H[0]
    trn2  v29.8H, v20.8H, v21.8H
    mls      v14.8H,  v6.8H,  v2.H[0]
    trn1  v30.8H, v22.8H, v23.8H
    mls      v15.8H,  v7.8H,  v2.H[0]
    trn2  v31.8H, v22.8H, v23.8H

    ldp q0, q1, [x2]
    add x2, x2, #2*16
    sub       v5.8H, v24.8H,  v8.8H
    add       v8.8H, v24.8H,  v8.8H
    ldr q24, [x1, #(0*192+16)]
    sub       v7.8H, v25.8H,  v9.8H
    add       v9.8H, v25.8H,  v9.8H
    ldr q25, [x1, #(1*192+16)]

    str  q8, [x0, #0*16]
    sub      v18.8H, v26.8H, v10.8H
    add      v10.8H, v26.8H, v10.8H
    ldr q26, [x1, #(2*192+16)]
    str  q5, [x0, #8*16]
    sub      v19.8H, v27.8H, v11.8H
    add      v11.8H, v27.8H, v11.8H
    ldr q27, [x1, #(3*192+16)]
    str  q9, [x0, #1*16]
    sub      v20.8H, v28.8H, v12.8H
    add      v12.8H, v28.8H, v12.8H
    ldr q28, [x1, #(4*192+16)]
    str  q7, [x0, #9*16]
    sub      v21.8H, v29.8H, v13.8H
    add      v13.8H, v29.8H, v13.8H
    ldr q29, [x1, #(5*192+16)]
    str q10, [x0, #2*16]
    sub      v22.8H, v30.8H, v14.8H
    add      v14.8H, v30.8H, v14.8H
    ldr q30, [x1, #(6*192+16)]
    str q18, [x0, #10*16]
    sub      v23.8H, v31.8H, v15.8H
    add      v15.8H, v31.8H, v15.8H
    ldr q31, [x1, #(7*192+16)]

    str q11, [x0, #3*16]
    str q21, [x0, #13*16]
    str q20, [x0, #12*16]

    str q12, [x0, #4*16]
    trn1   v8.2D, v24.2D, v28.2D
    ldr q16, [x1, #0*192]
    trn2  v12.2D, v24.2D, v28.2D
    str q13, [x0, #5*16]
    trn1   v9.2D, v25.2D, v29.2D
    ldr q20, [x1, #4*192]
    trn2  v13.2D, v25.2D, v29.2D
    str q14, [x0, #6*16]
    trn1  v10.2D, v26.2D, v30.2D
    ldr q17, [x1, #1*192]
    trn2  v14.2D, v26.2D, v30.2D
    str q15, [x0, #7*16]
    trn1  v11.2D, v27.2D, v31.2D
    ldr q21, [x1, #5*192]
    trn2  v15.2D, v27.2D, v31.2D

    str q22, [x0, #14*16]
    trn1  v24.4S,  v8.4S, v10.4S
    ldr q18, [x1, #2*192]
    trn2  v26.4S,  v8.4S, v10.4S
    str q19, [x0, #11*16]
    trn1  v25.4S,  v9.4S, v11.4S
    ldr q22, [x1, #6*192]
    trn2  v27.4S,  v9.4S, v11.4S
    str q23, [x0, #15*16]
    trn1  v28.4S, v12.4S, v14.4S
    ldr q19, [x1, #3*192]
    trn2  v30.4S, v12.4S, v14.4S
    trn1  v29.4S, v13.4S, v15.4S
    ldr q23, [x1, #7*192]
    trn2  v31.4S, v13.4S, v15.4S
    add x1, x1, #32*2

    add x0, x0, #16*16

    trn1   v8.8H, v24.8H, v25.8H
    trn2   v9.8H, v24.8H, v25.8H
    trn1  v10.8H, v26.8H, v27.8H
    trn2  v11.8H, v26.8H, v27.8H
    trn1  v12.8H, v28.8H, v29.8H
    trn2  v13.8H, v28.8H, v29.8H
    trn1  v14.8H, v30.8H, v31.8H
    trn2  v15.8H, v30.8H, v31.8H


    sqrdmulh  v4.8H,  v8.8H,  v1.8H
    trn1  v24.2D, v16.2D, v20.2D
    sqrdmulh  v5.8H,  v9.8H,  v1.8H
    trn2  v28.2D, v16.2D, v20.2D
    sqrdmulh  v6.8H, v10.8H,  v1.8H
    trn1  v25.2D, v17.2D, v21.2D
    sqrdmulh  v7.8H, v11.8H,  v1.8H
    trn2  v29.2D, v17.2D, v21.2D
    mul       v8.8H,  v8.8H,  v0.8H
    trn1  v26.2D, v18.2D, v22.2D
    mul       v9.8H,  v9.8H,  v0.8H
    trn2  v30.2D, v18.2D, v22.2D
    mul      v10.8H, v10.8H,  v0.8H
    trn1  v27.2D, v19.2D, v23.2D
    mul      v11.8H, v11.8H,  v0.8H
    trn2  v31.2D, v19.2D, v23.2D

    mls       v8.8H,  v4.8H,  v2.H[0]
    trn1  v16.4S, v24.4S, v26.4S
    mls       v9.8H,  v5.8H,  v2.H[0]
    trn2  v18.4S, v24.4S, v26.4S
    mls      v10.8H,  v6.8H,  v2.H[0]
    trn1  v17.4S, v25.4S, v27.4S
    mls      v11.8H,  v7.8H,  v2.H[0]
    trn2  v19.4S, v25.4S, v27.4S
    sqrdmulh  v4.8H, v12.8H,  v1.8H
    trn1  v20.4S, v28.4S, v30.4S
    sqrdmulh  v5.8H, v13.8H,  v1.8H
    trn2  v22.4S, v28.4S, v30.4S
    sqrdmulh  v6.8H, v14.8H,  v1.8H
    trn1  v21.4S, v29.4S, v31.4S
    sqrdmulh  v7.8H, v15.8H,  v1.8H
    trn2  v23.4S, v29.4S, v31.4S

    mul      v12.8H, v12.8H,  v0.8H
    trn1  v24.8H, v16.8H, v17.8H
    mul      v13.8H, v13.8H,  v0.8H
    trn2  v25.8H, v16.8H, v17.8H
    mul      v14.8H, v14.8H,  v0.8H
    trn1  v26.8H, v18.8H, v19.8H
    mul      v15.8H, v15.8H,  v0.8H
    trn2  v27.8H, v18.8H, v19.8H
    mls      v12.8H,  v4.8H,  v2.H[0]
    trn1  v28.8H, v20.8H, v21.8H
    mls      v13.8H,  v5.8H,  v2.H[0]
    trn2  v29.8H, v20.8H, v21.8H
    mls      v14.8H,  v6.8H,  v2.H[0]
    trn1  v30.8H, v22.8H, v23.8H
    mls      v15.8H,  v7.8H,  v2.H[0]
    trn2  v31.8H, v22.8H, v23.8H

    sub       v5.8H, v24.8H,  v8.8H
    add       v8.8H, v24.8H,  v8.8H
    sub       v7.8H, v25.8H,  v9.8H
    add       v9.8H, v25.8H,  v9.8H

    str  q8, [x0, #0*16]
    sub      v18.8H, v26.8H, v10.8H
    add      v10.8H, v26.8H, v10.8H
    str  q5, [x0, #8*16]
    sub      v19.8H, v27.8H, v11.8H
    add      v11.8H, v27.8H, v11.8H
    str  q9, [x0, #1*16]
    sub      v20.8H, v28.8H, v12.8H
    add      v12.8H, v28.8H, v12.8H
    str  q7, [x0, #9*16]
    sub      v21.8H, v29.8H, v13.8H
    add      v13.8H, v29.8H, v13.8H
    str q10, [x0, #2*16]
    sub      v22.8H, v30.8H, v14.8H
    add      v14.8H, v30.8H, v14.8H
    str q18, [x0, #10*16]
    sub      v23.8H, v31.8H, v15.8H
    add      v15.8H, v31.8H, v15.8H

    str q11, [x0, #3*16]
    str q19, [x0, #11*16]
    str q12, [x0, #4*16]
    str q20, [x0, #12*16]
    str q13, [x0, #5*16]
    str q21, [x0, #13*16]
    str q14, [x0, #6*16]
    str q22, [x0, #14*16]
    str q15, [x0, #7*16]
    str q23, [x0, #15*16]
    add x0, x0, #16*16

    sub x1, x1, #3*32*2
    add x1, x1, #768*2

    sub x9, x9, #1
    cbnz x9, __asm_CT_loop

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.macro Bruun_GF a0, a1, a2, a3, t0, t1, t2

    mul      \t1\().8H, \a2\().8H,  v0.8H
    sqrdmulh \t2\().8H, \a2\().8H,  v1.8H
    mls      \t1\().8H, \t2\().8H,  v4.H[0]

    mul      \t0\().8H, \a3\().8H,  v0.8H
    sqrdmulh \t2\().8H, \a3\().8H,  v1.8H
    mls      \t0\().8H, \t2\().8H,  v4.H[0]

    sub      \t1\().8H, \a0\().8H, \t1\().8H

    sqrdmulh \t2\().8H, \a2\().8H,  v3.8H
    mul      \a2\().8H, \a2\().8H,  v2.8H
    mls      \a2\().8H, \t2\().8H,  v4.H[0]

    add      \t2\().8H, \a1\().8H, \t0\().8H

    sub      \a1\().8H, \t2\().8H, \a2\().8H
    add      \a3\().8H, \t2\().8H, \a2\().8H

    sqrdmulh \t2\().8H, \t0\().8H,  v3.8H
    mul      \t0\().8H, \t0\().8H,  v2.8H
    mls      \t0\().8H, \t2\().8H,  v4.H[0]

    add      \a0\().8H, \t1\().8H, \t0\().8H
    sub      \a2\().8H, \t1\().8H, \t0\().8H


.endm

// distance between coefficients:
// 192 bytes / 96 coefficients for 16-bit
.align 6
.global __asm_transpose_Bruun
.global ___asm_transpose_Bruun
__asm_transpose_Bruun:
___asm_transpose_Bruun:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    mov v4.H[0], w3

    mov x9, #2
    __asm_Bruun_loop:

    ldp q0, q1, [x2]
    ldp q2, q3, [x2, #32]

    ldr q16, [x1, #(0*192+16)]
    ldr q17, [x1, #(1*192+16)]
    ldr q18, [x1, #(2*192+16)]
    ldr q19, [x1, #(3*192+16)]
    ldr q20, [x1, #(4*192+16)]
    ldr q21, [x1, #(5*192+16)]
    ldr q22, [x1, #(6*192+16)]
    ldr q23, [x1, #(7*192+16)]

    ldr  q8, [x1, #0*192]
    trn1  v24.2D, v16.2D, v20.2D
    trn2  v28.2D, v16.2D, v20.2D
    ldr  q9, [x1, #1*192]
    trn1  v25.2D, v17.2D, v21.2D
    trn2  v29.2D, v17.2D, v21.2D
    ldr q10, [x1, #2*192]
    trn1  v26.2D, v18.2D, v22.2D
    trn2  v30.2D, v18.2D, v22.2D
    ldr q11, [x1, #3*192]
    trn1  v27.2D, v19.2D, v23.2D
    trn2  v31.2D, v19.2D, v23.2D

    ldr q12, [x1, #4*192]
    trn1  v16.4S, v24.4S, v26.4S
    trn2  v18.4S, v24.4S, v26.4S
    ldr q13, [x1, #5*192]
    trn1  v17.4S, v25.4S, v27.4S
    trn2  v19.4S, v25.4S, v27.4S
    ldr q14, [x1, #6*192]
    trn1  v20.4S, v28.4S, v30.4S
    trn2  v22.4S, v28.4S, v30.4S
    ldr q15, [x1, #7*192]
    trn1  v21.4S, v29.4S, v31.4S
    trn2  v23.4S, v29.4S, v31.4S

    trn1  v24.8H, v16.8H, v17.8H
    trn2  v25.8H, v16.8H, v17.8H
    trn1  v26.8H, v18.8H, v19.8H
    trn2  v27.8H, v18.8H, v19.8H
    trn1  v28.8H, v20.8H, v21.8H
    trn2  v29.8H, v20.8H, v21.8H
    trn1  v30.8H, v22.8H, v23.8H
    trn2  v31.8H, v22.8H, v23.8H

    mul       v6.8H, v24.8H,  v0.8H
    trn1  v16.8H,  v8.8H,  v9.8H
    sqrdmulh  v7.8H, v24.8H,  v1.8H
    trn2  v17.8H,  v8.8H,  v9.8H
    mls       v6.8H,  v7.8H,  v4.H[0]
    trn1  v18.8H, v10.8H, v11.8H
    mul       v5.8H, v28.8H,  v0.8H
    trn2  v19.8H, v10.8H, v11.8H
    sqrdmulh  v7.8H, v28.8H,  v1.8H
    trn1  v20.8H, v12.8H, v13.8H
    mls       v5.8H,  v7.8H,  v4.H[0]
    trn2  v21.8H, v12.8H, v13.8H
    sqrdmulh  v7.8H, v24.8H,  v3.8H
    trn1  v22.8H, v14.8H, v15.8H
    mul      v24.8H, v24.8H,  v2.8H
    trn2  v23.8H, v14.8H, v15.8H

    mls      v24.8H,  v7.8H,  v4.H[0]

    trn1   v8.4S, v16.4S, v18.4S
    trn2  v10.4S, v16.4S, v18.4S
    trn1  v12.4S, v20.4S, v22.4S
    trn2  v14.4S, v20.4S, v22.4S

    trn1  v16.2D,  v8.2D, v12.2D
    trn2  v20.2D,  v8.2D, v12.2D

    sub      v16.8H, v16.8H,  v6.8H
    add      v20.8H, v20.8H,  v5.8H

    sqrdmulh  v7.8H,  v5.8H,  v3.8H
    trn1   v9.4S, v17.4S, v19.4S
    mul       v6.8H,  v5.8H,  v2.8H
    trn2  v11.4S, v17.4S, v19.4S
    mls       v6.8H,  v7.8H,  v4.H[0]
    trn1  v13.4S, v21.4S, v23.4S
    trn2  v15.4S, v21.4S, v23.4S
    trn1  v17.2D,  v9.2D, v13.2D
    trn2  v21.2D,  v9.2D, v13.2D
    trn1  v18.2D, v10.2D, v14.2D
    trn2  v22.2D, v10.2D, v14.2D
    trn1  v19.2D, v11.2D, v15.2D
    trn2  v23.2D, v11.2D, v15.2D

    mul      v11.8H, v25.8H,  v0.8H
    add      v28.8H, v20.8H, v24.8H
    sqrdmulh v12.8H, v25.8H,  v1.8H
    sub      v20.8H, v20.8H, v24.8H
    mls      v11.8H, v12.8H,  v4.H[0]
    sub      v24.8H, v16.8H,  v6.8H
    mul      v10.8H, v29.8H,  v0.8H
    add      v16.8H, v16.8H,  v6.8H
    sqrdmulh v12.8H, v29.8H,  v1.8H
    str q28, [x0, #12*16]
    mls      v10.8H, v12.8H,  v4.H[0]
    str q20, [x0, #4*16]
    sqrdmulh v12.8H, v25.8H,  v3.8H
    str q16, [x0, #0*16]
    mul      v25.8H, v25.8H,  v2.8H
    str q24, [x0, #8*16]
    mls      v25.8H, v12.8H,  v4.H[0]
    add      v21.8H, v21.8H, v10.8H
    sqrdmulh v12.8H, v10.8H,  v3.8H
    mul      v10.8H, v10.8H,  v2.8H
    mls      v10.8H, v12.8H,  v4.H[0]

    sqrdmulh v15.8H, v26.8H,  v1.8H
    sub      v11.8H, v17.8H, v11.8H
    mls      v18.8H, v26.8H,  v0.8H
    add      v29.8H, v21.8H, v25.8H
    mla      v18.8H, v15.8H,  v4.H[0]
    sub      v21.8H, v21.8H, v25.8H
    mul      v13.8H, v30.8H,  v0.8H
    add      v17.8H, v11.8H, v10.8H
    sqrdmulh v15.8H, v30.8H,  v1.8H
    sub      v25.8H, v11.8H, v10.8H
    mls      v13.8H, v15.8H,  v4.H[0]
    str q29, [x0, #13*16]
    sqrdmulh v15.8H, v26.8H,  v3.8H
    str q21, [x0, #5*16]
    mul      v26.8H, v26.8H,  v2.8H
    str q17, [x0, #1*16]
    mls      v26.8H, v15.8H,  v4.H[0]
    str q25, [x0, #9*16]
    add      v22.8H, v22.8H, v13.8H
    sqrdmulh v15.8H, v13.8H,  v3.8H
    mul      v13.8H, v13.8H,  v2.8H
    mls      v13.8H, v15.8H,  v4.H[0]

    mul      v24.8H, v27.8H,  v0.8H
    sqrdmulh v28.8H, v27.8H,  v1.8H
    add      v30.8H, v22.8H, v26.8H
    mls      v24.8H, v28.8H,  v4.H[0]
    sub      v22.8H, v22.8H, v26.8H
    mul      v20.8H, v31.8H,  v0.8H
    sub      v26.8H, v18.8H, v13.8H
    sqrdmulh v28.8H, v31.8H,  v1.8H
    add      v18.8H, v18.8H, v13.8H
    mls      v20.8H, v28.8H,  v4.H[0]
    str q30, [x0, #14*16]
    sqrdmulh v28.8H, v27.8H,  v3.8H
    str q22, [x0, #6*16]
    mul      v27.8H, v27.8H,  v2.8H
    str q18, [x0, #2*16]
    mls      v27.8H, v28.8H,  v4.H[0]
    str q26, [x0, #10*16]
    add      v23.8H, v23.8H, v20.8H
    sqrdmulh v28.8H, v20.8H,  v3.8H
    mul      v20.8H, v20.8H,  v2.8H
    mls      v20.8H, v28.8H,  v4.H[0]

    add x1, x1, #32*2
    add x2, x2, #12*16

    ldp q0, q1, [x2]
    sub      v24.8H, v19.8H, v24.8H
    add      v31.8H, v23.8H, v27.8H
    ldp q2, q3, [x2, #32]
    sub      v23.8H, v23.8H, v27.8H
    add      v19.8H, v24.8H, v20.8H
    ldr q16, [x1, #(0*192+16)]
    sub      v27.8H, v24.8H, v20.8H

    str q31, [x0, #15*16]
    ldr q17, [x1, #(1*192+16)]
    str q23, [x0, #7*16]
    ldr q18, [x1, #(2*192+16)]
    str q19, [x0, #3*16]
    ldr q19, [x1, #(3*192+16)]
    str q27, [x0, #11*16]

    add x0, x0, #16*16

    ldr q20, [x1, #(4*192+16)]
    ldr q21, [x1, #(5*192+16)]
    ldr q22, [x1, #(6*192+16)]
    ldr q23, [x1, #(7*192+16)]

    ldr  q8, [x1, #0*192]
    trn1  v24.2D, v16.2D, v20.2D
    trn2  v28.2D, v16.2D, v20.2D
    ldr  q9, [x1, #1*192]
    trn1  v25.2D, v17.2D, v21.2D
    trn2  v29.2D, v17.2D, v21.2D
    ldr q10, [x1, #2*192]
    trn1  v26.2D, v18.2D, v22.2D
    trn2  v30.2D, v18.2D, v22.2D
    ldr q11, [x1, #3*192]
    trn1  v27.2D, v19.2D, v23.2D
    trn2  v31.2D, v19.2D, v23.2D

    ldr q12, [x1, #4*192]
    trn1  v16.4S, v24.4S, v26.4S
    trn2  v18.4S, v24.4S, v26.4S
    ldr q13, [x1, #5*192]
    trn1  v17.4S, v25.4S, v27.4S
    trn2  v19.4S, v25.4S, v27.4S
    ldr q14, [x1, #6*192]
    trn1  v20.4S, v28.4S, v30.4S
    trn2  v22.4S, v28.4S, v30.4S
    ldr q15, [x1, #7*192]
    trn1  v21.4S, v29.4S, v31.4S
    trn2  v23.4S, v29.4S, v31.4S

    trn1  v24.8H, v16.8H, v17.8H
    trn2  v25.8H, v16.8H, v17.8H
    trn1  v26.8H, v18.8H, v19.8H
    trn2  v27.8H, v18.8H, v19.8H
    trn1  v28.8H, v20.8H, v21.8H
    trn2  v29.8H, v20.8H, v21.8H
    trn1  v30.8H, v22.8H, v23.8H
    trn2  v31.8H, v22.8H, v23.8H

    mul       v6.8H, v24.8H,  v0.8H
    trn1  v16.8H,  v8.8H,  v9.8H
    sqrdmulh  v7.8H, v24.8H,  v1.8H
    trn2  v17.8H,  v8.8H,  v9.8H
    mls       v6.8H,  v7.8H,  v4.H[0]
    trn1  v18.8H, v10.8H, v11.8H
    mul       v5.8H, v28.8H,  v0.8H
    trn2  v19.8H, v10.8H, v11.8H
    sqrdmulh  v7.8H, v28.8H,  v1.8H
    trn1  v20.8H, v12.8H, v13.8H
    mls       v5.8H,  v7.8H,  v4.H[0]
    trn2  v21.8H, v12.8H, v13.8H
    sqrdmulh  v7.8H, v24.8H,  v3.8H
    trn1  v22.8H, v14.8H, v15.8H
    mul      v24.8H, v24.8H,  v2.8H
    trn2  v23.8H, v14.8H, v15.8H

    mls      v24.8H,  v7.8H,  v4.H[0]

    trn1   v8.4S, v16.4S, v18.4S
    trn2  v10.4S, v16.4S, v18.4S
    trn1  v12.4S, v20.4S, v22.4S
    trn2  v14.4S, v20.4S, v22.4S

    trn1  v16.2D,  v8.2D, v12.2D
    trn2  v20.2D,  v8.2D, v12.2D

    sub      v16.8H, v16.8H,  v6.8H
    add      v20.8H, v20.8H,  v5.8H

    sqrdmulh  v7.8H,  v5.8H,  v3.8H
    trn1   v9.4S, v17.4S, v19.4S
    mul       v6.8H,  v5.8H,  v2.8H
    trn2  v11.4S, v17.4S, v19.4S
    mls       v6.8H,  v7.8H,  v4.H[0]
    trn1  v13.4S, v21.4S, v23.4S
    trn2  v15.4S, v21.4S, v23.4S
    trn1  v17.2D,  v9.2D, v13.2D
    trn2  v21.2D,  v9.2D, v13.2D
    trn1  v18.2D, v10.2D, v14.2D
    trn2  v22.2D, v10.2D, v14.2D
    trn1  v19.2D, v11.2D, v15.2D
    trn2  v23.2D, v11.2D, v15.2D

    mul      v11.8H, v25.8H,  v0.8H
    add      v28.8H, v20.8H, v24.8H
    sqrdmulh v12.8H, v25.8H,  v1.8H
    sub      v20.8H, v20.8H, v24.8H
    mls      v11.8H, v12.8H,  v4.H[0]
    sub      v24.8H, v16.8H,  v6.8H
    mul      v10.8H, v29.8H,  v0.8H
    add      v16.8H, v16.8H,  v6.8H
    sqrdmulh v12.8H, v29.8H,  v1.8H
    str q28, [x0, #12*16]
    mls      v10.8H, v12.8H,  v4.H[0]
    str q20, [x0, #4*16]
    sqrdmulh v12.8H, v25.8H,  v3.8H
    str q16, [x0, #0*16]
    mul      v25.8H, v25.8H,  v2.8H
    str q24, [x0, #8*16]
    mls      v25.8H, v12.8H,  v4.H[0]
    add      v21.8H, v21.8H, v10.8H
    sqrdmulh v12.8H, v10.8H,  v3.8H
    mul      v10.8H, v10.8H,  v2.8H
    mls      v10.8H, v12.8H,  v4.H[0]

    sqrdmulh v15.8H, v26.8H,  v1.8H
    sub      v11.8H, v17.8H, v11.8H
    mls      v18.8H, v26.8H,  v0.8H
    add      v29.8H, v21.8H, v25.8H
    mla      v18.8H, v15.8H,  v4.H[0]
    sub      v21.8H, v21.8H, v25.8H
    mul      v13.8H, v30.8H,  v0.8H
    add      v17.8H, v11.8H, v10.8H
    sqrdmulh v15.8H, v30.8H,  v1.8H
    sub      v25.8H, v11.8H, v10.8H
    mls      v13.8H, v15.8H,  v4.H[0]
    str q29, [x0, #13*16]
    sqrdmulh v15.8H, v26.8H,  v3.8H
    str q21, [x0, #5*16]
    mul      v26.8H, v26.8H,  v2.8H
    str q17, [x0, #1*16]
    mls      v26.8H, v15.8H,  v4.H[0]
    str q25, [x0, #9*16]
    add      v22.8H, v22.8H, v13.8H
    sqrdmulh v15.8H, v13.8H,  v3.8H
    mul      v13.8H, v13.8H,  v2.8H
    mls      v13.8H, v15.8H,  v4.H[0]

    mul      v24.8H, v27.8H,  v0.8H
    sqrdmulh v28.8H, v27.8H,  v1.8H
    add      v30.8H, v22.8H, v26.8H
    mls      v24.8H, v28.8H,  v4.H[0]
    sub      v22.8H, v22.8H, v26.8H
    mul      v20.8H, v31.8H,  v0.8H
    sub      v26.8H, v18.8H, v13.8H
    sqrdmulh v28.8H, v31.8H,  v1.8H
    add      v18.8H, v18.8H, v13.8H
    mls      v20.8H, v28.8H,  v4.H[0]
    str q30, [x0, #14*16]
    sqrdmulh v28.8H, v27.8H,  v3.8H
    str q22, [x0, #6*16]
    mul      v27.8H, v27.8H,  v2.8H
    str q18, [x0, #2*16]
    mls      v27.8H, v28.8H,  v4.H[0]
    str q26, [x0, #10*16]
    add      v23.8H, v23.8H, v20.8H
    sqrdmulh v28.8H, v20.8H,  v3.8H
    mul      v20.8H, v20.8H,  v2.8H
    mls      v20.8H, v28.8H,  v4.H[0]

    add x1, x1, #32*2
    add x2, x2, #12*16

    ldp q0, q1, [x2]
    sub      v24.8H, v19.8H, v24.8H
    add      v31.8H, v23.8H, v27.8H
    ldp q2, q3, [x2, #32]
    sub      v23.8H, v23.8H, v27.8H
    add      v19.8H, v24.8H, v20.8H
    ldr q16, [x1, #(0*192+16)]
    sub      v27.8H, v24.8H, v20.8H

    str q31, [x0, #15*16]
    ldr q17, [x1, #(1*192+16)]
    str q23, [x0, #7*16]
    ldr q18, [x1, #(2*192+16)]
    str q19, [x0, #3*16]
    ldr q19, [x1, #(3*192+16)]
    str q27, [x0, #11*16]

    add x0, x0, #16*16

    ldr q20, [x1, #(4*192+16)]
    ldr q21, [x1, #(5*192+16)]
    ldr q22, [x1, #(6*192+16)]
    ldr q23, [x1, #(7*192+16)]

    ldr  q8, [x1, #0*192]
    trn1  v24.2D, v16.2D, v20.2D
    trn2  v28.2D, v16.2D, v20.2D
    ldr  q9, [x1, #1*192]
    trn1  v25.2D, v17.2D, v21.2D
    trn2  v29.2D, v17.2D, v21.2D
    ldr q10, [x1, #2*192]
    trn1  v26.2D, v18.2D, v22.2D
    trn2  v30.2D, v18.2D, v22.2D
    ldr q11, [x1, #3*192]
    trn1  v27.2D, v19.2D, v23.2D
    trn2  v31.2D, v19.2D, v23.2D

    ldr q12, [x1, #4*192]
    trn1  v16.4S, v24.4S, v26.4S
    trn2  v18.4S, v24.4S, v26.4S
    ldr q13, [x1, #5*192]
    trn1  v17.4S, v25.4S, v27.4S
    trn2  v19.4S, v25.4S, v27.4S
    ldr q14, [x1, #6*192]
    trn1  v20.4S, v28.4S, v30.4S
    trn2  v22.4S, v28.4S, v30.4S
    ldr q15, [x1, #7*192]
    trn1  v21.4S, v29.4S, v31.4S
    trn2  v23.4S, v29.4S, v31.4S

    trn1  v24.8H, v16.8H, v17.8H
    trn2  v25.8H, v16.8H, v17.8H
    trn1  v26.8H, v18.8H, v19.8H
    trn2  v27.8H, v18.8H, v19.8H
    trn1  v28.8H, v20.8H, v21.8H
    trn2  v29.8H, v20.8H, v21.8H
    trn1  v30.8H, v22.8H, v23.8H
    trn2  v31.8H, v22.8H, v23.8H

    mul       v6.8H, v24.8H,  v0.8H
    trn1  v16.8H,  v8.8H,  v9.8H
    sqrdmulh  v7.8H, v24.8H,  v1.8H
    trn2  v17.8H,  v8.8H,  v9.8H
    mls       v6.8H,  v7.8H,  v4.H[0]
    trn1  v18.8H, v10.8H, v11.8H
    mul       v5.8H, v28.8H,  v0.8H
    trn2  v19.8H, v10.8H, v11.8H
    sqrdmulh  v7.8H, v28.8H,  v1.8H
    trn1  v20.8H, v12.8H, v13.8H
    mls       v5.8H,  v7.8H,  v4.H[0]
    trn2  v21.8H, v12.8H, v13.8H
    sqrdmulh  v7.8H, v24.8H,  v3.8H
    trn1  v22.8H, v14.8H, v15.8H
    mul      v24.8H, v24.8H,  v2.8H
    trn2  v23.8H, v14.8H, v15.8H

    mls      v24.8H,  v7.8H,  v4.H[0]

    trn1   v8.4S, v16.4S, v18.4S
    trn2  v10.4S, v16.4S, v18.4S
    trn1  v12.4S, v20.4S, v22.4S
    trn2  v14.4S, v20.4S, v22.4S

    trn1  v16.2D,  v8.2D, v12.2D
    trn2  v20.2D,  v8.2D, v12.2D

    sub      v16.8H, v16.8H,  v6.8H
    add      v20.8H, v20.8H,  v5.8H

    sqrdmulh  v7.8H,  v5.8H,  v3.8H
    trn1   v9.4S, v17.4S, v19.4S
    mul       v6.8H,  v5.8H,  v2.8H
    trn2  v11.4S, v17.4S, v19.4S
    mls       v6.8H,  v7.8H,  v4.H[0]
    trn1  v13.4S, v21.4S, v23.4S
    trn2  v15.4S, v21.4S, v23.4S
    trn1  v17.2D,  v9.2D, v13.2D
    trn2  v21.2D,  v9.2D, v13.2D
    trn1  v18.2D, v10.2D, v14.2D
    trn2  v22.2D, v10.2D, v14.2D
    trn1  v19.2D, v11.2D, v15.2D
    trn2  v23.2D, v11.2D, v15.2D

    mul      v11.8H, v25.8H,  v0.8H
    add      v28.8H, v20.8H, v24.8H
    sqrdmulh v12.8H, v25.8H,  v1.8H
    sub      v20.8H, v20.8H, v24.8H
    mls      v11.8H, v12.8H,  v4.H[0]
    sub      v24.8H, v16.8H,  v6.8H
    mul      v10.8H, v29.8H,  v0.8H
    add      v16.8H, v16.8H,  v6.8H
    sqrdmulh v12.8H, v29.8H,  v1.8H
    str q28, [x0, #12*16]
    mls      v10.8H, v12.8H,  v4.H[0]
    str q20, [x0, #4*16]
    sqrdmulh v12.8H, v25.8H,  v3.8H
    str q16, [x0, #0*16]
    mul      v25.8H, v25.8H,  v2.8H
    str q24, [x0, #8*16]
    mls      v25.8H, v12.8H,  v4.H[0]
    add      v21.8H, v21.8H, v10.8H
    sqrdmulh v12.8H, v10.8H,  v3.8H
    mul      v10.8H, v10.8H,  v2.8H
    mls      v10.8H, v12.8H,  v4.H[0]

    sqrdmulh v15.8H, v26.8H,  v1.8H
    sub      v11.8H, v17.8H, v11.8H
    mls      v18.8H, v26.8H,  v0.8H
    add      v29.8H, v21.8H, v25.8H
    mla      v18.8H, v15.8H,  v4.H[0]
    sub      v21.8H, v21.8H, v25.8H
    mul      v13.8H, v30.8H,  v0.8H
    add      v17.8H, v11.8H, v10.8H
    sqrdmulh v15.8H, v30.8H,  v1.8H
    sub      v25.8H, v11.8H, v10.8H
    mls      v13.8H, v15.8H,  v4.H[0]
    str q29, [x0, #13*16]
    sqrdmulh v15.8H, v26.8H,  v3.8H
    str q21, [x0, #5*16]
    mul      v26.8H, v26.8H,  v2.8H
    str q17, [x0, #1*16]
    mls      v26.8H, v15.8H,  v4.H[0]
    str q25, [x0, #9*16]
    add      v22.8H, v22.8H, v13.8H
    sqrdmulh v15.8H, v13.8H,  v3.8H
    mul      v13.8H, v13.8H,  v2.8H
    mls      v13.8H, v15.8H,  v4.H[0]

    mul      v24.8H, v27.8H,  v0.8H
    sqrdmulh v28.8H, v27.8H,  v1.8H
    add      v30.8H, v22.8H, v26.8H
    mls      v24.8H, v28.8H,  v4.H[0]
    sub      v22.8H, v22.8H, v26.8H
    mul      v20.8H, v31.8H,  v0.8H
    sub      v26.8H, v18.8H, v13.8H
    sqrdmulh v28.8H, v31.8H,  v1.8H
    add      v18.8H, v18.8H, v13.8H
    mls      v20.8H, v28.8H,  v4.H[0]
    str q30, [x0, #14*16]
    sqrdmulh v28.8H, v27.8H,  v3.8H
    str q22, [x0, #6*16]
    mul      v27.8H, v27.8H,  v2.8H
    str q18, [x0, #2*16]
    mls      v27.8H, v28.8H,  v4.H[0]
    str q26, [x0, #10*16]
    add      v23.8H, v23.8H, v20.8H
    sqrdmulh v28.8H, v20.8H,  v3.8H
    mul      v20.8H, v20.8H,  v2.8H
    mls      v20.8H, v28.8H,  v4.H[0]

    sub      v24.8H, v19.8H, v24.8H
    add      v31.8H, v23.8H, v27.8H
    sub      v23.8H, v23.8H, v27.8H
    add      v19.8H, v24.8H, v20.8H
    sub      v27.8H, v24.8H, v20.8H

    str q31, [x0, #15*16]
    str q23, [x0, #7*16]
    str q19, [x0, #3*16]
    str q27, [x0, #11*16]

    add x0, x0, #16*16
    add x1, x1, #32*2
    add x2, x2, #12*16

    sub x1, x1, #32*3*2
    add x1, x1, #768*2

    sub x9, x9, #1
    cbnz x9, __asm_Bruun_loop


    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr









