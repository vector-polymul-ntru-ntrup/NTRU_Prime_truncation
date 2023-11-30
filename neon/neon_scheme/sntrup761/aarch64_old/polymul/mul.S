
.align 6
.global __asm_schoolbook8x8
.global ___asm_schoolbook8x8
__asm_schoolbook8x8:
___asm_schoolbook8x8:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    mov w12, #-15631
    mov w13, #4591
    mov v0.H[0], w12
    mov v0.H[1], w13

    ldr  q8, [x1, #0*16]
    ldr q16, [x2, #0*16]

    // 0
    smull  v24.4S,  v8.4H, v16.4H
    smull2 v25.4S,  v8.8H, v16.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #0*16]

    // 1
    ldr  q9, [x1, #1*16]
    ldr q17, [x2, #1*16]

    smull  v24.4S,  v8.4H, v17.4H
    smull2 v25.4S,  v8.8H, v17.8H
    smlal  v24.4S,  v9.4H, v16.4H
    smlal2 v25.4S,  v9.8H, v16.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #1*16]

    // 2
    ldr q10, [x1, #2*16]
    ldr q18, [x2, #2*16]

    smull  v24.4S,  v8.4H, v18.4H
    smull2 v25.4S,  v8.8H, v18.8H
    smlal  v24.4S,  v9.4H, v17.4H
    smlal2 v25.4S,  v9.8H, v17.8H
    smlal  v24.4S, v10.4H, v16.4H
    smlal2 v25.4S, v10.8H, v16.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #2*16]

    // 3
    ldr q11, [x1, #3*16]
    ldr q19, [x2, #3*16]

    smull  v24.4S,  v8.4H, v19.4H
    smull2 v25.4S,  v8.8H, v19.8H
    smlal  v24.4S,  v9.4H, v18.4H
    smlal2 v25.4S,  v9.8H, v18.8H
    smlal  v24.4S, v10.4H, v17.4H
    smlal2 v25.4S, v10.8H, v17.8H
    smlal  v24.4S, v11.4H, v16.4H
    smlal2 v25.4S, v11.8H, v16.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #3*16]

    // 4
    ldr q12, [x1, #4*16]
    ldr q20, [x2, #4*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #4*16]

    // 5
    ldr q13, [x1, #5*16]
    ldr q21, [x2, #5*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #5*16]

    // 6
    ldr q14, [x1, #6*16]
    ldr q22, [x2, #6*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #6*16]

    // 7
    ldr q15, [x1, #7*16]
    ldr q23, [x2, #7*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #7*16]

    // 8
    smull  v24.4S,  v9.4H, v23.4H
    smull2 v25.4S,  v9.8H, v23.8H
    smlal  v24.4S, v10.4H, v22.4H
    smlal2 v25.4S, v10.8H, v22.8H
    smlal  v24.4S, v11.4H, v21.4H
    smlal2 v25.4S, v11.8H, v21.8H
    smlal  v24.4S, v12.4H, v20.4H
    smlal2 v25.4S, v12.8H, v20.8H
    smlal  v24.4S, v13.4H, v19.4H
    smlal2 v25.4S, v13.8H, v19.8H
    smlal  v24.4S, v14.4H, v18.4H
    smlal2 v25.4S, v14.8H, v18.8H
    smlal  v24.4S, v15.4H, v17.4H
    smlal2 v25.4S, v15.8H, v17.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #8*16]

    // 9
    smull  v24.4S, v10.4H, v23.4H
    smull2 v25.4S, v10.8H, v23.8H
    smlal  v24.4S, v11.4H, v22.4H
    smlal2 v25.4S, v11.8H, v22.8H
    smlal  v24.4S, v12.4H, v21.4H
    smlal2 v25.4S, v12.8H, v21.8H
    smlal  v24.4S, v13.4H, v20.4H
    smlal2 v25.4S, v13.8H, v20.8H
    smlal  v24.4S, v14.4H, v19.4H
    smlal2 v25.4S, v14.8H, v19.8H
    smlal  v24.4S, v15.4H, v18.4H
    smlal2 v25.4S, v15.8H, v18.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #9*16]

    // 10
    smull  v24.4S, v11.4H, v23.4H
    smull2 v25.4S, v11.8H, v23.8H
    smlal  v24.4S, v12.4H, v22.4H
    smlal2 v25.4S, v12.8H, v22.8H
    smlal  v24.4S, v13.4H, v21.4H
    smlal2 v25.4S, v13.8H, v21.8H
    smlal  v24.4S, v14.4H, v20.4H
    smlal2 v25.4S, v14.8H, v20.8H
    smlal  v24.4S, v15.4H, v19.4H
    smlal2 v25.4S, v15.8H, v19.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #10*16]

    // 11
    smull  v24.4S, v12.4H, v23.4H
    smull2 v25.4S, v12.8H, v23.8H
    smlal  v24.4S, v13.4H, v22.4H
    smlal2 v25.4S, v13.8H, v22.8H
    smlal  v24.4S, v14.4H, v21.4H
    smlal2 v25.4S, v14.8H, v21.8H
    smlal  v24.4S, v15.4H, v20.4H
    smlal2 v25.4S, v15.8H, v20.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #11*16]

    // 12
    smull  v24.4S, v13.4H, v23.4H
    smull2 v25.4S, v13.8H, v23.8H
    smlal  v24.4S, v14.4H, v22.4H
    smlal2 v25.4S, v14.8H, v22.8H
    smlal  v24.4S, v15.4H, v21.4H
    smlal2 v25.4S, v15.8H, v21.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #12*16]

    // 13
    smull  v24.4S, v14.4H, v23.4H
    smull2 v25.4S, v14.8H, v23.8H
    smlal  v24.4S, v15.4H, v22.4H
    smlal2 v25.4S, v15.8H, v22.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #13*16]

    // 14
    smull  v24.4S, v15.4H, v23.4H
    smull2 v25.4S, v15.8H, v23.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str q30, [x0, #14*16]

    // 15

    eor v30.16B,  v0.16B,  v0.16B
    str q30, [x0, #15*16]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr


.align 6
.global __asm_weighted8x8
.global ___asm_weighted8x8
__asm_weighted8x8:
___asm_weighted8x8:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldp q1, q2, [x3]
    mov w12, #-15631
    mov w13, #4591
    mov v0.H[0], w12
    mov v0.H[1], w13

    ldr  q8, [x1, #0*16]
    ldr  q9, [x1, #1*16]
    ldr q10, [x1, #2*16]
    ldr q11, [x1, #3*16]
    ldr q12, [x1, #4*16]
    ldr q13, [x1, #5*16]
    ldr q14, [x1, #6*16]
    ldr q15, [x1, #7*16]
    ldr q16, [x2, #0*16]
    ldr q17, [x2, #1*16]
    ldr q18, [x2, #2*16]
    ldr q19, [x2, #3*16]
    ldr q20, [x2, #4*16]
    ldr q21, [x2, #5*16]
    ldr q22, [x2, #6*16]
    ldr q23, [x2, #7*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #7*16]

    sqrdmulh  v4.8H, v23.8H,  v2.8H
    mul      v23.8H, v23.8H,  v1.8H
    mls      v23.8H,  v4.8H,  v0.H[1]

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
    smlal  v24.4S, v15.4H, v23.4H
    smlal2 v25.4S, v15.8H, v23.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #6*16]

    sqrdmulh  v4.8H, v22.8H,  v2.8H
    mul      v22.8H, v22.8H,  v1.8H
    mls      v22.8H,  v4.8H,  v0.H[1]

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
    smlal  v24.4S, v14.4H, v23.4H
    smlal2 v25.4S, v14.8H, v23.8H
    smlal  v24.4S, v15.4H, v22.4H
    smlal2 v25.4S, v15.8H, v22.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #5*16]

    sqrdmulh  v4.8H, v21.8H,  v2.8H
    mul      v21.8H, v21.8H,  v1.8H
    mls      v21.8H,  v4.8H,  v0.H[1]

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
    smlal  v24.4S, v13.4H, v23.4H
    smlal2 v25.4S, v13.8H, v23.8H
    smlal  v24.4S, v14.4H, v22.4H
    smlal2 v25.4S, v14.8H, v22.8H
    smlal  v24.4S, v15.4H, v21.4H
    smlal2 v25.4S, v15.8H, v21.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #4*16]

    sqrdmulh  v4.8H, v20.8H,  v2.8H
    mul      v20.8H, v20.8H,  v1.8H
    mls      v20.8H,  v4.8H,  v0.H[1]

    // 3
    smull  v24.4S,  v8.4H, v19.4H
    smull2 v25.4S,  v8.8H, v19.8H
    smlal  v24.4S,  v9.4H, v18.4H
    smlal2 v25.4S,  v9.8H, v18.8H
    smlal  v24.4S, v10.4H, v17.4H
    smlal2 v25.4S, v10.8H, v17.8H
    smlal  v24.4S, v11.4H, v16.4H
    smlal2 v25.4S, v11.8H, v16.8H
    smlal  v24.4S, v12.4H, v23.4H
    smlal2 v25.4S, v12.8H, v23.8H
    smlal  v24.4S, v13.4H, v22.4H
    smlal2 v25.4S, v13.8H, v22.8H
    smlal  v24.4S, v14.4H, v21.4H
    smlal2 v25.4S, v14.8H, v21.8H
    smlal  v24.4S, v15.4H, v20.4H
    smlal2 v25.4S, v15.8H, v20.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #3*16]

    sqrdmulh  v4.8H, v19.8H,  v2.8H
    mul      v19.8H, v19.8H,  v1.8H
    mls      v19.8H,  v4.8H,  v0.H[1]

    // 2
    smull  v24.4S,  v8.4H, v18.4H
    smull2 v25.4S,  v8.8H, v18.8H
    smlal  v24.4S,  v9.4H, v17.4H
    smlal2 v25.4S,  v9.8H, v17.8H
    smlal  v24.4S, v10.4H, v16.4H
    smlal2 v25.4S, v10.8H, v16.8H
    smlal  v24.4S, v11.4H, v23.4H
    smlal2 v25.4S, v11.8H, v23.8H
    smlal  v24.4S, v12.4H, v22.4H
    smlal2 v25.4S, v12.8H, v22.8H
    smlal  v24.4S, v13.4H, v21.4H
    smlal2 v25.4S, v13.8H, v21.8H
    smlal  v24.4S, v14.4H, v20.4H
    smlal2 v25.4S, v14.8H, v20.8H
    smlal  v24.4S, v15.4H, v19.4H
    smlal2 v25.4S, v15.8H, v19.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #2*16]

    sqrdmulh  v4.8H, v18.8H,  v2.8H
    mul      v18.8H, v18.8H,  v1.8H
    mls      v18.8H,  v4.8H,  v0.H[1]

    // 1
    smull  v24.4S,  v8.4H, v17.4H
    smull2 v25.4S,  v8.8H, v17.8H
    smlal  v24.4S,  v9.4H, v16.4H
    smlal2 v25.4S,  v9.8H, v16.8H
    smlal  v24.4S, v10.4H, v23.4H
    smlal2 v25.4S, v10.8H, v23.8H
    smlal  v24.4S, v11.4H, v22.4H
    smlal2 v25.4S, v11.8H, v22.8H
    smlal  v24.4S, v12.4H, v21.4H
    smlal2 v25.4S, v12.8H, v21.8H
    smlal  v24.4S, v13.4H, v20.4H
    smlal2 v25.4S, v13.8H, v20.8H
    smlal  v24.4S, v14.4H, v19.4H
    smlal2 v25.4S, v14.8H, v19.8H
    smlal  v24.4S, v15.4H, v18.4H
    smlal2 v25.4S, v15.8H, v18.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #1*16]

    sqrdmulh  v4.8H, v17.8H,  v2.8H
    mul      v17.8H, v17.8H,  v1.8H
    mls      v17.8H,  v4.8H,  v0.H[1]

    // 0
    smull  v24.4S,  v8.4H, v16.4H
    smull2 v25.4S,  v8.8H, v16.8H
    smlal  v24.4S,  v9.4H, v23.4H
    smlal2 v25.4S,  v9.8H, v23.8H
    smlal  v24.4S, v10.4H, v22.4H
    smlal2 v25.4S, v10.8H, v22.8H
    smlal  v24.4S, v11.4H, v21.4H
    smlal2 v25.4S, v11.8H, v21.8H
    smlal  v24.4S, v12.4H, v20.4H
    smlal2 v25.4S, v12.8H, v20.8H
    smlal  v24.4S, v13.4H, v19.4H
    smlal2 v25.4S, v13.8H, v19.8H
    smlal  v24.4S, v14.4H, v18.4H
    smlal2 v25.4S, v14.8H, v18.8H
    smlal  v24.4S, v15.4H, v17.4H
    smlal2 v25.4S, v15.8H, v17.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #0*16]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr


.align 6
.global __asm_cyclic_basemul8x8
.global ___asm_cyclic_basemul8x8
__asm_cyclic_basemul8x8:
___asm_cyclic_basemul8x8:

    sub sp, sp, #(16*4)
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]

    ldr s0, [x3]

    ldr  q8, [x1, #0*16]
    ldr  q9, [x1, #1*16]
    ldr q10, [x1, #2*16]
    ldr q11, [x1, #3*16]
    ldr q12, [x1, #4*16]
    ldr q13, [x1, #5*16]
    ldr q14, [x1, #6*16]
    ldr q15, [x1, #7*16]
    ldr q16, [x2, #0*16]
    ldr q17, [x2, #1*16]
    ldr q18, [x2, #2*16]
    ldr q19, [x2, #3*16]
    ldr q20, [x2, #4*16]
    ldr q21, [x2, #5*16]
    ldr q22, [x2, #6*16]
    ldr q23, [x2, #7*16]

    // 0
    smull  v24.4S,  v8.4H, v16.4H
    smull2 v25.4S,  v8.8H, v16.8H
    smlal  v24.4S,  v9.4H, v23.4H
    smlal2 v25.4S,  v9.8H, v23.8H
    smlal  v24.4S, v10.4H, v22.4H
    smlal2 v25.4S, v10.8H, v22.8H
    smlal  v24.4S, v11.4H, v21.4H
    smlal2 v25.4S, v11.8H, v21.8H
    smlal  v24.4S, v12.4H, v20.4H
    smlal2 v25.4S, v12.8H, v20.8H
    smlal  v24.4S, v13.4H, v19.4H
    smlal2 v25.4S, v13.8H, v19.8H
    smlal  v24.4S, v14.4H, v18.4H
    smlal2 v25.4S, v14.8H, v18.8H
    smlal  v24.4S, v15.4H, v17.4H
    smlal2 v25.4S, v15.8H, v17.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #0*16]

    // 1
    smull  v24.4S,  v8.4H, v17.4H
    smull2 v25.4S,  v8.8H, v17.8H
    smlal  v24.4S,  v9.4H, v16.4H
    smlal2 v25.4S,  v9.8H, v16.8H
    smlal  v24.4S, v10.4H, v23.4H
    smlal2 v25.4S, v10.8H, v23.8H
    smlal  v24.4S, v11.4H, v22.4H
    smlal2 v25.4S, v11.8H, v22.8H
    smlal  v24.4S, v12.4H, v21.4H
    smlal2 v25.4S, v12.8H, v21.8H
    smlal  v24.4S, v13.4H, v20.4H
    smlal2 v25.4S, v13.8H, v20.8H
    smlal  v24.4S, v14.4H, v19.4H
    smlal2 v25.4S, v14.8H, v19.8H
    smlal  v24.4S, v15.4H, v18.4H
    smlal2 v25.4S, v15.8H, v18.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #1*16]

    // 2
    smull  v24.4S,  v8.4H, v18.4H
    smull2 v25.4S,  v8.8H, v18.8H
    smlal  v24.4S,  v9.4H, v17.4H
    smlal2 v25.4S,  v9.8H, v17.8H
    smlal  v24.4S, v10.4H, v16.4H
    smlal2 v25.4S, v10.8H, v16.8H
    smlal  v24.4S, v11.4H, v23.4H
    smlal2 v25.4S, v11.8H, v23.8H
    smlal  v24.4S, v12.4H, v22.4H
    smlal2 v25.4S, v12.8H, v22.8H
    smlal  v24.4S, v13.4H, v21.4H
    smlal2 v25.4S, v13.8H, v21.8H
    smlal  v24.4S, v14.4H, v20.4H
    smlal2 v25.4S, v14.8H, v20.8H
    smlal  v24.4S, v15.4H, v19.4H
    smlal2 v25.4S, v15.8H, v19.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #2*16]

    // 3
    smull  v24.4S,  v8.4H, v19.4H
    smull2 v25.4S,  v8.8H, v19.8H
    smlal  v24.4S,  v9.4H, v18.4H
    smlal2 v25.4S,  v9.8H, v18.8H
    smlal  v24.4S, v10.4H, v17.4H
    smlal2 v25.4S, v10.8H, v17.8H
    smlal  v24.4S, v11.4H, v16.4H
    smlal2 v25.4S, v11.8H, v16.8H
    smlal  v24.4S, v12.4H, v23.4H
    smlal2 v25.4S, v12.8H, v23.8H
    smlal  v24.4S, v13.4H, v22.4H
    smlal2 v25.4S, v13.8H, v22.8H
    smlal  v24.4S, v14.4H, v21.4H
    smlal2 v25.4S, v14.8H, v21.8H
    smlal  v24.4S, v15.4H, v20.4H
    smlal2 v25.4S, v15.8H, v20.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #3*16]

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
    smlal  v24.4S, v13.4H, v23.4H
    smlal2 v25.4S, v13.8H, v23.8H
    smlal  v24.4S, v14.4H, v22.4H
    smlal2 v25.4S, v14.8H, v22.8H
    smlal  v24.4S, v15.4H, v21.4H
    smlal2 v25.4S, v15.8H, v21.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #4*16]

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
    smlal  v24.4S, v14.4H, v23.4H
    smlal2 v25.4S, v14.8H, v23.8H
    smlal  v24.4S, v15.4H, v22.4H
    smlal2 v25.4S, v15.8H, v22.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #5*16]

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
    smlal  v24.4S, v15.4H, v23.4H
    smlal2 v25.4S, v15.8H, v23.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #6*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #7*16]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr


.align 6
.global __asm_negacyclic_basemul8x8
.global ___asm_negacyclic_basemul8x8
__asm_negacyclic_basemul8x8:
___asm_negacyclic_basemul8x8:

    sub sp, sp, #(16*4)
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]

    ldr s0, [x3]

    ldr  q8, [x1, #0*16]
    ldr  q9, [x1, #1*16]
    ldr q10, [x1, #2*16]
    ldr q11, [x1, #3*16]
    ldr q12, [x1, #4*16]
    ldr q13, [x1, #5*16]
    ldr q14, [x1, #6*16]
    ldr q15, [x1, #7*16]
    ldr q16, [x2, #0*16]
    ldr q17, [x2, #1*16]
    ldr q18, [x2, #2*16]
    ldr q19, [x2, #3*16]
    ldr q20, [x2, #4*16]
    ldr q21, [x2, #5*16]
    ldr q22, [x2, #6*16]
    ldr q23, [x2, #7*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #0*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #1*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #2*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #3*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #4*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #5*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #6*16]

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

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2   v30.8H, v24.8H, v25.8H

    str    q30, [x0, #7*16]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_cyclic_basemul4x4
.global ___asm_cyclic_basemul4x4
__asm_cyclic_basemul4x4:
___asm_cyclic_basemul4x4:

    ldr s0, [x3]

    ldr q16, [x1, #0*16]
    ldr q17, [x1, #1*16]
    ldr q18, [x1, #2*16]
    ldr q19, [x1, #3*16]
    ldr q20, [x2, #0*16]
    ldr q21, [x2, #1*16]
    ldr q22, [x2, #2*16]
    ldr q23, [x2, #3*16]

    // 0
    smull  v24.4S, v16.4H, v20.4H
    smull2 v25.4S, v16.8H, v20.8H
    smlal  v24.4S, v17.4H, v23.4H
    smlal2 v25.4S, v17.8H, v23.8H
    smlal  v24.4S, v18.4H, v22.4H
    smlal2 v25.4S, v18.8H, v22.8H
    smlal  v24.4S, v19.4H, v21.4H
    smlal2 v25.4S, v19.8H, v21.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2    v4.8H, v24.8H, v25.8H

    str     q4, [x0, #0*16]

    // 1
    smull  v24.4S, v16.4H, v21.4H
    smull2 v25.4S, v16.8H, v21.8H
    smlal  v24.4S, v17.4H, v20.4H
    smlal2 v25.4S, v17.8H, v20.8H
    smlal  v24.4S, v18.4H, v23.4H
    smlal2 v25.4S, v18.8H, v23.8H
    smlal  v24.4S, v19.4H, v22.4H
    smlal2 v25.4S, v19.8H, v22.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2    v4.8H, v24.8H, v25.8H

    str     q4, [x0, #1*16]

    // 2
    smull  v24.4S, v16.4H, v22.4H
    smull2 v25.4S, v16.8H, v22.8H
    smlal  v24.4S, v17.4H, v21.4H
    smlal2 v25.4S, v17.8H, v21.8H
    smlal  v24.4S, v18.4H, v20.4H
    smlal2 v25.4S, v18.8H, v20.8H
    smlal  v24.4S, v19.4H, v23.4H
    smlal2 v25.4S, v19.8H, v23.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2    v4.8H, v24.8H, v25.8H

    str     q4, [x0, #2*16]

    // 3
    smull  v24.4S, v16.4H, v23.4H
    smull2 v25.4S, v16.8H, v23.8H
    smlal  v24.4S, v17.4H, v22.4H
    smlal2 v25.4S, v17.8H, v22.8H
    smlal  v24.4S, v18.4H, v21.4H
    smlal2 v25.4S, v18.8H, v21.8H
    smlal  v24.4S, v19.4H, v20.4H
    smlal2 v25.4S, v19.8H, v20.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2    v4.8H, v24.8H, v25.8H

    str     q4, [x0, #3*16]

    br lr

.align 6
.global __asm_negacyclic_basemul4x4
.global ___asm_negacyclic_basemul4x4
__asm_negacyclic_basemul4x4:
___asm_negacyclic_basemul4x4:

    ldr s0, [x3]

    ldr q16, [x1, #0*16]
    ldr q17, [x1, #1*16]
    ldr q18, [x1, #2*16]
    ldr q19, [x1, #3*16]
    ldr q20, [x2, #0*16]
    ldr q21, [x2, #1*16]
    ldr q22, [x2, #2*16]
    ldr q23, [x2, #3*16]

    // 0
    smull  v24.4S, v16.4H, v20.4H
    smull2 v25.4S, v16.8H, v20.8H
    smlsl  v24.4S, v17.4H, v23.4H
    smlsl2 v25.4S, v17.8H, v23.8H
    smlsl  v24.4S, v18.4H, v22.4H
    smlsl2 v25.4S, v18.8H, v22.8H
    smlsl  v24.4S, v19.4H, v21.4H
    smlsl2 v25.4S, v19.8H, v21.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2    v4.8H, v24.8H, v25.8H

    str     q4, [x0, #0*16]

    // 1
    smull  v24.4S, v16.4H, v21.4H
    smull2 v25.4S, v16.8H, v21.8H
    smlal  v24.4S, v17.4H, v20.4H
    smlal2 v25.4S, v17.8H, v20.8H
    smlsl  v24.4S, v18.4H, v23.4H
    smlsl2 v25.4S, v18.8H, v23.8H
    smlsl  v24.4S, v19.4H, v22.4H
    smlsl2 v25.4S, v19.8H, v22.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2    v4.8H, v24.8H, v25.8H

    str     q4, [x0, #1*16]

    // 2
    smull  v24.4S, v16.4H, v22.4H
    smull2 v25.4S, v16.8H, v22.8H
    smlal  v24.4S, v17.4H, v21.4H
    smlal2 v25.4S, v17.8H, v21.8H
    smlal  v24.4S, v18.4H, v20.4H
    smlal2 v25.4S, v18.8H, v20.8H
    smlsl  v24.4S, v19.4H, v23.4H
    smlsl2 v25.4S, v19.8H, v23.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2    v4.8H, v24.8H, v25.8H

    str     q4, [x0, #2*16]

    // 3
    smull  v24.4S, v16.4H, v23.4H
    smull2 v25.4S, v16.8H, v23.8H
    smlal  v24.4S, v17.4H, v22.4H
    smlal2 v25.4S, v17.8H, v22.8H
    smlal  v24.4S, v18.4H, v21.4H
    smlal2 v25.4S, v18.8H, v21.8H
    smlal  v24.4S, v19.4H, v20.4H
    smlal2 v25.4S, v19.8H, v20.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2    v4.8H, v24.8H, v25.8H

    str     q4, [x0, #3*16]

    br lr

.align 6
.global __asm_cyclic_negacyclic_basemul4x4
.global ___asm_cyclic_negacyclic_basemul4x4
__asm_cyclic_negacyclic_basemul4x4:
___asm_cyclic_negacyclic_basemul4x4:

    ldr s0, [x3]
    sub sp, sp, #(16*4)
    ldr q16, [x1, #0*16]
    stp  d8,  d9, [sp, #16*0]
    ldr q23, [x2, #3*16]
    stp d10, d11, [sp, #16*1]
    ldr q17, [x1, #1*16]
    stp d12, d13, [sp, #16*2]
    ldr q22, [x2, #2*16]
    stp d14, d15, [sp, #16*3]

    // 3
    ldr q18, [x1, #2*16]
    smull  v24.4S, v16.4H, v23.4H
    ldr q21, [x2, #1*16]
    smull2 v25.4S, v16.8H, v23.8H
    ldr q19, [x1, #3*16]
    smlal  v24.4S, v17.4H, v22.4H
    ldr q20, [x2, #0*16]
    smlal2 v25.4S, v17.8H, v22.8H
    ldr  q8, [x1, #4*16]
    smlal  v24.4S, v18.4H, v21.4H
    ldr q15, [x2, #7*16]
    smlal2 v25.4S, v18.8H, v21.8H
    ldr  q9, [x1, #5*16]
    smlal  v24.4S, v19.4H, v20.4H
    ldr q14, [x2, #6*16]
    smlal2 v25.4S, v19.8H, v20.8H

    ldr q10, [x1, #6*16]
    smull  v26.4S,  v8.4H, v15.4H
    ldr q13, [x2, #5*16]
    smull2 v27.4S,  v8.8H, v15.8H
    ldr q11, [x1, #7*16]
    smlal  v26.4S,  v9.4H, v14.4H
    ldr q12, [x2, #4*16]
    smlal2 v27.4S,  v9.8H, v14.8H
    smlal  v26.4S, v10.4H, v13.4H
    smlal2 v27.4S, v10.8H, v13.8H
    smlal  v26.4S, v11.4H, v12.4H
    smlal2 v27.4S, v11.8H, v12.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2    v4.8H, v24.8H, v25.8H

    str     q4, [x0, #3*16]

    uzp1   v30.8H, v26.8H, v27.8H
    mul    v31.8H, v30.8H,  v0.H[0]
    smlal  v26.4S, v31.4H,  v0.H[1]
    smlal2 v27.4S, v31.8H,  v0.H[1]
    uzp2    v5.8H, v26.8H, v27.8H

    str     q5, [x0, #7*16]
    
    // 0
    smull  v24.4S, v16.4H, v20.4H
    smull2 v25.4S, v16.8H, v20.8H
    smlal  v24.4S, v17.4H, v23.4H
    smlal2 v25.4S, v17.8H, v23.8H
    smlal  v24.4S, v18.4H, v22.4H
    smlal2 v25.4S, v18.8H, v22.8H
    smlal  v24.4S, v19.4H, v21.4H
    smlal2 v25.4S, v19.8H, v21.8H

    smull  v26.4S,  v8.4H, v12.4H
    smull2 v27.4S,  v8.8H, v12.8H
    smlsl  v26.4S,  v9.4H, v15.4H
    smlsl2 v27.4S,  v9.8H, v15.8H
    smlsl  v26.4S, v10.4H, v14.4H
    smlsl2 v27.4S, v10.8H, v14.8H
    smlsl  v26.4S, v11.4H, v13.4H
    smlsl2 v27.4S, v11.8H, v13.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2    v4.8H, v24.8H, v25.8H

    str     q4, [x0, #0*16]

    uzp1   v30.8H, v26.8H, v27.8H
    mul    v31.8H, v30.8H,  v0.H[0]
    smlal  v26.4S, v31.4H,  v0.H[1]
    smlal2 v27.4S, v31.8H,  v0.H[1]
    uzp2    v5.8H, v26.8H, v27.8H

    str     q5, [x0, #4*16]

    // 1
    smull  v24.4S, v16.4H, v21.4H
    smull2 v25.4S, v16.8H, v21.8H
    smlal  v24.4S, v17.4H, v20.4H
    smlal2 v25.4S, v17.8H, v20.8H
    smlal  v24.4S, v18.4H, v23.4H
    smlal2 v25.4S, v18.8H, v23.8H
    smlal  v24.4S, v19.4H, v22.4H
    smlal2 v25.4S, v19.8H, v22.8H

    smull  v26.4S,  v8.4H, v13.4H
    smull2 v27.4S,  v8.8H, v13.8H
    smlal  v26.4S,  v9.4H, v12.4H
    smlal2 v27.4S,  v9.8H, v12.8H
    smlsl  v26.4S, v10.4H, v15.4H
    smlsl2 v27.4S, v10.8H, v15.8H
    smlsl  v26.4S, v11.4H, v14.4H
    smlsl2 v27.4S, v11.8H, v14.8H

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2    v4.8H, v24.8H, v25.8H

    str     q4, [x0, #1*16]

    uzp1   v30.8H, v26.8H, v27.8H
    mul    v31.8H, v30.8H,  v0.H[0]
    smlal  v26.4S, v31.4H,  v0.H[1]
    smlal2 v27.4S, v31.8H,  v0.H[1]
    uzp2    v5.8H, v26.8H, v27.8H

    str     q5, [x0, #5*16]

    // 2
    smull  v26.4S,  v8.4H, v14.4H
    smull2 v27.4S,  v8.8H, v14.8H
    smlal  v26.4S,  v9.4H, v13.4H
    smlal2 v27.4S,  v9.8H, v13.8H
    smlal  v26.4S, v10.4H, v12.4H
    smlal2 v27.4S, v10.8H, v12.8H
    smlsl  v26.4S, v11.4H, v15.4H
    smlsl2 v27.4S, v11.8H, v15.8H

    smull  v24.4S, v16.4H, v22.4H
    smull2 v25.4S, v16.8H, v22.8H
    ldp  d8,  d9, [sp, #16*0]
    smlal  v24.4S, v17.4H, v21.4H
    smlal2 v25.4S, v17.8H, v21.8H
    ldp d10, d11, [sp, #16*1]
    smlal  v24.4S, v18.4H, v20.4H
    smlal2 v25.4S, v18.8H, v20.8H
    ldp d12, d13, [sp, #16*2]
    smlal  v24.4S, v19.4H, v23.4H
    smlal2 v25.4S, v19.8H, v23.8H
    ldp d14, d15, [sp, #16*3]
    
    add sp, sp, #(16*4)
    uzp1   v30.8H, v26.8H, v27.8H
    mul    v31.8H, v30.8H,  v0.H[0]
    smlal  v26.4S, v31.4H,  v0.H[1]
    smlal2 v27.4S, v31.8H,  v0.H[1]
    uzp2    v5.8H, v26.8H, v27.8H

    str     q5, [x0, #6*16]

    uzp1   v28.8H, v24.8H, v25.8H
    mul    v29.8H, v28.8H,  v0.H[0]
    smlal  v24.4S, v29.4H,  v0.H[1]
    smlal2 v25.4S, v29.8H,  v0.H[1]
    uzp2    v4.8H, v24.8H, v25.8H

    str     q4, [x0, #2*16]

//


    br lr





