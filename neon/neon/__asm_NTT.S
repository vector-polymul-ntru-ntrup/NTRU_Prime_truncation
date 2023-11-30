
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

.macro butterfly3_l4l1 a0, a1, a2, wlo, whi, mod, t0, t1, t2, t3, srcc_ptr, c0, c1, c2, c3, memc0, memc1, memc2, memc3, srcd_ptr, d0, memd0

    ldr            \c0, [\srcc_ptr, \memc0]
    sub      \t0\().8H, \a1\().8H, \a2\().8H
    mul      \t3\().8H, \t0\().8H, \wlo
    ldr            \c1, [\srcc_ptr, \memc1]
    sqrdmulh \t2\().8H, \t0\().8H, \whi
    ldr            \c2, [\srcc_ptr, \memc2]
    mls      \t3\().8H, \t2\().8H, \mod
    sub      \t1\().8H, \a0\().8H, \a2\().8H
    ldr            \c3, [\srcc_ptr, \memc3]
    sub      \t2\().8H, \a0\().8H, \a1\().8H
    add      \a0\().8H, \a0\().8H, \a1\().8H
    ldr            \d0, [\srcd_ptr, \memd0]
    add      \a0\().8H, \a0\().8H, \a2\().8H
    add      \a1\().8H, \t1\().8H, \t3\().8H
    sub      \a2\().8H, \t2\().8H, \t3\().8H

.endm

.align 6
.global __asm_3x2
.global ___asm_3x2
__asm_3x2:
___asm_3x2:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr d6, [x1]

.rept 16

