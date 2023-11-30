
.macro montgomery_long a0, a1, t

    uzp1    \t\().8H, \a0\().8H, \a1\().8H
    mul     \t\().8H,  \t\().8H,  v4.H[0]
    smlal  \a0\().4S,  \t\().4H,  v4.H[1]
    smlal2 \a1\().4S,  \t\().8H,  v4.H[1]
    uzp2   \a0\().8H, \a0\().8H, \a1\().8H

.endm

.align 6
.global __asm_Bruun_GF_mul
.global ___asm_Bruun_GF_mul
__asm_Bruun_GF_mul:
___asm_Bruun_GF_mul:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldp q12, q13, [x3]
    mov w12, #-15631
    mov w13, #4591
    mov v4.H[0], w12
    mov v4.H[1], w13

    ldr q16, [x1, #0*16]
    ldr q17, [x1, #1*16]
    ldr q18, [x1, #2*16]
    ldr q19, [x1, #3*16]
    ldr q20, [x1, #4*16]
    ldr q21, [x1, #5*16]
    ldr q22, [x1, #6*16]
    ldr q23, [x1, #7*16]

    ldr q24, [x2, #0*16]
    ldr q25, [x2, #1*16]
    ldr q26, [x2, #2*16]
    ldr q27, [x2, #3*16]
    ldr q28, [x2, #4*16]
    ldr q29, [x2, #5*16]
    ldr q30, [x2, #6*16]
    ldr q31, [x2, #7*16]

    // 3, 7, 11

    // 11
    smull    v14.4S, v20.4H, v31.4H
    smull2    v9.4S, v20.8H, v31.8H
    smlal    v14.4S, v21.4H, v30.4H
    smlal2    v9.4S, v21.8H, v30.8H
    smlal    v14.4S, v22.4H, v29.4H
    smlal2    v9.4S, v22.8H, v29.8H
    smlal    v14.4S, v23.4H, v28.4H
    smlal2    v9.4S, v23.8H, v28.8H
    montgomery_long v14, v9, v10
    
    // 7
    smull     v8.4S, v16.4H, v31.4H
    smull2    v9.4S, v16.8H, v31.8H
    smlsl     v8.4S, v14.4H, v13.4H
    smlsl2    v9.4S, v14.8H, v13.8H
    smlal     v8.4S, v17.4H, v30.4H
    smlal2    v9.4S, v17.8H, v30.8H
    smlal     v8.4S, v18.4H, v29.4H
    smlal2    v9.4S, v18.8H, v29.8H
    smlal     v8.4S, v19.4H, v28.4H
    smlal2    v9.4S, v19.8H, v28.8H
    smlal     v8.4S, v20.4H, v27.4H
    smlal2    v9.4S, v20.8H, v27.8H
    smlal     v8.4S, v21.4H, v26.4H
    smlal2    v9.4S, v21.8H, v26.8H
    smlal     v8.4S, v22.4H, v25.4H
    smlal2    v9.4S, v22.8H, v25.8H
    smlal     v8.4S, v23.4H, v24.4H
    smlal2    v9.4S, v23.8H, v24.8H
    montgomery_long v8, v9, v10
    str  q8, [x0, #7*16]

    // 3
    smull     v8.4S, v16.4H, v27.4H
    smull2    v9.4S, v16.8H, v27.8H
    smlsl     v8.4S, v14.4H, v12.4H
    smlsl2    v9.4S, v14.8H, v12.8H
    smlal     v8.4S, v17.4H, v26.4H
    smlal2    v9.4S, v17.8H, v26.8H
    smlal     v8.4S, v18.4H, v25.4H
    smlal2    v9.4S, v18.8H, v25.8H
    smlal     v8.4S, v19.4H, v24.4H
    smlal2    v9.4S, v19.8H, v24.8H
    montgomery_long v8, v9, v10
    str  q8, [x0, #3*16]

    // 2, 6, 10, 14

    // 14
    smull    v14.4S, v23.4H, v31.4H
    smull2    v9.4S, v23.8H, v31.8H
    montgomery_long v14, v9, v10

    // 10
    smull    v15.4S, v19.4H, v31.4H
    smull2    v9.4S, v19.8H, v31.8H
    smlsl    v15.4S, v14.4H, v13.4H
    smlsl2    v9.4S, v14.8H, v13.8H
    smlal    v15.4S, v20.4H, v30.4H
    smlal2    v9.4S, v20.8H, v30.8H
    smlal    v15.4S, v21.4H, v29.4H
    smlal2    v9.4S, v21.8H, v29.8H
    smlal    v15.4S, v22.4H, v28.4H
    smlal2    v9.4S, v22.8H, v28.8H
    smlal    v15.4S, v23.4H, v27.4H
    smlal2    v9.4S, v23.8H, v27.8H
    montgomery_long v15, v9, v10

    // 6
    smull     v8.4S, v16.4H, v30.4H
    smull2    v9.4S, v16.8H, v30.8H
    smlsl     v8.4S, v14.4H, v12.4H
    smlsl2    v9.4S, v14.8H, v12.8H
    smlsl     v8.4S, v15.4H, v13.4H
    smlsl2    v9.4S, v15.8H, v13.8H
    smlal     v8.4S, v17.4H, v29.4H
    smlal2    v9.4S, v17.8H, v29.8H
    smlal     v8.4S, v18.4H, v28.4H
    smlal2    v9.4S, v18.8H, v28.8H
    smlal     v8.4S, v19.4H, v27.4H
    smlal2    v9.4S, v19.8H, v27.8H
    smlal     v8.4S, v20.4H, v26.4H
    smlal2    v9.4S, v20.8H, v26.8H
    smlal     v8.4S, v21.4H, v25.4H
    smlal2    v9.4S, v21.8H, v25.8H
    smlal     v8.4S, v22.4H, v24.4H
    smlal2    v9.4S, v22.8H, v24.8H
    montgomery_long v8, v9, v10
    str  q8, [x0, #6*16]

    // 2
    smull     v8.4S, v16.4H, v26.4H
    smull2    v9.4S, v16.8H, v26.8H
    smlsl     v8.4S, v15.4H, v12.4H
    smlsl2    v9.4S, v15.8H, v12.8H
    smlal     v8.4S, v17.4H, v25.4H
    smlal2    v9.4S, v17.8H, v25.8H
    smlal     v8.4S, v18.4H, v24.4H
    smlal2    v9.4S, v18.8H, v24.8H
    montgomery_long v8, v9, v10
    str  q8, [x0, #2*16]

    // 1, 5, 9, 13

    // 13
    smull    v14.4S, v23.4H, v30.4H
    smull2    v9.4S, v23.8H, v30.8H
    smlal    v14.4S, v22.4H, v31.4H
    smlal2    v9.4S, v22.8H, v31.8H
    montgomery_long v14, v9, v6

    // 9
    smull    v15.4S, v18.4H, v31.4H
    smull2    v9.4S, v18.8H, v31.8H
    smlsl    v15.4S, v14.4H, v13.4H
    smlsl2    v9.4S, v14.8H, v13.8H
    smlal    v15.4S, v19.4H, v30.4H
    smlal2    v9.4S, v19.8H, v30.8H
    smlal    v15.4S, v20.4H, v29.4H
    smlal2    v9.4S, v20.8H, v29.8H
    smlal    v15.4S, v21.4H, v28.4H
    smlal2    v9.4S, v21.8H, v28.8H
    smlal    v15.4S, v22.4H, v27.4H
    smlal2    v9.4S, v22.8H, v27.8H
    smlal    v15.4S, v23.4H, v26.4H
    smlal2    v9.4S, v23.8H, v26.8H
    montgomery_long v15, v9, v10

    // 5
    smull     v8.4S, v16.4H, v29.4H
    smull2    v9.4S, v16.8H, v29.8H
    smlsl     v8.4S, v14.4H, v12.4H
    smlsl2    v9.4S, v14.8H, v12.8H
    smlsl     v8.4S, v15.4H, v13.4H
    smlsl2    v9.4S, v15.8H, v13.8H
    smlal     v8.4S, v17.4H, v28.4H
    smlal2    v9.4S, v17.8H, v28.8H
    smlal     v8.4S, v18.4H, v27.4H
    smlal2    v9.4S, v18.8H, v27.8H
    smlal     v8.4S, v19.4H, v26.4H
    smlal2    v9.4S, v19.8H, v26.8H
    smlal     v8.4S, v20.4H, v25.4H
    smlal2    v9.4S, v20.8H, v25.8H
    smlal     v8.4S, v21.4H, v24.4H
    smlal2    v9.4S, v21.8H, v24.8H
    montgomery_long v8, v9, v10
    str  q8, [x0, #5*16]

    // 1
    smull     v8.4S, v16.4H, v25.4H
    smull2    v9.4S, v16.8H, v25.8H
    smlsl     v8.4S, v15.4H, v12.4H
    smlsl2    v9.4S, v15.8H, v12.8H
    smlal     v8.4S, v17.4H, v24.4H
    smlal2    v9.4S, v17.8H, v24.8H
    montgomery_long v8, v9, v10
    str  q8, [x0, #1*16]

    // 0, 4, 8, 12

    // 12
    smull    v14.4S, v23.4H, v29.4H
    smull2    v9.4S, v23.8H, v29.8H
    smlal    v14.4S, v22.4H, v30.4H
    smlal2    v9.4S, v22.8H, v30.8H
    smlal    v14.4S, v21.4H, v31.4H
    smlal2    v9.4S, v21.8H, v31.8H
    montgomery_long v14, v9, v10

    // 8
    smull    v15.4S, v17.4H, v31.4H
    smull2    v9.4S, v17.8H, v31.8H
    smlsl    v15.4S, v14.4H, v13.4H
    smlsl2    v9.4S, v14.8H, v13.8H
    smlal    v15.4S, v18.4H, v30.4H
    smlal2    v9.4S, v18.8H, v30.8H
    smlal    v15.4S, v19.4H, v29.4H
    smlal2    v9.4S, v19.8H, v29.8H
    smlal    v15.4S, v20.4H, v28.4H
    smlal2    v9.4S, v20.8H, v28.8H
    smlal    v15.4S, v21.4H, v27.4H
    smlal2    v9.4S, v21.8H, v27.8H
    smlal    v15.4S, v22.4H, v26.4H
    smlal2    v9.4S, v22.8H, v26.8H
    smlal    v15.4S, v23.4H, v25.4H
    smlal2    v9.4S, v23.8H, v25.8H
    montgomery_long v15, v9, v10

    // 4
    smull     v8.4S, v16.4H, v28.4H
    smull2    v9.4S, v16.8H, v28.8H
    smlsl     v8.4S, v14.4H, v12.4H
    smlsl2    v9.4S, v14.8H, v12.8H
    smlsl     v8.4S, v15.4H, v13.4H
    smlsl2    v9.4S, v15.8H, v13.8H
    smlal     v8.4S, v17.4H, v27.4H
    smlal2    v9.4S, v17.8H, v27.8H
    smlal     v8.4S, v18.4H, v26.4H
    smlal2    v9.4S, v18.8H, v26.8H
    smlal     v8.4S, v19.4H, v25.4H
    smlal2    v9.4S, v19.8H, v25.8H
    smlal     v8.4S, v20.4H, v24.4H
    smlal2    v9.4S, v20.8H, v24.8H
    montgomery_long v8, v9, v10
    str  q8, [x0, #4*16]

    // 0
    smull     v8.4S, v16.4H, v24.4H
    smull2    v9.4S, v16.8H, v24.8H
    smlsl     v8.4S, v15.4H, v12.4H
    smlsl2    v9.4S, v15.8H, v12.8H
    montgomery_long v8, v9, v10
    str  q8, [x0, #0*16]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr



