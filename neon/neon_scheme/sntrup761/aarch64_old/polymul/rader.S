
.align 6
.global __asm_rader_17_pre_tbl
.global ___asm_rader_17_pre_tbl
__asm_rader_17_pre_tbl:
___asm_rader_17_pre_tbl:

    mov w12, #4591
    mov w13, #29235
    mov v1.H[0], w12
    mov v1.H[1], w13

    .equ jump, 16

    // *head_ptr = head = src[in_table[0]];
    ldrh  w9, [x3, #0*2]
    ldr  q0, [x2, x9, lsl #4]
    str  q0, [x0]

    // (1, 5, 9, 13) <- (3, 5, 14, 12)
    ldrh w10, [x3, #3*2]
    ldrh w11, [x3, #5*2]
    ldrh w12, [x3, #14*2]
    ldrh w13, [x3, #12*2]
    ldr q16, [x2, x10, lsl #4]
    ldr q17, [x2, x11, lsl #4]
    ldr q18, [x2, x12, lsl #4]
    ldr q19, [x2, x13, lsl #4]

    add  v4.8H, v16.8H, v18.8H
    sub  v6.8H, v16.8H, v18.8H
    add  v5.8H, v17.8H, v19.8H
    sub  v7.8H, v17.8H, v19.8H
    str  q6, [x1, #9*jump]
    str  q7, [x1, #13*jump]
    add  v2.8H,  v4.8H,  v5.8H
    sub  v3.8H,  v4.8H,  v5.8H
    str  q2, [x1, #1*jump]
    str  q3, [x1, #5*jump]

    add  v0.8H,  v0.8H,  v2.8H

    // (2, 6, 10, 14) <- (9, 15, 8, 2)
    ldrh w10, [x3, #9*2]
    ldrh w11, [x3, #15*2]
    ldrh w12, [x3, #8*2]
    ldrh w13, [x3, #2*2]
    ldr q16, [x2, x10, lsl #4]
    ldr q17, [x2, x11, lsl #4]
    ldr q18, [x2, x12, lsl #4]
    ldr q19, [x2, x13, lsl #4]

    add  v4.8H, v16.8H, v18.8H
    sub  v6.8H, v16.8H, v18.8H
    add  v5.8H, v17.8H, v19.8H
    sub  v7.8H, v17.8H, v19.8H
    str  q6, [x1, #10*jump]
    str  q7, [x1, #14*jump]
    add  v2.8H,  v4.8H,  v5.8H
    sub  v3.8H,  v4.8H,  v5.8H
    str  q2, [x1, #2*jump]
    str  q3, [x1, #6*jump]

    add  v0.8H,  v0.8H,  v2.8H
    sqdmulh  v4.8H,  v0.8H,  v1.H[1]
    srshr    v4.8H,  v4.8H, #12
    mls      v0.8H,  v4.8H,  v1.H[0]

    // (3, 7, 11, 15) <- (10, 11, 7, 6)
    ldrh w10, [x3, #10*2]
    ldrh w11, [x3, #11*2]
    ldrh w12, [x3, #7*2]
    ldrh w13, [x3, #6*2]
    ldr q16, [x2, x10, lsl #4]
    ldr q17, [x2, x11, lsl #4]
    ldr q18, [x2, x12, lsl #4]
    ldr q19, [x2, x13, lsl #4]

    add  v4.8H, v16.8H, v18.8H
    sub  v6.8H, v16.8H, v18.8H
    add  v5.8H, v17.8H, v19.8H
    sub  v7.8H, v17.8H, v19.8H
    str  q6, [x1, #11*jump]
    str  q7, [x1, #15*jump]
    add  v2.8H,  v4.8H,  v5.8H
    sub  v3.8H,  v4.8H,  v5.8H
    str  q2, [x1, #3*jump]
    str  q3, [x1, #7*jump]

    add  v0.8H,  v0.8H,  v2.8H

    // (4, 8, 12, 16) <- (13, 16, 4, 1)
    ldrh w10, [x3, #13*2]
    ldrh w11, [x3, #16*2]
    ldrh w12, [x3, #4*2]
    ldrh w13, [x3, #1*2]
    ldr q16, [x2, x10, lsl #4]
    ldr q17, [x2, x11, lsl #4]
    ldr q18, [x2, x12, lsl #4]
    ldr q19, [x2, x13, lsl #4]

    add  v4.8H, v16.8H, v18.8H
    sub  v6.8H, v16.8H, v18.8H
    add  v5.8H, v17.8H, v19.8H
    sub  v7.8H, v17.8H, v19.8H
    str  q6, [x1, #12*jump]
    str  q7, [x1, #16*jump]
    add  v2.8H,  v4.8H,  v5.8H
    sub  v3.8H,  v4.8H,  v5.8H
    str  q2, [x1, #4*jump]
    str  q3, [x1, #8*jump]

    add  v0.8H,  v0.8H,  v2.8H
    sqdmulh  v4.8H,  v0.8H,  v1.H[1]
    srshr    v4.8H,  v4.8H, #12
    mls      v0.8H,  v4.8H,  v1.H[0]
    str  q0, [x1]


    br lr



.align 6
.global __asm_rader_17_post_tbl
.global ___asm_rader_17_post_tbl
__asm_rader_17_post_tbl:
___asm_rader_17_post_tbl:

    .equ jump, 16

    ldr  q0, [x1]

    ldrh  w9, [x3, #0*2]
    ldr  q2, [x2, #0*jump]
    str  q2, [x0, x9, lsl #4]

    // (6, 7, 11, 10) <- (1, 5, 9, 13)
    ldr q16, [x2, #1*jump]
    ldr q17, [x2, #5*jump]
    ldr q18, [x2, #9*jump]
    ldr q19, [x2, #13*jump]
    ldrh w10, [x3, #7*2]
    ldrh w11, [x3, #10*2]
    ldrh w12, [x3, #6*2]
    ldrh w13, [x3, #11*2]

    add  v4.8H, v16.8H,  v0.8H
    sub  v5.8H,  v4.8H, v17.8H
    add  v4.8H,  v4.8H, v17.8H
    add  v6.8H,  v4.8H, v18.8H
    sub  v7.8H,  v4.8H, v18.8H
    str  q6, [x0, x12, lsl #4]
    str  q7, [x0, x13, lsl #4]
    add  v2.8H,  v5.8H, v19.8H
    sub  v3.8H,  v5.8H, v19.8H
    str  q2, [x0, x10, lsl #4]
    str  q3, [x0, x11, lsl #4]

    // (2, 8, 15, 9) <- (2, 6, 10, 14)
    ldr q16, [x2, #2*jump]
    ldr q17, [x2, #6*jump]
    ldr q18, [x2, #10*jump]
    ldr q19, [x2, #14*jump]
    ldrh w10, [x3, #8*2]
    ldrh w11, [x3, #9*2]
    ldrh w12, [x3, #2*2]
    ldrh w13, [x3, #15*2]

    add  v4.8H, v16.8H,  v0.8H
    sub  v5.8H,  v4.8H, v17.8H
    add  v4.8H,  v4.8H, v17.8H
    add  v6.8H,  v4.8H, v18.8H
    sub  v7.8H,  v4.8H, v18.8H
    str  q6, [x0, x12, lsl #4]
    str  q7, [x0, x13, lsl #4]
    add  v2.8H,  v5.8H, v19.8H
    sub  v3.8H,  v5.8H, v19.8H
    str  q2, [x0, x10, lsl #4]
    str  q3, [x0, x11, lsl #4]

    // (12, 14, 5, 3) <- (3, 7, 11, 15)
    ldr q16, [x2, #3*jump]
    ldr q17, [x2, #7*jump]
    ldr q18, [x2, #11*jump]
    ldr q19, [x2, #15*jump]
    ldrh w10, [x3, #14*2]
    ldrh w11, [x3, #3*2]
    ldrh w12, [x3, #12*2]
    ldrh w13, [x3, #5*2]

    add  v4.8H, v16.8H,  v0.8H
    sub  v5.8H,  v4.8H, v17.8H
    add  v4.8H,  v4.8H, v17.8H
    add  v6.8H,  v4.8H, v18.8H
    sub  v7.8H,  v4.8H, v18.8H
    str  q6, [x0, x12, lsl #4]
    str  q7, [x0, x13, lsl #4]
    add  v2.8H,  v5.8H, v19.8H
    sub  v3.8H,  v5.8H, v19.8H
    str  q2, [x0, x10, lsl #4]
    str  q3, [x0, x11, lsl #4]

    // (4, 16, 13, 1) <- (4, 8, 12, 16)
    ldr q16, [x2, #4*jump]
    ldr q17, [x2, #8*jump]
    ldr q18, [x2, #12*jump]
    ldr q19, [x2, #16*jump]
    ldrh w10, [x3, #16*2]
    ldrh w11, [x3, #1*2]
    ldrh w12, [x3, #4*2]
    ldrh w13, [x3, #13*2]

    add  v4.8H, v16.8H,  v0.8H
    sub  v5.8H,  v4.8H, v17.8H
    add  v4.8H,  v4.8H, v17.8H
    add  v6.8H,  v4.8H, v18.8H
    sub  v7.8H,  v4.8H, v18.8H
    str  q6, [x0, x12, lsl #4]
    str  q7, [x0, x13, lsl #4]
    add  v2.8H,  v5.8H, v19.8H
    sub  v3.8H,  v5.8H, v19.8H
    str  q2, [x0, x10, lsl #4]
    str  q3, [x0, x11, lsl #4]

    br lr

.align 6
.global __asm_rader_17_post
.global ___asm_rader_17_post
__asm_rader_17_post:
___asm_rader_17_post:

    .equ jump, 16

    ldr  q0, [x1]

    ldr  q2, [x2, #0*jump]
    str q2, [x0]

    // (6, 7, 11, 10) <- (1, 5, 9, 13)
    ldr q16, [x2, #1*jump]
    ldr q17, [x2, #5*jump]
    ldr q18, [x2, #9*jump]
    ldr q19, [x2, #13*jump]

    add  v4.8H, v16.8H,  v0.8H
    sub  v5.8H,  v4.8H, v17.8H
    add  v4.8H,  v4.8H, v17.8H
    add  v6.8H,  v4.8H, v18.8H
    sub  v7.8H,  v4.8H, v18.8H
    str q6, [x0, #6*192]
    str q7, [x0, #11*192]
    add  v2.8H,  v5.8H, v19.8H
    sub  v3.8H,  v5.8H, v19.8H
    str q2, [x0, #7*192]
    str q3, [x0, #10*192]

    // (2, 8, 15, 9) <- (2, 6, 10, 14)
    ldr q16, [x2, #2*jump]
    ldr q17, [x2, #6*jump]
    ldr q18, [x2, #10*jump]
    ldr q19, [x2, #14*jump]

    add  v4.8H, v16.8H,  v0.8H
    sub  v5.8H,  v4.8H, v17.8H
    add  v4.8H,  v4.8H, v17.8H
    add  v6.8H,  v4.8H, v18.8H
    sub  v7.8H,  v4.8H, v18.8H
    str q6, [x0, #2*192]
    str q7, [x0, #15*192]
    add  v2.8H,  v5.8H, v19.8H
    sub  v3.8H,  v5.8H, v19.8H
    str q2, [x0, #8*192]
    str q3, [x0, #9*192]

    // (12, 14, 5, 3) <- (3, 7, 11, 15)
    ldr q16, [x2, #3*jump]
    ldr q17, [x2, #7*jump]
    ldr q18, [x2, #11*jump]
    ldr q19, [x2, #15*jump]

    add  v4.8H, v16.8H,  v0.8H
    sub  v5.8H,  v4.8H, v17.8H
    add  v4.8H,  v4.8H, v17.8H
    add  v6.8H,  v4.8H, v18.8H
    sub  v7.8H,  v4.8H, v18.8H
    str q6, [x0, #12*192]
    str q7, [x0, #5*192]
    add  v2.8H,  v5.8H, v19.8H
    sub  v3.8H,  v5.8H, v19.8H
    str q2, [x0, #14*192]
    str q3, [x0, #3*192]

    // (4, 16, 13, 1) <- (4, 8, 12, 16)
    ldr q16, [x2, #4*jump]
    ldr q17, [x2, #8*jump]
    ldr q18, [x2, #12*jump]
    ldr q19, [x2, #16*jump]

    add  v4.8H, v16.8H,  v0.8H
    sub  v5.8H,  v4.8H, v17.8H
    add  v4.8H,  v4.8H, v17.8H
    add  v6.8H,  v4.8H, v18.8H
    sub  v7.8H,  v4.8H, v18.8H
    str q6, [x0, #4*192]
    str q7, [x0, #13*192]
    add  v2.8H,  v5.8H, v19.8H
    sub  v3.8H,  v5.8H, v19.8H
    str q2, [x0, #16*192]
    str q3, [x0, #1*192]

    br lr

.align 6
.global __asm_rader_17_mix_pre
.global ___asm_rader_17_mix_pre
__asm_rader_17_mix_pre:
___asm_rader_17_mix_pre:

    sub sp, sp, #(4*16)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    sub sp, sp, #(17*16)

    mov w12, #4591
    mov w13, #29235
    mov w14, #-15631
    mov v1.H[0], w12
    mov v1.H[1], w13
    mov v1.H[2], w14

    // *head_ptr = head = src[in_table[0]];
    ldrh  w9, [x2, #0*2]
    ldr  q0, [x1, x9, lsl #4]
    str  q0, [sp]

    // (1, 5, 9, 13) <- (3, 5, 14, 12)
    ldrh w10, [x2, #3*2]
    ldrh w11, [x2, #5*2]
    ldrh w12, [x2, #14*2]
    ldrh w13, [x2, #12*2]
    ldr q16, [x1, x10, lsl #4]
    ldr q17, [x1, x11, lsl #4]
    ldr q18, [x1, x12, lsl #4]
    ldr q19, [x1, x13, lsl #4]

    // (2, 6, 10, 14) <- (9, 15, 8, 2)

    ldrh w10, [x2, #9*2]
    add  v20.8H, v16.8H, v18.8H
    sub   v8.8H, v16.8H, v18.8H
    ldrh w11, [x2, #15*2]
    add  v21.8H, v17.8H, v19.8H
    sub  v12.8H, v17.8H, v19.8H
    ldrh w12, [x2, #8*2]
    add   v4.8H, v20.8H, v21.8H
    sub  v28.8H, v20.8H, v21.8H
    ldrh w13, [x2, #2*2]

    add  v0.8H,  v0.8H,  v4.8H

    ldr q16, [x1, x10, lsl #4]
    ldr q17, [x1, x11, lsl #4]
    ldr q18, [x1, x12, lsl #4]
    ldr q19, [x1, x13, lsl #4]

    ldrh w10, [x2, #10*2]
    add  v20.8H, v16.8H, v18.8H
    sub   v9.8H, v16.8H, v18.8H
    ldrh w11, [x2, #11*2]
    add  v21.8H, v17.8H, v19.8H
    sub  v13.8H, v17.8H, v19.8H
    ldrh w12, [x2, #7*2]
    add   v5.8H, v20.8H, v21.8H
    sub  v29.8H, v20.8H, v21.8H
    ldrh w13, [x2, #6*2]

    add  v0.8H,  v0.8H,  v5.8H
    sqdmulh v22.8H,  v0.8H,  v1.H[1]
    ldr q16, [x1, x10, lsl #4]
    srshr   v22.8H, v22.8H, #12
    mls      v0.8H, v22.8H,  v1.H[0]

    // (3, 7, 11, 15) <- (10, 11, 7, 6)
    ldr q17, [x1, x11, lsl #4]
    ldr q18, [x1, x12, lsl #4]
    ldr q19, [x1, x13, lsl #4]

    ldrh w10, [x2, #13*2]
    add  v20.8H, v16.8H, v18.8H
    sub  v10.8H, v16.8H, v18.8H
    ldrh w11, [x2, #16*2]
    add  v21.8H, v17.8H, v19.8H
    sub  v14.8H, v17.8H, v19.8H
    ldrh w12, [x2, #4*2]
    add   v6.8H, v20.8H, v21.8H
    sub  v30.8H, v20.8H, v21.8H
    ldrh w13, [x2, #1*2]

    add  v0.8H,  v0.8H,  v6.8H

    // (4, 8, 12, 16) <- (13, 16, 4, 1)
    ldr q16, [x1, x10, lsl #4]
    ldr q17, [x1, x11, lsl #4]
    ldr q18, [x1, x12, lsl #4]
    ldr q19, [x1, x13, lsl #4]

    add  v20.8H, v16.8H, v18.8H
    sub  v11.8H, v16.8H, v18.8H
    ldr q16, [x3, #9*16]
    add  v21.8H, v17.8H, v19.8H
    sub  v15.8H, v17.8H, v19.8H
    ldr q23, [x3, #16*16]
    add   v7.8H, v20.8H, v21.8H
    sub  v31.8H, v20.8H, v21.8H

    ldr q21, [x3, #14*16]
    add  v0.8H,  v0.8H,  v7.8H
    sqdmulh v22.8H,  v0.8H,  v1.H[1]
    ldr q20, [x3, #13*16]
    srshr   v22.8H, v22.8H, #12
    mls      v0.8H, v22.8H,  v1.H[0]
    ldr q22, [x3, #15*16]
    str  q0, [x0]

//

    ldr q0, [sp]

    // 0
    ldr q19, [x3, #12*16]
    smull  v24.4S,  v8.4H, v16.4H
    ldr q18, [x3, #11*16]
    smull2 v25.4S,  v8.8H, v16.8H
    ldr q17, [x3, #10*16]
    smlsl  v24.4S,  v9.4H, v23.4H
    smlsl2 v25.4S,  v9.8H, v23.8H
    smlsl  v24.4S, v10.4H, v22.4H
    smlsl2 v25.4S, v10.8H, v22.8H
    smlsl  v24.4S, v11.4H, v21.4H
    smlsl2 v25.4S, v11.8H, v21.8H
    smlsl  v24.4S, v12.4H, v20.4H
    smlsl2 v25.4S, v12.8H, v20.8H
    smlsl  v24.4S, v13.4H, v19.4H
    smlsl2 v25.4S, v13.8H, v19.8H
    smlsl  v24.4S, v14.4H, v18.4H
    smlsl2 v25.4S, v14.8H, v18.8H
    smlsl  v24.4S, v15.4H, v17.4H
    smlsl2 v25.4S, v15.8H, v17.8H

    uzp1   v26.8H, v24.8H, v25.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal  v24.4S, v27.4H,  v1.H[0]
    smlal2 v25.4S, v27.8H,  v1.H[0]
    uzp2    v2.8H, v24.8H, v25.8H

    str     q2, [sp, #9*16]

    // 1
    smull  v24.4S,  v8.4H, v17.4H
    smull2 v25.4S,  v8.8H, v17.8H
    smlal  v24.4S,  v9.4H, v16.4H
    smlal2 v25.4S,  v9.8H, v16.8H
    smlsl  v24.4S, v10.4H, v23.4H
    smlsl2 v25.4S, v10.8H, v23.8H
    smlsl  v24.4S, v11.4H, v22.4H
    smlsl2 v25.4S, v11.8H, v22.8H
    smlsl  v24.4S, v12.4H, v21.4H
    smlsl2 v25.4S, v12.8H, v21.8H
    smlsl  v24.4S, v13.4H, v20.4H
    smlsl2 v25.4S, v13.8H, v20.8H
    smlsl  v24.4S, v14.4H, v19.4H
    smlsl2 v25.4S, v14.8H, v19.8H
    smlsl  v24.4S, v15.4H, v18.4H
    smlsl2 v25.4S, v15.8H, v18.8H

    uzp1   v26.8H, v24.8H, v25.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal  v24.4S, v27.4H,  v1.H[0]
    smlal2 v25.4S, v27.8H,  v1.H[0]
    uzp2    v2.8H, v24.8H, v25.8H

    str     q2, [sp, #10*16]

    // 2
    smull  v24.4S,  v8.4H, v18.4H
    smull2 v25.4S,  v8.8H, v18.8H
    smlal  v24.4S,  v9.4H, v17.4H
    smlal2 v25.4S,  v9.8H, v17.8H
    smlal  v24.4S, v10.4H, v16.4H
    smlal2 v25.4S, v10.8H, v16.8H
    smlsl  v24.4S, v11.4H, v23.4H
    smlsl2 v25.4S, v11.8H, v23.8H
    smlsl  v24.4S, v12.4H, v22.4H
    smlsl2 v25.4S, v12.8H, v22.8H
    smlsl  v24.4S, v13.4H, v21.4H
    smlsl2 v25.4S, v13.8H, v21.8H
    smlsl  v24.4S, v14.4H, v20.4H
    smlsl2 v25.4S, v14.8H, v20.8H
    smlsl  v24.4S, v15.4H, v19.4H
    smlsl2 v25.4S, v15.8H, v19.8H

    uzp1   v26.8H, v24.8H, v25.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal  v24.4S, v27.4H,  v1.H[0]
    smlal2 v25.4S, v27.8H,  v1.H[0]
    uzp2    v2.8H, v24.8H, v25.8H

    str     q2, [sp, #11*16]

    // 3
    smull  v24.4S,  v8.4H, v19.4H
    smull2 v25.4S,  v8.8H, v19.8H
    smlal  v24.4S,  v9.4H, v18.4H
    smlal2 v25.4S,  v9.8H, v18.8H
    smlal  v24.4S, v10.4H, v17.4H
    smlal2 v25.4S, v10.8H, v17.8H
    smlal  v24.4S, v11.4H, v16.4H
    smlal2 v25.4S, v11.8H, v16.8H
    smlsl  v24.4S, v12.4H, v23.4H
    smlsl2 v25.4S, v12.8H, v23.8H
    smlsl  v24.4S, v13.4H, v22.4H
    smlsl2 v25.4S, v13.8H, v22.8H
    smlsl  v24.4S, v14.4H, v21.4H
    smlsl2 v25.4S, v14.8H, v21.8H
    smlsl  v24.4S, v15.4H, v20.4H
    smlsl2 v25.4S, v15.8H, v20.8H

    uzp1   v26.8H, v24.8H, v25.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal  v24.4S, v27.4H,  v1.H[0]
    smlal2 v25.4S, v27.8H,  v1.H[0]
    uzp2    v2.8H, v24.8H, v25.8H

    str     q2, [sp, #12*16]

    // 4
    smull  v24.4S,  v8.4H, v20.4H
    smull2 v25.4S,  v8.8H, v20.8H
    smlal  v24.4S,  v9.4H, v19.4H
    smlal2 v25.4S,  v9.8H, v19.8H
    smlal  v24.4S, v10.4H, v18.4H
    smlal2 v25.4S, v10.8H, v18.8H
    smlal  v24.4S, v11.4H, v17.4H
    smlal2 v25.4S, v11.8H, v17.8H
    smlal  v24.4S, v12.4H, v16.4H
    smlal2 v25.4S, v12.8H, v16.8H
    smlsl  v24.4S, v13.4H, v23.4H
    smlsl2 v25.4S, v13.8H, v23.8H
    smlsl  v24.4S, v14.4H, v22.4H
    smlsl2 v25.4S, v14.8H, v22.8H
    smlsl  v24.4S, v15.4H, v21.4H
    smlsl2 v25.4S, v15.8H, v21.8H

    uzp1   v26.8H, v24.8H, v25.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal  v24.4S, v27.4H,  v1.H[0]
    smlal2 v25.4S, v27.8H,  v1.H[0]
    uzp2    v2.8H, v24.8H, v25.8H

    str     q2, [sp, #13*16]

    // 5
    smull  v24.4S,  v8.4H, v21.4H
    smull2 v25.4S,  v8.8H, v21.8H
    smlal  v24.4S,  v9.4H, v20.4H
    smlal2 v25.4S,  v9.8H, v20.8H
    smlal  v24.4S, v10.4H, v19.4H
    smlal2 v25.4S, v10.8H, v19.8H
    smlal  v24.4S, v11.4H, v18.4H
    smlal2 v25.4S, v11.8H, v18.8H
    smlal  v24.4S, v12.4H, v17.4H
    smlal2 v25.4S, v12.8H, v17.8H
    smlal  v24.4S, v13.4H, v16.4H
    smlal2 v25.4S, v13.8H, v16.8H
    smlsl  v24.4S, v14.4H, v23.4H
    smlsl2 v25.4S, v14.8H, v23.8H
    smlsl  v24.4S, v15.4H, v22.4H
    smlsl2 v25.4S, v15.8H, v22.8H

    uzp1   v26.8H, v24.8H, v25.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal  v24.4S, v27.4H,  v1.H[0]
    smlal2 v25.4S, v27.8H,  v1.H[0]
    uzp2    v2.8H, v24.8H, v25.8H

    str     q2, [sp, #14*16]

    // 6
    smull  v24.4S,  v8.4H, v22.4H
    smull2 v25.4S,  v8.8H, v22.8H
    smlal  v24.4S,  v9.4H, v21.4H
    smlal2 v25.4S,  v9.8H, v21.8H
    smlal  v24.4S, v10.4H, v20.4H
    smlal2 v25.4S, v10.8H, v20.8H
    smlal  v24.4S, v11.4H, v19.4H
    smlal2 v25.4S, v11.8H, v19.8H
    smlal  v24.4S, v12.4H, v18.4H
    smlal2 v25.4S, v12.8H, v18.8H
    smlal  v24.4S, v13.4H, v17.4H
    smlal2 v25.4S, v13.8H, v17.8H
    smlal  v24.4S, v14.4H, v16.4H
    smlal2 v25.4S, v14.8H, v16.8H
    smlsl  v24.4S, v15.4H, v23.4H
    smlsl2 v25.4S, v15.8H, v23.8H

    uzp1   v26.8H, v24.8H, v25.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal  v24.4S, v27.4H,  v1.H[0]
    smlal2 v25.4S, v27.8H,  v1.H[0]
    uzp2    v2.8H, v24.8H, v25.8H

    str     q2, [sp, #15*16]

    // 7
    smull  v24.4S,  v8.4H, v23.4H
    smull2 v25.4S,  v8.8H, v23.8H
    ldr q23, [x3, #4*16]
    smlal  v24.4S,  v9.4H, v22.4H
    smlal2 v25.4S,  v9.8H, v22.8H
    ldr q22, [x3, #3*16]
    smlal  v24.4S, v10.4H, v21.4H
    smlal2 v25.4S, v10.8H, v21.8H
    ldr q21, [x3, #2*16]
    smlal  v24.4S, v11.4H, v20.4H
    smlal2 v25.4S, v11.8H, v20.8H
    ldr q20, [x3, #1*16]
    smlal  v24.4S, v12.4H, v19.4H
    smlal2 v25.4S, v12.8H, v19.8H
    ldr q12, [x3, #5*16]
    smlal  v24.4S, v13.4H, v18.4H
    smlal2 v25.4S, v13.8H, v18.8H
    ldr q13, [x3, #6*16]
    smlal  v24.4S, v14.4H, v17.4H
    smlal2 v25.4S, v14.8H, v17.8H
    ldr q14, [x3, #7*16]
    smlal  v24.4S, v15.4H, v16.4H
    smlal2 v25.4S, v15.8H, v16.8H

    ldr q15, [x3, #8*16]
    uzp1   v26.8H, v24.8H, v25.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal  v24.4S, v27.4H,  v1.H[0]
    smlal2 v25.4S, v27.8H,  v1.H[0]
    uzp2    v2.8H, v24.8H, v25.8H

    str     q2, [sp, #16*16]

//

    // 0
    smull  v24.4S,  v4.4H, v20.4H
    smull2 v25.4S,  v4.8H, v20.8H
    smlal  v24.4S,  v5.4H, v23.4H
    smlal2 v25.4S,  v5.8H, v23.8H
    smlal  v24.4S,  v6.4H, v22.4H
    smlal2 v25.4S,  v6.8H, v22.8H
    smlal  v24.4S,  v7.4H, v21.4H
    smlal2 v25.4S,  v7.8H, v21.8H

    smull   v8.4S, v28.4H, v12.4H
    uzp1   v26.8H, v24.8H, v25.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal  v24.4S, v27.4H,  v1.H[0]
    smlal2 v25.4S, v27.8H,  v1.H[0]
    uzp2   v16.8H, v24.8H, v25.8H
    smull2  v9.4S, v28.8H, v12.8H
    add    v16.8H, v16.8H,  v0.8H

    // 0
    ldr q18, [sp, #9*16]
    smlsl   v8.4S, v29.4H, v15.4H
    ldr q19, [sp, #13*16]
    smlsl2  v9.4S, v29.8H, v15.8H
    smlsl   v8.4S, v30.4H, v14.4H
    smlsl2  v9.4S, v30.8H, v14.8H
    smlsl   v8.4S, v31.4H, v13.4H
    smlsl2  v9.4S, v31.8H, v13.8H

    uzp1   v26.8H,  v8.8H,  v9.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal   v8.4S, v27.4H,  v1.H[0]
    smlal2  v9.4S, v27.8H,  v1.H[0]
    uzp2   v17.8H,  v8.8H,  v9.8H

    // 1
    smull  v24.4S,  v4.4H, v21.4H
    add     v2.8H, v16.8H, v17.8H
    smull2 v25.4S,  v4.8H, v21.8H
    sub     v3.8H, v16.8H, v17.8H

    smlal  v24.4S,  v5.4H, v20.4H
    add     v8.8H,  v2.8H, v18.8H
    smlal2 v25.4S,  v5.8H, v20.8H
    sub     v9.8H,  v2.8H, v18.8H
    smlal  v24.4S,  v6.4H, v23.4H
    add    v10.8H,  v3.8H, v19.8H
    smlal2 v25.4S,  v6.8H, v23.8H
    sub    v11.8H,  v3.8H, v19.8H

    str  q8, [x0, #6*192]
    smlal  v24.4S,  v7.4H, v22.4H
    str  q9, [x0, #11*192]
    smlal2 v25.4S,  v7.8H, v22.8H

    // 1
    smull   v8.4S, v28.4H, v13.4H
    uzp1   v26.8H, v24.8H, v25.8H
    str q10, [x0, #7*192]
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal  v24.4S, v27.4H,  v1.H[0]
    smlal2 v25.4S, v27.8H,  v1.H[0]
    uzp2   v16.8H, v24.8H, v25.8H
    str q11, [x0, #10*192]

    smull2  v9.4S, v28.8H, v13.8H
    add    v16.8H, v16.8H,  v0.8H

    ldr q18, [sp, #10*16]
    smlal   v8.4S, v29.4H, v12.4H
    ldr q19, [sp, #14*16]
    smlal2  v9.4S, v29.8H, v12.8H
    smlsl   v8.4S, v30.4H, v15.4H
    smlsl2  v9.4S, v30.8H, v15.8H
    smlsl   v8.4S, v31.4H, v14.4H
    smlsl2  v9.4S, v31.8H, v14.8H

    uzp1   v26.8H,  v8.8H,  v9.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal   v8.4S, v27.4H,  v1.H[0]
    smlal2  v9.4S, v27.8H,  v1.H[0]
    uzp2   v17.8H,  v8.8H,  v9.8H

    // 2
    smull  v24.4S,  v4.4H, v22.4H
    add     v2.8H, v16.8H, v17.8H
    smull2 v25.4S,  v4.8H, v22.8H
    sub     v3.8H, v16.8H, v17.8H

    smlal  v24.4S,  v5.4H, v21.4H
    add     v8.8H,  v2.8H, v18.8H
    smlal2 v25.4S,  v5.8H, v21.8H
    sub     v9.8H,  v2.8H, v18.8H
    smlal  v24.4S,  v6.4H, v20.4H
    add    v10.8H,  v3.8H, v19.8H
    smlal2 v25.4S,  v6.8H, v20.8H
    sub    v11.8H,  v3.8H, v19.8H

    str  q8, [x0, #2*192]
    smlal  v24.4S,  v7.4H, v23.4H
    str  q9, [x0, #15*192]
    smlal2 v25.4S,  v7.8H, v23.8H

    // 2
    smull   v8.4S, v28.4H, v14.4H
    uzp1   v26.8H, v24.8H, v25.8H
    str q10, [x0, #8*192]
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal  v24.4S, v27.4H,  v1.H[0]
    smlal2 v25.4S, v27.8H,  v1.H[0]
    uzp2   v16.8H, v24.8H, v25.8H
    str q11, [x0, #9*192]

    smull2  v9.4S, v28.8H, v14.8H
    add    v16.8H, v16.8H,  v0.8H

    ldr q18, [sp, #11*16]
    smlal   v8.4S, v29.4H, v13.4H
    ldr q19, [sp, #15*16]
    smlal2  v9.4S, v29.8H, v13.8H
    smlal   v8.4S, v30.4H, v12.4H
    smlal2  v9.4S, v30.8H, v12.8H
    smlsl   v8.4S, v31.4H, v15.4H
    smlsl2  v9.4S, v31.8H, v15.8H

    uzp1   v26.8H,  v8.8H,  v9.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal   v8.4S, v27.4H,  v1.H[0]
    smlal2  v9.4S, v27.8H,  v1.H[0]
    uzp2   v17.8H,  v8.8H,  v9.8H

    // 3
    smull  v24.4S,  v4.4H, v23.4H
    add     v2.8H, v16.8H, v17.8H
    smull2 v25.4S,  v4.8H, v23.8H
    sub     v3.8H, v16.8H, v17.8H

    smlal  v24.4S,  v5.4H, v22.4H
    add     v8.8H,  v2.8H, v18.8H
    smlal2 v25.4S,  v5.8H, v22.8H
    sub     v9.8H,  v2.8H, v18.8H
    smlal  v24.4S,  v6.4H, v21.4H
    add    v10.8H,  v3.8H, v19.8H
    smlal2 v25.4S,  v6.8H, v21.8H
    sub    v11.8H,  v3.8H, v19.8H

    str  q8, [x0, #12*192]
    smlal  v24.4S,  v7.4H, v20.4H
    str  q9, [x0, #5*192]
    smlal2 v25.4S,  v7.8H, v20.8H

    // 3
    smull   v8.4S, v28.4H, v15.4H
    uzp1   v26.8H, v24.8H, v25.8H
    str q10, [x0, #14*192]
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal  v24.4S, v27.4H,  v1.H[0]
    smlal2 v25.4S, v27.8H,  v1.H[0]
    uzp2   v16.8H, v24.8H, v25.8H
    str q11, [x0, #3*192]

    smull2  v9.4S, v28.8H, v15.8H
    add    v16.8H, v16.8H,  v0.8H

    ldr q18, [sp, #12*16]
    smlal   v8.4S, v29.4H, v14.4H
    ldr q19, [sp, #16*16]
    smlal2  v9.4S, v29.8H, v14.8H
    smlal   v8.4S, v30.4H, v13.4H
    smlal2  v9.4S, v30.8H, v13.8H
    smlal   v8.4S, v31.4H, v12.4H
    smlal2  v9.4S, v31.8H, v12.8H

    add sp, sp, #(17*16)

    ldr d12, [sp, #4*8]
    uzp1   v26.8H,  v8.8H,  v9.8H
    mul    v27.8H, v26.8H,  v1.H[2]
    smlal   v8.4S, v27.4H,  v1.H[0]
    smlal2  v9.4S, v27.8H,  v1.H[0]
    uzp2   v17.8H,  v8.8H,  v9.8H


    ldr d13, [sp, #5*8]
    add     v2.8H, v16.8H, v17.8H
    sub     v3.8H, v16.8H, v17.8H


    ldr d14, [sp, #6*8]
    add     v8.8H,  v2.8H, v18.8H
    sub     v9.8H,  v2.8H, v18.8H
    ldr d15, [sp, #7*8]
    add    v10.8H,  v3.8H, v19.8H
    sub    v11.8H,  v3.8H, v19.8H

    str  q8, [x0, #4*192]
    ldr  d8, [sp, #0*8]
    str  q9, [x0, #13*192]
    ldr  d9, [sp, #1*8]
    str q10, [x0, #16*192]
    ldr d10, [sp, #2*8]
    str q11, [x0, #1*192]
    ldr d11, [sp, #3*8]

//

    add sp, sp, #(4*16)


    br lr

.align 6
.global __asm_rader_17_mix_post
.global ___asm_rader_17_mix_post
__asm_rader_17_mix_post:
___asm_rader_17_mix_post:

    sub sp, sp, #(4*16)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    sub sp, sp, #(17*16)

    mov w12, #4591
    mov w13, #29235
    mov w14, #-15631
    mov w10, #-849
    mov w11, #-6060
    mov v1.H[0], w12
    mov v1.H[1], w13
    mov v1.H[2], w14
    mov v1.H[4], w10
    mov v1.H[5], w11


    // *head_ptr = head = src[in_table[0]];
    ldr  q0, [x1]

    // (1, 5, 9, 13) <- (3, 5, 14, 12)
    ldr q16, [x1, #3*192]
    ldr q17, [x1, #5*192]
    ldr q18, [x1, #14*192]
    ldr q19, [x1, #12*192]

    add v24.8H, v16.8H, v18.8H
    sub  v8.8H, v16.8H, v18.8H
    // (2, 6, 10, 14) <- (9, 15, 8, 2)
    ldr q16, [x1, #9*192]
    add v25.8H, v17.8H, v19.8H
    sub v12.8H, v17.8H, v19.8H
    ldr q18, [x1, #8*192]
    add  v4.8H, v24.8H, v25.8H
    sub v28.8H, v24.8H, v25.8H
    ldr q17, [x1, #15*192]

    add  v3.8H,  v0.8H,  v4.8H

    ldr q19, [x1, #2*192]

    add v24.8H, v16.8H, v18.8H
    sub  v9.8H, v16.8H, v18.8H
    // (3, 7, 11, 15) <- (10, 11, 7, 6)
    ldr q16, [x1, #10*192]
    add v25.8H, v17.8H, v19.8H
    sub v13.8H, v17.8H, v19.8H
    ldr q18, [x1, #7*192]
    add  v5.8H, v24.8H, v25.8H
    sub v29.8H, v24.8H, v25.8H
    ldr q17, [x1, #11*192]

    add  v3.8H,  v3.8H,  v5.8H
    sqdmulh  v2.8H,  v3.8H,  v1.H[1]
    ldr q19, [x1, #6*192]
    srshr    v2.8H,  v2.8H, #12
    mls      v3.8H,  v2.8H,  v1.H[0]


    add v24.8H, v16.8H, v18.8H
    sub v10.8H, v16.8H, v18.8H
    // (4, 8, 12, 16) <- (13, 16, 4, 1)
    ldr q16, [x1, #13*192]
    add v25.8H, v17.8H, v19.8H
    sub v14.8H, v17.8H, v19.8H
    ldr q18, [x1, #4*192]
    add  v6.8H, v24.8H, v25.8H
    sub v30.8H, v24.8H, v25.8H
    ldr q17, [x1, #16*192]

    add  v3.8H,  v3.8H,  v6.8H

    ldr q19, [x1, #1*192]

    add v24.8H, v16.8H, v18.8H
    sub v11.8H, v16.8H, v18.8H
    ldr q16, [x3, #9*16]
    add v25.8H, v17.8H, v19.8H
    sub v15.8H, v17.8H, v19.8H
    ldr q18, [x3, #11*16]
    add  v7.8H, v24.8H, v25.8H
    sub v31.8H, v24.8H, v25.8H
    ldr q17, [x3, #10*16]

    add  v3.8H,  v3.8H,  v7.8H
    ldr q19, [x3, #12*16]
    sqdmulh  v2.8H,  v3.8H,  v1.H[1]
    srshr    v2.8H,  v2.8H, #12
    ldr q20, [x3, #13*16]
    mls      v3.8H,  v2.8H,  v1.H[0]
    ldr q21, [x3, #14*16]

    sqrdmulh  v2.8H,  v3.8H,  v1.H[5]
    ldrh  w9, [x2, #0*2]
    mul       v3.8H,  v3.8H,  v1.H[4]
    ldr q22, [x3, #15*16]
    mls       v3.8H,  v2.8H,  v1.H[0]
    ldr q23, [x3, #16*16]

    str  q3, [x0, x9, lsl #4]

//


    // 0
    smull  v24.4S,  v8.4H, v16.4H
    smull2 v25.4S,  v8.8H, v16.8H
    smlsl  v24.4S,  v9.4H, v23.4H
    smlsl2 v25.4S,  v9.8H, v23.8H
    smlsl  v24.4S, v10.4H, v22.4H
    smlsl2 v25.4S, v10.8H, v22.8H
    smlsl  v24.4S, v11.4H, v21.4H
    smlsl2 v25.4S, v11.8H, v21.8H
    smlsl  v24.4S, v12.4H, v20.4H
    smlsl2 v25.4S, v12.8H, v20.8H
    smlsl  v24.4S, v13.4H, v19.4H
    smlsl2 v25.4S, v13.8H, v19.8H
    smlsl  v24.4S, v14.4H, v18.4H
    smlsl2 v25.4S, v14.8H, v18.8H
    smlsl  v24.4S, v15.4H, v17.4H
    smlsl2 v25.4S, v15.8H, v17.8H

    uzp1    v2.8H, v24.8H, v25.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v24.4S,  v3.4H,  v1.H[0]
    smlal2 v25.4S,  v3.8H,  v1.H[0]
    uzp2   v24.8H, v24.8H, v25.8H

    str    q24, [sp, #9*16]

    // 1
    smull  v24.4S,  v8.4H, v17.4H
    smull2 v25.4S,  v8.8H, v17.8H
    smlal  v24.4S,  v9.4H, v16.4H
    smlal2 v25.4S,  v9.8H, v16.8H
    smlsl  v24.4S, v10.4H, v23.4H
    smlsl2 v25.4S, v10.8H, v23.8H
    smlsl  v24.4S, v11.4H, v22.4H
    smlsl2 v25.4S, v11.8H, v22.8H
    smlsl  v24.4S, v12.4H, v21.4H
    smlsl2 v25.4S, v12.8H, v21.8H
    smlsl  v24.4S, v13.4H, v20.4H
    smlsl2 v25.4S, v13.8H, v20.8H
    smlsl  v24.4S, v14.4H, v19.4H
    smlsl2 v25.4S, v14.8H, v19.8H
    smlsl  v24.4S, v15.4H, v18.4H
    smlsl2 v25.4S, v15.8H, v18.8H

    uzp1    v2.8H, v24.8H, v25.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v24.4S,  v3.4H,  v1.H[0]
    smlal2 v25.4S,  v3.8H,  v1.H[0]
    uzp2   v24.8H, v24.8H, v25.8H

    str    q24, [sp, #10*16]

    // 2
    smull  v24.4S,  v8.4H, v18.4H
    smull2 v25.4S,  v8.8H, v18.8H
    smlal  v24.4S,  v9.4H, v17.4H
    smlal2 v25.4S,  v9.8H, v17.8H
    smlal  v24.4S, v10.4H, v16.4H
    smlal2 v25.4S, v10.8H, v16.8H
    smlsl  v24.4S, v11.4H, v23.4H
    smlsl2 v25.4S, v11.8H, v23.8H
    smlsl  v24.4S, v12.4H, v22.4H
    smlsl2 v25.4S, v12.8H, v22.8H
    smlsl  v24.4S, v13.4H, v21.4H
    smlsl2 v25.4S, v13.8H, v21.8H
    smlsl  v24.4S, v14.4H, v20.4H
    smlsl2 v25.4S, v14.8H, v20.8H
    smlsl  v24.4S, v15.4H, v19.4H
    smlsl2 v25.4S, v15.8H, v19.8H

    uzp1    v2.8H, v24.8H, v25.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v24.4S,  v3.4H,  v1.H[0]
    smlal2 v25.4S,  v3.8H,  v1.H[0]
    uzp2   v24.8H, v24.8H, v25.8H

    str    q24, [sp, #11*16]

    // 3
    smull  v24.4S,  v8.4H, v19.4H
    smull2 v25.4S,  v8.8H, v19.8H
    smlal  v24.4S,  v9.4H, v18.4H
    smlal2 v25.4S,  v9.8H, v18.8H
    smlal  v24.4S, v10.4H, v17.4H
    smlal2 v25.4S, v10.8H, v17.8H
    smlal  v24.4S, v11.4H, v16.4H
    smlal2 v25.4S, v11.8H, v16.8H
    smlsl  v24.4S, v12.4H, v23.4H
    smlsl2 v25.4S, v12.8H, v23.8H
    smlsl  v24.4S, v13.4H, v22.4H
    smlsl2 v25.4S, v13.8H, v22.8H
    smlsl  v24.4S, v14.4H, v21.4H
    smlsl2 v25.4S, v14.8H, v21.8H
    smlsl  v24.4S, v15.4H, v20.4H
    smlsl2 v25.4S, v15.8H, v20.8H

    uzp1    v2.8H, v24.8H, v25.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v24.4S,  v3.4H,  v1.H[0]
    smlal2 v25.4S,  v3.8H,  v1.H[0]
    uzp2   v24.8H, v24.8H, v25.8H

    str    q24, [sp, #12*16]

    // 4
    smull  v24.4S,  v8.4H, v20.4H
    smull2 v25.4S,  v8.8H, v20.8H
    smlal  v24.4S,  v9.4H, v19.4H
    smlal2 v25.4S,  v9.8H, v19.8H
    smlal  v24.4S, v10.4H, v18.4H
    smlal2 v25.4S, v10.8H, v18.8H
    smlal  v24.4S, v11.4H, v17.4H
    smlal2 v25.4S, v11.8H, v17.8H
    smlal  v24.4S, v12.4H, v16.4H
    smlal2 v25.4S, v12.8H, v16.8H
    smlsl  v24.4S, v13.4H, v23.4H
    smlsl2 v25.4S, v13.8H, v23.8H
    smlsl  v24.4S, v14.4H, v22.4H
    smlsl2 v25.4S, v14.8H, v22.8H
    smlsl  v24.4S, v15.4H, v21.4H
    smlsl2 v25.4S, v15.8H, v21.8H

    uzp1    v2.8H, v24.8H, v25.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v24.4S,  v3.4H,  v1.H[0]
    smlal2 v25.4S,  v3.8H,  v1.H[0]
    uzp2   v24.8H, v24.8H, v25.8H

    str    q24, [sp, #13*16]

    // 5
    smull  v24.4S,  v8.4H, v21.4H
    smull2 v25.4S,  v8.8H, v21.8H
    smlal  v24.4S,  v9.4H, v20.4H
    smlal2 v25.4S,  v9.8H, v20.8H
    smlal  v24.4S, v10.4H, v19.4H
    smlal2 v25.4S, v10.8H, v19.8H
    smlal  v24.4S, v11.4H, v18.4H
    smlal2 v25.4S, v11.8H, v18.8H
    smlal  v24.4S, v12.4H, v17.4H
    smlal2 v25.4S, v12.8H, v17.8H
    smlal  v24.4S, v13.4H, v16.4H
    smlal2 v25.4S, v13.8H, v16.8H
    smlsl  v24.4S, v14.4H, v23.4H
    smlsl2 v25.4S, v14.8H, v23.8H
    smlsl  v24.4S, v15.4H, v22.4H
    smlsl2 v25.4S, v15.8H, v22.8H

    uzp1    v2.8H, v24.8H, v25.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v24.4S,  v3.4H,  v1.H[0]
    smlal2 v25.4S,  v3.8H,  v1.H[0]
    uzp2   v24.8H, v24.8H, v25.8H

    str    q24, [sp, #14*16]

    // 6
    smull  v24.4S,  v8.4H, v22.4H
    smull2 v25.4S,  v8.8H, v22.8H
    smlal  v24.4S,  v9.4H, v21.4H
    smlal2 v25.4S,  v9.8H, v21.8H
    smlal  v24.4S, v10.4H, v20.4H
    smlal2 v25.4S, v10.8H, v20.8H
    smlal  v24.4S, v11.4H, v19.4H
    smlal2 v25.4S, v11.8H, v19.8H
    smlal  v24.4S, v12.4H, v18.4H
    smlal2 v25.4S, v12.8H, v18.8H
    smlal  v24.4S, v13.4H, v17.4H
    smlal2 v25.4S, v13.8H, v17.8H
    smlal  v24.4S, v14.4H, v16.4H
    smlal2 v25.4S, v14.8H, v16.8H
    smlsl  v24.4S, v15.4H, v23.4H
    smlsl2 v25.4S, v15.8H, v23.8H

    uzp1    v2.8H, v24.8H, v25.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v24.4S,  v3.4H,  v1.H[0]
    smlal2 v25.4S,  v3.8H,  v1.H[0]
    uzp2   v24.8H, v24.8H, v25.8H

    str    q24, [sp, #15*16]

    // 7
    smull  v24.4S,  v8.4H, v23.4H
    smull2 v25.4S,  v8.8H, v23.8H
    smlal  v24.4S,  v9.4H, v22.4H
    smlal2 v25.4S,  v9.8H, v22.8H
    smlal  v24.4S, v10.4H, v21.4H
    smlal2 v25.4S, v10.8H, v21.8H
    smlal  v24.4S, v11.4H, v20.4H
    smlal2 v25.4S, v11.8H, v20.8H
    smlal  v24.4S, v12.4H, v19.4H
    smlal2 v25.4S, v12.8H, v19.8H
    smlal  v24.4S, v13.4H, v18.4H
    smlal2 v25.4S, v13.8H, v18.8H
    smlal  v24.4S, v14.4H, v17.4H
    smlal2 v25.4S, v14.8H, v17.8H
    smlal  v24.4S, v15.4H, v16.4H
    smlal2 v25.4S, v15.8H, v16.8H

    uzp1    v2.8H, v24.8H, v25.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v24.4S,  v3.4H,  v1.H[0]
    smlal2 v25.4S,  v3.8H,  v1.H[0]
    uzp2   v24.8H, v24.8H, v25.8H

    str    q24, [sp, #16*16]

//

    ldr q23, [x3, #4*16]
    ldr q22, [x3, #3*16]
    ldr q21, [x3, #2*16]
    ldr q20, [x3, #1*16]
    ldr q15, [x3, #8*16]
    ldr q14, [x3, #7*16]
    ldr q13, [x3, #6*16]
    ldr q12, [x3, #5*16]


    // 3
    smull  v24.4S,  v4.4H, v23.4H
    smull2 v25.4S,  v4.8H, v23.8H
    smlal  v24.4S,  v5.4H, v22.4H
    smlal2 v25.4S,  v5.8H, v22.8H
    smlal  v24.4S,  v6.4H, v21.4H
    smlal2 v25.4S,  v6.8H, v21.8H
    smlal  v24.4S,  v7.4H, v20.4H
    smlal2 v25.4S,  v7.8H, v20.8H

    smull  v26.4S, v28.4H, v15.4H
    smull2 v27.4S, v28.8H, v15.8H
    smlal  v26.4S, v29.4H, v14.4H
    smlal2 v27.4S, v29.8H, v14.8H
    smlal  v26.4S, v30.4H, v13.4H
    smlal2 v27.4S, v30.8H, v13.8H
    smlal  v26.4S, v31.4H, v12.4H
    smlal2 v27.4S, v31.8H, v12.8H

    uzp1    v2.8H, v24.8H, v25.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v24.4S,  v3.4H,  v1.H[0]
    smlal2 v25.4S,  v3.8H,  v1.H[0]
    uzp2   v24.8H, v24.8H, v25.8H

    uzp1    v2.8H, v26.8H, v27.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v26.4S,  v3.4H,  v1.H[0]
    smlal2 v27.4S,  v3.8H,  v1.H[0]
    uzp2   v26.8H, v26.8H, v27.8H

    // (4, 16, 13, 1) <- (4, 8, 12, 16)
    ldr q18, [sp, #12*16]
    ldr q19, [sp, #16*16]
    ldrh w10, [x2, #16*2]
    ldrh w11, [x2, #1*2]
    ldrh w12, [x2, #4*2]
    ldrh w13, [x2, #13*2]

    add  v8.8H, v24.8H,  v0.8H
    sub  v9.8H,  v8.8H, v26.8H
    add  v8.8H,  v8.8H, v26.8H
    add v10.8H,  v8.8H, v18.8H
    sub v11.8H,  v8.8H, v18.8H
    sqrdmulh  v2.8H, v10.8H,  v1.H[5]
    mul      v10.8H, v10.8H,  v1.H[4]
    mls      v10.8H,  v2.8H,  v1.H[0]
    sqrdmulh  v3.8H, v11.8H,  v1.H[5]
    mul      v11.8H, v11.8H,  v1.H[4]
    mls      v11.8H,  v3.8H,  v1.H[0]
    str q10, [x0, x12, lsl #4]
    str q11, [x0, x13, lsl #4]
    add  v8.8H,  v9.8H, v19.8H
    sub  v9.8H,  v9.8H, v19.8H
    sqrdmulh  v2.8H,  v8.8H,  v1.H[5]
    mul       v8.8H,  v8.8H,  v1.H[4]
    mls       v8.8H,  v2.8H,  v1.H[0]
    sqrdmulh  v3.8H,  v9.8H,  v1.H[5]
    mul       v9.8H,  v9.8H,  v1.H[4]
    mls       v9.8H,  v3.8H,  v1.H[0]
    str  q8, [x0, x10, lsl #4]
    str  q9, [x0, x11, lsl #4]

    // 0
    smull  v24.4S,  v4.4H, v20.4H
    smull2 v25.4S,  v4.8H, v20.8H
    smlal  v24.4S,  v5.4H, v23.4H
    smlal2 v25.4S,  v5.8H, v23.8H
    smlal  v24.4S,  v6.4H, v22.4H
    smlal2 v25.4S,  v6.8H, v22.8H
    smlal  v24.4S,  v7.4H, v21.4H
    smlal2 v25.4S,  v7.8H, v21.8H

    smull  v26.4S, v28.4H, v12.4H
    smull2 v27.4S, v28.8H, v12.8H
    smlsl  v26.4S, v29.4H, v15.4H
    smlsl2 v27.4S, v29.8H, v15.8H
    smlsl  v26.4S, v30.4H, v14.4H
    smlsl2 v27.4S, v30.8H, v14.8H
    smlsl  v26.4S, v31.4H, v13.4H
    smlsl2 v27.4S, v31.8H, v13.8H

    uzp1    v2.8H, v24.8H, v25.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v24.4S,  v3.4H,  v1.H[0]
    smlal2 v25.4S,  v3.8H,  v1.H[0]
    uzp2   v24.8H, v24.8H, v25.8H

    uzp1    v2.8H, v26.8H, v27.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v26.4S,  v3.4H,  v1.H[0]
    smlal2 v27.4S,  v3.8H,  v1.H[0]
    uzp2   v26.8H, v26.8H, v27.8H

    // (6, 7, 11, 10) <- (1, 5, 9, 13)
    ldr q18, [sp, #9*16]
    ldr q19, [sp, #13*16]
    ldrh w10, [x2, #7*2]
    ldrh w11, [x2, #10*2]
    ldrh w12, [x2, #6*2]
    ldrh w13, [x2, #11*2]

    add  v8.8H, v24.8H,  v0.8H
    sub  v9.8H,  v8.8H, v26.8H
    add  v8.8H,  v8.8H, v26.8H
    add v10.8H,  v8.8H, v18.8H
    sub v11.8H,  v8.8H, v18.8H
    sqrdmulh  v2.8H, v10.8H,  v1.H[5]
    mul      v10.8H, v10.8H,  v1.H[4]
    mls      v10.8H,  v2.8H,  v1.H[0]
    sqrdmulh  v3.8H, v11.8H,  v1.H[5]
    mul      v11.8H, v11.8H,  v1.H[4]
    mls      v11.8H,  v3.8H,  v1.H[0]
    str q10, [x0, x12, lsl #4]
    str q11, [x0, x13, lsl #4]
    add  v8.8H,  v9.8H, v19.8H
    sub  v9.8H,  v9.8H, v19.8H
    sqrdmulh  v2.8H,  v8.8H,  v1.H[5]
    mul       v8.8H,  v8.8H,  v1.H[4]
    mls       v8.8H,  v2.8H,  v1.H[0]
    sqrdmulh  v3.8H,  v9.8H,  v1.H[5]
    mul       v9.8H,  v9.8H,  v1.H[4]
    mls       v9.8H,  v3.8H,  v1.H[0]
    str  q8, [x0, x10, lsl #4]
    str  q9, [x0, x11, lsl #4]

    // 1
    smull  v24.4S,  v4.4H, v21.4H
    smull2 v25.4S,  v4.8H, v21.8H
    smlal  v24.4S,  v5.4H, v20.4H
    smlal2 v25.4S,  v5.8H, v20.8H
    smlal  v24.4S,  v6.4H, v23.4H
    smlal2 v25.4S,  v6.8H, v23.8H
    smlal  v24.4S,  v7.4H, v22.4H
    smlal2 v25.4S,  v7.8H, v22.8H

    smull  v26.4S, v28.4H, v13.4H
    smull2 v27.4S, v28.8H, v13.8H
    smlal  v26.4S, v29.4H, v12.4H
    smlal2 v27.4S, v29.8H, v12.8H
    smlsl  v26.4S, v30.4H, v15.4H
    smlsl2 v27.4S, v30.8H, v15.8H
    smlsl  v26.4S, v31.4H, v14.4H
    smlsl2 v27.4S, v31.8H, v14.8H

    uzp1    v2.8H, v24.8H, v25.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v24.4S,  v3.4H,  v1.H[0]
    smlal2 v25.4S,  v3.8H,  v1.H[0]
    uzp2    v24.8H, v24.8H, v25.8H

    uzp1    v2.8H, v26.8H, v27.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v26.4S,  v3.4H,  v1.H[0]
    smlal2 v27.4S,  v3.8H,  v1.H[0]
    uzp2   v26.8H, v26.8H, v27.8H

    // (2, 8, 15, 9) <- (2, 6, 10, 14)
    ldr q18, [sp, #10*16]
    ldr q19, [sp, #14*16]
    ldrh w10, [x2, #8*2]
    ldrh w11, [x2, #9*2]
    ldrh w12, [x2, #2*2]
    ldrh w13, [x2, #15*2]

    add  v8.8H, v24.8H,  v0.8H
    sub  v9.8H,  v8.8H, v26.8H
    add  v8.8H,  v8.8H, v26.8H
    add v10.8H,  v8.8H, v18.8H
    sub v11.8H,  v8.8H, v18.8H
    sqrdmulh  v2.8H, v10.8H,  v1.H[5]
    mul      v10.8H, v10.8H,  v1.H[4]
    mls      v10.8H,  v2.8H,  v1.H[0]
    sqrdmulh  v3.8H, v11.8H,  v1.H[5]
    mul      v11.8H, v11.8H,  v1.H[4]
    mls      v11.8H,  v3.8H,  v1.H[0]
    str q10, [x0, x12, lsl #4]
    str q11, [x0, x13, lsl #4]
    add  v8.8H,  v9.8H, v19.8H
    sub  v9.8H,  v9.8H, v19.8H
    sqrdmulh  v2.8H,  v8.8H,  v1.H[5]
    mul       v8.8H,  v8.8H,  v1.H[4]
    mls       v8.8H,  v2.8H,  v1.H[0]
    sqrdmulh  v3.8H,  v9.8H,  v1.H[5]
    mul       v9.8H,  v9.8H,  v1.H[4]
    mls       v9.8H,  v3.8H,  v1.H[0]
    str  q8, [x0, x10, lsl #4]
    str  q9, [x0, x11, lsl #4]

    // 2
    smull  v26.4S, v28.4H, v14.4H
    smull2 v27.4S, v28.8H, v14.8H
    smlal  v26.4S, v29.4H, v13.4H
    smlal2 v27.4S, v29.8H, v13.8H
    smlal  v26.4S, v30.4H, v12.4H
    smlal2 v27.4S, v30.8H, v12.8H
    smlsl  v26.4S, v31.4H, v15.4H
    smlsl2 v27.4S, v31.8H, v15.8H

    smull  v24.4S,  v4.4H, v22.4H
    smull2 v25.4S,  v4.8H, v22.8H
    smlal  v24.4S,  v5.4H, v21.4H
    smlal2 v25.4S,  v5.8H, v21.8H
    smlal  v24.4S,  v6.4H, v20.4H
    smlal2 v25.4S,  v6.8H, v20.8H
    smlal  v24.4S,  v7.4H, v23.4H
    smlal2 v25.4S,  v7.8H, v23.8H

    uzp1    v2.8H, v26.8H, v27.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v26.4S,  v3.4H,  v1.H[0]
    smlal2 v27.4S,  v3.8H,  v1.H[0]
    uzp2   v26.8H, v26.8H, v27.8H

    uzp1    v2.8H, v24.8H, v25.8H
    mul     v3.8H,  v2.8H,  v1.H[2]
    smlal  v24.4S,  v3.4H,  v1.H[0]
    smlal2 v25.4S,  v3.8H,  v1.H[0]
    uzp2   v24.8H, v24.8H, v25.8H

    // (12, 14, 5, 3) <- (3, 7, 11, 15)
    ldr q18, [sp, #11*16]
    ldr q19, [sp, #15*16]
    ldrh w10, [x2, #14*2]
    ldrh w11, [x2, #3*2]
    ldrh w12, [x2, #12*2]
    ldrh w13, [x2, #5*2]

    add  v8.8H, v24.8H,  v0.8H
    sub  v9.8H,  v8.8H, v26.8H
    add  v8.8H,  v8.8H, v26.8H
    add v10.8H,  v8.8H, v18.8H
    sub v11.8H,  v8.8H, v18.8H
    sqrdmulh  v2.8H, v10.8H,  v1.H[5]
    mul      v10.8H, v10.8H,  v1.H[4]
    mls      v10.8H,  v2.8H,  v1.H[0]
    sqrdmulh  v3.8H, v11.8H,  v1.H[5]
    mul      v11.8H, v11.8H,  v1.H[4]
    mls      v11.8H,  v3.8H,  v1.H[0]
    str q10, [x0, x12, lsl #4]
    str q11, [x0, x13, lsl #4]
    add  v8.8H,  v9.8H, v19.8H
    sub  v9.8H,  v9.8H, v19.8H
    sqrdmulh  v2.8H,  v8.8H,  v1.H[5]
    mul       v8.8H,  v8.8H,  v1.H[4]
    mls       v8.8H,  v2.8H,  v1.H[0]
    sqrdmulh  v3.8H,  v9.8H,  v1.H[5]
    mul       v9.8H,  v9.8H,  v1.H[4]
    mls       v9.8H,  v3.8H,  v1.H[0]
    str  q8, [x0, x10, lsl #4]
    str  q9, [x0, x11, lsl #4]

//

    add sp, sp, #(17*16)

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(4*16)




    br lr