.rept 2

    ldr  q0, [x0, #0*32]
    ldr  q4, [x0, #1*32]
    ldr  q2, [x0, #2*32]
    ldr  q3, [x0, #3*32]
    ldr  q1, [x0, #4*32]
    ldr  q5, [x0, #5*32]

    add       v16.8H,  v0.8H,  v3.8H
    sub       v19.8H,  v0.8H,  v3.8H
    add       v17.8H,  v1.8H,  v4.8H
    sub       v20.8H,  v1.8H,  v4.8H
    add       v18.8H,  v2.8H,  v5.8H
    sub       v21.8H,  v2.8H,  v5.8H

    butterfly3 v16, v17, v18, v6.H[2], v6.H[3], v6.H[1], v24, v25, v26, v27
    butterfly3 v19, v20, v21, v6.H[2], v6.H[3], v6.H[1], v24, v25, v26, v27

    str q16, [x0, #0*32]
    str q20, [x0, #1*32]
    str q18, [x0, #2*32]
    str q19, [x0, #3*32]
    str q17, [x0, #4*32]
    str q21, [x0, #5*32]

    add x0, x0, #16

.endr

    sub x0, x0, #32
    add x0, x0, #192

.endr

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_3x2_twistx2
.global ___asm_3x2_twistx2
__asm_3x2_twistx2:
___asm_3x2_twistx2:

    counter     .req  x8

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr d6, [x3]

    ldr  q0, [x0, #0*32]
    ldr  q3, [x0, #3*32]
    ldr  q1, [x0, #4*32]
    ldr  q4, [x0, #1*32]
    ldr  q2, [x0, #2*32]
    ldr  q5, [x0, #5*32]

    ldr q16, [x1, #0*64]
    ldr q19, [x1, #3*64]
    ldr q17, [x1, #4*64]
    ldr q20, [x1, #1*64]
    ldr q18, [x1, #2*64]
    ldr q21, [x1, #5*64]

    ldr q24, [x1, #(16+0*64)]
    ldr q27, [x1, #(16+3*64)]
    ldr q25, [x1, #(16+4*64)]
    ldr q28, [x1, #(16+1*64)]
    ldr q26, [x1, #(16+2*64)]
    ldr q29, [x1, #(16+5*64)]

    sqrdmulh v24.8H,  v0.8H, v24.8H
    sqrdmulh v27.8H,  v3.8H, v27.8H
    sqrdmulh v25.8H,  v1.8H, v25.8H
    sqrdmulh v28.8H,  v4.8H, v28.8H
    sqrdmulh v26.8H,  v2.8H, v26.8H
    sqrdmulh v29.8H,  v5.8H, v29.8H

    mul       v0.8H,  v0.8H, v16.8H
    mul       v3.8H,  v3.8H, v19.8H
    mul       v1.8H,  v1.8H, v17.8H
    mul       v4.8H,  v4.8H, v20.8H
    mul       v2.8H,  v2.8H, v18.8H
    mul       v5.8H,  v5.8H, v21.8H

    mls       v0.8H, v24.8H,  v6.H[1]
    mls       v3.8H, v27.8H,  v6.H[1]
    mls       v1.8H, v25.8H,  v6.H[1]
    mls       v4.8H, v28.8H,  v6.H[1]
    mls       v2.8H, v26.8H,  v6.H[1]
    mls       v5.8H, v29.8H,  v6.H[1]

    add       v8.8H,  v0.8H,  v3.8H
    sub      v11.8H,  v0.8H,  v3.8H
    add       v9.8H,  v1.8H,  v4.8H
    sub      v12.8H,  v1.8H,  v4.8H
    add      v10.8H,  v2.8H,  v5.8H
    sub      v13.8H,  v2.8H,  v5.8H

    butterfly3_l4l1 \
             v8,  v9, v10, v6.H[2], v6.H[3], v6.H[1], v16, v17, v18, v19, \
             x2, \
            q24, q25, q26, q27, \
            #(16+0*64), #(16+4*64), #(16+2*64), #(16+3*64), \
             x2, \
            q28, \
            (16+1*64)

    butterfly3_l4l1 \
            v11, v12, v13, v6.H[2], v6.H[3], v6.H[1], v20, v21, v22, v23, \
             x2, \
            q16, q17, q18, q19, \
            #0*64, #4*64, #2*64, #3*64, \
             x2, \
            q29, \
            #(16+5*64)

    ldr q20, [x2, #1*64]
    ldr q21, [x2, #5*64]

    sqrdmulh v24.8H,  v8.8H, v24.8H
    ldr  q0, [x0, #(16+0*32)]
    sqrdmulh v25.8H,  v9.8H, v25.8H
    ldr  q3, [x0, #(16+3*32)]
    sqrdmulh v26.8H, v10.8H, v26.8H
    ldr  q1, [x0, #(16+4*32)]
    sqrdmulh v27.8H, v11.8H, v27.8H
    ldr  q4, [x0, #(16+1*32)]
    sqrdmulh v28.8H, v12.8H, v28.8H
    ldr  q2, [x0, #(16+2*32)]
    sqrdmulh v29.8H, v13.8H, v29.8H
    ldr  q5, [x0, #(16+5*32)]

    mul       v8.8H,  v8.8H, v16.8H
    ldr q16, [x1, #(32+0*64)]
    mul       v9.8H,  v9.8H, v17.8H
    ldr q17, [x1, #(32+4*64)]
    mul      v10.8H, v10.8H, v18.8H
    ldr q18, [x1, #(32+2*64)]
    mul      v11.8H, v11.8H, v19.8H
    ldr q19, [x1, #(32+3*64)]
    mul      v12.8H, v12.8H, v20.8H
    ldr q20, [x1, #(32+1*64)]
    mul      v13.8H, v13.8H, v21.8H
    ldr q21, [x1, #(32+5*64)]

    mls       v8.8H, v24.8H,  v6.H[1]
    ldr q24, [x1, #(48+0*64)]
    str  q8, [x0, #0*32]
    mls       v9.8H, v25.8H,  v6.H[1]
    ldr q25, [x1, #(48+4*64)]
    str  q9, [x0, #4*32]
    mls      v10.8H, v26.8H,  v6.H[1]
    ldr q26, [x1, #(48+2*64)]
    str q10, [x0, #2*32]
    mls      v11.8H, v27.8H,  v6.H[1]
    ldr q27, [x1, #(48+3*64)]
    str q11, [x0, #3*32]
    mls      v12.8H, v28.8H,  v6.H[1]
    ldr q28, [x1, #(48+1*64)]
    str q12, [x0, #1*32]
    mls      v13.8H, v29.8H,  v6.H[1]
    ldr q29, [x1, #(48+5*64)]
    str q13, [x0, #5*32]

    add x0, x0, #16
    add x1, x1, #32
    add x2, x2, #32

    sqrdmulh v24.8H,  v0.8H, v24.8H
    sqrdmulh v27.8H,  v3.8H, v27.8H
    sqrdmulh v25.8H,  v1.8H, v25.8H
    sqrdmulh v28.8H,  v4.8H, v28.8H
    sqrdmulh v26.8H,  v2.8H, v26.8H
    sqrdmulh v29.8H,  v5.8H, v29.8H

    mul       v0.8H,  v0.8H, v16.8H
    mul       v3.8H,  v3.8H, v19.8H
    mul       v1.8H,  v1.8H, v17.8H
    mul       v4.8H,  v4.8H, v20.8H
    mul       v2.8H,  v2.8H, v18.8H
    mul       v5.8H,  v5.8H, v21.8H

    mls       v0.8H, v24.8H,  v6.H[1]
    mls       v3.8H, v27.8H,  v6.H[1]
    mls       v1.8H, v25.8H,  v6.H[1]
    mls       v4.8H, v28.8H,  v6.H[1]
    mls       v2.8H, v26.8H,  v6.H[1]
    mls       v5.8H, v29.8H,  v6.H[1]

    add       v8.8H,  v0.8H,  v3.8H
    sub      v11.8H,  v0.8H,  v3.8H
    add       v9.8H,  v1.8H,  v4.8H
    sub      v12.8H,  v1.8H,  v4.8H
    add      v10.8H,  v2.8H,  v5.8H
    sub      v13.8H,  v2.8H,  v5.8H

    butterfly3_l4l1 \
             v8,  v9, v10, v6.H[2], v6.H[3], v6.H[1], v16, v17, v18, v19, \
             x2, \
            q24, q25, q26, q27, \
            #(16+0*64), #(16+4*64), #(16+2*64), #(16+3*64), \
             x2, \
            q28, \
            (16+1*64)

    butterfly3_l4l1 \
            v11, v12, v13, v6.H[2], v6.H[3], v6.H[1], v20, v21, v22, v23, \
             x2, \
            q16, q17, q18, q19, \
            #0*64, #4*64, #2*64, #3*64, \
             x2, \
            q29, \
            #(16+5*64)

    ldr q20, [x2, #1*64]
    ldr q21, [x2, #5*64]

    mov counter, #15
    __asm_3x2_twistx2_loop:

    sqrdmulh v24.8H,  v8.8H, v24.8H
    ldr  q0, [x0, #((6-1)*32+16+0*32)]
    sqrdmulh v25.8H,  v9.8H, v25.8H
    ldr  q1, [x0, #((6-1)*32+16+4*32)]
    sqrdmulh v26.8H, v10.8H, v26.8H
    ldr  q2, [x0, #((6-1)*32+16+2*32)]
    sqrdmulh v27.8H, v11.8H, v27.8H
    ldr  q3, [x0, #((6-1)*32+16+3*32)]
    sqrdmulh v28.8H, v12.8H, v28.8H
    ldr  q4, [x0, #((6-1)*32+16+1*32)]
    sqrdmulh v29.8H, v13.8H, v29.8H
    ldr  q5, [x0, #((6-1)*32+16+5*32)]

    mul       v8.8H,  v8.8H, v16.8H
    ldr q16, [x1, #((6-1)*64+32+0*64)]
    mul       v9.8H,  v9.8H, v17.8H
    ldr q17, [x1, #((6-1)*64+32+4*64)]
    mul      v10.8H, v10.8H, v18.8H
    ldr q18, [x1, #((6-1)*64+32+2*64)]
    mul      v11.8H, v11.8H, v19.8H
    ldr q19, [x1, #((6-1)*64+32+3*64)]
    mul      v12.8H, v12.8H, v20.8H
    ldr q20, [x1, #((6-1)*64+32+1*64)]
    mul      v13.8H, v13.8H, v21.8H
    ldr q21, [x1, #((6-1)*64+32+5*64)]

    mls       v8.8H, v24.8H,  v6.H[1]
    ldr q24, [x1, #((6-1)*64+32+16+0*64)]
    str  q8, [x0, #0*32]
    mls       v9.8H, v25.8H,  v6.H[1]
    ldr q25, [x1, #((6-1)*64+32+16+4*64)]
    str  q9, [x0, #4*32]
    mls      v10.8H, v26.8H,  v6.H[1]
    ldr q26, [x1, #((6-1)*64+32+16+2*64)]
    str q10, [x0, #2*32]
    mls      v11.8H, v27.8H,  v6.H[1]
    ldr q27, [x1, #((6-1)*64+32+16+3*64)]
    str q11, [x0, #3*32]
    mls      v12.8H, v28.8H,  v6.H[1]
    ldr q28, [x1, #((6-1)*64+32+16+1*64)]
    str q12, [x0, #1*32]
    mls      v13.8H, v29.8H,  v6.H[1]
    ldr q29, [x1, #((6-1)*64+32+16+5*64)]
    str q13, [x0, #5*32]

    add x0, x0, #((6-1)*32+16)
    add x1, x1, #((6-1)*64+32)
    add x2, x2, #((6-1)*64+32)

    sqrdmulh v24.8H,  v0.8H, v24.8H
    sqrdmulh v27.8H,  v3.8H, v27.8H
    sqrdmulh v25.8H,  v1.8H, v25.8H
    sqrdmulh v28.8H,  v4.8H, v28.8H
    sqrdmulh v26.8H,  v2.8H, v26.8H
    sqrdmulh v29.8H,  v5.8H, v29.8H

    mul       v0.8H,  v0.8H, v16.8H
    mul       v3.8H,  v3.8H, v19.8H
    mul       v1.8H,  v1.8H, v17.8H
    mul       v4.8H,  v4.8H, v20.8H
    mul       v2.8H,  v2.8H, v18.8H
    mul       v5.8H,  v5.8H, v21.8H

    mls       v0.8H, v24.8H,  v6.H[1]
    mls       v3.8H, v27.8H,  v6.H[1]
    mls       v1.8H, v25.8H,  v6.H[1]
    mls       v4.8H, v28.8H,  v6.H[1]
    mls       v2.8H, v26.8H,  v6.H[1]
    mls       v5.8H, v29.8H,  v6.H[1]

    add       v8.8H,  v0.8H,  v3.8H
    sub      v11.8H,  v0.8H,  v3.8H
    add       v9.8H,  v1.8H,  v4.8H
    sub      v12.8H,  v1.8H,  v4.8H
    add      v10.8H,  v2.8H,  v5.8H
    sub      v13.8H,  v2.8H,  v5.8H

    butterfly3_l4l1 \
             v8,  v9, v10, v6.H[2], v6.H[3], v6.H[1], v16, v17, v18, v19, \
             x2, \
            q24, q25, q26, q27, \
            #(16+0*64), #(16+4*64), #(16+2*64), #(16+3*64), \
             x2, \
            q28, \
            (16+1*64)

    butterfly3_l4l1 \
            v11, v12, v13, v6.H[2], v6.H[3], v6.H[1], v20, v21, v22, v23, \
             x2, \
            q16, q17, q18, q19, \
            #0*64, #4*64, #2*64, #3*64, \
             x2, \
            q29, \
            #(16+5*64)

    ldr q20, [x2, #1*64]
    ldr q21, [x2, #5*64]

    sqrdmulh v24.8H,  v8.8H, v24.8H
    ldr  q0, [x0, #(16+0*32)]
    sqrdmulh v25.8H,  v9.8H, v25.8H
    ldr  q3, [x0, #(16+3*32)]
    sqrdmulh v26.8H, v10.8H, v26.8H
    ldr  q1, [x0, #(16+4*32)]
    sqrdmulh v27.8H, v11.8H, v27.8H
    ldr  q4, [x0, #(16+1*32)]
    sqrdmulh v28.8H, v12.8H, v28.8H
    ldr  q2, [x0, #(16+2*32)]
    sqrdmulh v29.8H, v13.8H, v29.8H
    ldr  q5, [x0, #(16+5*32)]

    mul       v8.8H,  v8.8H, v16.8H
    ldr q16, [x1, #(32+0*64)]
    mul       v9.8H,  v9.8H, v17.8H
    ldr q17, [x1, #(32+4*64)]
    mul      v10.8H, v10.8H, v18.8H
    ldr q18, [x1, #(32+2*64)]
    mul      v11.8H, v11.8H, v19.8H
    ldr q19, [x1, #(32+3*64)]
    mul      v12.8H, v12.8H, v20.8H
    ldr q20, [x1, #(32+1*64)]
    mul      v13.8H, v13.8H, v21.8H
    ldr q21, [x1, #(32+5*64)]

    mls       v8.8H, v24.8H,  v6.H[1]
    ldr q24, [x1, #(48+0*64)]
    str  q8, [x0, #0*32]
    mls       v9.8H, v25.8H,  v6.H[1]
    ldr q25, [x1, #(48+4*64)]
    str  q9, [x0, #4*32]
    mls      v10.8H, v26.8H,  v6.H[1]
    ldr q26, [x1, #(48+2*64)]
    str q10, [x0, #2*32]
    mls      v11.8H, v27.8H,  v6.H[1]
    ldr q27, [x1, #(48+3*64)]
    str q11, [x0, #3*32]
    mls      v12.8H, v28.8H,  v6.H[1]
    ldr q28, [x1, #(48+1*64)]
    str q12, [x0, #1*32]
    mls      v13.8H, v29.8H,  v6.H[1]
    ldr q29, [x1, #(48+5*64)]
    str q13, [x0, #5*32]

    add x0, x0, #16
    add x1, x1, #32
    add x2, x2, #32

    sqrdmulh v24.8H,  v0.8H, v24.8H
    sqrdmulh v27.8H,  v3.8H, v27.8H
    sqrdmulh v25.8H,  v1.8H, v25.8H
    sqrdmulh v28.8H,  v4.8H, v28.8H
    sqrdmulh v26.8H,  v2.8H, v26.8H
    sqrdmulh v29.8H,  v5.8H, v29.8H

    mul       v0.8H,  v0.8H, v16.8H
    mul       v3.8H,  v3.8H, v19.8H
    mul       v1.8H,  v1.8H, v17.8H
    mul       v4.8H,  v4.8H, v20.8H
    mul       v2.8H,  v2.8H, v18.8H
    mul       v5.8H,  v5.8H, v21.8H

    mls       v0.8H, v24.8H,  v6.H[1]
    mls       v3.8H, v27.8H,  v6.H[1]
    mls       v1.8H, v25.8H,  v6.H[1]
    mls       v4.8H, v28.8H,  v6.H[1]
    mls       v2.8H, v26.8H,  v6.H[1]
    mls       v5.8H, v29.8H,  v6.H[1]

    add       v8.8H,  v0.8H,  v3.8H
    sub      v11.8H,  v0.8H,  v3.8H
    add       v9.8H,  v1.8H,  v4.8H
    sub      v12.8H,  v1.8H,  v4.8H
    add      v10.8H,  v2.8H,  v5.8H
    sub      v13.8H,  v2.8H,  v5.8H

    butterfly3_l4l1 \
             v8,  v9, v10, v6.H[2], v6.H[3], v6.H[1], v16, v17, v18, v19, \
             x2, \
            q24, q25, q26, q27, \
            #(16+0*64), #(16+4*64), #(16+2*64), #(16+3*64), \
             x2, \
            q28, \
            (16+1*64)

    butterfly3_l4l1 \
            v11, v12, v13, v6.H[2], v6.H[3], v6.H[1], v20, v21, v22, v23, \
             x2, \
            q16, q17, q18, q19, \
            #0*64, #4*64, #2*64, #3*64, \
             x2, \
            q29, \
            #(16+5*64)

    ldr q20, [x2, #1*64]
    ldr q21, [x2, #5*64]

    sub counter, counter, #1
    cbnz counter, __asm_3x2_twistx2_loop

    sqrdmulh v24.8H,  v8.8H, v24.8H
    sqrdmulh v25.8H,  v9.8H, v25.8H
    sqrdmulh v26.8H, v10.8H, v26.8H
    sqrdmulh v27.8H, v11.8H, v27.8H
    sqrdmulh v28.8H, v12.8H, v28.8H
    sqrdmulh v29.8H, v13.8H, v29.8H

    mul       v8.8H,  v8.8H, v16.8H
    mul       v9.8H,  v9.8H, v17.8H
    mul      v10.8H, v10.8H, v18.8H
    mul      v11.8H, v11.8H, v19.8H
    mul      v12.8H, v12.8H, v20.8H
    mul      v13.8H, v13.8H, v21.8H

    mls       v8.8H, v24.8H,  v6.H[1]
    mls       v9.8H, v25.8H,  v6.H[1]
    mls      v10.8H, v26.8H,  v6.H[1]
    mls      v11.8H, v27.8H,  v6.H[1]
    mls      v12.8H, v28.8H,  v6.H[1]
    mls      v13.8H, v29.8H,  v6.H[1]

    str  q8, [x0, #0*32]
    str  q9, [x0, #4*32]
    str q10, [x0, #2*32]
    str q11, [x0, #3*32]
    str q12, [x0, #1*32]
    str q13, [x0, #5*32]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_3x2_post_twist
.global ___asm_3x2_post_twist
__asm_3x2_post_twist:
___asm_3x2_post_twist:

    counter     .req  x8

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr d6, [x3]

    ldr  q0, [x0, #0*32]
    ldr  q3, [x0, #3*32]
    ldr  q1, [x0, #4*32]
    ldr  q4, [x0, #1*32]
    ldr  q2, [x0, #2*32]
    ldr  q5, [x0, #5*32]

    add       v8.8H,  v0.8H,  v3.8H
    sub      v11.8H,  v0.8H,  v3.8H
    add       v9.8H,  v1.8H,  v4.8H
    sub      v12.8H,  v1.8H,  v4.8H
    add      v10.8H,  v2.8H,  v5.8H
    sub      v13.8H,  v2.8H,  v5.8H

    butterfly3_l4l1 \
             v8,  v9, v10, v6.H[2], v6.H[3], v6.H[1], v16, v17, v18, v19, \
             x2, \
            q24, q25, q26, q27, \
            #(16+0*64), #(16+4*64), #(16+2*64), #(16+3*64), \
             x2, \
            q28, \
            (16+1*64)

    butterfly3_l4l1 \
            v11, v12, v13, v6.H[2], v6.H[3], v6.H[1], v20, v21, v22, v23, \
             x2, \
            q16, q17, q18, q19, \
            #0*64, #4*64, #2*64, #3*64, \
             x2, \
            q29, \
            #(16+5*64)

    ldr q20, [x2, #1*64]
    ldr q21, [x2, #5*64]

    sqrdmulh v24.8H,  v8.8H, v24.8H
    ldr  q0, [x0, #(16+0*32)]
    sqrdmulh v25.8H,  v9.8H, v25.8H
    ldr  q3, [x0, #(16+3*32)]
    sqrdmulh v26.8H, v10.8H, v26.8H
    ldr  q1, [x0, #(16+4*32)]
    sqrdmulh v27.8H, v11.8H, v27.8H
    ldr  q4, [x0, #(16+1*32)]
    sqrdmulh v28.8H, v12.8H, v28.8H
    ldr  q2, [x0, #(16+2*32)]
    sqrdmulh v29.8H, v13.8H, v29.8H
    ldr  q5, [x0, #(16+5*32)]

    mul       v8.8H,  v8.8H, v16.8H
    mul       v9.8H,  v9.8H, v17.8H
    mul      v10.8H, v10.8H, v18.8H
    mul      v11.8H, v11.8H, v19.8H
    mul      v12.8H, v12.8H, v20.8H
    mul      v13.8H, v13.8H, v21.8H

    mls       v8.8H, v24.8H,  v6.H[1]
    str  q8, [x0, #0*32]
    mls       v9.8H, v25.8H,  v6.H[1]
    str  q9, [x0, #4*32]
    mls      v10.8H, v26.8H,  v6.H[1]
    str q10, [x0, #2*32]
    mls      v11.8H, v27.8H,  v6.H[1]
    str q11, [x0, #3*32]
    mls      v12.8H, v28.8H,  v6.H[1]
    str q12, [x0, #1*32]
    mls      v13.8H, v29.8H,  v6.H[1]
    str q13, [x0, #5*32]

    add x0, x0, #16
    add x1, x1, #32
    add x2, x2, #32

    add       v8.8H,  v0.8H,  v3.8H
    sub      v11.8H,  v0.8H,  v3.8H
    add       v9.8H,  v1.8H,  v4.8H
    sub      v12.8H,  v1.8H,  v4.8H
    add      v10.8H,  v2.8H,  v5.8H
    sub      v13.8H,  v2.8H,  v5.8H

    butterfly3_l4l1 \
             v8,  v9, v10, v6.H[2], v6.H[3], v6.H[1], v16, v17, v18, v19, \
             x2, \
            q24, q25, q26, q27, \
            #(16+0*64), #(16+4*64), #(16+2*64), #(16+3*64), \
             x2, \
            q28, \
            (16+1*64)

    butterfly3_l4l1 \
            v11, v12, v13, v6.H[2], v6.H[3], v6.H[1], v20, v21, v22, v23, \
             x2, \
            q16, q17, q18, q19, \
            #0*64, #4*64, #2*64, #3*64, \
             x2, \
            q29, \
            #(16+5*64)

    ldr q20, [x2, #1*64]
    ldr q21, [x2, #5*64]

    mov counter, #15
    __asm_3x2_post_twist_loop:

    sqrdmulh v24.8H,  v8.8H, v24.8H
    ldr  q0, [x0, #((6-1)*32+16+0*32)]
    sqrdmulh v25.8H,  v9.8H, v25.8H
    ldr  q1, [x0, #((6-1)*32+16+4*32)]
    sqrdmulh v26.8H, v10.8H, v26.8H
    ldr  q2, [x0, #((6-1)*32+16+2*32)]
    sqrdmulh v27.8H, v11.8H, v27.8H
    ldr  q3, [x0, #((6-1)*32+16+3*32)]
    sqrdmulh v28.8H, v12.8H, v28.8H
    ldr  q4, [x0, #((6-1)*32+16+1*32)]
    sqrdmulh v29.8H, v13.8H, v29.8H
    ldr  q5, [x0, #((6-1)*32+16+5*32)]

    mul       v8.8H,  v8.8H, v16.8H
    mul       v9.8H,  v9.8H, v17.8H
    mul      v10.8H, v10.8H, v18.8H
    mul      v11.8H, v11.8H, v19.8H
    mul      v12.8H, v12.8H, v20.8H
    mul      v13.8H, v13.8H, v21.8H

    mls       v8.8H, v24.8H,  v6.H[1]
    str  q8, [x0, #0*32]
    mls       v9.8H, v25.8H,  v6.H[1]
    str  q9, [x0, #4*32]
    mls      v10.8H, v26.8H,  v6.H[1]
    str q10, [x0, #2*32]
    mls      v11.8H, v27.8H,  v6.H[1]
    str q11, [x0, #3*32]
    mls      v12.8H, v28.8H,  v6.H[1]
    str q12, [x0, #1*32]
    mls      v13.8H, v29.8H,  v6.H[1]
    str q13, [x0, #5*32]

    add x0, x0, #((6-1)*32+16)
    add x1, x1, #((6-1)*64+32)
    add x2, x2, #((6-1)*64+32)

    add       v8.8H,  v0.8H,  v3.8H
    sub      v11.8H,  v0.8H,  v3.8H
    add       v9.8H,  v1.8H,  v4.8H
    sub      v12.8H,  v1.8H,  v4.8H
    add      v10.8H,  v2.8H,  v5.8H
    sub      v13.8H,  v2.8H,  v5.8H

    butterfly3_l4l1 \
             v8,  v9, v10, v6.H[2], v6.H[3], v6.H[1], v16, v17, v18, v19, \
             x2, \
            q24, q25, q26, q27, \
            #(16+0*64), #(16+4*64), #(16+2*64), #(16+3*64), \
             x2, \
            q28, \
            (16+1*64)

    butterfly3_l4l1 \
            v11, v12, v13, v6.H[2], v6.H[3], v6.H[1], v20, v21, v22, v23, \
             x2, \
            q16, q17, q18, q19, \
            #0*64, #4*64, #2*64, #3*64, \
             x2, \
            q29, \
            #(16+5*64)

    ldr q20, [x2, #1*64]
    ldr q21, [x2, #5*64]

    sqrdmulh v24.8H,  v8.8H, v24.8H
    ldr  q0, [x0, #(16+0*32)]
    sqrdmulh v25.8H,  v9.8H, v25.8H
    ldr  q3, [x0, #(16+3*32)]
    sqrdmulh v26.8H, v10.8H, v26.8H
    ldr  q1, [x0, #(16+4*32)]
    sqrdmulh v27.8H, v11.8H, v27.8H
    ldr  q4, [x0, #(16+1*32)]
    sqrdmulh v28.8H, v12.8H, v28.8H
    ldr  q2, [x0, #(16+2*32)]
    sqrdmulh v29.8H, v13.8H, v29.8H
    ldr  q5, [x0, #(16+5*32)]

    mul       v8.8H,  v8.8H, v16.8H
    mul       v9.8H,  v9.8H, v17.8H
    mul      v10.8H, v10.8H, v18.8H
    mul      v11.8H, v11.8H, v19.8H
    mul      v12.8H, v12.8H, v20.8H
    mul      v13.8H, v13.8H, v21.8H

    mls       v8.8H, v24.8H,  v6.H[1]
    str  q8, [x0, #0*32]
    mls       v9.8H, v25.8H,  v6.H[1]
    str  q9, [x0, #4*32]
    mls      v10.8H, v26.8H,  v6.H[1]
    str q10, [x0, #2*32]
    mls      v11.8H, v27.8H,  v6.H[1]
    str q11, [x0, #3*32]
    mls      v12.8H, v28.8H,  v6.H[1]
    str q12, [x0, #1*32]
    mls      v13.8H, v29.8H,  v6.H[1]
    str q13, [x0, #5*32]

    add x0, x0, #16
    add x1, x1, #32
    add x2, x2, #32

    add       v8.8H,  v0.8H,  v3.8H
    sub      v11.8H,  v0.8H,  v3.8H
    add       v9.8H,  v1.8H,  v4.8H
    sub      v12.8H,  v1.8H,  v4.8H
    add      v10.8H,  v2.8H,  v5.8H
    sub      v13.8H,  v2.8H,  v5.8H

    butterfly3_l4l1 \
             v8,  v9, v10, v6.H[2], v6.H[3], v6.H[1], v16, v17, v18, v19, \
             x2, \
            q24, q25, q26, q27, \
            #(16+0*64), #(16+4*64), #(16+2*64), #(16+3*64), \
             x2, \
            q28, \
            (16+1*64)

    butterfly3_l4l1 \
            v11, v12, v13, v6.H[2], v6.H[3], v6.H[1], v20, v21, v22, v23, \
             x2, \
            q16, q17, q18, q19, \
            #0*64, #4*64, #2*64, #3*64, \
             x2, \
            q29, \
            #(16+5*64)

    ldr q20, [x2, #1*64]
    ldr q21, [x2, #5*64]

    sub counter, counter, #1
    cbnz counter, __asm_3x2_post_twist_loop

    sqrdmulh v24.8H,  v8.8H, v24.8H
    sqrdmulh v25.8H,  v9.8H, v25.8H
    sqrdmulh v26.8H, v10.8H, v26.8H
    sqrdmulh v27.8H, v11.8H, v27.8H
    sqrdmulh v28.8H, v12.8H, v28.8H
    sqrdmulh v29.8H, v13.8H, v29.8H

    mul       v8.8H,  v8.8H, v16.8H
    mul       v9.8H,  v9.8H, v17.8H
    mul      v10.8H, v10.8H, v18.8H
    mul      v11.8H, v11.8H, v19.8H
    mul      v12.8H, v12.8H, v20.8H
    mul      v13.8H, v13.8H, v21.8H

    mls       v8.8H, v24.8H,  v6.H[1]
    mls       v9.8H, v25.8H,  v6.H[1]
    mls      v10.8H, v26.8H,  v6.H[1]
    mls      v11.8H, v27.8H,  v6.H[1]
    mls      v12.8H, v28.8H,  v6.H[1]
    mls      v13.8H, v29.8H,  v6.H[1]

    str  q8, [x0, #0*32]
    str  q9, [x0, #4*32]
    str q10, [x0, #2*32]
    str q11, [x0, #3*32]
    str q12, [x0, #1*32]
    str q13, [x0, #5*32]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr




