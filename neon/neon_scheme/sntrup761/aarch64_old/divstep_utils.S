
.align 6
.global __asm_mul_f0g0
.global ___asm_mul_f0g0
__asm_mul_f0g0:
___asm_mul_f0g0:


    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    mov v0.S[0], w2
    mov w4, #-15631
    mov w5, #4591
    mov v0.H[2], w4
    mov v0.H[3], w5
    mov w6, #-433
    mov w7, #-18015
    mov v0.H[4], w6
    mov v0.H[5], w7
    dup v1.8H, w3

    ldr q16, [x0, #0*16]
    ldr q17, [x0, #1*16]
    ldr q18, [x0, #2*16]
    ldr q19, [x0, #3*16]
    add x0, x0, #4*16
    ldr q20, [x1, #0*16]
    ldr q21, [x1, #1*16]
    ldr q22, [x1, #2*16]
    ldr q23, [x1, #3*16]
    add x1, x1, #4*16

    eor v12.16B, v16.16B, v20.16B
    eor v13.16B, v17.16B, v21.16B
    eor v14.16B, v18.16B, v22.16B
    eor v15.16B, v19.16B, v23.16B

    and v28.16B, v12.16B,  v1.16B
    and v29.16B, v13.16B,  v1.16B
    and v30.16B, v14.16B,  v1.16B
    and v31.16B, v15.16B,  v1.16B

    eor v16.16B, v16.16B, v28.16B
    eor v17.16B, v17.16B, v29.16B
    eor v18.16B, v18.16B, v30.16B
    eor v19.16B, v19.16B, v31.16B

    eor v20.16B, v20.16B, v28.16B
    eor v21.16B, v21.16B, v29.16B
    eor v22.16B, v22.16B, v30.16B
    eor v23.16B, v23.16B, v31.16B

    str q20, [x1, #-4*16]
    str q21, [x1, #-3*16]
    str q22, [x1, #-2*16]
    str q23, [x1, #-1*16]

    smull   v24.4S, v16.4H, v0.H[0]
    smull2  v25.4S, v16.8H, v0.H[0]
    smull   v26.4S, v17.4H, v0.H[0]
    smull2  v27.4S, v17.8H, v0.H[0]
    smull   v28.4S, v18.4H, v0.H[0]
    smull2  v29.4S, v18.8H, v0.H[0]
    smull   v30.4S, v19.4H, v0.H[0]
    smull2  v31.4S, v19.8H, v0.H[0]

    smlsl   v24.4S, v20.4H, v0.H[1]
    smlsl2  v25.4S, v20.8H, v0.H[1]
    smlsl   v26.4S, v21.4H, v0.H[1]
    smlsl2  v27.4S, v21.8H, v0.H[1]
    smlsl   v28.4S, v22.4H, v0.H[1]
    smlsl2  v29.4S, v22.8H, v0.H[1]
    smlsl   v30.4S, v23.4H, v0.H[1]
    smlsl2  v31.4S, v23.8H, v0.H[1]

.rept 23

    uzp1     v4.8H, v24.8H, v25.8H
    uzp1     v5.8H, v26.8H, v27.8H
    uzp1     v6.8H, v28.8H, v29.8H
    uzp1     v7.8H, v30.8H, v31.8H

    mul      v4.8H,  v4.8H, v0.H[2]
    ldr q16, [x0, #0*16]
    mul      v5.8H,  v5.8H, v0.H[2]
    ldr q17, [x0, #1*16]
    mul      v6.8H,  v6.8H, v0.H[2]
    ldr q18, [x0, #2*16]
    mul      v7.8H,  v7.8H, v0.H[2]
    ldr q19, [x0, #3*16]

    smlal   v24.4S,  v4.4H, v0.H[3]
    ldr q20, [x1, #0*16]
    smlal2  v25.4S,  v4.8H, v0.H[3]
    ldr q21, [x1, #1*16]
    smlal   v26.4S,  v5.4H, v0.H[3]
    ldr q22, [x1, #2*16]
    smlal2  v27.4S,  v5.8H, v0.H[3]
    ldr q23, [x1, #3*16]
    add x1, x1, #4*16
    smlal   v28.4S,  v6.4H, v0.H[3]
    eor v12.16B, v16.16B, v20.16B
    smlal2  v29.4S,  v6.8H, v0.H[3]
    eor v13.16B, v17.16B, v21.16B
    smlal   v30.4S,  v7.4H, v0.H[3]
    eor v14.16B, v18.16B, v22.16B
    smlal2  v31.4S,  v7.8H, v0.H[3]
    eor v15.16B, v19.16B, v23.16B

    uzp2     v4.8H, v24.8H, v25.8H
    uzp2     v5.8H, v26.8H, v27.8H
    uzp2     v6.8H, v28.8H, v29.8H
    uzp2     v7.8H, v30.8H, v31.8H

    mul      v8.8H,  v4.8H, v0.H[5]
    and v28.16B, v12.16B,  v1.16B
    mul      v9.8H,  v5.8H, v0.H[5]
    and v29.16B, v13.16B,  v1.16B
    mul     v10.8H,  v6.8H, v0.H[5]
    and v30.16B, v14.16B,  v1.16B
    mul     v11.8H,  v7.8H, v0.H[5]
    and v31.16B, v15.16B,  v1.16B

    sqdmulh v12.8H,  v4.8H, v0.H[4]
    eor v16.16B, v16.16B, v28.16B
    sqdmulh v13.8H,  v5.8H, v0.H[4]
    eor v17.16B, v17.16B, v29.16B
    sqdmulh v14.8H,  v6.8H, v0.H[4]
    eor v18.16B, v18.16B, v30.16B
    sqdmulh v15.8H,  v7.8H, v0.H[4]
    eor v19.16B, v19.16B, v31.16B

    sqdmulh  v8.8H,  v8.8H, v0.H[3]
    eor v20.16B, v20.16B, v28.16B
    sqdmulh  v9.8H,  v9.8H, v0.H[3]
    eor v21.16B, v21.16B, v29.16B
    sqdmulh v10.8H, v10.8H, v0.H[3]
    eor v22.16B, v22.16B, v30.16B
    sqdmulh v11.8H, v11.8H, v0.H[3]
    eor v23.16B, v23.16B, v31.16B

    smull   v24.4S, v16.4H, v0.H[0]
    str q20, [x1, #-4*16]
    smull2  v25.4S, v16.8H, v0.H[0]
    str q21, [x1, #-3*16]
    smull   v26.4S, v17.4H, v0.H[0]
    str q22, [x1, #-2*16]
    smull2  v27.4S, v17.8H, v0.H[0]
    str q23, [x1, #-1*16]
    smull   v28.4S, v18.4H, v0.H[0]
    shsub    v4.8H, v12.8H,  v8.8H
    smull2  v29.4S, v18.8H, v0.H[0]
    shsub    v5.8H, v13.8H,  v9.8H
    smull   v30.4S, v19.4H, v0.H[0]
    shsub    v6.8H, v14.8H, v10.8H
    smull2  v31.4S, v19.8H, v0.H[0]
    shsub    v7.8H, v15.8H, v11.8H

    smlsl   v24.4S, v20.4H, v0.H[1]
    str  q4, [x0, #-4*16]
    smlsl2  v25.4S, v20.8H, v0.H[1]
    str  q5, [x0, #-3*16]
    smlsl   v26.4S, v21.4H, v0.H[1]
    str  q6, [x0, #-2*16]
    smlsl2  v27.4S, v21.8H, v0.H[1]
    str  q7, [x0, #-1*16]
    smlsl   v28.4S, v22.4H, v0.H[1]
    smlsl2  v29.4S, v22.8H, v0.H[1]
    smlsl   v30.4S, v23.4H, v0.H[1]
    smlsl2  v31.4S, v23.8H, v0.H[1]

    add x0, x0, #4*16

.endr

    uzp1     v4.8H, v24.8H, v25.8H
    uzp1     v5.8H, v26.8H, v27.8H
    uzp1     v6.8H, v28.8H, v29.8H
    uzp1     v7.8H, v30.8H, v31.8H

    mul      v4.8H,  v4.8H, v0.H[2]
    mul      v5.8H,  v5.8H, v0.H[2]
    mul      v6.8H,  v6.8H, v0.H[2]
    mul      v7.8H,  v7.8H, v0.H[2]

    smlal   v24.4S,  v4.4H, v0.H[3]
    smlal2  v25.4S,  v4.8H, v0.H[3]
    smlal   v26.4S,  v5.4H, v0.H[3]
    smlal2  v27.4S,  v5.8H, v0.H[3]
    smlal   v28.4S,  v6.4H, v0.H[3]
    smlal2  v29.4S,  v6.8H, v0.H[3]
    smlal   v30.4S,  v7.4H, v0.H[3]
    smlal2  v31.4S,  v7.8H, v0.H[3]

    uzp2     v4.8H, v24.8H, v25.8H
    uzp2     v5.8H, v26.8H, v27.8H
    uzp2     v6.8H, v28.8H, v29.8H
    uzp2     v7.8H, v30.8H, v31.8H

    mul      v8.8H,  v4.8H, v0.H[5]
    mul      v9.8H,  v5.8H, v0.H[5]
    mul     v10.8H,  v6.8H, v0.H[5]
    mul     v11.8H,  v7.8H, v0.H[5]

    sqdmulh v12.8H,  v4.8H, v0.H[4]
    sqdmulh v13.8H,  v5.8H, v0.H[4]
    sqdmulh v14.8H,  v6.8H, v0.H[4]
    sqdmulh v15.8H,  v7.8H, v0.H[4]

    sqdmulh  v8.8H,  v8.8H, v0.H[3]
    sqdmulh  v9.8H,  v9.8H, v0.H[3]
    sqdmulh v10.8H, v10.8H, v0.H[3]
    sqdmulh v11.8H, v11.8H, v0.H[3]

    shsub    v4.8H, v12.8H,  v8.8H
    shsub    v5.8H, v13.8H,  v9.8H
    shsub    v6.8H, v14.8H, v10.8H
    shsub    v7.8H, v15.8H, v11.8H

    str  q4, [x0, #-4*16]
    str  q5, [x0, #-3*16]
    str  q6, [x0, #-2*16]
    str  q7, [x0, #-1*16]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr


