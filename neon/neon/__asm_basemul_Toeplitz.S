
.align 6
.global __asm_negacyclic_Toeplitz8
.global ___asm_negacyclic_Toeplitz8
__asm_negacyclic_Toeplitz8:
___asm_negacyclic_Toeplitz8:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr s4, [x3]

    ldr  q0, [x1, #0*16]

    ldr q16, [x2, #0*16]
    neg v24.8H, v16.8H

    ext v17.16B, v24.16B, v16.16B, #14
    ext v18.16B, v24.16B, v16.16B, #12
    ext v19.16B, v24.16B, v16.16B, #10
    ext v20.16B, v24.16B, v16.16B,  #8
    ext v21.16B, v24.16B, v16.16B,  #6
    ext v22.16B, v24.16B, v16.16B,  #4
    ext v23.16B, v24.16B, v16.16B,  #2

    smull  v12.4S, v16.4H,  v0.H[0]
    smull2 v13.4S, v16.8H,  v0.H[0]

    smlal  v12.4S, v17.4H,  v0.H[1]
    smlal2 v13.4S, v17.8H,  v0.H[1]

    smlal  v12.4S, v18.4H,  v0.H[2]
    smlal2 v13.4S, v18.8H,  v0.H[2]

    smlal  v12.4S, v19.4H,  v0.H[3]
    smlal2 v13.4S, v19.8H,  v0.H[3]

    smlal  v12.4S, v20.4H,  v0.H[4]
    smlal2 v13.4S, v20.8H,  v0.H[4]

    smlal  v12.4S, v21.4H,  v0.H[5]
    smlal2 v13.4S, v21.8H,  v0.H[5]

    smlal  v12.4S, v22.4H,  v0.H[6]
    smlal2 v13.4S, v22.8H,  v0.H[6]

    smlal  v12.4S, v23.4H,  v0.H[7]
    smlal2 v13.4S, v23.8H,  v0.H[7]

    uzp1    v8.8H, v12.8H, v13.8H
    mul     v8.8H,  v8.8H,  v4.H[1]
    smlal  v12.4S,  v8.4H,  v4.H[0]
    smlal2 v13.4S,  v8.8H,  v4.H[0]
    uzp2    v8.8H, v12.8H, v13.8H

    str q8, [x0, #0*16]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_cyclic_Toeplitz16
.global ___asm_cyclic_Toeplitz16
__asm_cyclic_Toeplitz16:
___asm_cyclic_Toeplitz16:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr s4, [x3]

    ldr  q0, [x1, #0*16]
    ldr  q1, [x1, #1*16]

    ldr q16, [x2, #0*16]
    ldr q17, [x2, #1*16]

    ext v18.16B, v17.16B, v16.16B, #14
    ext v19.16B, v16.16B, v17.16B, #14
    ext v20.16B, v17.16B, v16.16B, #12
    ext v21.16B, v16.16B, v17.16B, #12
    ext v22.16B, v17.16B, v16.16B, #10
    ext v23.16B, v16.16B, v17.16B, #10
    ext v24.16B, v17.16B, v16.16B,  #8
    ext v25.16B, v16.16B, v17.16B,  #8
    ext v26.16B, v17.16B, v16.16B,  #6
    ext v27.16B, v16.16B, v17.16B,  #6
    ext v28.16B, v17.16B, v16.16B,  #4
    ext v29.16B, v16.16B, v17.16B,  #4
    ext v30.16B, v17.16B, v16.16B,  #2
    ext v31.16B, v16.16B, v17.16B,  #2

    smull  v12.4S, v16.4H,  v0.H[0]
    smull2 v13.4S, v16.8H,  v0.H[0]
    smull  v14.4S, v17.4H,  v0.H[0]
    smull2 v15.4S, v17.8H,  v0.H[0]

    smlal  v12.4S, v18.4H,  v0.H[1]
    smlal2 v13.4S, v18.8H,  v0.H[1]
    smlal  v14.4S, v19.4H,  v0.H[1]
    smlal2 v15.4S, v19.8H,  v0.H[1]

    smlal  v12.4S, v20.4H,  v0.H[2]
    smlal2 v13.4S, v20.8H,  v0.H[2]
    smlal  v14.4S, v21.4H,  v0.H[2]
    smlal2 v15.4S, v21.8H,  v0.H[2]

    smlal  v12.4S, v22.4H,  v0.H[3]
    smlal2 v13.4S, v22.8H,  v0.H[3]
    smlal  v14.4S, v23.4H,  v0.H[3]
    smlal2 v15.4S, v23.8H,  v0.H[3]

    smlal  v12.4S, v24.4H,  v0.H[4]
    smlal2 v13.4S, v24.8H,  v0.H[4]
    smlal  v14.4S, v25.4H,  v0.H[4]
    smlal2 v15.4S, v25.8H,  v0.H[4]

    smlal  v12.4S, v26.4H,  v0.H[5]
    smlal2 v13.4S, v26.8H,  v0.H[5]
    smlal  v14.4S, v27.4H,  v0.H[5]
    smlal2 v15.4S, v27.8H,  v0.H[5]

    smlal  v12.4S, v28.4H,  v0.H[6]
    smlal2 v13.4S, v28.8H,  v0.H[6]
    smlal  v14.4S, v29.4H,  v0.H[6]
    smlal2 v15.4S, v29.8H,  v0.H[6]

    smlal  v12.4S, v30.4H,  v0.H[7]
    smlal2 v13.4S, v30.8H,  v0.H[7]
    smlal  v14.4S, v31.4H,  v0.H[7]
    smlal2 v15.4S, v31.8H,  v0.H[7]

    smlal  v12.4S, v17.4H,  v1.H[0]
    smlal2 v13.4S, v17.8H,  v1.H[0]
    smlal  v14.4S, v16.4H,  v1.H[0]
    smlal2 v15.4S, v16.8H,  v1.H[0]

    smlal  v12.4S, v19.4H,  v1.H[1]
    smlal2 v13.4S, v19.8H,  v1.H[1]
    smlal  v14.4S, v18.4H,  v1.H[1]
    smlal2 v15.4S, v18.8H,  v1.H[1]

    smlal  v12.4S, v21.4H,  v1.H[2]
    smlal2 v13.4S, v21.8H,  v1.H[2]
    smlal  v14.4S, v20.4H,  v1.H[2]
    smlal2 v15.4S, v20.8H,  v1.H[2]

    smlal  v12.4S, v23.4H,  v1.H[3]
    smlal2 v13.4S, v23.8H,  v1.H[3]
    smlal  v14.4S, v22.4H,  v1.H[3]
    smlal2 v15.4S, v22.8H,  v1.H[3]

    smlal  v12.4S, v25.4H,  v1.H[4]
    smlal2 v13.4S, v25.8H,  v1.H[4]
    smlal  v14.4S, v24.4H,  v1.H[4]
    smlal2 v15.4S, v24.8H,  v1.H[4]

    smlal  v12.4S, v27.4H,  v1.H[5]
    smlal2 v13.4S, v27.8H,  v1.H[5]
    smlal  v14.4S, v26.4H,  v1.H[5]
    smlal2 v15.4S, v26.8H,  v1.H[5]

    smlal  v12.4S, v29.4H,  v1.H[6]
    smlal2 v13.4S, v29.8H,  v1.H[6]
    smlal  v14.4S, v28.4H,  v1.H[6]
    smlal2 v15.4S, v28.8H,  v1.H[6]

    smlal  v12.4S, v31.4H,  v1.H[7]
    smlal2 v13.4S, v31.8H,  v1.H[7]
    smlal  v14.4S, v30.4H,  v1.H[7]
    smlal2 v15.4S, v30.8H,  v1.H[7]

    uzp1    v8.8H, v12.8H, v13.8H
    mul     v8.8H,  v8.8H,  v4.H[0]
    smlal  v12.4S,  v8.4H,  v4.H[1]
    smlal2 v13.4S,  v8.8H,  v4.H[1]
    uzp2    v8.8H, v12.8H, v13.8H

    str q8, [x0, #0*16]

    uzp1    v9.8H, v14.8H, v15.8H
    mul     v9.8H,  v9.8H,  v4.H[0]
    smlal  v14.4S,  v9.4H,  v4.H[1]
    smlal2 v15.4S,  v9.8H,  v4.H[1]
    uzp2    v9.8H, v14.8H, v15.8H

    str q9, [x0, #1*16]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_cyclic_Toeplitz16_doubling
.global ___asm_cyclic_Toeplitz16_doubling
__asm_cyclic_Toeplitz16_doubling:
___asm_cyclic_Toeplitz16_doubling:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr s4, [x3]

    ldr  q8, [x1, #0*16]
    ldr  q9, [x1, #1*16]

    add  v0.8H,  v8.8H,  v9.8H
    sub  v1.8H,  v8.8H,  v9.8H

    ldr q24, [x2, #0*16]
    ldr q25, [x2, #1*16]

    add v16.8H, v24.8H, v25.8H
    sub v17.8H, v24.8H, v25.8H
    neg v18.8H, v17.8H

    ext v25.16B, v16.16B, v16.16B, #14
    ext v26.16B, v16.16B, v16.16B, #12
    ext v27.16B, v16.16B, v16.16B, #10
    ext v28.16B, v16.16B, v16.16B,  #8
    ext v29.16B, v16.16B, v16.16B,  #6
    ext v30.16B, v16.16B, v16.16B,  #4
    ext v31.16B, v16.16B, v16.16B,  #2

    smull  v12.4S, v16.4H,  v0.H[0]
    smull2 v13.4S, v16.8H,  v0.H[0]
    smlal  v12.4S, v25.4H,  v0.H[1]
    smlal2 v13.4S, v25.8H,  v0.H[1]
    smlal  v12.4S, v26.4H,  v0.H[2]
    smlal2 v13.4S, v26.8H,  v0.H[2]
    smlal  v12.4S, v27.4H,  v0.H[3]
    smlal2 v13.4S, v27.8H,  v0.H[3]
    smlal  v12.4S, v28.4H,  v0.H[4]
    smlal2 v13.4S, v28.8H,  v0.H[4]
    smlal  v12.4S, v29.4H,  v0.H[5]
    smlal2 v13.4S, v29.8H,  v0.H[5]
    smlal  v12.4S, v30.4H,  v0.H[6]
    smlal2 v13.4S, v30.8H,  v0.H[6]
    smlal  v12.4S, v31.4H,  v0.H[7]
    smlal2 v13.4S, v31.8H,  v0.H[7]

    uzp1    v8.8H, v12.8H, v13.8H
    mul     v8.8H,  v8.8H,  v4.H[0]
    smlal  v12.4S,  v8.4H,  v4.H[1]
    smlal2 v13.4S,  v8.8H,  v4.H[1]
    uzp2    v8.8H, v12.8H, v13.8H

    ext v25.16B, v18.16B, v17.16B, #14
    ext v26.16B, v18.16B, v17.16B, #12
    ext v27.16B, v18.16B, v17.16B, #10
    ext v28.16B, v18.16B, v17.16B,  #8
    ext v29.16B, v18.16B, v17.16B,  #6
    ext v30.16B, v18.16B, v17.16B,  #4
    ext v31.16B, v18.16B, v17.16B,  #2

    smull  v12.4S, v17.4H,  v1.H[0]
    smull2 v13.4S, v17.8H,  v1.H[0]
    smlal  v12.4S, v25.4H,  v1.H[1]
    smlal2 v13.4S, v25.8H,  v1.H[1]
    smlal  v12.4S, v26.4H,  v1.H[2]
    smlal2 v13.4S, v26.8H,  v1.H[2]
    smlal  v12.4S, v27.4H,  v1.H[3]
    smlal2 v13.4S, v27.8H,  v1.H[3]
    smlal  v12.4S, v28.4H,  v1.H[4]
    smlal2 v13.4S, v28.8H,  v1.H[4]
    smlal  v12.4S, v29.4H,  v1.H[5]
    smlal2 v13.4S, v29.8H,  v1.H[5]
    smlal  v12.4S, v30.4H,  v1.H[6]
    smlal2 v13.4S, v30.8H,  v1.H[6]
    smlal  v12.4S, v31.4H,  v1.H[7]
    smlal2 v13.4S, v31.8H,  v1.H[7]

    uzp1    v9.8H, v12.8H, v13.8H
    mul     v9.8H,  v9.8H,  v4.H[0]
    smlal  v12.4S,  v9.4H,  v4.H[1]
    smlal2 v13.4S,  v9.8H,  v4.H[1]
    uzp2    v9.8H, v12.8H, v13.8H

    add  v0.8H,  v8.8H,  v9.8H
    sub  v1.8H,  v8.8H,  v9.8H

    str  q0, [x0, #0*16]
    str  q1, [x0, #1*16]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_cyclic_Toeplitz16_doubling_full
.global ___asm_cyclic_Toeplitz16_doubling_full
__asm_cyclic_Toeplitz16_doubling_full:
___asm_cyclic_Toeplitz16_doubling_full:

    counter     .req  x8

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr s4, [x3]

    ldr  q8, [x1, #0*16]
    ldr  q1, [x1, #1*16]

    add  v0.8H,  v8.8H,  v1.8H
    sub  v1.8H,  v8.8H,  v1.8H

    ldr q24, [x2, #0*16]
    ldr q25, [x2, #1*16]

    sub v16.8H, v25.8H, v24.8H
    add v24.8H, v24.8H, v25.8H

    ext v25.16B, v24.16B, v24.16B, #14
    ext v26.16B, v24.16B, v24.16B, #12
    ext v27.16B, v24.16B, v24.16B, #10

    smull  v12.4S, v24.4H,  v0.H[0]
    ext v28.16B, v24.16B, v24.16B,  #8
    smull2 v13.4S, v24.8H,  v0.H[0]
    ext v29.16B, v24.16B, v24.16B,  #6
    smlal  v12.4S, v25.4H,  v0.H[1]
    ext v30.16B, v24.16B, v24.16B,  #4
    smlal2 v13.4S, v25.8H,  v0.H[1]
    ext v31.16B, v24.16B, v24.16B,  #2
    smlal  v12.4S, v26.4H,  v0.H[2]
    smlal2 v13.4S, v26.8H,  v0.H[2]
    smlal  v12.4S, v27.4H,  v0.H[3]
    smlal2 v13.4S, v27.8H,  v0.H[3]

    smlal  v12.4S, v28.4H,  v0.H[4]
    smlal2 v13.4S, v28.8H,  v0.H[4]
    smlal  v12.4S, v29.4H,  v0.H[5]
    smlal2 v13.4S, v29.8H,  v0.H[5]
    neg v24.8H, v16.8H
    smlal  v12.4S, v30.4H,  v0.H[6]
    ext v25.16B, v16.16B, v24.16B, #14
    smlal2 v13.4S, v30.8H,  v0.H[6]
    ext v26.16B, v16.16B, v24.16B, #12
    smlal  v12.4S, v31.4H,  v0.H[7]
    ext v27.16B, v16.16B, v24.16B, #10
    smlal2 v13.4S, v31.8H,  v0.H[7]

    smull  v14.4S, v24.4H,  v1.H[0]
    uzp1    v6.8H, v12.8H, v13.8H
    smull2 v15.4S, v24.8H,  v1.H[0]
    mul     v6.8H,  v6.8H,  v4.H[0]
    smlal  v14.4S, v25.4H,  v1.H[1]
    smlal  v12.4S,  v6.4H,  v4.H[1]
    smlal2 v15.4S, v25.8H,  v1.H[1]
    smlal2 v13.4S,  v6.8H,  v4.H[1]
    smlal  v14.4S, v26.4H,  v1.H[2]
    uzp2    v6.8H, v12.8H, v13.8H
    smlal2 v15.4S, v26.8H,  v1.H[2]

    smlal  v14.4S, v27.4H,  v1.H[3]
    smlal2 v15.4S, v27.8H,  v1.H[3]

    ldr  q9, [x1, #(64+0*16)]
    ext v28.16B, v16.16B, v24.16B,  #8
    ext v29.16B, v16.16B, v24.16B,  #6
    ldr  q3, [x1, #(64+1*16)]
    ext v30.16B, v16.16B, v24.16B,  #4
    ext v31.16B, v16.16B, v24.16B,  #2

    ldr q24, [x2, #(64+0*16)]
    smlal  v14.4S, v28.4H,  v1.H[4]
    add  v2.8H,  v9.8H,  v3.8H
    ldr q25, [x2, #(64+1*16)]
    smlal2 v15.4S, v28.8H,  v1.H[4]
    sub  v3.8H,  v9.8H,  v3.8H
    smlal  v14.4S, v29.4H,  v1.H[5]
    sub v16.8H, v25.8H, v24.8H
    smlal2 v15.4S, v29.8H,  v1.H[5]
    add v24.8H, v24.8H, v25.8H
    smlal  v14.4S, v30.4H,  v1.H[6]
    ext v25.16B, v24.16B, v24.16B, #14
    smlal2 v15.4S, v30.8H,  v1.H[6]
    ext v26.16B, v24.16B, v24.16B, #12
    smlal  v14.4S, v31.4H,  v1.H[7]
    ext v27.16B, v24.16B, v24.16B, #10
    smlal2 v15.4S, v31.8H,  v1.H[7]

    smull  v12.4S, v24.4H,  v2.H[0]
    uzp1    v7.8H, v14.8H, v15.8H
    smull2 v13.4S, v24.8H,  v2.H[0]
    mul     v7.8H,  v7.8H,  v4.H[0]
    smlal  v12.4S, v25.4H,  v2.H[1]
    smlal  v14.4S,  v7.4H,  v4.H[1]
    smlal2 v13.4S, v25.8H,  v2.H[1]
    smlal2 v15.4S,  v7.8H,  v4.H[1]
    smlal  v12.4S, v26.4H,  v2.H[2]
    uzp2    v7.8H, v14.8H, v15.8H
    smlal2 v13.4S, v26.8H,  v2.H[2]

    smlal  v12.4S, v27.4H,  v2.H[3]
    add  v0.8H,  v6.8H,  v7.8H
    str  q0, [x0, #0*16]
    smlal2 v13.4S, v27.8H,  v2.H[3]
    sub  v1.8H,  v6.8H,  v7.8H
    str  q1, [x0, #1*16]

    ext v28.16B, v24.16B, v24.16B,  #8
    ext v29.16B, v24.16B, v24.16B,  #6
    ext v30.16B, v24.16B, v24.16B,  #4
    ext v31.16B, v24.16B, v24.16B,  #2

    smlal  v12.4S, v28.4H,  v2.H[4]
    smlal2 v13.4S, v28.8H,  v2.H[4]
    smlal  v12.4S, v29.4H,  v2.H[5]
    smlal2 v13.4S, v29.8H,  v2.H[5]
    neg v24.8H, v16.8H
    smlal  v12.4S, v30.4H,  v2.H[6]
    ext v25.16B, v16.16B, v24.16B, #14
    smlal2 v13.4S, v30.8H,  v2.H[6]
    ext v26.16B, v16.16B, v24.16B, #12
    smlal  v12.4S, v31.4H,  v2.H[7]
    ext v27.16B, v16.16B, v24.16B, #10
    smlal2 v13.4S, v31.8H,  v2.H[7]

    mov counter, #23
    __asm_cyclic_Toeplitz16_doubling_full_loop:

    smull  v14.4S, v24.4H,  v3.H[0]
    uzp1   v10.8H, v12.8H, v13.8H
    smull2 v15.4S, v24.8H,  v3.H[0]
    ext v28.16B, v16.16B, v24.16B,  #8
    mul    v10.8H, v10.8H,  v4.H[0]
    ext v29.16B, v16.16B, v24.16B,  #6
    smlal  v14.4S, v25.4H,  v3.H[1]
    ext v30.16B, v16.16B, v24.16B,  #4
    smlal  v12.4S, v10.4H,  v4.H[1]
    ext v31.16B, v16.16B, v24.16B,  #2
    smlal2 v15.4S, v25.8H,  v3.H[1]
    smlal2 v13.4S, v10.8H,  v4.H[1]
    ldr  q8, [x1, #(128+0*16)]
    smlal  v14.4S, v26.4H,  v3.H[2]
    uzp2   v10.8H, v12.8H, v13.8H
    smlal2 v15.4S, v26.8H,  v3.H[2]
    ldr  q1, [x1, #(128+1*16)]
    smlal  v14.4S, v27.4H,  v3.H[3]
    smlal2 v15.4S, v27.8H,  v3.H[3]

    ldr q24, [x2, #(128+0*16)]
    smlal  v14.4S, v28.4H,  v3.H[4]
    add  v0.8H,  v8.8H,  v1.8H
    ldr q25, [x2, #(128+1*16)]
    smlal2 v15.4S, v28.8H,  v3.H[4]
    sub  v1.8H,  v8.8H,  v1.8H
    smlal  v14.4S, v29.4H,  v3.H[5]
    add x0, x0, #128
    sub v16.8H, v25.8H, v24.8H
    smlal2 v15.4S, v29.8H,  v3.H[5]
    add x1, x1, #128
    add v24.8H, v24.8H, v25.8H
    smlal  v14.4S, v30.4H,  v3.H[6]
    ext v25.16B, v24.16B, v24.16B, #14
    smlal2 v15.4S, v30.8H,  v3.H[6]
    ext v26.16B, v24.16B, v24.16B, #12
    smlal  v14.4S, v31.4H,  v3.H[7]
    ext v27.16B, v24.16B, v24.16B, #10
    smlal2 v15.4S, v31.8H,  v3.H[7]

    smull  v12.4S, v24.4H,  v0.H[0]
    uzp1   v11.8H, v14.8H, v15.8H
    smull2 v13.4S, v24.8H,  v0.H[0]
    ext v28.16B, v24.16B, v24.16B,  #8
    mul    v11.8H, v11.8H,  v4.H[0]
    ext v29.16B, v24.16B, v24.16B,  #6
    smlal  v12.4S, v25.4H,  v0.H[1]
    ext v30.16B, v24.16B, v24.16B,  #4
    smlal  v14.4S, v11.4H,  v4.H[1]
    ext v31.16B, v24.16B, v24.16B,  #2
    smlal2 v13.4S, v25.8H,  v0.H[1]
    smlal2 v15.4S, v11.8H,  v4.H[1]
    smlal  v12.4S, v26.4H,  v0.H[2]
    uzp2   v11.8H, v14.8H, v15.8H
    smlal2 v13.4S, v26.8H,  v0.H[2]

    add  v2.8H, v10.8H, v11.8H
    smlal  v12.4S, v27.4H,  v0.H[3]
    sub  v3.8H, v10.8H, v11.8H
    smlal2 v13.4S, v27.8H,  v0.H[3]

    add x2, x2, #128

    str  q2, [x0, #(-64+0*16)]
    smlal  v12.4S, v28.4H,  v0.H[4]
    str  q3, [x0, #(-64+1*16)]
    smlal2 v13.4S, v28.8H,  v0.H[4]
    smlal  v12.4S, v29.4H,  v0.H[5]
    smlal2 v13.4S, v29.8H,  v0.H[5]
    neg v24.8H, v16.8H
    smlal  v12.4S, v30.4H,  v0.H[6]
    ext v25.16B, v16.16B, v24.16B, #14
    smlal2 v13.4S, v30.8H,  v0.H[6]
    ext v26.16B, v16.16B, v24.16B, #12
    smlal  v12.4S, v31.4H,  v0.H[7]
    ext v27.16B, v16.16B, v24.16B, #10
    smlal2 v13.4S, v31.8H,  v0.H[7]

    smull  v14.4S, v24.4H,  v1.H[0]
    uzp1    v6.8H, v12.8H, v13.8H
    smull2 v15.4S, v24.8H,  v1.H[0]
    ext v28.16B, v16.16B, v24.16B,  #8
    mul     v6.8H,  v6.8H,  v4.H[0]
    ext v29.16B, v16.16B, v24.16B,  #6
    smlal  v14.4S, v25.4H,  v1.H[1]
    ext v30.16B, v16.16B, v24.16B,  #4
    smlal  v12.4S,  v6.4H,  v4.H[1]
    ext v31.16B, v16.16B, v24.16B,  #2
    smlal2 v15.4S, v25.8H,  v1.H[1]
    ldr  q9, [x1, #(64+0*16)]
    smlal2 v13.4S,  v6.8H,  v4.H[1]
    smlal  v14.4S, v26.4H,  v1.H[2]
    uzp2    v6.8H, v12.8H, v13.8H
    ldr  q3, [x1, #(64+1*16)]
    smlal2 v15.4S, v26.8H,  v1.H[2]

    smlal  v14.4S, v27.4H,  v1.H[3]
    smlal2 v15.4S, v27.8H,  v1.H[3]

    ldr q24, [x2, #(64+0*16)]
    smlal  v14.4S, v28.4H,  v1.H[4]
    add  v2.8H,  v9.8H,  v3.8H
    ldr q25, [x2, #(64+1*16)]
    smlal2 v15.4S, v28.8H,  v1.H[4]
    sub  v3.8H,  v9.8H,  v3.8H
    smlal  v14.4S, v29.4H,  v1.H[5]
    sub v16.8H, v25.8H, v24.8H
    smlal2 v15.4S, v29.8H,  v1.H[5]
    add v24.8H, v24.8H, v25.8H
    smlal  v14.4S, v30.4H,  v1.H[6]
    ext v25.16B, v24.16B, v24.16B, #14
    smlal2 v15.4S, v30.8H,  v1.H[6]
    ext v26.16B, v24.16B, v24.16B, #12
    smlal  v14.4S, v31.4H,  v1.H[7]
    ext v27.16B, v24.16B, v24.16B, #10
    smlal2 v15.4S, v31.8H,  v1.H[7]

    smull  v12.4S, v24.4H,  v2.H[0]
    uzp1    v7.8H, v14.8H, v15.8H
    smull2 v13.4S, v24.8H,  v2.H[0]
    ext v28.16B, v24.16B, v24.16B,  #8
    mul     v7.8H,  v7.8H,  v4.H[0]
    ext v29.16B, v24.16B, v24.16B,  #6
    smlal  v12.4S, v25.4H,  v2.H[1]
    ext v30.16B, v24.16B, v24.16B,  #4
    smlal  v14.4S,  v7.4H,  v4.H[1]
    ext v31.16B, v24.16B, v24.16B,  #2
    smlal2 v13.4S, v25.8H,  v2.H[1]
    smlal2 v15.4S,  v7.8H,  v4.H[1]
    smlal  v12.4S, v26.4H,  v2.H[2]
    uzp2    v7.8H, v14.8H, v15.8H
    smlal2 v13.4S, v26.8H,  v2.H[2]

    smlal  v12.4S, v27.4H,  v2.H[3]
    add  v0.8H,  v6.8H,  v7.8H
    str  q0, [x0, #0*16]
    smlal2 v13.4S, v27.8H,  v2.H[3]
    sub  v1.8H,  v6.8H,  v7.8H
    str  q1, [x0, #1*16]

    smlal  v12.4S, v28.4H,  v2.H[4]
    smlal2 v13.4S, v28.8H,  v2.H[4]
    smlal  v12.4S, v29.4H,  v2.H[5]
    smlal2 v13.4S, v29.8H,  v2.H[5]
    neg v24.8H, v16.8H
    smlal  v12.4S, v30.4H,  v2.H[6]
    ext v25.16B, v16.16B, v24.16B, #14
    smlal2 v13.4S, v30.8H,  v2.H[6]
    ext v26.16B, v16.16B, v24.16B, #12
    smlal  v12.4S, v31.4H,  v2.H[7]
    ext v27.16B, v16.16B, v24.16B, #10
    smlal2 v13.4S, v31.8H,  v2.H[7]

    sub counter, counter, #1
    cbnz counter, __asm_cyclic_Toeplitz16_doubling_full_loop

    smull  v14.4S, v24.4H,  v3.H[0]
    uzp1   v10.8H, v12.8H, v13.8H
    smull2 v15.4S, v24.8H,  v3.H[0]
    ext v28.16B, v16.16B, v24.16B,  #8
    mul    v10.8H, v10.8H,  v4.H[0]
    ext v29.16B, v16.16B, v24.16B,  #6
    smlal  v14.4S, v25.4H,  v3.H[1]
    ext v30.16B, v16.16B, v24.16B,  #4
    smlal  v12.4S, v10.4H,  v4.H[1]
    ext v31.16B, v16.16B, v24.16B,  #2
    smlal2 v15.4S, v25.8H,  v3.H[1]
    smlal2 v13.4S, v10.8H,  v4.H[1]
    smlal  v14.4S, v26.4H,  v3.H[2]
    uzp2   v10.8H, v12.8H, v13.8H
    smlal2 v15.4S, v26.8H,  v3.H[2]
    smlal  v14.4S, v27.4H,  v3.H[3]
    smlal2 v15.4S, v27.8H,  v3.H[3]

    smlal  v14.4S, v28.4H,  v3.H[4]
    smlal2 v15.4S, v28.8H,  v3.H[4]
    smlal  v14.4S, v29.4H,  v3.H[5]
    smlal2 v15.4S, v29.8H,  v3.H[5]
    smlal  v14.4S, v30.4H,  v3.H[6]
    smlal2 v15.4S, v30.8H,  v3.H[6]
    smlal  v14.4S, v31.4H,  v3.H[7]
    smlal2 v15.4S, v31.8H,  v3.H[7]

    uzp1   v11.8H, v14.8H, v15.8H
    mul    v11.8H, v11.8H,  v4.H[0]
    smlal  v14.4S, v11.4H,  v4.H[1]
    smlal2 v15.4S, v11.8H,  v4.H[1]
    uzp2   v11.8H, v14.8H, v15.8H

    add  v2.8H, v10.8H, v11.8H
    sub  v3.8H, v10.8H, v11.8H

    str  q2, [x0, #(64+0*16)]
    str  q3, [x0, #(64+1*16)]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    .unreq counter

    br lr

.align 6
.global __asm_negacyclic_Toeplitz16
.global ___asm_negacyclic_Toeplitz16
__asm_negacyclic_Toeplitz16:
___asm_negacyclic_Toeplitz16:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr s4, [x3]

    ldr  q0, [x1, #0*16]
    ldr  q1, [x1, #1*16]

    ldr q16, [x2, #0*16]
    ldr q17, [x2, #1*16]
    neg v11.8H, v17.8H

    smull  v12.4S, v16.4H,  v0.H[0]
    ext v18.16B, v11.16B, v16.16B, #14
    smull2 v13.4S, v16.8H,  v0.H[0]
    ext v19.16B, v16.16B, v17.16B, #14
    smull  v14.4S, v17.4H,  v0.H[0]
    ext v20.16B, v11.16B, v16.16B, #12
    smull2 v15.4S, v17.8H,  v0.H[0]
    ext v21.16B, v16.16B, v17.16B, #12

    smlal  v12.4S, v18.4H,  v0.H[1]
    ext v22.16B, v11.16B, v16.16B, #10
    smlal2 v13.4S, v18.8H,  v0.H[1]
    ext v23.16B, v16.16B, v17.16B, #10
    smlal  v14.4S, v19.4H,  v0.H[1]
    ext v24.16B, v11.16B, v16.16B,  #8
    smlal2 v15.4S, v19.8H,  v0.H[1]
    ext v25.16B, v16.16B, v17.16B,  #8

    smlal  v12.4S, v20.4H,  v0.H[2]
    ext v26.16B, v11.16B, v16.16B,  #6
    smlal2 v13.4S, v20.8H,  v0.H[2]
    ext v27.16B, v16.16B, v17.16B,  #6
    smlal  v14.4S, v21.4H,  v0.H[2]
    ext v28.16B, v11.16B, v16.16B,  #4
    smlal2 v15.4S, v21.8H,  v0.H[2]
    ext v29.16B, v16.16B, v17.16B,  #4

    smlal  v12.4S, v22.4H,  v0.H[3]
    ext v30.16B, v11.16B, v16.16B,  #2
    smlal2 v13.4S, v22.8H,  v0.H[3]
    ext v31.16B, v16.16B, v17.16B,  #2

    smlal  v14.4S, v23.4H,  v0.H[3]
    smlal2 v15.4S, v23.8H,  v0.H[3]

    smlal  v12.4S, v24.4H,  v0.H[4]
    smlal2 v13.4S, v24.8H,  v0.H[4]
    smlal  v14.4S, v25.4H,  v0.H[4]
    smlal2 v15.4S, v25.8H,  v0.H[4]

    smlal  v12.4S, v26.4H,  v0.H[5]
    smlal2 v13.4S, v26.8H,  v0.H[5]
    smlal  v14.4S, v27.4H,  v0.H[5]
    smlal2 v15.4S, v27.8H,  v0.H[5]

    smlal  v12.4S, v28.4H,  v0.H[6]
    smlal2 v13.4S, v28.8H,  v0.H[6]
    smlal  v14.4S, v29.4H,  v0.H[6]
    smlal2 v15.4S, v29.8H,  v0.H[6]

    smlal  v12.4S, v30.4H,  v0.H[7]
    smlal2 v13.4S, v30.8H,  v0.H[7]
    smlal  v14.4S, v31.4H,  v0.H[7]
    smlal2 v15.4S, v31.8H,  v0.H[7]

    smlsl  v12.4S, v17.4H,  v1.H[0]
    smlsl2 v13.4S, v17.8H,  v1.H[0]
    smlal  v14.4S, v16.4H,  v1.H[0]
    smlal2 v15.4S, v16.8H,  v1.H[0]

    smlsl  v12.4S, v19.4H,  v1.H[1]
    smlsl2 v13.4S, v19.8H,  v1.H[1]
    smlal  v14.4S, v18.4H,  v1.H[1]
    smlal2 v15.4S, v18.8H,  v1.H[1]

    smlsl  v12.4S, v21.4H,  v1.H[2]
    smlsl2 v13.4S, v21.8H,  v1.H[2]
    smlal  v14.4S, v20.4H,  v1.H[2]
    smlal2 v15.4S, v20.8H,  v1.H[2]

    smlsl  v12.4S, v23.4H,  v1.H[3]
    smlsl2 v13.4S, v23.8H,  v1.H[3]
    smlal  v14.4S, v22.4H,  v1.H[3]
    smlal2 v15.4S, v22.8H,  v1.H[3]

    smlsl  v12.4S, v25.4H,  v1.H[4]
    smlsl2 v13.4S, v25.8H,  v1.H[4]
    smlal  v14.4S, v24.4H,  v1.H[4]
    smlal2 v15.4S, v24.8H,  v1.H[4]

    smlsl  v12.4S, v27.4H,  v1.H[5]
    smlsl2 v13.4S, v27.8H,  v1.H[5]
    smlal  v14.4S, v26.4H,  v1.H[5]
    smlal2 v15.4S, v26.8H,  v1.H[5]

    smlsl  v12.4S, v29.4H,  v1.H[6]
    smlsl2 v13.4S, v29.8H,  v1.H[6]
    smlal  v14.4S, v28.4H,  v1.H[6]
    smlal2 v15.4S, v28.8H,  v1.H[6]

    smlsl  v12.4S, v31.4H,  v1.H[7]
    smlsl2 v13.4S, v31.8H,  v1.H[7]
    smlal  v14.4S, v30.4H,  v1.H[7]
    smlal2 v15.4S, v30.8H,  v1.H[7]

    uzp1    v8.8H, v12.8H, v13.8H
    mul     v8.8H,  v8.8H,  v4.H[0]
    smlal  v12.4S,  v8.4H,  v4.H[1]
    smlal2 v13.4S,  v8.8H,  v4.H[1]
    uzp2    v8.8H, v12.8H, v13.8H

    str q8, [x0, #0*16]

    uzp1    v9.8H, v14.8H, v15.8H
    mul     v9.8H,  v9.8H,  v4.H[0]
    smlal  v14.4S,  v9.4H,  v4.H[1]
    smlal2 v15.4S,  v9.8H,  v4.H[1]
    uzp2    v9.8H, v14.8H, v15.8H

    str q9, [x0, #1*16]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_negacyclic_Toeplitz16_doubling
.global ___asm_negacyclic_Toeplitz16_doubling
__asm_negacyclic_Toeplitz16_doubling:
___asm_negacyclic_Toeplitz16_doubling:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr s4, [x3]

    ldr  q0, [x1, #0*16]
    ldr  q1, [x1, #1*16]

    ldr q16, [x2, #0*16]
    ldr q17, [x2, #1*16]
    neg v11.8H, v17.8H

    smull  v12.4S, v16.4H,  v0.H[0]
    ext v18.16B, v11.16B, v16.16B, #14
    smull2 v13.4S, v16.8H,  v0.H[0]
    ext v19.16B, v16.16B, v17.16B, #14
    smull  v14.4S, v17.4H,  v0.H[0]
    ext v20.16B, v11.16B, v16.16B, #12
    smull2 v15.4S, v17.8H,  v0.H[0]
    ext v21.16B, v16.16B, v17.16B, #12

    smlal  v12.4S, v18.4H,  v0.H[1]
    ext v22.16B, v11.16B, v16.16B, #10
    smlal2 v13.4S, v18.8H,  v0.H[1]
    ext v23.16B, v16.16B, v17.16B, #10
    smlal  v14.4S, v19.4H,  v0.H[1]
    ext v24.16B, v11.16B, v16.16B,  #8
    smlal2 v15.4S, v19.8H,  v0.H[1]
    ext v25.16B, v16.16B, v17.16B,  #8

    smlal  v12.4S, v20.4H,  v0.H[2]
    ext v26.16B, v11.16B, v16.16B,  #6
    smlal2 v13.4S, v20.8H,  v0.H[2]
    ext v27.16B, v16.16B, v17.16B,  #6
    smlal  v14.4S, v21.4H,  v0.H[2]
    ext v28.16B, v11.16B, v16.16B,  #4
    smlal2 v15.4S, v21.8H,  v0.H[2]
    ext v29.16B, v16.16B, v17.16B,  #4

    smlal  v12.4S, v22.4H,  v0.H[3]
    ext v30.16B, v11.16B, v16.16B,  #2
    smlal2 v13.4S, v22.8H,  v0.H[3]
    ext v31.16B, v16.16B, v17.16B,  #2

    smlal  v14.4S, v23.4H,  v0.H[3]
    smlal2 v15.4S, v23.8H,  v0.H[3]

    smlal  v12.4S, v24.4H,  v0.H[4]
    smlal2 v13.4S, v24.8H,  v0.H[4]
    smlal  v14.4S, v25.4H,  v0.H[4]
    smlal2 v15.4S, v25.8H,  v0.H[4]

    smlal  v12.4S, v26.4H,  v0.H[5]
    smlal2 v13.4S, v26.8H,  v0.H[5]
    smlal  v14.4S, v27.4H,  v0.H[5]
    smlal2 v15.4S, v27.8H,  v0.H[5]

    smlal  v12.4S, v28.4H,  v0.H[6]
    smlal2 v13.4S, v28.8H,  v0.H[6]
    smlal  v14.4S, v29.4H,  v0.H[6]
    smlal2 v15.4S, v29.8H,  v0.H[6]

    smlal  v12.4S, v30.4H,  v0.H[7]
    smlal2 v13.4S, v30.8H,  v0.H[7]
    smlal  v14.4S, v31.4H,  v0.H[7]
    smlal2 v15.4S, v31.8H,  v0.H[7]

    smlsl  v12.4S, v17.4H,  v1.H[0]
    smlsl2 v13.4S, v17.8H,  v1.H[0]
    smlal  v14.4S, v16.4H,  v1.H[0]
    smlal2 v15.4S, v16.8H,  v1.H[0]

    smlsl  v12.4S, v19.4H,  v1.H[1]
    smlsl2 v13.4S, v19.8H,  v1.H[1]
    smlal  v14.4S, v18.4H,  v1.H[1]
    smlal2 v15.4S, v18.8H,  v1.H[1]

    smlsl  v12.4S, v21.4H,  v1.H[2]
    smlsl2 v13.4S, v21.8H,  v1.H[2]
    smlal  v14.4S, v20.4H,  v1.H[2]
    smlal2 v15.4S, v20.8H,  v1.H[2]

    smlsl  v12.4S, v23.4H,  v1.H[3]
    smlsl2 v13.4S, v23.8H,  v1.H[3]
    smlal  v14.4S, v22.4H,  v1.H[3]
    smlal2 v15.4S, v22.8H,  v1.H[3]

    smlsl  v12.4S, v25.4H,  v1.H[4]
    smlsl2 v13.4S, v25.8H,  v1.H[4]
    smlal  v14.4S, v24.4H,  v1.H[4]
    smlal2 v15.4S, v24.8H,  v1.H[4]

    smlsl  v12.4S, v27.4H,  v1.H[5]
    smlsl2 v13.4S, v27.8H,  v1.H[5]
    smlal  v14.4S, v26.4H,  v1.H[5]
    smlal2 v15.4S, v26.8H,  v1.H[5]

    smlsl  v12.4S, v29.4H,  v1.H[6]
    smlsl2 v13.4S, v29.8H,  v1.H[6]
    smlal  v14.4S, v28.4H,  v1.H[6]
    smlal2 v15.4S, v28.8H,  v1.H[6]

    smlsl  v12.4S, v31.4H,  v1.H[7]
    smlsl2 v13.4S, v31.8H,  v1.H[7]
    smlal  v14.4S, v30.4H,  v1.H[7]
    smlal2 v15.4S, v30.8H,  v1.H[7]

    uzp1    v8.8H, v12.8H, v13.8H
    mul     v8.8H,  v8.8H,  v4.H[0]
    smlal  v12.4S,  v8.4H,  v4.H[1]
    smlal2 v13.4S,  v8.8H,  v4.H[1]
    uzp2    v8.8H, v12.8H, v13.8H
    add     v8.8H,  v8.8H,  v8.8H

    str q8, [x0, #0*16]

    uzp1    v9.8H, v14.8H, v15.8H
    mul     v9.8H,  v9.8H,  v4.H[0]
    smlal  v14.4S,  v9.4H,  v4.H[1]
    smlal2 v15.4S,  v9.8H,  v4.H[1]
    uzp2    v9.8H, v14.8H, v15.8H
    add     v9.8H,  v9.8H,  v9.8H

    str q9, [x0, #1*16]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_negacyclic_Toeplitz16_doubling_full
.global ___asm_negacyclic_Toeplitz16_doubling_full
__asm_negacyclic_Toeplitz16_doubling_full:
___asm_negacyclic_Toeplitz16_doubling_full:

    counter     .req  x8

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr s2, [x3]

    ldr  q0, [x1, #0*16]
    ldr  q1, [x1, #1*16]

    ldr q16, [x2, #0*16]
    ldr q17, [x2, #1*16]
    neg v11.8H, v17.8H

    ext v18.16B, v11.16B, v16.16B, #14
    ext v19.16B, v16.16B, v17.16B, #14
    ext v20.16B, v11.16B, v16.16B, #12
    ext v21.16B, v16.16B, v17.16B, #12
    ext v22.16B, v11.16B, v16.16B, #10
    ext v23.16B, v16.16B, v17.16B, #10
    ext v24.16B, v11.16B, v16.16B,  #8
    ext v25.16B, v16.16B, v17.16B,  #8
    ext v26.16B, v11.16B, v16.16B,  #6
    ext v27.16B, v16.16B, v17.16B,  #6
    ext v28.16B, v11.16B, v16.16B,  #4
    ext v29.16B, v16.16B, v17.16B,  #4
    ext v30.16B, v11.16B, v16.16B,  #2
    ext v31.16B, v16.16B, v17.16B,  #2

    smull  v12.4S, v16.4H,  v0.H[0]
    smull2 v13.4S, v16.8H,  v0.H[0]
    smull  v14.4S, v17.4H,  v0.H[0]
    smull2 v15.4S, v17.8H,  v0.H[0]

    smlal  v12.4S, v18.4H,  v0.H[1]
    smlal2 v13.4S, v18.8H,  v0.H[1]
    smlal  v14.4S, v19.4H,  v0.H[1]
    smlal2 v15.4S, v19.8H,  v0.H[1]

    smlal  v12.4S, v20.4H,  v0.H[2]
    smlal2 v13.4S, v20.8H,  v0.H[2]
    smlal  v14.4S, v21.4H,  v0.H[2]
    smlal2 v15.4S, v21.8H,  v0.H[2]

    smlal  v12.4S, v22.4H,  v0.H[3]
    smlal2 v13.4S, v22.8H,  v0.H[3]
    smlal  v14.4S, v23.4H,  v0.H[3]
    smlal2 v15.4S, v23.8H,  v0.H[3]

    smlal  v12.4S, v24.4H,  v0.H[4]
    smlal2 v13.4S, v24.8H,  v0.H[4]
    smlal  v14.4S, v25.4H,  v0.H[4]
    smlal2 v15.4S, v25.8H,  v0.H[4]

    smlal  v12.4S, v26.4H,  v0.H[5]
    smlal2 v13.4S, v26.8H,  v0.H[5]
    smlal  v14.4S, v27.4H,  v0.H[5]
    smlal2 v15.4S, v27.8H,  v0.H[5]

    smlal  v12.4S, v28.4H,  v0.H[6]
    smlal2 v13.4S, v28.8H,  v0.H[6]
    smlal  v14.4S, v29.4H,  v0.H[6]
    smlal2 v15.4S, v29.8H,  v0.H[6]

    smlal  v12.4S, v30.4H,  v0.H[7]
    smlal2 v13.4S, v30.8H,  v0.H[7]
    smlal  v14.4S, v31.4H,  v0.H[7]
    smlal2 v15.4S, v31.8H,  v0.H[7]

    smlsl  v12.4S, v17.4H,  v1.H[0]
    smlsl2 v13.4S, v17.8H,  v1.H[0]
    smlal  v14.4S, v16.4H,  v1.H[0]
    smlal2 v15.4S, v16.8H,  v1.H[0]

    smlsl  v12.4S, v19.4H,  v1.H[1]
    ldr  q0, [x1, #(64+0*16)]
    smlsl2 v13.4S, v19.8H,  v1.H[1]
    ldr  q3, [x1, #(64+1*16)]
    smlal  v14.4S, v18.4H,  v1.H[1]
    ldr q16, [x2, #(64+0*16)]
    smlal2 v15.4S, v18.8H,  v1.H[1]
    ldr q17, [x2, #(64+1*16)]
    neg  v9.8H, v17.8H

    smlsl  v12.4S, v21.4H,  v1.H[2]
    smlsl2 v13.4S, v21.8H,  v1.H[2]
    ext v19.16B, v16.16B, v17.16B, #14
    smlal  v14.4S, v20.4H,  v1.H[2]
    smlal2 v15.4S, v20.8H,  v1.H[2]
    ext v18.16B,  v9.16B, v16.16B, #14

    smlsl  v12.4S, v23.4H,  v1.H[3]
    smlsl2 v13.4S, v23.8H,  v1.H[3]
    ext v21.16B, v16.16B, v17.16B, #12
    smlal  v14.4S, v22.4H,  v1.H[3]
    smlal2 v15.4S, v22.8H,  v1.H[3]
    ext v20.16B,  v9.16B, v16.16B, #12

    smlsl  v12.4S, v25.4H,  v1.H[4]
    smlsl2 v13.4S, v25.8H,  v1.H[4]
    ext v23.16B, v16.16B, v17.16B, #10
    smlal  v14.4S, v24.4H,  v1.H[4]
    smlal2 v15.4S, v24.8H,  v1.H[4]
    ext v22.16B,  v9.16B, v16.16B, #10

    smlsl  v12.4S, v27.4H,  v1.H[5]
    smlsl2 v13.4S, v27.8H,  v1.H[5]
    ext v25.16B, v16.16B, v17.16B,  #8
    smlal  v14.4S, v26.4H,  v1.H[5]
    smlal2 v15.4S, v26.8H,  v1.H[5]
    ext v24.16B,  v9.16B, v16.16B,  #8

    smlsl  v12.4S, v29.4H,  v1.H[6]
    smlsl2 v13.4S, v29.8H,  v1.H[6]
    ext v27.16B, v16.16B, v17.16B,  #6
    smlal  v14.4S, v28.4H,  v1.H[6]
    smlal2 v15.4S, v28.8H,  v1.H[6]
    ext v26.16B,  v9.16B, v16.16B,  #6

    smlsl  v12.4S, v31.4H,  v1.H[7]
    smlsl2 v13.4S, v31.8H,  v1.H[7]
    ext v29.16B, v16.16B, v17.16B,  #4
    smlal  v14.4S, v30.4H,  v1.H[7]
    smlal2 v15.4S, v30.8H,  v1.H[7]
    ext v28.16B,  v9.16B, v16.16B,  #4

    smull   v4.4S, v16.4H,  v0.H[0]
    uzp1   v10.8H, v12.8H, v13.8H
    smull2  v5.4S, v16.8H,  v0.H[0]
    mul    v10.8H, v10.8H,  v2.H[0]
    smull   v6.4S, v17.4H,  v0.H[0]
    ext v31.16B, v16.16B, v17.16B,  #2
    smlal  v12.4S, v10.4H,  v2.H[1]
    smull2  v7.4S, v17.8H,  v0.H[0]
    ext v30.16B,  v9.16B, v16.16B,  #2
    smlal2 v13.4S, v10.8H,  v2.H[1]
    uzp2   v10.8H, v12.8H, v13.8H
    add    v10.8H, v10.8H, v10.8H

    str q10, [x0, #0*16]

    smlal   v4.4S, v18.4H,  v0.H[1]
    uzp1   v11.8H, v14.8H, v15.8H
    smlal2  v5.4S, v18.8H,  v0.H[1]
    mul    v11.8H, v11.8H,  v2.H[0]
    smlal   v6.4S, v19.4H,  v0.H[1]
    smlal  v14.4S, v11.4H,  v2.H[1]
    smlal2  v7.4S, v19.8H,  v0.H[1]
    smlal2 v15.4S, v11.8H,  v2.H[1]
    uzp2   v11.8H, v14.8H, v15.8H
    add    v11.8H, v11.8H, v11.8H

    str q11, [x0, #1*16]

    add x0, x0, #64
    add x1, x1, #64
    add x2, x2, #64

    smlal   v4.4S, v20.4H,  v0.H[2]
    smlal2  v5.4S, v20.8H,  v0.H[2]
    smlal   v6.4S, v21.4H,  v0.H[2]
    smlal2  v7.4S, v21.8H,  v0.H[2]

    smlal   v4.4S, v22.4H,  v0.H[3]
    smlal2  v5.4S, v22.8H,  v0.H[3]
    smlal   v6.4S, v23.4H,  v0.H[3]
    smlal2  v7.4S, v23.8H,  v0.H[3]

    smlal   v4.4S, v24.4H,  v0.H[4]
    smlal2  v5.4S, v24.8H,  v0.H[4]
    smlal   v6.4S, v25.4H,  v0.H[4]
    smlal2  v7.4S, v25.8H,  v0.H[4]

    smlal   v4.4S, v26.4H,  v0.H[5]
    smlal2  v5.4S, v26.8H,  v0.H[5]
    smlal   v6.4S, v27.4H,  v0.H[5]
    smlal2  v7.4S, v27.8H,  v0.H[5]

    smlal   v4.4S, v28.4H,  v0.H[6]
    smlal2  v5.4S, v28.8H,  v0.H[6]
    smlal   v6.4S, v29.4H,  v0.H[6]
    smlal2  v7.4S, v29.8H,  v0.H[6]

    smlal   v4.4S, v30.4H,  v0.H[7]
    smlal2  v5.4S, v30.8H,  v0.H[7]
    smlal   v6.4S, v31.4H,  v0.H[7]
    smlal2  v7.4S, v31.8H,  v0.H[7]

    mov counter, #23
    __asm_negacyclic_Toeplitz16_doubling_full_loop:

    smlsl   v4.4S, v17.4H,  v3.H[0]
    smlsl2  v5.4S, v17.8H,  v3.H[0]
    smlal   v6.4S, v16.4H,  v3.H[0]
    smlal2  v7.4S, v16.8H,  v3.H[0]

    smlsl   v4.4S, v19.4H,  v3.H[1]
    ldr  q0, [x1, #(64+0*16)]
    smlsl2  v5.4S, v19.8H,  v3.H[1]
    ldr  q1, [x1, #(64+1*16)]
    smlal   v6.4S, v18.4H,  v3.H[1]
    ldr q16, [x2, #(64+0*16)]
    smlal2  v7.4S, v18.8H,  v3.H[1]
    ldr q17, [x2, #(64+1*16)]
    neg v11.8H, v17.8H

    smlsl   v4.4S, v21.4H,  v3.H[2]
    smlsl2  v5.4S, v21.8H,  v3.H[2]
    ext v19.16B, v16.16B, v17.16B, #14
    smlal   v6.4S, v20.4H,  v3.H[2]
    smlal2  v7.4S, v20.8H,  v3.H[2]
    ext v18.16B, v11.16B, v16.16B, #14

    smlsl   v4.4S, v23.4H,  v3.H[3]
    smlsl2  v5.4S, v23.8H,  v3.H[3]
    ext v21.16B, v16.16B, v17.16B, #12
    smlal   v6.4S, v22.4H,  v3.H[3]
    smlal2  v7.4S, v22.8H,  v3.H[3]
    ext v20.16B, v11.16B, v16.16B, #12

    smlsl   v4.4S, v25.4H,  v3.H[4]
    smlsl2  v5.4S, v25.8H,  v3.H[4]
    ext v23.16B, v16.16B, v17.16B, #10
    smlal   v6.4S, v24.4H,  v3.H[4]
    smlal2  v7.4S, v24.8H,  v3.H[4]
    ext v22.16B, v11.16B, v16.16B, #10

    smlsl   v4.4S, v27.4H,  v3.H[5]
    smlsl2  v5.4S, v27.8H,  v3.H[5]
    ext v25.16B, v16.16B, v17.16B,  #8
    smlal   v6.4S, v26.4H,  v3.H[5]
    smlal2  v7.4S, v26.8H,  v3.H[5]
    ext v24.16B, v11.16B, v16.16B,  #8

    smlsl   v4.4S, v29.4H,  v3.H[6]
    smlsl2  v5.4S, v29.8H,  v3.H[6]
    ext v27.16B, v16.16B, v17.16B,  #6
    smlal   v6.4S, v28.4H,  v3.H[6]
    smlal2  v7.4S, v28.8H,  v3.H[6]
    ext v26.16B, v11.16B, v16.16B,  #6

    smlsl   v4.4S, v31.4H,  v3.H[7]
    smlsl2  v5.4S, v31.8H,  v3.H[7]
    ext v29.16B, v16.16B, v17.16B,  #4
    smlal   v6.4S, v30.4H,  v3.H[7]
    smlal2  v7.4S, v30.8H,  v3.H[7]
    ext v28.16B, v11.16B, v16.16B,  #4

    smull  v12.4S, v16.4H,  v0.H[0]
    uzp1    v8.8H,  v4.8H,  v5.8H
    smull2 v13.4S, v16.8H,  v0.H[0]
    mul     v8.8H,  v8.8H,  v2.H[0]
    smull  v14.4S, v17.4H,  v0.H[0]
    ext v30.16B, v11.16B, v16.16B,  #2
    smlal   v4.4S,  v8.4H,  v2.H[1]
    smull2 v15.4S, v17.8H,  v0.H[0]
    ext v31.16B, v16.16B, v17.16B,  #2
    smlal2  v5.4S,  v8.8H,  v2.H[1]
    uzp2    v8.8H,  v4.8H,  v5.8H
    add     v8.8H,  v8.8H,  v8.8H

    str  q8, [x0, #0*16]

    smlal  v12.4S, v18.4H,  v0.H[1]
    uzp1    v9.8H,  v6.8H,  v7.8H
    smlal2 v13.4S, v18.8H,  v0.H[1]
    mul     v9.8H,  v9.8H,  v2.H[0]
    smlal  v14.4S, v19.4H,  v0.H[1]
    smlal   v6.4S,  v9.4H,  v2.H[1]
    smlal2 v15.4S, v19.8H,  v0.H[1]
    smlal2  v7.4S,  v9.8H,  v2.H[1]
    uzp2    v9.8H,  v6.8H,  v7.8H
    add     v9.8H,  v9.8H,  v9.8H

    str  q9, [x0, #1*16]

    add x0, x0, #64
    add x1, x1, #64
    add x2, x2, #64


    smlal  v12.4S, v20.4H,  v0.H[2]
    smlal2 v13.4S, v20.8H,  v0.H[2]
    smlal  v14.4S, v21.4H,  v0.H[2]
    smlal2 v15.4S, v21.8H,  v0.H[2]

    smlal  v12.4S, v22.4H,  v0.H[3]
    smlal2 v13.4S, v22.8H,  v0.H[3]
    smlal  v14.4S, v23.4H,  v0.H[3]
    smlal2 v15.4S, v23.8H,  v0.H[3]

    smlal  v12.4S, v24.4H,  v0.H[4]
    smlal2 v13.4S, v24.8H,  v0.H[4]
    smlal  v14.4S, v25.4H,  v0.H[4]
    smlal2 v15.4S, v25.8H,  v0.H[4]

    smlal  v12.4S, v26.4H,  v0.H[5]
    smlal2 v13.4S, v26.8H,  v0.H[5]
    smlal  v14.4S, v27.4H,  v0.H[5]
    smlal2 v15.4S, v27.8H,  v0.H[5]

    smlal  v12.4S, v28.4H,  v0.H[6]
    smlal2 v13.4S, v28.8H,  v0.H[6]
    smlal  v14.4S, v29.4H,  v0.H[6]
    smlal2 v15.4S, v29.8H,  v0.H[6]

    smlal  v12.4S, v30.4H,  v0.H[7]
    smlal2 v13.4S, v30.8H,  v0.H[7]
    smlal  v14.4S, v31.4H,  v0.H[7]
    smlal2 v15.4S, v31.8H,  v0.H[7]

    smlsl  v12.4S, v17.4H,  v1.H[0]
    smlsl2 v13.4S, v17.8H,  v1.H[0]
    smlal  v14.4S, v16.4H,  v1.H[0]
    smlal2 v15.4S, v16.8H,  v1.H[0]

    smlsl  v12.4S, v19.4H,  v1.H[1]
    ldr  q0, [x1, #(64+0*16)]
    smlsl2 v13.4S, v19.8H,  v1.H[1]
    ldr  q3, [x1, #(64+1*16)]
    smlal  v14.4S, v18.4H,  v1.H[1]
    ldr q16, [x2, #(64+0*16)]
    smlal2 v15.4S, v18.8H,  v1.H[1]
    ldr q17, [x2, #(64+1*16)]
    neg  v9.8H, v17.8H

    smlsl  v12.4S, v21.4H,  v1.H[2]
    smlsl2 v13.4S, v21.8H,  v1.H[2]
    ext v19.16B, v16.16B, v17.16B, #14
    smlal  v14.4S, v20.4H,  v1.H[2]
    smlal2 v15.4S, v20.8H,  v1.H[2]
    ext v18.16B,  v9.16B, v16.16B, #14

    smlsl  v12.4S, v23.4H,  v1.H[3]
    smlsl2 v13.4S, v23.8H,  v1.H[3]
    ext v21.16B, v16.16B, v17.16B, #12
    smlal  v14.4S, v22.4H,  v1.H[3]
    smlal2 v15.4S, v22.8H,  v1.H[3]
    ext v20.16B,  v9.16B, v16.16B, #12

    smlsl  v12.4S, v25.4H,  v1.H[4]
    smlsl2 v13.4S, v25.8H,  v1.H[4]
    ext v23.16B, v16.16B, v17.16B, #10
    smlal  v14.4S, v24.4H,  v1.H[4]
    smlal2 v15.4S, v24.8H,  v1.H[4]
    ext v22.16B,  v9.16B, v16.16B, #10

    smlsl  v12.4S, v27.4H,  v1.H[5]
    smlsl2 v13.4S, v27.8H,  v1.H[5]
    ext v25.16B, v16.16B, v17.16B,  #8
    smlal  v14.4S, v26.4H,  v1.H[5]
    smlal2 v15.4S, v26.8H,  v1.H[5]
    ext v24.16B,  v9.16B, v16.16B,  #8

    smlsl  v12.4S, v29.4H,  v1.H[6]
    smlsl2 v13.4S, v29.8H,  v1.H[6]
    ext v27.16B, v16.16B, v17.16B,  #6
    smlal  v14.4S, v28.4H,  v1.H[6]
    smlal2 v15.4S, v28.8H,  v1.H[6]
    ext v26.16B,  v9.16B, v16.16B,  #6

    smlsl  v12.4S, v31.4H,  v1.H[7]
    smlsl2 v13.4S, v31.8H,  v1.H[7]
    ext v29.16B, v16.16B, v17.16B,  #4
    smlal  v14.4S, v30.4H,  v1.H[7]
    smlal2 v15.4S, v30.8H,  v1.H[7]
    ext v28.16B,  v9.16B, v16.16B,  #4

    smull   v4.4S, v16.4H,  v0.H[0]
    uzp1   v10.8H, v12.8H, v13.8H
    smull2  v5.4S, v16.8H,  v0.H[0]
    mul    v10.8H, v10.8H,  v2.H[0]
    smull   v6.4S, v17.4H,  v0.H[0]
    ext v31.16B, v16.16B, v17.16B,  #2
    smlal  v12.4S, v10.4H,  v2.H[1]
    smull2  v7.4S, v17.8H,  v0.H[0]
    ext v30.16B,  v9.16B, v16.16B,  #2
    smlal2 v13.4S, v10.8H,  v2.H[1]
    uzp2   v10.8H, v12.8H, v13.8H
    add    v10.8H, v10.8H, v10.8H

    str q10, [x0, #0*16]

    smlal   v4.4S, v18.4H,  v0.H[1]
    uzp1   v11.8H, v14.8H, v15.8H
    smlal2  v5.4S, v18.8H,  v0.H[1]
    mul    v11.8H, v11.8H,  v2.H[0]
    smlal  v14.4S, v11.4H,  v2.H[1]
    smlal   v6.4S, v19.4H,  v0.H[1]
    smlal2 v15.4S, v11.8H,  v2.H[1]
    smlal2  v7.4S, v19.8H,  v0.H[1]
    uzp2   v11.8H, v14.8H, v15.8H
    add    v11.8H, v11.8H, v11.8H

    str q11, [x0, #1*16]

    add x0, x0, #64
    add x1, x1, #64
    add x2, x2, #64

    smlal   v4.4S, v20.4H,  v0.H[2]
    smlal2  v5.4S, v20.8H,  v0.H[2]
    smlal   v6.4S, v21.4H,  v0.H[2]
    smlal2  v7.4S, v21.8H,  v0.H[2]

    smlal   v4.4S, v22.4H,  v0.H[3]
    smlal2  v5.4S, v22.8H,  v0.H[3]
    smlal   v6.4S, v23.4H,  v0.H[3]
    smlal2  v7.4S, v23.8H,  v0.H[3]

    smlal   v4.4S, v24.4H,  v0.H[4]
    smlal2  v5.4S, v24.8H,  v0.H[4]
    smlal   v6.4S, v25.4H,  v0.H[4]
    smlal2  v7.4S, v25.8H,  v0.H[4]

    smlal   v4.4S, v26.4H,  v0.H[5]
    smlal2  v5.4S, v26.8H,  v0.H[5]
    smlal   v6.4S, v27.4H,  v0.H[5]
    smlal2  v7.4S, v27.8H,  v0.H[5]

    smlal   v4.4S, v28.4H,  v0.H[6]
    smlal2  v5.4S, v28.8H,  v0.H[6]
    smlal   v6.4S, v29.4H,  v0.H[6]
    smlal2  v7.4S, v29.8H,  v0.H[6]

    smlal   v4.4S, v30.4H,  v0.H[7]
    smlal2  v5.4S, v30.8H,  v0.H[7]
    smlal   v6.4S, v31.4H,  v0.H[7]
    smlal2  v7.4S, v31.8H,  v0.H[7]

    sub counter, counter, #1
    cbnz counter, __asm_negacyclic_Toeplitz16_doubling_full_loop

    smlsl   v4.4S, v17.4H,  v3.H[0]
    smlsl2  v5.4S, v17.8H,  v3.H[0]
    smlal   v6.4S, v16.4H,  v3.H[0]
    smlal2  v7.4S, v16.8H,  v3.H[0]

    smlsl   v4.4S, v19.4H,  v3.H[1]
    smlsl2  v5.4S, v19.8H,  v3.H[1]
    smlal   v6.4S, v18.4H,  v3.H[1]
    smlal2  v7.4S, v18.8H,  v3.H[1]

    smlsl   v4.4S, v21.4H,  v3.H[2]
    smlsl2  v5.4S, v21.8H,  v3.H[2]
    smlal   v6.4S, v20.4H,  v3.H[2]
    smlal2  v7.4S, v20.8H,  v3.H[2]

    smlsl   v4.4S, v23.4H,  v3.H[3]
    smlsl2  v5.4S, v23.8H,  v3.H[3]
    smlal   v6.4S, v22.4H,  v3.H[3]
    smlal2  v7.4S, v22.8H,  v3.H[3]

    smlsl   v4.4S, v25.4H,  v3.H[4]
    smlsl2  v5.4S, v25.8H,  v3.H[4]
    smlal   v6.4S, v24.4H,  v3.H[4]
    smlal2  v7.4S, v24.8H,  v3.H[4]

    smlsl   v4.4S, v27.4H,  v3.H[5]
    smlsl2  v5.4S, v27.8H,  v3.H[5]
    smlal   v6.4S, v26.4H,  v3.H[5]
    smlal2  v7.4S, v26.8H,  v3.H[5]

    smlsl   v4.4S, v29.4H,  v3.H[6]
    smlsl2  v5.4S, v29.8H,  v3.H[6]
    smlal   v6.4S, v28.4H,  v3.H[6]
    smlal2  v7.4S, v28.8H,  v3.H[6]

    smlsl   v4.4S, v31.4H,  v3.H[7]
    smlsl2  v5.4S, v31.8H,  v3.H[7]
    smlal   v6.4S, v30.4H,  v3.H[7]
    smlal2  v7.4S, v30.8H,  v3.H[7]

    uzp1    v8.8H,  v4.8H,  v5.8H
    mul     v8.8H,  v8.8H,  v2.H[0]
    smlal   v4.4S,  v8.4H,  v2.H[1]
    smlal2  v5.4S,  v8.8H,  v2.H[1]
    uzp2    v8.8H,  v4.8H,  v5.8H
    add     v8.8H,  v8.8H,  v8.8H

    str  q8, [x0, #0*16]

    uzp1    v9.8H,  v6.8H,  v7.8H
    mul     v9.8H,  v9.8H,  v2.H[0]
    smlal   v6.4S,  v9.4H,  v2.H[1]
    smlal2  v7.4S,  v9.8H,  v2.H[1]
    uzp2    v9.8H,  v6.8H,  v7.8H
    add     v9.8H,  v9.8H,  v9.8H

    str  q9, [x0, #1*16]

    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    .unreq counter

    br lr






