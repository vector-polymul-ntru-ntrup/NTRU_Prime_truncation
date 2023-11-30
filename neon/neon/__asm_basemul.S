
.align 6
.global __asm_negacyclic_schoolbook8
.global ___asm_negacyclic_schoolbook8
__asm_negacyclic_schoolbook8:
___asm_negacyclic_schoolbook8:

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
.global __asm_point_mul_extended
.global ___asm_point_mul_extended
__asm_point_mul_extended:
___asm_point_mul_extended:


    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr s4, [x2]

.rept 192

    ldr q0, [x0]
    ld2 {v1.8H, v2.8H}, [x1]

    sqrdmulh  v8.8H,  v0.8H,  v2.8H
    mul       v0.8H,  v0.8H,  v1.8H
    mls       v0.8H,  v8.8H,  v4.H[1]

    str q0, [x0]

    add x0, x0, #16
    add x1, x1, #32

.endr


    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_point_mul_lohi
.global ___asm_point_mul_lohi
__asm_point_mul_lohi:
___asm_point_mul_lohi:


    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]

    ldr s4, [x2]

.rept 192

    ldr q0, [x0]
    ld1 {v1.8H, v2.8H}, [x1]

    sqrdmulh  v8.8H,  v0.8H,  v2.8H
    mul       v0.8H,  v0.8H,  v1.8H
    mls       v0.8H,  v8.8H,  v4.H[1]

    str q0, [x0]

    add x0, x0, #16
    add x1, x1, #32

.endr


    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_cyclic_FFT16
.global ___asm_cyclic_FFT16
__asm_cyclic_FFT16:
___asm_cyclic_FFT16:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]
    sub sp, sp, #(16*16)

    ldr  q0, [x1,  #0*16]
    ldr  q1, [x1,  #1*16]
    ldr  q2, [x1,  #2*16]
    ldr  q3, [x1,  #3*16]
    ldr  q4, [x1,  #4*16]
    ldr  q5, [x1,  #5*16]
    ldr  q6, [x1,  #6*16]
    ldr  q7, [x1,  #7*16]
    ldr  q8, [x1,  #8*16]
    ldr  q9, [x1,  #9*16]
    ldr q10, [x1, #10*16]
    ldr q11, [x1, #11*16]
    ldr q12, [x1, #12*16]
    ldr q13, [x1, #13*16]
    ldr q14, [x1, #14*16]
    ldr q15, [x1, #15*16]

    add   v16.8H,  v0.8H,  v8.8H
    sub   v24.8H,  v0.8H,  v8.8H
    add   v17.8H,  v1.8H,  v9.8H
    sub   v25.8H,  v1.8H,  v9.8H
    add   v18.8H,  v2.8H, v10.8H
    sub   v26.8H,  v2.8H, v10.8H
    add   v19.8H,  v3.8H, v11.8H
    sub   v27.8H,  v3.8H, v11.8H
    add   v20.8H,  v4.8H, v12.8H
    sub   v28.8H,  v4.8H, v12.8H
    add   v21.8H,  v5.8H, v13.8H
    sub   v29.8H,  v5.8H, v13.8H
    add   v22.8H,  v6.8H, v14.8H
    sub   v30.8H,  v6.8H, v14.8H
    add   v23.8H,  v7.8H, v15.8H
    sub   v31.8H,  v7.8H, v15.8H

    ldr d0, [x3]

    add    v8.8H, v16.8H, v20.8H
    sub   v12.8H, v16.8H, v20.8H
    add    v9.8H, v17.8H, v21.8H
    sub   v13.8H, v17.8H, v21.8H
    add   v10.8H, v18.8H, v22.8H
    sub   v14.8H, v18.8H, v22.8H
    add   v11.8H, v19.8H, v23.8H
    sub   v15.8H, v19.8H, v23.8H

    sqdmulh  v16.8H,  v8.8H,  v0.H[2]
    sqdmulh  v17.8H,  v9.8H,  v0.H[2]
    sqdmulh  v18.8H, v10.8H,  v0.H[2]
    sqdmulh  v19.8H, v11.8H,  v0.H[2]
    sqdmulh  v20.8H, v12.8H,  v0.H[2]
    sqdmulh  v21.8H, v13.8H,  v0.H[2]
    sqdmulh  v22.8H, v14.8H,  v0.H[2]
    sqdmulh  v23.8H, v15.8H,  v0.H[2]

    srshr    v16.8H, v16.8H, #12
    srshr    v17.8H, v17.8H, #12
    srshr    v18.8H, v18.8H, #12
    srshr    v19.8H, v19.8H, #12
    srshr    v20.8H, v20.8H, #12
    srshr    v21.8H, v21.8H, #12
    srshr    v22.8H, v22.8H, #12
    srshr    v23.8H, v23.8H, #12

    mls       v8.8H, v16.8H,  v0.H[1]
    mls       v8.8H, v17.8H,  v0.H[1]
    mls      v10.8H, v18.8H,  v0.H[1]
    mls      v11.8H, v19.8H,  v0.H[1]
    mls      v12.8H, v20.8H,  v0.H[1]
    mls      v13.8H, v21.8H,  v0.H[1]
    mls      v14.8H, v22.8H,  v0.H[1]
    mls      v15.8H, v23.8H,  v0.H[1]

    str  q8, [sp,  #0*16]
    str  q9, [sp,  #1*16]
    str q10, [sp,  #2*16]
    str q11, [sp,  #3*16]
    str q12, [sp,  #4*16]
    str q13, [sp,  #5*16]
    str q14, [sp,  #6*16]
    str q15, [sp,  #7*16]
    str q24, [sp,  #8*16]
    str q25, [sp,  #9*16]
    str q26, [sp, #10*16]
    str q27, [sp, #11*16]
    str q28, [sp, #12*16]
    str q29, [sp, #13*16]
    str q30, [sp, #14*16]
    str q31, [sp, #15*16]

    ldr  q0, [x2,  #0*16]
    ldr  q1, [x2,  #1*16]
    ldr  q2, [x2,  #2*16]
    ldr  q3, [x2,  #3*16]
    ldr  q4, [x2,  #4*16]
    ldr  q5, [x2,  #5*16]
    ldr  q6, [x2,  #6*16]
    ldr  q7, [x2,  #7*16]
    ldr  q8, [x2,  #8*16]
    ldr  q9, [x2,  #9*16]
    ldr q10, [x2, #10*16]
    ldr q11, [x2, #11*16]
    ldr q12, [x2, #12*16]
    ldr q13, [x2, #13*16]
    ldr q14, [x2, #14*16]
    ldr q15, [x2, #15*16]

    add   v16.8H,  v0.8H,  v8.8H
    sub   v24.8H,  v0.8H,  v8.8H
    add   v17.8H,  v1.8H,  v9.8H
    sub   v25.8H,  v1.8H,  v9.8H
    add   v18.8H,  v2.8H, v10.8H
    sub   v26.8H,  v2.8H, v10.8H
    add   v19.8H,  v3.8H, v11.8H
    sub   v27.8H,  v3.8H, v11.8H
    add   v20.8H,  v4.8H, v12.8H
    sub   v28.8H,  v4.8H, v12.8H
    add   v21.8H,  v5.8H, v13.8H
    sub   v29.8H,  v5.8H, v13.8H
    add   v22.8H,  v6.8H, v14.8H
    sub   v30.8H,  v6.8H, v14.8H
    add   v23.8H,  v7.8H, v15.8H
    sub   v31.8H,  v7.8H, v15.8H

    ldr d0, [x3]

    add    v8.8H, v16.8H, v20.8H
    sub   v12.8H, v16.8H, v20.8H
    add    v9.8H, v17.8H, v21.8H
    sub   v13.8H, v17.8H, v21.8H
    add   v10.8H, v18.8H, v22.8H
    sub   v14.8H, v18.8H, v22.8H
    add   v11.8H, v19.8H, v23.8H
    sub   v15.8H, v19.8H, v23.8H

    sqdmulh  v16.8H,  v8.8H,  v0.H[2]
    sqdmulh  v17.8H,  v9.8H,  v0.H[2]
    sqdmulh  v18.8H, v10.8H,  v0.H[2]
    sqdmulh  v19.8H, v11.8H,  v0.H[2]
    sqdmulh  v20.8H, v12.8H,  v0.H[2]
    sqdmulh  v21.8H, v13.8H,  v0.H[2]
    sqdmulh  v22.8H, v14.8H,  v0.H[2]
    sqdmulh  v23.8H, v15.8H,  v0.H[2]

    srshr    v16.8H, v16.8H, #12
    srshr    v17.8H, v17.8H, #12
    srshr    v18.8H, v18.8H, #12
    srshr    v19.8H, v19.8H, #12
    srshr    v20.8H, v20.8H, #12
    srshr    v21.8H, v21.8H, #12
    srshr    v22.8H, v22.8H, #12
    srshr    v23.8H, v23.8H, #12

    mls       v8.8H, v16.8H,  v0.H[1]
    mls       v8.8H, v17.8H,  v0.H[1]
    mls      v10.8H, v18.8H,  v0.H[1]
    mls      v11.8H, v19.8H,  v0.H[1]
    mls      v12.8H, v20.8H,  v0.H[1]
    mls      v13.8H, v21.8H,  v0.H[1]
    mls      v14.8H, v22.8H,  v0.H[1]
    mls      v15.8H, v23.8H,  v0.H[1]

// ================

    ldr q16, [sp,  #0*16]
    ldr q17, [sp,  #1*16]
    ldr q18, [sp,  #2*16]
    ldr q19, [sp,  #3*16]
    ldr q20, [sp,  #4*16]
    ldr q21, [sp,  #5*16]
    ldr q22, [sp,  #6*16]
    ldr q23, [sp,  #7*16]

    ldr  d0, [x3]

    // 0
    smull   v4.4S,  v8.4H, v16.4H
    smull2  v5.4S,  v8.8H, v16.8H
    smlal   v4.4S,  v9.4H, v19.4H
    smlal2  v5.4S,  v9.8H, v19.8H
    smlal   v4.4S, v10.4H, v18.4H
    smlal2  v5.4S, v10.8H, v18.8H
    smlal   v4.4S, v11.4H, v17.4H
    smlal2  v5.4S, v11.8H, v17.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #0*16]

    // 1
    smull   v4.4S,  v8.4H, v17.4H
    smull2  v5.4S,  v8.8H, v17.8H
    smlal   v4.4S,  v9.4H, v16.4H
    smlal2  v5.4S,  v9.8H, v16.8H
    smlal   v4.4S, v10.4H, v19.4H
    smlal2  v5.4S, v10.8H, v19.8H
    smlal   v4.4S, v11.4H, v18.4H
    smlal2  v5.4S, v11.8H, v18.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #1*16]

    // 2
    smull   v4.4S,  v8.4H, v18.4H
    smull2  v5.4S,  v8.8H, v18.8H
    smlal   v4.4S,  v9.4H, v17.4H
    smlal2  v5.4S,  v9.8H, v17.8H
    smlal   v4.4S, v10.4H, v16.4H
    smlal2  v5.4S, v10.8H, v16.8H
    smlal   v4.4S, v11.4H, v19.4H
    smlal2  v5.4S, v11.8H, v19.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #2*16]

    // 3
    smull   v4.4S,  v8.4H, v19.4H
    smull2  v5.4S,  v8.8H, v19.8H
    smlal   v4.4S,  v9.4H, v18.4H
    smlal2  v5.4S,  v9.8H, v18.8H
    smlal   v4.4S, v10.4H, v17.4H
    smlal2  v5.4S, v10.8H, v17.8H
    smlal   v4.4S, v11.4H, v16.4H
    smlal2  v5.4S, v11.8H, v16.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #3*16]

// ================

    // 4
    smull   v4.4S, v12.4H, v20.4H
    smull2  v5.4S, v12.8H, v20.8H
    smlsl   v4.4S, v13.4H, v23.4H
    smlsl2  v5.4S, v13.8H, v23.8H
    smlsl   v4.4S, v14.4H, v22.4H
    smlsl2  v5.4S, v14.8H, v22.8H
    smlsl   v4.4S, v15.4H, v21.4H
    smlsl2  v5.4S, v15.8H, v21.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #4*16]

    // 5
    smull   v4.4S, v12.4H, v21.4H
    smull2  v5.4S, v12.8H, v21.8H
    smlal   v4.4S, v13.4H, v20.4H
    smlal2  v5.4S, v13.8H, v20.8H
    smlsl   v4.4S, v14.4H, v23.4H
    smlsl2  v5.4S, v14.8H, v23.8H
    smlsl   v4.4S, v15.4H, v22.4H
    smlsl2  v5.4S, v15.8H, v22.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #5*16]

    // 6
    smull   v4.4S, v12.4H, v22.4H
    smull2  v5.4S, v12.8H, v22.8H
    smlal   v4.4S, v13.4H, v21.4H
    smlal2  v5.4S, v13.8H, v21.8H
    smlal   v4.4S, v14.4H, v20.4H
    smlal2  v5.4S, v14.8H, v20.8H
    smlsl   v4.4S, v15.4H, v23.4H
    smlsl2  v5.4S, v15.8H, v23.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #6*16]

    // 7
    smull   v4.4S, v12.4H, v23.4H
    smull2  v5.4S, v12.8H, v23.8H
    smlal   v4.4S, v13.4H, v22.4H
    smlal2  v5.4S, v13.8H, v22.8H
    smlal   v4.4S, v14.4H, v21.4H
    smlal2  v5.4S, v14.8H, v21.8H
    smlal   v4.4S, v15.4H, v20.4H
    smlal2  v5.4S, v15.8H, v20.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #7*16]

// ================

    ldr  q8, [sp,  #(8+0)*16]
    ldr  q9, [sp,  #(8+1)*16]
    ldr q10, [sp,  #(8+2)*16]
    ldr q11, [sp,  #(8+3)*16]
    ldr q12, [sp,  #(8+4)*16]
    ldr q13, [sp,  #(8+5)*16]
    ldr q14, [sp,  #(8+6)*16]
    ldr q15, [sp,  #(8+7)*16]

    // 0
    smull   v4.4S,  v8.4H, v24.4H
    smull2  v5.4S,  v8.8H, v24.8H
    smlsl   v4.4S,  v9.4H, v31.4H
    smlsl2  v5.4S,  v9.8H, v31.8H
    smlsl   v4.4S, v10.4H, v30.4H
    smlsl2  v5.4S, v10.8H, v30.8H
    smlsl   v4.4S, v11.4H, v29.4H
    smlsl2  v5.4S, v11.8H, v29.8H
    smlsl   v4.4S, v12.4H, v28.4H
    smlsl2  v5.4S, v12.8H, v28.8H
    smlsl   v4.4S, v13.4H, v27.4H
    smlsl2  v5.4S, v13.8H, v27.8H
    smlsl   v4.4S, v14.4H, v26.4H
    smlsl2  v5.4S, v14.8H, v26.8H
    smlsl   v4.4S, v15.4H, v25.4H
    smlsl2  v5.4S, v15.8H, v25.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+0)*16]

    // 1
    smull   v4.4S,  v8.4H, v25.4H
    smull2  v5.4S,  v8.8H, v25.8H
    smlal   v4.4S,  v9.4H, v24.4H
    smlal2  v5.4S,  v9.8H, v24.8H
    smlsl   v4.4S, v10.4H, v31.4H
    smlsl2  v5.4S, v10.8H, v31.8H
    smlsl   v4.4S, v11.4H, v30.4H
    smlsl2  v5.4S, v11.8H, v30.8H
    smlsl   v4.4S, v12.4H, v29.4H
    smlsl2  v5.4S, v12.8H, v29.8H
    smlsl   v4.4S, v13.4H, v28.4H
    smlsl2  v5.4S, v13.8H, v28.8H
    smlsl   v4.4S, v14.4H, v27.4H
    smlsl2  v5.4S, v14.8H, v27.8H
    smlsl   v4.4S, v15.4H, v26.4H
    smlsl2  v5.4S, v15.8H, v26.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+1)*16]

    // 2
    smull   v4.4S,  v8.4H, v26.4H
    smull2  v5.4S,  v8.8H, v26.8H
    smlal   v4.4S,  v9.4H, v25.4H
    smlal2  v5.4S,  v9.8H, v25.8H
    smlal   v4.4S, v10.4H, v24.4H
    smlal2  v5.4S, v10.8H, v24.8H
    smlsl   v4.4S, v11.4H, v31.4H
    smlsl2  v5.4S, v11.8H, v31.8H
    smlsl   v4.4S, v12.4H, v30.4H
    smlsl2  v5.4S, v12.8H, v30.8H
    smlsl   v4.4S, v13.4H, v29.4H
    smlsl2  v5.4S, v13.8H, v29.8H
    smlsl   v4.4S, v14.4H, v28.4H
    smlsl2  v5.4S, v14.8H, v28.8H
    smlsl   v4.4S, v15.4H, v27.4H
    smlsl2  v5.4S, v15.8H, v27.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+2)*16]

    // 3
    smull   v4.4S,  v8.4H, v27.4H
    smull2  v5.4S,  v8.8H, v27.8H
    smlal   v4.4S,  v9.4H, v26.4H
    smlal2  v5.4S,  v9.8H, v26.8H
    smlal   v4.4S, v10.4H, v25.4H
    smlal2  v5.4S, v10.8H, v25.8H
    smlal   v4.4S, v11.4H, v24.4H
    smlal2  v5.4S, v11.8H, v24.8H
    smlsl   v4.4S, v12.4H, v31.4H
    smlsl2  v5.4S, v12.8H, v31.8H
    smlsl   v4.4S, v13.4H, v30.4H
    smlsl2  v5.4S, v13.8H, v30.8H
    smlsl   v4.4S, v14.4H, v29.4H
    smlsl2  v5.4S, v14.8H, v29.8H
    smlsl   v4.4S, v15.4H, v28.4H
    smlsl2  v5.4S, v15.8H, v28.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+3)*16]

    // 4
    smull   v4.4S,  v8.4H, v28.4H
    smull2  v5.4S,  v8.8H, v28.8H
    smlal   v4.4S,  v9.4H, v27.4H
    smlal2  v5.4S,  v9.8H, v27.8H
    smlal   v4.4S, v10.4H, v26.4H
    smlal2  v5.4S, v10.8H, v26.8H
    smlal   v4.4S, v11.4H, v25.4H
    smlal2  v5.4S, v11.8H, v25.8H
    smlal   v4.4S, v12.4H, v24.4H
    smlal2  v5.4S, v12.8H, v24.8H
    smlsl   v4.4S, v13.4H, v31.4H
    smlsl2  v5.4S, v13.8H, v31.8H
    smlsl   v4.4S, v14.4H, v30.4H
    smlsl2  v5.4S, v14.8H, v30.8H
    smlsl   v4.4S, v15.4H, v29.4H
    smlsl2  v5.4S, v15.8H, v29.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+4)*16]

    // 5
    smull   v4.4S,  v8.4H, v29.4H
    smull2  v5.4S,  v8.8H, v29.8H
    smlal   v4.4S,  v9.4H, v28.4H
    smlal2  v5.4S,  v9.8H, v28.8H
    smlal   v4.4S, v10.4H, v27.4H
    smlal2  v5.4S, v10.8H, v27.8H
    smlal   v4.4S, v11.4H, v26.4H
    smlal2  v5.4S, v11.8H, v26.8H
    smlal   v4.4S, v12.4H, v25.4H
    smlal2  v5.4S, v12.8H, v25.8H
    smlal   v4.4S, v13.4H, v24.4H
    smlal2  v5.4S, v13.8H, v24.8H
    smlsl   v4.4S, v14.4H, v31.4H
    smlsl2  v5.4S, v14.8H, v31.8H
    smlsl   v4.4S, v15.4H, v30.4H
    smlsl2  v5.4S, v15.8H, v30.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+5)*16]

    // 6
    smull   v4.4S,  v8.4H, v30.4H
    smull2  v5.4S,  v8.8H, v30.8H
    smlal   v4.4S,  v9.4H, v29.4H
    smlal2  v5.4S,  v9.8H, v29.8H
    smlal   v4.4S, v10.4H, v28.4H
    smlal2  v5.4S, v10.8H, v28.8H
    smlal   v4.4S, v11.4H, v27.4H
    smlal2  v5.4S, v11.8H, v27.8H
    smlal   v4.4S, v12.4H, v26.4H
    smlal2  v5.4S, v12.8H, v26.8H
    smlal   v4.4S, v13.4H, v25.4H
    smlal2  v5.4S, v13.8H, v25.8H
    smlal   v4.4S, v14.4H, v24.4H
    smlal2  v5.4S, v14.8H, v24.8H
    smlsl   v4.4S, v15.4H, v31.4H
    smlsl2  v5.4S, v15.8H, v31.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+6)*16]

    // 7
    smull   v4.4S,  v8.4H, v31.4H
    smull2  v5.4S,  v8.8H, v31.8H
    smlal   v4.4S,  v9.4H, v30.4H
    smlal2  v5.4S,  v9.8H, v30.8H
    smlal   v4.4S, v10.4H, v29.4H
    smlal2  v5.4S, v10.8H, v29.8H
    smlal   v4.4S, v11.4H, v28.4H
    smlal2  v5.4S, v11.8H, v28.8H
    smlal   v4.4S, v12.4H, v27.4H
    smlal2  v5.4S, v12.8H, v27.8H
    smlal   v4.4S, v13.4H, v26.4H
    smlal2  v5.4S, v13.8H, v26.8H
    smlal   v4.4S, v14.4H, v25.4H
    smlal2  v5.4S, v14.8H, v25.8H
    smlal   v4.4S, v15.4H, v24.4H
    smlal2  v5.4S, v15.8H, v24.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+7)*16]

// ================

    ldr  q0, [sp,  #0*16]
    ldr  q4, [sp,  #4*16]
    ldr  q8, [sp,  #8*16]
    ldr q12, [sp, #12*16]

    add   v16.8H,  v0.8H,  v4.8H
    sub   v20.8H,  v0.8H,  v4.8H
    add    v8.8H,  v8.8H,  v8.8H
    add   v12.8H, v12.8H, v12.8H
    sub   v24.8H, v16.8H,  v8.8H
    add   v16.8H, v16.8H,  v8.8H
    sub   v28.8H, v20.8H, v12.8H
    add   v20.8H, v20.8H, v12.8H

    str q16, [x0,  #0*16]
    str q20, [x0,  #4*16]
    str q24, [x0,  #8*16]
    str q28, [x0, #12*16]

    ldr  q1, [sp,  #1*16]
    ldr  q5, [sp,  #5*16]
    ldr  q9, [sp,  #9*16]
    ldr q13, [sp, #13*16]

    add   v17.8H,  v1.8H,  v5.8H
    sub   v21.8H,  v1.8H,  v5.8H
    add    v9.8H,  v9.8H,  v9.8H
    add   v13.8H, v13.8H, v13.8H
    sub   v25.8H, v17.8H,  v9.8H
    add   v17.8H, v17.8H,  v9.8H
    sub   v29.8H, v21.8H, v13.8H
    add   v21.8H, v21.8H, v13.8H

    str q17, [x0,  #1*16]
    str q21, [x0,  #5*16]
    str q25, [x0,  #9*16]
    str q29, [x0, #13*16]

    ldr  q2, [sp,  #2*16]
    ldr  q6, [sp,  #6*16]
    ldr q10, [sp, #10*16]
    ldr q14, [sp, #14*16]

    add   v18.8H,  v2.8H,  v6.8H
    sub   v22.8H,  v2.8H,  v6.8H
    add   v10.8H, v10.8H, v10.8H
    add   v14.8H, v14.8H, v14.8H
    sub   v26.8H, v18.8H, v10.8H
    add   v18.8H, v18.8H, v10.8H
    sub   v30.8H, v22.8H, v14.8H
    add   v22.8H, v22.8H, v14.8H

    str q18, [x0,  #2*16]
    str q22, [x0,  #6*16]
    str q26, [x0, #10*16]
    str q30, [x0, #14*16]

    ldr  q3, [sp,  #3*16]
    ldr  q7, [sp,  #7*16]
    ldr q11, [sp, #11*16]
    ldr q15, [sp, #15*16]

    add   v19.8H,  v3.8H,  v7.8H
    sub   v23.8H,  v3.8H,  v7.8H
    add   v11.8H, v11.8H, v11.8H
    add   v15.8H, v15.8H, v15.8H
    sub   v27.8H, v19.8H, v11.8H
    add   v19.8H, v19.8H, v11.8H
    sub   v31.8H, v23.8H, v15.8H
    add   v23.8H, v23.8H, v15.8H

    str q19, [x0,  #3*16]
    str q23, [x0,  #7*16]
    str q27, [x0, #11*16]
    str q31, [x0, #15*16]

    add sp, sp, #(16*16)
    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_cyclic_FFT16_precompute
.global ___asm_cyclic_FFT16_precompute
__asm_cyclic_FFT16_precompute:
___asm_cyclic_FFT16_precompute:

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]
    sub sp, sp, #(16*16)

    .equ  src00,  0*16
    .equ  src01,  1*16
    .equ  src02,  2*16
    .equ  src03,  3*16
    .equ  src04,  4*16
    .equ  src05,  5*16
    .equ  src06,  6*16
    .equ  src07,  7*16
    .equ  src08,  8*16
    .equ  src09,  9*16
    .equ src010, 10*16
    .equ src011, 11*16
    .equ src012, 12*16
    .equ src013, 13*16
    .equ src014, 14*16
    .equ src015, 15*16

    .equ  src10,  0*16
    .equ  src11,  1*16
    .equ  src12,  2*16
    .equ  src13,  3*16
    .equ  src14,  4*16
    .equ  src15,  5*16
    .equ  src16,  6*16
    .equ  src17,  7*16
    .equ  src18,  8*16
    .equ  src19,  9*16
    .equ src110, 10*16
    .equ src111, 11*16
    .equ src112, 12*16
    .equ src113, 13*16
    .equ src114, 14*16
    .equ src115, 15*16

    .equ   des0,  0*16
    .equ   des1,  1*16
    .equ   des2,  2*16
    .equ   des3,  3*16
    .equ   des4,  4*16
    .equ   des5,  5*16
    .equ   des6,  6*16
    .equ   des7,  7*16
    .equ   des8,  8*16
    .equ   des9,  9*16
    .equ  des10, 10*16
    .equ  des11, 11*16
    .equ  des12, 12*16
    .equ  des13, 13*16
    .equ  des14, 14*16
    .equ  des15, 15*16

    ldr  q0, [x1,  #src00]
    ldr  q1, [x1,  #src01]
    ldr  q2, [x1,  #src02]
    ldr  q3, [x1,  #src03]
    ldr  q4, [x1,  #src04]
    ldr  q5, [x1,  #src05]
    ldr  q6, [x1,  #src06]
    ldr  q7, [x1,  #src07]
    ldr  q8, [x1,  #src08]
    ldr  q9, [x1,  #src09]
    ldr q10, [x1, #src010]
    ldr q11, [x1, #src011]
    ldr q12, [x1, #src012]
    ldr q13, [x1, #src013]
    ldr q14, [x1, #src014]
    ldr q15, [x1, #src015]

    add   v16.8H,  v0.8H,  v8.8H
    sub   v24.8H,  v0.8H,  v8.8H
    add   v17.8H,  v1.8H,  v9.8H
    sub   v25.8H,  v1.8H,  v9.8H
    add   v18.8H,  v2.8H, v10.8H
    sub   v26.8H,  v2.8H, v10.8H
    add   v19.8H,  v3.8H, v11.8H
    sub   v27.8H,  v3.8H, v11.8H
    add   v20.8H,  v4.8H, v12.8H
    sub   v28.8H,  v4.8H, v12.8H
    add   v21.8H,  v5.8H, v13.8H
    sub   v29.8H,  v5.8H, v13.8H
    add   v22.8H,  v6.8H, v14.8H
    sub   v30.8H,  v6.8H, v14.8H
    add   v23.8H,  v7.8H, v15.8H
    sub   v31.8H,  v7.8H, v15.8H

    ldr d0, [x3]

    add    v8.8H, v16.8H, v20.8H
    sub   v12.8H, v16.8H, v20.8H
    add    v9.8H, v17.8H, v21.8H
    sub   v13.8H, v17.8H, v21.8H
    add   v10.8H, v18.8H, v22.8H
    sub   v14.8H, v18.8H, v22.8H
    add   v11.8H, v19.8H, v23.8H
    sub   v15.8H, v19.8H, v23.8H

    sqdmulh  v16.8H,  v8.8H,  v0.H[2]
    sqdmulh  v17.8H,  v9.8H,  v0.H[2]
    sqdmulh  v18.8H, v10.8H,  v0.H[2]
    sqdmulh  v19.8H, v11.8H,  v0.H[2]
    sqdmulh  v20.8H, v12.8H,  v0.H[2]
    sqdmulh  v21.8H, v13.8H,  v0.H[2]
    sqdmulh  v22.8H, v14.8H,  v0.H[2]
    sqdmulh  v23.8H, v15.8H,  v0.H[2]

    srshr    v16.8H, v16.8H, #12
    srshr    v17.8H, v17.8H, #12
    srshr    v18.8H, v18.8H, #12
    srshr    v19.8H, v19.8H, #12
    srshr    v20.8H, v20.8H, #12
    srshr    v21.8H, v21.8H, #12
    srshr    v22.8H, v22.8H, #12
    srshr    v23.8H, v23.8H, #12

    mls       v8.8H, v16.8H,  v0.H[1]
    mls       v8.8H, v17.8H,  v0.H[1]
    mls      v10.8H, v18.8H,  v0.H[1]
    mls      v11.8H, v19.8H,  v0.H[1]
    mls      v12.8H, v20.8H,  v0.H[1]
    mls      v13.8H, v21.8H,  v0.H[1]
    mls      v14.8H, v22.8H,  v0.H[1]
    mls      v15.8H, v23.8H,  v0.H[1]

    str  q8, [sp,  #0*16]
    str  q9, [sp,  #1*16]
    str q10, [sp,  #2*16]
    str q11, [sp,  #3*16]
    str q12, [sp,  #4*16]
    str q13, [sp,  #5*16]
    str q14, [sp,  #6*16]
    str q15, [sp,  #7*16]
    str q24, [sp,  #8*16]
    str q25, [sp,  #9*16]
    str q26, [sp, #10*16]
    str q27, [sp, #11*16]
    str q28, [sp, #12*16]
    str q29, [sp, #13*16]
    str q30, [sp, #14*16]
    str q31, [sp, #15*16]

    ldr  q8, [x2,  #src10]
    ldr  q9, [x2,  #src11]
    ldr q10, [x2,  #src12]
    ldr q11, [x2,  #src13]
    ldr q12, [x2,  #src14]
    ldr q13, [x2,  #src15]
    ldr q14, [x2,  #src16]
    ldr q15, [x2,  #src17]
    ldr q24, [x2,  #src18]
    ldr q25, [x2,  #src19]
    ldr q26, [x2, #src110]
    ldr q27, [x2, #src111]
    ldr q28, [x2, #src112]
    ldr q29, [x2, #src113]
    ldr q30, [x2, #src114]
    ldr q31, [x2, #src115]


// ================

    ldr q16, [sp,  #0*16]
    ldr q17, [sp,  #1*16]
    ldr q18, [sp,  #2*16]
    ldr q19, [sp,  #3*16]
    ldr q20, [sp,  #4*16]
    ldr q21, [sp,  #5*16]
    ldr q22, [sp,  #6*16]
    ldr q23, [sp,  #7*16]

    ldr  d0, [x3]

    // 0
    smull   v4.4S,  v8.4H, v16.4H
    smull2  v5.4S,  v8.8H, v16.8H
    smlal   v4.4S,  v9.4H, v19.4H
    smlal2  v5.4S,  v9.8H, v19.8H
    smlal   v4.4S, v10.4H, v18.4H
    smlal2  v5.4S, v10.8H, v18.8H
    smlal   v4.4S, v11.4H, v17.4H
    smlal2  v5.4S, v11.8H, v17.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #0*16]

    // 1
    smull   v4.4S,  v8.4H, v17.4H
    smull2  v5.4S,  v8.8H, v17.8H
    smlal   v4.4S,  v9.4H, v16.4H
    smlal2  v5.4S,  v9.8H, v16.8H
    smlal   v4.4S, v10.4H, v19.4H
    smlal2  v5.4S, v10.8H, v19.8H
    smlal   v4.4S, v11.4H, v18.4H
    smlal2  v5.4S, v11.8H, v18.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #1*16]

    // 2
    smull   v4.4S,  v8.4H, v18.4H
    smull2  v5.4S,  v8.8H, v18.8H
    smlal   v4.4S,  v9.4H, v17.4H
    smlal2  v5.4S,  v9.8H, v17.8H
    smlal   v4.4S, v10.4H, v16.4H
    smlal2  v5.4S, v10.8H, v16.8H
    smlal   v4.4S, v11.4H, v19.4H
    smlal2  v5.4S, v11.8H, v19.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #2*16]

    // 3
    smull   v4.4S,  v8.4H, v19.4H
    smull2  v5.4S,  v8.8H, v19.8H
    smlal   v4.4S,  v9.4H, v18.4H
    smlal2  v5.4S,  v9.8H, v18.8H
    smlal   v4.4S, v10.4H, v17.4H
    smlal2  v5.4S, v10.8H, v17.8H
    smlal   v4.4S, v11.4H, v16.4H
    smlal2  v5.4S, v11.8H, v16.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #3*16]

// ================

    // 4
    smull   v4.4S, v12.4H, v20.4H
    smull2  v5.4S, v12.8H, v20.8H
    smlsl   v4.4S, v13.4H, v23.4H
    smlsl2  v5.4S, v13.8H, v23.8H
    smlsl   v4.4S, v14.4H, v22.4H
    smlsl2  v5.4S, v14.8H, v22.8H
    smlsl   v4.4S, v15.4H, v21.4H
    smlsl2  v5.4S, v15.8H, v21.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #4*16]

    // 5
    smull   v4.4S, v12.4H, v21.4H
    smull2  v5.4S, v12.8H, v21.8H
    smlal   v4.4S, v13.4H, v20.4H
    smlal2  v5.4S, v13.8H, v20.8H
    smlsl   v4.4S, v14.4H, v23.4H
    smlsl2  v5.4S, v14.8H, v23.8H
    smlsl   v4.4S, v15.4H, v22.4H
    smlsl2  v5.4S, v15.8H, v22.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #5*16]

    // 6
    smull   v4.4S, v12.4H, v22.4H
    smull2  v5.4S, v12.8H, v22.8H
    smlal   v4.4S, v13.4H, v21.4H
    smlal2  v5.4S, v13.8H, v21.8H
    smlal   v4.4S, v14.4H, v20.4H
    smlal2  v5.4S, v14.8H, v20.8H
    smlsl   v4.4S, v15.4H, v23.4H
    smlsl2  v5.4S, v15.8H, v23.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #6*16]

    // 7
    smull   v4.4S, v12.4H, v23.4H
    smull2  v5.4S, v12.8H, v23.8H
    smlal   v4.4S, v13.4H, v22.4H
    smlal2  v5.4S, v13.8H, v22.8H
    smlal   v4.4S, v14.4H, v21.4H
    smlal2  v5.4S, v14.8H, v21.8H
    smlal   v4.4S, v15.4H, v20.4H
    smlal2  v5.4S, v15.8H, v20.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #7*16]

// ================

    ldr  q8, [sp,  #(8+0)*16]
    ldr  q9, [sp,  #(8+1)*16]
    ldr q10, [sp,  #(8+2)*16]
    ldr q11, [sp,  #(8+3)*16]
    ldr q12, [sp,  #(8+4)*16]
    ldr q13, [sp,  #(8+5)*16]
    ldr q14, [sp,  #(8+6)*16]
    ldr q15, [sp,  #(8+7)*16]

    // 0
    smull   v4.4S,  v8.4H, v24.4H
    smull2  v5.4S,  v8.8H, v24.8H
    smlsl   v4.4S,  v9.4H, v31.4H
    smlsl2  v5.4S,  v9.8H, v31.8H
    smlsl   v4.4S, v10.4H, v30.4H
    smlsl2  v5.4S, v10.8H, v30.8H
    smlsl   v4.4S, v11.4H, v29.4H
    smlsl2  v5.4S, v11.8H, v29.8H
    smlsl   v4.4S, v12.4H, v28.4H
    smlsl2  v5.4S, v12.8H, v28.8H
    smlsl   v4.4S, v13.4H, v27.4H
    smlsl2  v5.4S, v13.8H, v27.8H
    smlsl   v4.4S, v14.4H, v26.4H
    smlsl2  v5.4S, v14.8H, v26.8H
    smlsl   v4.4S, v15.4H, v25.4H
    smlsl2  v5.4S, v15.8H, v25.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+0)*16]

    // 1
    smull   v4.4S,  v8.4H, v25.4H
    smull2  v5.4S,  v8.8H, v25.8H
    smlal   v4.4S,  v9.4H, v24.4H
    smlal2  v5.4S,  v9.8H, v24.8H
    smlsl   v4.4S, v10.4H, v31.4H
    smlsl2  v5.4S, v10.8H, v31.8H
    smlsl   v4.4S, v11.4H, v30.4H
    smlsl2  v5.4S, v11.8H, v30.8H
    smlsl   v4.4S, v12.4H, v29.4H
    smlsl2  v5.4S, v12.8H, v29.8H
    smlsl   v4.4S, v13.4H, v28.4H
    smlsl2  v5.4S, v13.8H, v28.8H
    smlsl   v4.4S, v14.4H, v27.4H
    smlsl2  v5.4S, v14.8H, v27.8H
    smlsl   v4.4S, v15.4H, v26.4H
    smlsl2  v5.4S, v15.8H, v26.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+1)*16]

    // 2
    smull   v4.4S,  v8.4H, v26.4H
    smull2  v5.4S,  v8.8H, v26.8H
    smlal   v4.4S,  v9.4H, v25.4H
    smlal2  v5.4S,  v9.8H, v25.8H
    smlal   v4.4S, v10.4H, v24.4H
    smlal2  v5.4S, v10.8H, v24.8H
    smlsl   v4.4S, v11.4H, v31.4H
    smlsl2  v5.4S, v11.8H, v31.8H
    smlsl   v4.4S, v12.4H, v30.4H
    smlsl2  v5.4S, v12.8H, v30.8H
    smlsl   v4.4S, v13.4H, v29.4H
    smlsl2  v5.4S, v13.8H, v29.8H
    smlsl   v4.4S, v14.4H, v28.4H
    smlsl2  v5.4S, v14.8H, v28.8H
    smlsl   v4.4S, v15.4H, v27.4H
    smlsl2  v5.4S, v15.8H, v27.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+2)*16]

    // 3
    smull   v4.4S,  v8.4H, v27.4H
    smull2  v5.4S,  v8.8H, v27.8H
    smlal   v4.4S,  v9.4H, v26.4H
    smlal2  v5.4S,  v9.8H, v26.8H
    smlal   v4.4S, v10.4H, v25.4H
    smlal2  v5.4S, v10.8H, v25.8H
    smlal   v4.4S, v11.4H, v24.4H
    smlal2  v5.4S, v11.8H, v24.8H
    smlsl   v4.4S, v12.4H, v31.4H
    smlsl2  v5.4S, v12.8H, v31.8H
    smlsl   v4.4S, v13.4H, v30.4H
    smlsl2  v5.4S, v13.8H, v30.8H
    smlsl   v4.4S, v14.4H, v29.4H
    smlsl2  v5.4S, v14.8H, v29.8H
    smlsl   v4.4S, v15.4H, v28.4H
    smlsl2  v5.4S, v15.8H, v28.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+3)*16]

    // 4
    smull   v4.4S,  v8.4H, v28.4H
    smull2  v5.4S,  v8.8H, v28.8H
    smlal   v4.4S,  v9.4H, v27.4H
    smlal2  v5.4S,  v9.8H, v27.8H
    smlal   v4.4S, v10.4H, v26.4H
    smlal2  v5.4S, v10.8H, v26.8H
    smlal   v4.4S, v11.4H, v25.4H
    smlal2  v5.4S, v11.8H, v25.8H
    smlal   v4.4S, v12.4H, v24.4H
    smlal2  v5.4S, v12.8H, v24.8H
    smlsl   v4.4S, v13.4H, v31.4H
    smlsl2  v5.4S, v13.8H, v31.8H
    smlsl   v4.4S, v14.4H, v30.4H
    smlsl2  v5.4S, v14.8H, v30.8H
    smlsl   v4.4S, v15.4H, v29.4H
    smlsl2  v5.4S, v15.8H, v29.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+4)*16]

    // 5
    smull   v4.4S,  v8.4H, v29.4H
    smull2  v5.4S,  v8.8H, v29.8H
    smlal   v4.4S,  v9.4H, v28.4H
    smlal2  v5.4S,  v9.8H, v28.8H
    smlal   v4.4S, v10.4H, v27.4H
    smlal2  v5.4S, v10.8H, v27.8H
    smlal   v4.4S, v11.4H, v26.4H
    smlal2  v5.4S, v11.8H, v26.8H
    smlal   v4.4S, v12.4H, v25.4H
    smlal2  v5.4S, v12.8H, v25.8H
    smlal   v4.4S, v13.4H, v24.4H
    smlal2  v5.4S, v13.8H, v24.8H
    smlsl   v4.4S, v14.4H, v31.4H
    smlsl2  v5.4S, v14.8H, v31.8H
    smlsl   v4.4S, v15.4H, v30.4H
    smlsl2  v5.4S, v15.8H, v30.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+5)*16]

    // 6
    smull   v4.4S,  v8.4H, v30.4H
    smull2  v5.4S,  v8.8H, v30.8H
    smlal   v4.4S,  v9.4H, v29.4H
    smlal2  v5.4S,  v9.8H, v29.8H
    smlal   v4.4S, v10.4H, v28.4H
    smlal2  v5.4S, v10.8H, v28.8H
    smlal   v4.4S, v11.4H, v27.4H
    smlal2  v5.4S, v11.8H, v27.8H
    smlal   v4.4S, v12.4H, v26.4H
    smlal2  v5.4S, v12.8H, v26.8H
    smlal   v4.4S, v13.4H, v25.4H
    smlal2  v5.4S, v13.8H, v25.8H
    smlal   v4.4S, v14.4H, v24.4H
    smlal2  v5.4S, v14.8H, v24.8H
    smlsl   v4.4S, v15.4H, v31.4H
    smlsl2  v5.4S, v15.8H, v31.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+6)*16]

    // 7
    smull   v4.4S,  v8.4H, v31.4H
    smull2  v5.4S,  v8.8H, v31.8H
    smlal   v4.4S,  v9.4H, v30.4H
    smlal2  v5.4S,  v9.8H, v30.8H
    smlal   v4.4S, v10.4H, v29.4H
    smlal2  v5.4S, v10.8H, v29.8H
    smlal   v4.4S, v11.4H, v28.4H
    smlal2  v5.4S, v11.8H, v28.8H
    smlal   v4.4S, v12.4H, v27.4H
    smlal2  v5.4S, v12.8H, v27.8H
    smlal   v4.4S, v13.4H, v26.4H
    smlal2  v5.4S, v13.8H, v26.8H
    smlal   v4.4S, v14.4H, v25.4H
    smlal2  v5.4S, v14.8H, v25.8H
    smlal   v4.4S, v15.4H, v24.4H
    smlal2  v5.4S, v15.8H, v24.8H

    uzp1    v6.8H,  v4.8H,  v5.8H
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal   v4.4S,  v6.4H,  v0.H[1]
    smlal2  v5.4S,  v6.8H,  v0.H[1]
    uzp2    v6.8H,  v4.8H,  v5.8H

    str  q6, [sp,  #(8+7)*16]

// ================

    ldr  q0, [sp,  #0*16]
    ldr  q4, [sp,  #4*16]
    ldr  q8, [sp,  #8*16]
    ldr q12, [sp, #12*16]

    add   v16.8H,  v0.8H,  v4.8H
    sub   v20.8H,  v0.8H,  v4.8H
    add    v8.8H,  v8.8H,  v8.8H
    add   v12.8H, v12.8H, v12.8H
    sub   v24.8H, v16.8H,  v8.8H
    add   v16.8H, v16.8H,  v8.8H
    sub   v28.8H, v20.8H, v12.8H
    add   v20.8H, v20.8H, v12.8H

    str q16, [x0,  #des0]
    str q20, [x0,  #des4]
    str q24, [x0,  #des8]
    str q28, [x0, #des12]

    ldr  q1, [sp,  #1*16]
    ldr  q5, [sp,  #5*16]
    ldr  q9, [sp,  #9*16]
    ldr q13, [sp, #13*16]

    add   v17.8H,  v1.8H,  v5.8H
    sub   v21.8H,  v1.8H,  v5.8H
    add    v9.8H,  v9.8H,  v9.8H
    add   v13.8H, v13.8H, v13.8H
    sub   v25.8H, v17.8H,  v9.8H
    add   v17.8H, v17.8H,  v9.8H
    sub   v29.8H, v21.8H, v13.8H
    add   v21.8H, v21.8H, v13.8H

    str q17, [x0,  #des1]
    str q21, [x0,  #des5]
    str q25, [x0,  #des9]
    str q29, [x0, #des13]

    ldr  q2, [sp,  #2*16]
    ldr  q6, [sp,  #6*16]
    ldr q10, [sp, #10*16]
    ldr q14, [sp, #14*16]

    add   v18.8H,  v2.8H,  v6.8H
    sub   v22.8H,  v2.8H,  v6.8H
    add   v10.8H, v10.8H, v10.8H
    add   v14.8H, v14.8H, v14.8H
    sub   v26.8H, v18.8H, v10.8H
    add   v18.8H, v18.8H, v10.8H
    sub   v30.8H, v22.8H, v14.8H
    add   v22.8H, v22.8H, v14.8H

    str q18, [x0,  #des2]
    str q22, [x0,  #des6]
    str q26, [x0, #des10]
    str q30, [x0, #des14]

    ldr  q3, [sp,  #3*16]
    ldr  q7, [sp,  #7*16]
    ldr q11, [sp, #11*16]
    ldr q15, [sp, #15*16]

    add   v19.8H,  v3.8H,  v7.8H
    sub   v23.8H,  v3.8H,  v7.8H
    add   v11.8H, v11.8H, v11.8H
    add   v15.8H, v15.8H, v15.8H
    sub   v27.8H, v19.8H, v11.8H
    add   v19.8H, v19.8H, v11.8H
    sub   v31.8H, v23.8H, v15.8H
    add   v23.8H, v23.8H, v15.8H

    str q19, [x0,  #des3]
    str q23, [x0,  #des7]
    str q27, [x0, #des11]
    str q31, [x0, #des15]

    add sp, sp, #(16*16)
    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr










