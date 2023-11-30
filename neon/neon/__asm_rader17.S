

.if 0

i mapsto 16 - rader_dlog_permute[i] =
{
0, 2, 15, 4,
11, 1, 5, 6,
14, 13, 9, 3,
12, 7, 10, 8
}

16 - rader_dlog_permute[i] mapsto i =
{
0, 5, 1, 11,
3, 6, 7, 13,
15, 10, 14, 4,
12, 9, 8, 2
}

i mapsto rader_dlog_permute[i] =
{
0, 14, 1, 12,
5, 15, 11, 10,
2, 3, 7, 13,
4, 9, 6, 8
}

rader_dlog_permute[i] mapsto i =
{
0, 2, 8, 9,
12, 4, 14, 10,
15, 13, 7, 6,
3, 11, 1, 5
}

.endif

.align 6
.global __asm_rader17_primitive
.global ___asm_rader17_primitive
__asm_rader17_primitive:
___asm_rader17_primitive:

    counter     .req  x8

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]
    sub sp, sp, #(16*16)

    .equ  src00,  0*192
    .equ  src01,  5*192
    .equ  src02,  1*192
    .equ  src03, 11*192
    .equ  src04,  3*192
    .equ  src05,  6*192
    .equ  src06,  7*192
    .equ  src07, 13*192
    .equ  src08, 15*192
    .equ  src09, 10*192
    .equ src010, 14*192
    .equ src011,  4*192
    .equ src012, 12*192
    .equ src013,  9*192
    .equ src014,  8*192
    .equ src015,  2*192

    .equ   des0,  0*192
    .equ   des1,  2*192
    .equ   des2,  8*192
    .equ   des3,  9*192
    .equ   des4, 12*192
    .equ   des5,  4*192
    .equ   des6, 14*192
    .equ   des7, 10*192
    .equ   des8, 15*192
    .equ   des9, 13*192
    .equ  des10,  7*192
    .equ  des11,  6*192
    .equ  des12,  3*192
    .equ  des13, 11*192
    .equ  des14,  1*192
    .equ  des15,  5*192

    ldr  q0, [x1,  #src00]
    ldr  q4, [x1,  #src04]
    ldr  q8, [x1,  #src08]
    ldr q12, [x1, #src012]

    add   v16.8H,  v0.8H,  v8.8H
    sub   v24.8H,  v0.8H,  v8.8H
    add   v20.8H,  v4.8H, v12.8H
    sub   v28.8H,  v4.8H, v12.8H
    add    v8.8H, v16.8H, v20.8H
    sub   v12.8H, v16.8H, v20.8H

    ldr  q1, [x1,  #src01]
    ldr  q5, [x1,  #src05]
    ldr  q9, [x1,  #src09]
    ldr q13, [x1, #src013]

    add   v17.8H,  v1.8H,  v9.8H
    sub   v25.8H,  v1.8H,  v9.8H
    add   v21.8H,  v5.8H, v13.8H
    sub   v29.8H,  v5.8H, v13.8H
    add    v9.8H, v17.8H, v21.8H
    sub   v13.8H, v17.8H, v21.8H

    ldr  q2, [x1,  #src02]
    ldr  q6, [x1,  #src06]
    ldr q10, [x1, #src010]
    ldr q14, [x1, #src014]

    add   v18.8H,  v2.8H, v10.8H
    sub   v26.8H,  v2.8H, v10.8H
    add   v22.8H,  v6.8H, v14.8H
    sub   v30.8H,  v6.8H, v14.8H
    add   v10.8H, v18.8H, v22.8H
    sub   v14.8H, v18.8H, v22.8H

    ldr  q3, [x1,  #src03]
    ldr  q7, [x1,  #src07]
    ldr q11, [x1, #src011]
    ldr q15, [x1, #src015]

    add   v19.8H,  v3.8H, v11.8H
    sub   v27.8H,  v3.8H, v11.8H
    add   v23.8H,  v7.8H, v15.8H
    sub   v31.8H,  v7.8H, v15.8H
    add   v11.8H, v19.8H, v23.8H
    sub   v15.8H, v19.8H, v23.8H

    add x1, x1, #16

    ldr d0, [x3]

    ldr q2, [x2,  #0*16]
    ldr q3, [x2,  #1*16]

// ================

    ldr  d0, [x3]

    // 0
    smull  v16.4S,  v8.4H,  v2.H[0]
    smull2 v17.4S,  v8.8H,  v2.H[0]
    smlal  v16.4S,  v9.4H,  v2.H[3]
    smlal2 v17.4S,  v9.8H,  v2.H[3]
    smlal  v16.4S, v10.4H,  v2.H[2]
    smlal2 v17.4S, v10.8H,  v2.H[2]
    smlal  v16.4S, v11.4H,  v2.H[1]
    smlal2 v17.4S, v11.8H,  v2.H[1]

    // 1
    smull  v18.4S,  v8.4H,  v2.H[1]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S,  v8.8H,  v2.H[1]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S,  v9.4H,  v2.H[0]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S,  v9.8H,  v2.H[0]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlal  v18.4S, v10.4H,  v2.H[3]
    uzp2    v4.8H, v16.8H, v17.8H
    smlal2 v19.4S, v10.8H,  v2.H[3]
    str  q4, [sp,  #0*16]
    smlal  v18.4S, v11.4H,  v2.H[2]
    smlal2 v19.4S, v11.8H,  v2.H[2]

    // 2
    smull  v20.4S,  v8.4H,  v2.H[2]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S,  v8.8H,  v2.H[2]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S,  v9.4H,  v2.H[1]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S,  v9.8H,  v2.H[1]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v10.4H,  v2.H[0]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v10.8H,  v2.H[0]
    str  q5, [sp,  #1*16]
    smlal  v20.4S, v11.4H,  v2.H[3]
    smlal2 v21.4S, v11.8H,  v2.H[3]

    // 3
    smull  v22.4S,  v8.4H,  v2.H[3]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S,  v8.8H,  v2.H[3]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S,  v9.4H,  v2.H[2]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S,  v9.8H,  v2.H[2]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v10.4H,  v2.H[1]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v10.8H,  v2.H[1]
    str  q6, [sp,  #2*16]
    smlal  v22.4S, v11.4H,  v2.H[0]
    smlal2 v23.4S, v11.8H,  v2.H[0]

    // 4
    smull  v16.4S, v12.4H,  v2.H[4]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v12.8H,  v2.H[4]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlsl  v16.4S, v13.4H,  v2.H[7]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlsl2 v17.4S, v13.8H,  v2.H[7]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlsl  v16.4S, v14.4H,  v2.H[6]
    uzp2    v7.8H, v22.8H, v23.8H
    smlsl2 v17.4S, v14.8H,  v2.H[6]
    str  q7, [sp,  #3*16]

// ================

    smlsl  v16.4S, v15.4H,  v2.H[5]
    smlsl2 v17.4S, v15.8H,  v2.H[5]

    // 5
    smull  v18.4S, v12.4H,  v2.H[5]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v12.8H,  v2.H[5]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v13.4H,  v2.H[4]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v13.8H,  v2.H[4]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlsl  v18.4S, v14.4H,  v2.H[7]
    uzp2    v4.8H, v16.8H, v17.8H
    smlsl2 v19.4S, v14.8H,  v2.H[7]
    str  q4, [sp,  #4*16]
    smlsl  v18.4S, v15.4H,  v2.H[6]
    smlsl2 v19.4S, v15.8H,  v2.H[6]

    // 6
    smull  v20.4S, v12.4H,  v2.H[6]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v12.8H,  v2.H[6]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v13.4H,  v2.H[5]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v13.8H,  v2.H[5]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v14.4H,  v2.H[4]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v14.8H,  v2.H[4]
    str  q5, [sp,  #5*16]
    smlsl  v20.4S, v15.4H,  v2.H[7]
    smlsl2 v21.4S, v15.8H,  v2.H[7]

    // 7
    smull  v22.4S, v12.4H,  v2.H[7]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v12.8H,  v2.H[7]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v13.4H,  v2.H[6]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v13.8H,  v2.H[6]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v14.4H,  v2.H[5]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v14.8H,  v2.H[5]
    str  q6, [sp,  #6*16]
    smlal  v22.4S, v15.4H,  v2.H[4]
    smlal2 v23.4S, v15.8H,  v2.H[4]

    // 0
    smull  v16.4S, v24.4H,  v3.H[0]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v24.8H,  v3.H[0]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlsl  v16.4S, v25.4H,  v3.H[7]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlsl2 v17.4S, v25.8H,  v3.H[7]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlsl  v16.4S, v26.4H,  v3.H[6]
    uzp2    v7.8H, v22.8H, v23.8H
    smlsl2 v17.4S, v26.8H,  v3.H[6]
    str  q7, [sp,  #7*16]

// ================

    smlsl  v16.4S, v27.4H,  v3.H[5]
    smlsl2 v17.4S, v27.8H,  v3.H[5]
    smlsl  v16.4S, v28.4H,  v3.H[4]
    smlsl2 v17.4S, v28.8H,  v3.H[4]
    smlsl  v16.4S, v29.4H,  v3.H[3]
    smlsl2 v17.4S, v29.8H,  v3.H[3]
    smlsl  v16.4S, v30.4H,  v3.H[2]
    smlsl2 v17.4S, v30.8H,  v3.H[2]
    smlsl  v16.4S, v31.4H,  v3.H[1]
    smlsl2 v17.4S, v31.8H,  v3.H[1]

    // 1
    smull  v18.4S, v24.4H,  v3.H[1]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v24.8H,  v3.H[1]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v25.4H,  v3.H[0]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v25.8H,  v3.H[0]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlsl  v18.4S, v26.4H,  v3.H[7]
    uzp2    v4.8H, v16.8H, v17.8H
    smlsl2 v19.4S, v26.8H,  v3.H[7]
    str  q4, [sp,  #(8+0)*16]

    smlsl  v18.4S, v27.4H,  v3.H[6]
    smlsl2 v19.4S, v27.8H,  v3.H[6]
    smlsl  v18.4S, v28.4H,  v3.H[5]
    smlsl2 v19.4S, v28.8H,  v3.H[5]
    smlsl  v18.4S, v29.4H,  v3.H[4]
    smlsl2 v19.4S, v29.8H,  v3.H[4]
    smlsl  v18.4S, v30.4H,  v3.H[3]
    smlsl2 v19.4S, v30.8H,  v3.H[3]
    smlsl  v18.4S, v31.4H,  v3.H[2]
    smlsl2 v19.4S, v31.8H,  v3.H[2]

    // 2
    smull  v20.4S, v24.4H,  v3.H[2]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v24.8H,  v3.H[2]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v25.4H,  v3.H[1]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v25.8H,  v3.H[1]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v26.4H,  v3.H[0]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v26.8H,  v3.H[0]
    str  q5, [sp,  #(8+1)*16]

    smlsl  v20.4S, v27.4H,  v3.H[7]
    smlsl2 v21.4S, v27.8H,  v3.H[7]
    smlsl  v20.4S, v28.4H,  v3.H[6]
    smlsl2 v21.4S, v28.8H,  v3.H[6]
    smlsl  v20.4S, v29.4H,  v3.H[5]
    smlsl2 v21.4S, v29.8H,  v3.H[5]
    smlsl  v20.4S, v30.4H,  v3.H[4]
    smlsl2 v21.4S, v30.8H,  v3.H[4]
    smlsl  v20.4S, v31.4H,  v3.H[3]
    smlsl2 v21.4S, v31.8H,  v3.H[3]

    // 3
    smull  v22.4S, v24.4H,  v3.H[3]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v24.8H,  v3.H[3]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v25.4H,  v3.H[2]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v25.8H,  v3.H[2]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v26.4H,  v3.H[1]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v26.8H,  v3.H[1]
    str  q6, [sp,  #(8+2)*16]

    smlal  v22.4S, v27.4H,  v3.H[0]
    smlal2 v23.4S, v27.8H,  v3.H[0]
    smlsl  v22.4S, v28.4H,  v3.H[7]
    smlsl2 v23.4S, v28.8H,  v3.H[7]
    smlsl  v22.4S, v29.4H,  v3.H[6]
    smlsl2 v23.4S, v29.8H,  v3.H[6]
    smlsl  v22.4S, v30.4H,  v3.H[5]
    smlsl2 v23.4S, v30.8H,  v3.H[5]
    smlsl  v22.4S, v31.4H,  v3.H[4]
    smlsl2 v23.4S, v31.8H,  v3.H[4]

    // 4
    smull  v16.4S, v24.4H,  v3.H[4]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v24.8H,  v3.H[4]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlal  v16.4S, v25.4H,  v3.H[3]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlal2 v17.4S, v25.8H,  v3.H[3]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlal  v16.4S, v26.4H,  v3.H[2]
    uzp2    v7.8H, v22.8H, v23.8H
    smlal2 v17.4S, v26.8H,  v3.H[2]
    str  q7, [sp,  #(8+3)*16]

    smlal  v16.4S, v27.4H,  v3.H[1]
    smlal2 v17.4S, v27.8H,  v3.H[1]
    smlal  v16.4S, v28.4H,  v3.H[0]
    smlal2 v17.4S, v28.8H,  v3.H[0]
    smlsl  v16.4S, v29.4H,  v3.H[7]
    smlsl2 v17.4S, v29.8H,  v3.H[7]
    smlsl  v16.4S, v30.4H,  v3.H[6]
    smlsl2 v17.4S, v30.8H,  v3.H[6]
    smlsl  v16.4S, v31.4H,  v3.H[5]
    smlsl2 v17.4S, v31.8H,  v3.H[5]

    // 5
    smull  v18.4S, v24.4H,  v3.H[5]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v24.8H,  v3.H[5]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v25.4H,  v3.H[4]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v25.8H,  v3.H[4]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlal  v18.4S, v26.4H,  v3.H[3]
    uzp2    v4.8H, v16.8H, v17.8H
    smlal2 v19.4S, v26.8H,  v3.H[3]
    str  q4, [sp,  #(8+4)*16]

    smlal  v18.4S, v27.4H,  v3.H[2]
    smlal2 v19.4S, v27.8H,  v3.H[2]
    smlal  v18.4S, v28.4H,  v3.H[1]
    smlal2 v19.4S, v28.8H,  v3.H[1]
    smlal  v18.4S, v29.4H,  v3.H[0]
    smlal2 v19.4S, v29.8H,  v3.H[0]
    smlsl  v18.4S, v30.4H,  v3.H[7]
    smlsl2 v19.4S, v30.8H,  v3.H[7]
    smlsl  v18.4S, v31.4H,  v3.H[6]
    smlsl2 v19.4S, v31.8H,  v3.H[6]

    // 6
    smull  v20.4S, v24.4H,  v3.H[6]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v24.8H,  v3.H[6]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v25.4H,  v3.H[5]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v25.8H,  v3.H[5]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v26.4H,  v3.H[4]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v26.8H,  v3.H[4]
    str  q5, [sp,  #(8+5)*16]

    smlal  v20.4S, v27.4H,  v3.H[3]
    smlal2 v21.4S, v27.8H,  v3.H[3]
    smlal  v20.4S, v28.4H,  v3.H[2]
    smlal2 v21.4S, v28.8H,  v3.H[2]
    smlal  v20.4S, v29.4H,  v3.H[1]
    smlal2 v21.4S, v29.8H,  v3.H[1]
    smlal  v20.4S, v30.4H,  v3.H[0]
    smlal2 v21.4S, v30.8H,  v3.H[0]
    smlsl  v20.4S, v31.4H,  v3.H[7]
    smlsl2 v21.4S, v31.8H,  v3.H[7]

    // 7
    smull  v22.4S, v24.4H,  v3.H[7]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v24.8H,  v3.H[7]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v25.4H,  v3.H[6]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v25.8H,  v3.H[6]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v26.4H,  v3.H[5]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v26.8H,  v3.H[5]
    str  q6, [sp,  #(8+6)*16]

    smlal  v22.4S, v27.4H,  v3.H[4]
    smlal2 v23.4S, v27.8H,  v3.H[4]
    smlal  v22.4S, v28.4H,  v3.H[3]
    smlal2 v23.4S, v28.8H,  v3.H[3]
    smlal  v22.4S, v29.4H,  v3.H[2]
    smlal2 v23.4S, v29.8H,  v3.H[2]
    smlal  v22.4S, v30.4H,  v3.H[1]
    smlal2 v23.4S, v30.8H,  v3.H[1]
    smlal  v22.4S, v31.4H,  v3.H[0]
    smlal2 v23.4S, v31.8H,  v3.H[0]

    uzp1    v7.8H, v22.8H, v23.8H
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    uzp2    v7.8H, v22.8H, v23.8H
    str  q7, [sp,  #(8+7)*16]

    mov counter, #11
    __asm_rader17_primitive_loop:

// ================================

    ldr q24, [sp,  #0*16]
    ldr q28, [sp,  #4*16]
    ldr q16, [sp,  #8*16]
    ldr q20, [sp, #12*16]

    ldr q25, [sp,  #1*16]
    add    v8.8H, v24.8H, v28.8H
    sub   v12.8H, v24.8H, v28.8H
    ldr q29, [sp,  #5*16]
    add   v16.8H, v16.8H, v16.8H
    add   v20.8H, v20.8H, v20.8H

    ldr q17, [sp,  #9*16]
    add   v24.8H,  v8.8H, v16.8H
    sub   v16.8H,  v8.8H, v16.8H
    ldr q21, [sp, #13*16]
    add   v28.8H, v12.8H, v20.8H
    sub   v20.8H, v12.8H, v20.8H

    ldr  q0, [x1,  #src00]
    add    v9.8H, v25.8H, v29.8H
    sub   v13.8H, v25.8H, v29.8H
    ldr  q4, [x1,  #src04]
    add   v17.8H, v17.8H, v17.8H
    add   v21.8H, v21.8H, v21.8H
    ldr  q8, [x1,  #src08]
    add   v25.8H,  v9.8H, v17.8H
    sub   v17.8H,  v9.8H, v17.8H
    ldr q12, [x1, #src012]
    add   v29.8H, v13.8H, v21.8H
    sub   v21.8H, v13.8H, v21.8H

    ldr  q1, [x1,  #src01]
    str q24, [x0,  #des0]
    sub   v24.8H,  v0.8H,  v8.8H
    ldr  q5, [x1,  #src05]
    str q28, [x0,  #des4]
    sub   v28.8H,  v4.8H, v12.8H
    ldr  q9, [x1,  #src09]
    str q16, [x0,  #des8]
    add   v16.8H,  v0.8H,  v8.8H
    ldr q13, [x1, #src013]
    str q20, [x0, #des12]
    add   v20.8H,  v4.8H, v12.8H

    add    v8.8H, v16.8H, v20.8H
    sub   v12.8H, v16.8H, v20.8H

// ================

    ldr q26, [sp,  #2*16]
    str q25, [x0,  #des1]
    sub   v25.8H,  v1.8H,  v9.8H
    ldr q30, [sp,  #6*16]
    str q29, [x0,  #des5]
    sub   v29.8H,  v5.8H, v13.8H
    ldr q18, [sp, #10*16]
    str q17, [x0,  #des9]
    add   v17.8H,  v1.8H,  v9.8H
    ldr q22, [sp, #14*16]
    str q21, [x0, #des13]
    add   v21.8H,  v5.8H, v13.8H

    add    v9.8H, v17.8H, v21.8H
    sub   v13.8H, v17.8H, v21.8H

// ================

    ldr q27, [sp,  #3*16]
    add   v10.8H, v26.8H, v30.8H
    sub   v14.8H, v26.8H, v30.8H
    ldr q31, [sp,  #7*16]
    add   v18.8H, v18.8H, v18.8H
    add   v22.8H, v22.8H, v22.8H

    ldr q19, [sp, #11*16]
    add   v26.8H, v10.8H, v18.8H
    sub   v18.8H, v10.8H, v18.8H
    ldr q23, [sp, #15*16]
    add   v30.8H, v14.8H, v22.8H
    sub   v22.8H, v14.8H, v22.8H

    ldr  q2, [x1,  #src02]
    add   v11.8H, v27.8H, v31.8H
    sub   v15.8H, v27.8H, v31.8H
    ldr  q6, [x1,  #src06]
    add   v19.8H, v19.8H, v19.8H
    add   v23.8H, v23.8H, v23.8H
    ldr q10, [x1, #src010]
    add   v27.8H, v11.8H, v19.8H
    sub   v19.8H, v11.8H, v19.8H
    ldr q14, [x1, #src014]
    add   v31.8H, v15.8H, v23.8H
    sub   v23.8H, v15.8H, v23.8H

    ldr  q3, [x1,  #src03]
    str q26, [x0,  #des2]
    sub   v26.8H,  v2.8H, v10.8H
    ldr  q7, [x1,  #src07]
    str q30, [x0,  #des6]
    sub   v30.8H,  v6.8H, v14.8H
    ldr q11, [x1, #src011]
    str q18, [x0, #des10]
    add   v18.8H,  v2.8H, v10.8H
    ldr q15, [x1, #src015]
    str q22, [x0, #des14]
    add   v22.8H,  v6.8H, v14.8H



// ================

    str q27, [x0,  #des3]
    add   v10.8H, v18.8H, v22.8H
    sub   v14.8H, v18.8H, v22.8H
    str q31, [x0,  #des7]
    sub   v27.8H,  v3.8H, v11.8H
    sub   v31.8H,  v7.8H, v15.8H
    str q19, [x0, #des11]
    str q23, [x0, #des15]
    add   v19.8H,  v3.8H, v11.8H
    add   v23.8H,  v7.8H, v15.8H

    add   v11.8H, v19.8H, v23.8H
    sub   v15.8H, v19.8H, v23.8H

// ================

    add x0, x0, #16
    add x1, x1, #16

    ldr q2, [x2,  #0*16]
    ldr q3, [x2,  #1*16]

// ================================

    ldr  d0, [x3]

    // 0
    smull  v16.4S,  v8.4H,  v2.H[0]
    smull2 v17.4S,  v8.8H,  v2.H[0]
    smlal  v16.4S,  v9.4H,  v2.H[3]
    smlal2 v17.4S,  v9.8H,  v2.H[3]
    smlal  v16.4S, v10.4H,  v2.H[2]
    smlal2 v17.4S, v10.8H,  v2.H[2]
    smlal  v16.4S, v11.4H,  v2.H[1]
    smlal2 v17.4S, v11.8H,  v2.H[1]

    // 1
    smull  v18.4S,  v8.4H,  v2.H[1]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S,  v8.8H,  v2.H[1]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S,  v9.4H,  v2.H[0]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S,  v9.8H,  v2.H[0]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlal  v18.4S, v10.4H,  v2.H[3]
    uzp2    v4.8H, v16.8H, v17.8H
    smlal2 v19.4S, v10.8H,  v2.H[3]
    str  q4, [sp,  #0*16]
    smlal  v18.4S, v11.4H,  v2.H[2]
    smlal2 v19.4S, v11.8H,  v2.H[2]

    // 2
    smull  v20.4S,  v8.4H,  v2.H[2]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S,  v8.8H,  v2.H[2]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S,  v9.4H,  v2.H[1]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S,  v9.8H,  v2.H[1]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v10.4H,  v2.H[0]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v10.8H,  v2.H[0]
    str  q5, [sp,  #1*16]
    smlal  v20.4S, v11.4H,  v2.H[3]
    smlal2 v21.4S, v11.8H,  v2.H[3]

    // 3
    smull  v22.4S,  v8.4H,  v2.H[3]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S,  v8.8H,  v2.H[3]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S,  v9.4H,  v2.H[2]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S,  v9.8H,  v2.H[2]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v10.4H,  v2.H[1]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v10.8H,  v2.H[1]
    str  q6, [sp,  #2*16]
    smlal  v22.4S, v11.4H,  v2.H[0]
    smlal2 v23.4S, v11.8H,  v2.H[0]

    // 4
    smull  v16.4S, v12.4H,  v2.H[4]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v12.8H,  v2.H[4]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlsl  v16.4S, v13.4H,  v2.H[7]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlsl2 v17.4S, v13.8H,  v2.H[7]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlsl  v16.4S, v14.4H,  v2.H[6]
    uzp2    v7.8H, v22.8H, v23.8H
    smlsl2 v17.4S, v14.8H,  v2.H[6]
    str  q7, [sp,  #3*16]

// ================

    smlsl  v16.4S, v15.4H,  v2.H[5]
    smlsl2 v17.4S, v15.8H,  v2.H[5]

    // 5
    smull  v18.4S, v12.4H,  v2.H[5]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v12.8H,  v2.H[5]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v13.4H,  v2.H[4]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v13.8H,  v2.H[4]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlsl  v18.4S, v14.4H,  v2.H[7]
    uzp2    v4.8H, v16.8H, v17.8H
    smlsl2 v19.4S, v14.8H,  v2.H[7]
    str  q4, [sp,  #4*16]
    smlsl  v18.4S, v15.4H,  v2.H[6]
    smlsl2 v19.4S, v15.8H,  v2.H[6]

    // 6
    smull  v20.4S, v12.4H,  v2.H[6]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v12.8H,  v2.H[6]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v13.4H,  v2.H[5]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v13.8H,  v2.H[5]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v14.4H,  v2.H[4]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v14.8H,  v2.H[4]
    str  q5, [sp,  #5*16]
    smlsl  v20.4S, v15.4H,  v2.H[7]
    smlsl2 v21.4S, v15.8H,  v2.H[7]

    // 7
    smull  v22.4S, v12.4H,  v2.H[7]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v12.8H,  v2.H[7]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v13.4H,  v2.H[6]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v13.8H,  v2.H[6]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v14.4H,  v2.H[5]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v14.8H,  v2.H[5]
    str  q6, [sp,  #6*16]
    smlal  v22.4S, v15.4H,  v2.H[4]
    smlal2 v23.4S, v15.8H,  v2.H[4]

    // 0
    smull  v16.4S, v24.4H,  v3.H[0]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v24.8H,  v3.H[0]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlsl  v16.4S, v25.4H,  v3.H[7]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlsl2 v17.4S, v25.8H,  v3.H[7]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlsl  v16.4S, v26.4H,  v3.H[6]
    uzp2    v7.8H, v22.8H, v23.8H
    smlsl2 v17.4S, v26.8H,  v3.H[6]
    str  q7, [sp,  #7*16]

// ================

    smlsl  v16.4S, v27.4H,  v3.H[5]
    smlsl2 v17.4S, v27.8H,  v3.H[5]
    smlsl  v16.4S, v28.4H,  v3.H[4]
    smlsl2 v17.4S, v28.8H,  v3.H[4]
    smlsl  v16.4S, v29.4H,  v3.H[3]
    smlsl2 v17.4S, v29.8H,  v3.H[3]
    smlsl  v16.4S, v30.4H,  v3.H[2]
    smlsl2 v17.4S, v30.8H,  v3.H[2]
    smlsl  v16.4S, v31.4H,  v3.H[1]
    smlsl2 v17.4S, v31.8H,  v3.H[1]

    // 1
    smull  v18.4S, v24.4H,  v3.H[1]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v24.8H,  v3.H[1]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v25.4H,  v3.H[0]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v25.8H,  v3.H[0]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlsl  v18.4S, v26.4H,  v3.H[7]
    uzp2    v4.8H, v16.8H, v17.8H
    smlsl2 v19.4S, v26.8H,  v3.H[7]
    str  q4, [sp,  #(8+0)*16]

    smlsl  v18.4S, v27.4H,  v3.H[6]
    smlsl2 v19.4S, v27.8H,  v3.H[6]
    smlsl  v18.4S, v28.4H,  v3.H[5]
    smlsl2 v19.4S, v28.8H,  v3.H[5]
    smlsl  v18.4S, v29.4H,  v3.H[4]
    smlsl2 v19.4S, v29.8H,  v3.H[4]
    smlsl  v18.4S, v30.4H,  v3.H[3]
    smlsl2 v19.4S, v30.8H,  v3.H[3]
    smlsl  v18.4S, v31.4H,  v3.H[2]
    smlsl2 v19.4S, v31.8H,  v3.H[2]

    // 2
    smull  v20.4S, v24.4H,  v3.H[2]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v24.8H,  v3.H[2]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v25.4H,  v3.H[1]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v25.8H,  v3.H[1]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v26.4H,  v3.H[0]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v26.8H,  v3.H[0]
    str  q5, [sp,  #(8+1)*16]

    smlsl  v20.4S, v27.4H,  v3.H[7]
    smlsl2 v21.4S, v27.8H,  v3.H[7]
    smlsl  v20.4S, v28.4H,  v3.H[6]
    smlsl2 v21.4S, v28.8H,  v3.H[6]
    smlsl  v20.4S, v29.4H,  v3.H[5]
    smlsl2 v21.4S, v29.8H,  v3.H[5]
    smlsl  v20.4S, v30.4H,  v3.H[4]
    smlsl2 v21.4S, v30.8H,  v3.H[4]
    smlsl  v20.4S, v31.4H,  v3.H[3]
    smlsl2 v21.4S, v31.8H,  v3.H[3]

    // 3
    smull  v22.4S, v24.4H,  v3.H[3]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v24.8H,  v3.H[3]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v25.4H,  v3.H[2]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v25.8H,  v3.H[2]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v26.4H,  v3.H[1]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v26.8H,  v3.H[1]
    str  q6, [sp,  #(8+2)*16]

    smlal  v22.4S, v27.4H,  v3.H[0]
    smlal2 v23.4S, v27.8H,  v3.H[0]
    smlsl  v22.4S, v28.4H,  v3.H[7]
    smlsl2 v23.4S, v28.8H,  v3.H[7]
    smlsl  v22.4S, v29.4H,  v3.H[6]
    smlsl2 v23.4S, v29.8H,  v3.H[6]
    smlsl  v22.4S, v30.4H,  v3.H[5]
    smlsl2 v23.4S, v30.8H,  v3.H[5]
    smlsl  v22.4S, v31.4H,  v3.H[4]
    smlsl2 v23.4S, v31.8H,  v3.H[4]

    // 4
    smull  v16.4S, v24.4H,  v3.H[4]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v24.8H,  v3.H[4]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlal  v16.4S, v25.4H,  v3.H[3]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlal2 v17.4S, v25.8H,  v3.H[3]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlal  v16.4S, v26.4H,  v3.H[2]
    uzp2    v7.8H, v22.8H, v23.8H
    smlal2 v17.4S, v26.8H,  v3.H[2]
    str  q7, [sp,  #(8+3)*16]

    smlal  v16.4S, v27.4H,  v3.H[1]
    smlal2 v17.4S, v27.8H,  v3.H[1]
    smlal  v16.4S, v28.4H,  v3.H[0]
    smlal2 v17.4S, v28.8H,  v3.H[0]
    smlsl  v16.4S, v29.4H,  v3.H[7]
    smlsl2 v17.4S, v29.8H,  v3.H[7]
    smlsl  v16.4S, v30.4H,  v3.H[6]
    smlsl2 v17.4S, v30.8H,  v3.H[6]
    smlsl  v16.4S, v31.4H,  v3.H[5]
    smlsl2 v17.4S, v31.8H,  v3.H[5]

    // 5
    smull  v18.4S, v24.4H,  v3.H[5]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v24.8H,  v3.H[5]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v25.4H,  v3.H[4]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v25.8H,  v3.H[4]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlal  v18.4S, v26.4H,  v3.H[3]
    uzp2    v4.8H, v16.8H, v17.8H
    smlal2 v19.4S, v26.8H,  v3.H[3]
    str  q4, [sp,  #(8+4)*16]

    smlal  v18.4S, v27.4H,  v3.H[2]
    smlal2 v19.4S, v27.8H,  v3.H[2]
    smlal  v18.4S, v28.4H,  v3.H[1]
    smlal2 v19.4S, v28.8H,  v3.H[1]
    smlal  v18.4S, v29.4H,  v3.H[0]
    smlal2 v19.4S, v29.8H,  v3.H[0]
    smlsl  v18.4S, v30.4H,  v3.H[7]
    smlsl2 v19.4S, v30.8H,  v3.H[7]
    smlsl  v18.4S, v31.4H,  v3.H[6]
    smlsl2 v19.4S, v31.8H,  v3.H[6]

    // 6
    smull  v20.4S, v24.4H,  v3.H[6]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v24.8H,  v3.H[6]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v25.4H,  v3.H[5]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v25.8H,  v3.H[5]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v26.4H,  v3.H[4]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v26.8H,  v3.H[4]
    str  q5, [sp,  #(8+5)*16]

    smlal  v20.4S, v27.4H,  v3.H[3]
    smlal2 v21.4S, v27.8H,  v3.H[3]
    smlal  v20.4S, v28.4H,  v3.H[2]
    smlal2 v21.4S, v28.8H,  v3.H[2]
    smlal  v20.4S, v29.4H,  v3.H[1]
    smlal2 v21.4S, v29.8H,  v3.H[1]
    smlal  v20.4S, v30.4H,  v3.H[0]
    smlal2 v21.4S, v30.8H,  v3.H[0]
    smlsl  v20.4S, v31.4H,  v3.H[7]
    smlsl2 v21.4S, v31.8H,  v3.H[7]

    // 7
    smull  v22.4S, v24.4H,  v3.H[7]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v24.8H,  v3.H[7]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v25.4H,  v3.H[6]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v25.8H,  v3.H[6]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v26.4H,  v3.H[5]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v26.8H,  v3.H[5]
    str  q6, [sp,  #(8+6)*16]

    smlal  v22.4S, v27.4H,  v3.H[4]
    smlal2 v23.4S, v27.8H,  v3.H[4]
    smlal  v22.4S, v28.4H,  v3.H[3]
    smlal2 v23.4S, v28.8H,  v3.H[3]
    smlal  v22.4S, v29.4H,  v3.H[2]
    smlal2 v23.4S, v29.8H,  v3.H[2]
    smlal  v22.4S, v30.4H,  v3.H[1]
    smlal2 v23.4S, v30.8H,  v3.H[1]
    smlal  v22.4S, v31.4H,  v3.H[0]
    smlal2 v23.4S, v31.8H,  v3.H[0]

    uzp1    v7.8H, v22.8H, v23.8H
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    uzp2    v7.8H, v22.8H, v23.8H
    str  q7, [sp,  #(8+7)*16]

// ================

    sub counter, counter, #1
    cbnz counter, __asm_rader17_primitive_loop

    ldr q24, [sp,  #0*16]
    ldr q28, [sp,  #4*16]
    ldr q16, [sp,  #8*16]
    ldr q20, [sp, #12*16]

    add    v8.8H, v24.8H, v28.8H
    sub   v12.8H, v24.8H, v28.8H
    add   v16.8H, v16.8H, v16.8H
    add   v20.8H, v20.8H, v20.8H

    add   v24.8H,  v8.8H, v16.8H
    sub   v16.8H,  v8.8H, v16.8H
    add   v28.8H, v12.8H, v20.8H
    sub   v20.8H, v12.8H, v20.8H

    str q24, [x0,  #des0]
    str q28, [x0,  #des4]
    str q16, [x0,  #des8]
    str q20, [x0, #des12]

    ldr q25, [sp,  #1*16]
    ldr q29, [sp,  #5*16]
    ldr q17, [sp,  #9*16]
    ldr q21, [sp, #13*16]

    add    v9.8H, v25.8H, v29.8H
    sub   v13.8H, v25.8H, v29.8H
    add   v17.8H, v17.8H, v17.8H
    add   v21.8H, v21.8H, v21.8H

    add   v25.8H,  v9.8H, v17.8H
    sub   v17.8H,  v9.8H, v17.8H
    add   v29.8H, v13.8H, v21.8H
    sub   v21.8H, v13.8H, v21.8H

    str q25, [x0,  #des1]
    str q29, [x0,  #des5]
    str q17, [x0,  #des9]
    str q21, [x0, #des13]

    ldr q26, [sp,  #2*16]
    ldr q30, [sp,  #6*16]
    ldr q18, [sp, #10*16]
    ldr q22, [sp, #14*16]

    add   v10.8H, v26.8H, v30.8H
    sub   v14.8H, v26.8H, v30.8H
    add   v18.8H, v18.8H, v18.8H
    add   v22.8H, v22.8H, v22.8H

    add   v26.8H, v10.8H, v18.8H
    sub   v18.8H, v10.8H, v18.8H
    add   v30.8H, v14.8H, v22.8H
    sub   v22.8H, v14.8H, v22.8H

    str q26, [x0,  #des2]
    str q30, [x0,  #des6]
    str q18, [x0, #des10]
    str q22, [x0, #des14]

    ldr q27, [sp,  #3*16]
    ldr q31, [sp,  #7*16]
    ldr q19, [sp, #11*16]
    ldr q23, [sp, #15*16]

    add   v11.8H, v27.8H, v31.8H
    sub   v15.8H, v27.8H, v31.8H
    add   v19.8H, v19.8H, v19.8H
    add   v23.8H, v23.8H, v23.8H

    add   v27.8H, v11.8H, v19.8H
    sub   v19.8H, v11.8H, v19.8H
    add   v31.8H, v15.8H, v23.8H
    sub   v23.8H, v15.8H, v23.8H

    str q27, [x0,  #des3]
    str q31, [x0,  #des7]
    str q19, [x0, #des11]
    str q23, [x0, #des15]

    // add x0, x0, #16

    add sp, sp, #(16*16)
    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_rader17_primitive_clean
.global ___asm_rader17_primitive_clean
__asm_rader17_primitive_clean:
___asm_rader17_primitive_clean:

    counter     .req  x8

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]
    sub sp, sp, #(16*16)

    .equ  src00,  0*192
    .equ  src01,  5*192
    .equ  src02,  1*192
    .equ  src03, 11*192
    .equ  src04,  3*192
    .equ  src05,  6*192
    .equ  src06,  7*192
    .equ  src07, 13*192
    .equ  src08, 15*192
    .equ  src09, 10*192
    .equ src010, 14*192
    .equ src011,  4*192
    .equ src012, 12*192
    .equ src013,  9*192
    .equ src014,  8*192
    .equ src015,  2*192

    .equ   des0,  0*192
    .equ   des1,  2*192
    .equ   des2,  8*192
    .equ   des3,  9*192
    .equ   des4, 12*192
    .equ   des5,  4*192
    .equ   des6, 14*192
    .equ   des7, 10*192
    .equ   des8, 15*192
    .equ   des9, 13*192
    .equ  des10,  7*192
    .equ  des11,  6*192
    .equ  des12,  3*192
    .equ  des13, 11*192
    .equ  des14,  1*192
    .equ  des15,  5*192

.rept 12

// ================

    ldr  q0, [x1,  #src00]
    ldr  q4, [x1,  #src04]
    ldr  q8, [x1,  #src08]
    ldr q12, [x1, #src012]

    add   v16.8H,  v0.8H,  v8.8H
    sub   v24.8H,  v0.8H,  v8.8H
    add   v20.8H,  v4.8H, v12.8H
    sub   v28.8H,  v4.8H, v12.8H
    add    v8.8H, v16.8H, v20.8H
    sub   v12.8H, v16.8H, v20.8H

    ldr  q1, [x1,  #src01]
    ldr  q5, [x1,  #src05]
    ldr  q9, [x1,  #src09]
    ldr q13, [x1, #src013]

    add   v17.8H,  v1.8H,  v9.8H
    sub   v25.8H,  v1.8H,  v9.8H
    add   v21.8H,  v5.8H, v13.8H
    sub   v29.8H,  v5.8H, v13.8H
    add    v9.8H, v17.8H, v21.8H
    sub   v13.8H, v17.8H, v21.8H

    ldr  q2, [x1,  #src02]
    ldr  q6, [x1,  #src06]
    ldr q10, [x1, #src010]
    ldr q14, [x1, #src014]

    add   v18.8H,  v2.8H, v10.8H
    sub   v26.8H,  v2.8H, v10.8H
    add   v22.8H,  v6.8H, v14.8H
    sub   v30.8H,  v6.8H, v14.8H
    add   v10.8H, v18.8H, v22.8H
    sub   v14.8H, v18.8H, v22.8H

    ldr  q3, [x1,  #src03]
    ldr  q7, [x1,  #src07]
    ldr q11, [x1, #src011]
    ldr q15, [x1, #src015]

    add   v19.8H,  v3.8H, v11.8H
    sub   v27.8H,  v3.8H, v11.8H
    add   v23.8H,  v7.8H, v15.8H
    sub   v31.8H,  v7.8H, v15.8H
    add   v11.8H, v19.8H, v23.8H
    sub   v15.8H, v19.8H, v23.8H

    add x1, x1, #16

    ldr d0, [x3]

    ldr q2, [x2,  #0*16]
    ldr q3, [x2,  #1*16]

// ================

    ldr  d0, [x3]

    // 0
    smull  v16.4S,  v8.4H,  v2.H[0]
    smull2 v17.4S,  v8.8H,  v2.H[0]
    smlal  v16.4S,  v9.4H,  v2.H[3]
    smlal2 v17.4S,  v9.8H,  v2.H[3]
    smlal  v16.4S, v10.4H,  v2.H[2]
    smlal2 v17.4S, v10.8H,  v2.H[2]
    smlal  v16.4S, v11.4H,  v2.H[1]
    smlal2 v17.4S, v11.8H,  v2.H[1]

    // 1
    smull  v18.4S,  v8.4H,  v2.H[1]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S,  v8.8H,  v2.H[1]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S,  v9.4H,  v2.H[0]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S,  v9.8H,  v2.H[0]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlal  v18.4S, v10.4H,  v2.H[3]
    uzp2    v4.8H, v16.8H, v17.8H
    smlal2 v19.4S, v10.8H,  v2.H[3]
    str  q4, [sp,  #0*16]
    smlal  v18.4S, v11.4H,  v2.H[2]
    smlal2 v19.4S, v11.8H,  v2.H[2]

    // 2
    smull  v20.4S,  v8.4H,  v2.H[2]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S,  v8.8H,  v2.H[2]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S,  v9.4H,  v2.H[1]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S,  v9.8H,  v2.H[1]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v10.4H,  v2.H[0]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v10.8H,  v2.H[0]
    str  q5, [sp,  #1*16]
    smlal  v20.4S, v11.4H,  v2.H[3]
    smlal2 v21.4S, v11.8H,  v2.H[3]

    // 3
    smull  v22.4S,  v8.4H,  v2.H[3]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S,  v8.8H,  v2.H[3]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S,  v9.4H,  v2.H[2]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S,  v9.8H,  v2.H[2]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v10.4H,  v2.H[1]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v10.8H,  v2.H[1]
    str  q6, [sp,  #2*16]
    smlal  v22.4S, v11.4H,  v2.H[0]
    smlal2 v23.4S, v11.8H,  v2.H[0]

    // 4
    smull  v16.4S, v12.4H,  v2.H[4]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v12.8H,  v2.H[4]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlsl  v16.4S, v13.4H,  v2.H[7]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlsl2 v17.4S, v13.8H,  v2.H[7]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlsl  v16.4S, v14.4H,  v2.H[6]
    uzp2    v7.8H, v22.8H, v23.8H
    smlsl2 v17.4S, v14.8H,  v2.H[6]
    str  q7, [sp,  #3*16]

// ================

    smlsl  v16.4S, v15.4H,  v2.H[5]
    smlsl2 v17.4S, v15.8H,  v2.H[5]

    // 5
    smull  v18.4S, v12.4H,  v2.H[5]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v12.8H,  v2.H[5]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v13.4H,  v2.H[4]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v13.8H,  v2.H[4]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlsl  v18.4S, v14.4H,  v2.H[7]
    uzp2    v4.8H, v16.8H, v17.8H
    smlsl2 v19.4S, v14.8H,  v2.H[7]
    str  q4, [sp,  #4*16]
    smlsl  v18.4S, v15.4H,  v2.H[6]
    smlsl2 v19.4S, v15.8H,  v2.H[6]

    // 6
    smull  v20.4S, v12.4H,  v2.H[6]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v12.8H,  v2.H[6]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v13.4H,  v2.H[5]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v13.8H,  v2.H[5]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v14.4H,  v2.H[4]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v14.8H,  v2.H[4]
    str  q5, [sp,  #5*16]
    smlsl  v20.4S, v15.4H,  v2.H[7]
    smlsl2 v21.4S, v15.8H,  v2.H[7]

    // 7
    smull  v22.4S, v12.4H,  v2.H[7]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v12.8H,  v2.H[7]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v13.4H,  v2.H[6]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v13.8H,  v2.H[6]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v14.4H,  v2.H[5]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v14.8H,  v2.H[5]
    str  q6, [sp,  #6*16]
    smlal  v22.4S, v15.4H,  v2.H[4]
    smlal2 v23.4S, v15.8H,  v2.H[4]

    // 0
    smull  v16.4S, v24.4H,  v3.H[0]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v24.8H,  v3.H[0]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlsl  v16.4S, v25.4H,  v3.H[7]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlsl2 v17.4S, v25.8H,  v3.H[7]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlsl  v16.4S, v26.4H,  v3.H[6]
    uzp2    v7.8H, v22.8H, v23.8H
    smlsl2 v17.4S, v26.8H,  v3.H[6]
    str  q7, [sp,  #7*16]

// ================

    smlsl  v16.4S, v27.4H,  v3.H[5]
    smlsl2 v17.4S, v27.8H,  v3.H[5]
    smlsl  v16.4S, v28.4H,  v3.H[4]
    smlsl2 v17.4S, v28.8H,  v3.H[4]
    smlsl  v16.4S, v29.4H,  v3.H[3]
    smlsl2 v17.4S, v29.8H,  v3.H[3]
    smlsl  v16.4S, v30.4H,  v3.H[2]
    smlsl2 v17.4S, v30.8H,  v3.H[2]
    smlsl  v16.4S, v31.4H,  v3.H[1]
    smlsl2 v17.4S, v31.8H,  v3.H[1]

    // 1
    smull  v18.4S, v24.4H,  v3.H[1]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v24.8H,  v3.H[1]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v25.4H,  v3.H[0]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v25.8H,  v3.H[0]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlsl  v18.4S, v26.4H,  v3.H[7]
    uzp2    v4.8H, v16.8H, v17.8H
    smlsl2 v19.4S, v26.8H,  v3.H[7]
    str  q4, [sp,  #(8+0)*16]

    smlsl  v18.4S, v27.4H,  v3.H[6]
    smlsl2 v19.4S, v27.8H,  v3.H[6]
    smlsl  v18.4S, v28.4H,  v3.H[5]
    smlsl2 v19.4S, v28.8H,  v3.H[5]
    smlsl  v18.4S, v29.4H,  v3.H[4]
    smlsl2 v19.4S, v29.8H,  v3.H[4]
    smlsl  v18.4S, v30.4H,  v3.H[3]
    smlsl2 v19.4S, v30.8H,  v3.H[3]
    smlsl  v18.4S, v31.4H,  v3.H[2]
    smlsl2 v19.4S, v31.8H,  v3.H[2]

    // 2
    smull  v20.4S, v24.4H,  v3.H[2]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v24.8H,  v3.H[2]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v25.4H,  v3.H[1]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v25.8H,  v3.H[1]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v26.4H,  v3.H[0]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v26.8H,  v3.H[0]
    str  q5, [sp,  #(8+1)*16]

    smlsl  v20.4S, v27.4H,  v3.H[7]
    smlsl2 v21.4S, v27.8H,  v3.H[7]
    smlsl  v20.4S, v28.4H,  v3.H[6]
    smlsl2 v21.4S, v28.8H,  v3.H[6]
    smlsl  v20.4S, v29.4H,  v3.H[5]
    smlsl2 v21.4S, v29.8H,  v3.H[5]
    smlsl  v20.4S, v30.4H,  v3.H[4]
    smlsl2 v21.4S, v30.8H,  v3.H[4]
    smlsl  v20.4S, v31.4H,  v3.H[3]
    smlsl2 v21.4S, v31.8H,  v3.H[3]

    // 3
    smull  v22.4S, v24.4H,  v3.H[3]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v24.8H,  v3.H[3]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v25.4H,  v3.H[2]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v25.8H,  v3.H[2]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v26.4H,  v3.H[1]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v26.8H,  v3.H[1]
    str  q6, [sp,  #(8+2)*16]

    smlal  v22.4S, v27.4H,  v3.H[0]
    smlal2 v23.4S, v27.8H,  v3.H[0]
    smlsl  v22.4S, v28.4H,  v3.H[7]
    smlsl2 v23.4S, v28.8H,  v3.H[7]
    smlsl  v22.4S, v29.4H,  v3.H[6]
    smlsl2 v23.4S, v29.8H,  v3.H[6]
    smlsl  v22.4S, v30.4H,  v3.H[5]
    smlsl2 v23.4S, v30.8H,  v3.H[5]
    smlsl  v22.4S, v31.4H,  v3.H[4]
    smlsl2 v23.4S, v31.8H,  v3.H[4]

    // 4
    smull  v16.4S, v24.4H,  v3.H[4]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v24.8H,  v3.H[4]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlal  v16.4S, v25.4H,  v3.H[3]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlal2 v17.4S, v25.8H,  v3.H[3]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlal  v16.4S, v26.4H,  v3.H[2]
    uzp2    v7.8H, v22.8H, v23.8H
    smlal2 v17.4S, v26.8H,  v3.H[2]
    str  q7, [sp,  #(8+3)*16]

    smlal  v16.4S, v27.4H,  v3.H[1]
    smlal2 v17.4S, v27.8H,  v3.H[1]
    smlal  v16.4S, v28.4H,  v3.H[0]
    smlal2 v17.4S, v28.8H,  v3.H[0]
    smlsl  v16.4S, v29.4H,  v3.H[7]
    smlsl2 v17.4S, v29.8H,  v3.H[7]
    smlsl  v16.4S, v30.4H,  v3.H[6]
    smlsl2 v17.4S, v30.8H,  v3.H[6]
    smlsl  v16.4S, v31.4H,  v3.H[5]
    smlsl2 v17.4S, v31.8H,  v3.H[5]

    // 5
    smull  v18.4S, v24.4H,  v3.H[5]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v24.8H,  v3.H[5]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v25.4H,  v3.H[4]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v25.8H,  v3.H[4]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlal  v18.4S, v26.4H,  v3.H[3]
    uzp2    v4.8H, v16.8H, v17.8H
    smlal2 v19.4S, v26.8H,  v3.H[3]
    str  q4, [sp,  #(8+4)*16]

    smlal  v18.4S, v27.4H,  v3.H[2]
    smlal2 v19.4S, v27.8H,  v3.H[2]
    smlal  v18.4S, v28.4H,  v3.H[1]
    smlal2 v19.4S, v28.8H,  v3.H[1]
    smlal  v18.4S, v29.4H,  v3.H[0]
    smlal2 v19.4S, v29.8H,  v3.H[0]
    smlsl  v18.4S, v30.4H,  v3.H[7]
    smlsl2 v19.4S, v30.8H,  v3.H[7]
    smlsl  v18.4S, v31.4H,  v3.H[6]
    smlsl2 v19.4S, v31.8H,  v3.H[6]

    // 6
    smull  v20.4S, v24.4H,  v3.H[6]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v24.8H,  v3.H[6]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v25.4H,  v3.H[5]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v25.8H,  v3.H[5]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v26.4H,  v3.H[4]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v26.8H,  v3.H[4]
    str  q5, [sp,  #(8+5)*16]

    smlal  v20.4S, v27.4H,  v3.H[3]
    smlal2 v21.4S, v27.8H,  v3.H[3]
    smlal  v20.4S, v28.4H,  v3.H[2]
    smlal2 v21.4S, v28.8H,  v3.H[2]
    smlal  v20.4S, v29.4H,  v3.H[1]
    smlal2 v21.4S, v29.8H,  v3.H[1]
    smlal  v20.4S, v30.4H,  v3.H[0]
    smlal2 v21.4S, v30.8H,  v3.H[0]
    smlsl  v20.4S, v31.4H,  v3.H[7]
    smlsl2 v21.4S, v31.8H,  v3.H[7]

    // 7
    smull  v22.4S, v24.4H,  v3.H[7]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v24.8H,  v3.H[7]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v25.4H,  v3.H[6]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v25.8H,  v3.H[6]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v26.4H,  v3.H[5]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v26.8H,  v3.H[5]
    str  q6, [sp,  #(8+6)*16]

    smlal  v22.4S, v27.4H,  v3.H[4]
    smlal2 v23.4S, v27.8H,  v3.H[4]
    smlal  v22.4S, v28.4H,  v3.H[3]
    smlal2 v23.4S, v28.8H,  v3.H[3]
    smlal  v22.4S, v29.4H,  v3.H[2]
    smlal2 v23.4S, v29.8H,  v3.H[2]
    smlal  v22.4S, v30.4H,  v3.H[1]
    smlal2 v23.4S, v30.8H,  v3.H[1]
    smlal  v22.4S, v31.4H,  v3.H[0]
    smlal2 v23.4S, v31.8H,  v3.H[0]

    uzp1    v7.8H, v22.8H, v23.8H
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    uzp2    v7.8H, v22.8H, v23.8H
    str  q7, [sp,  #(8+7)*16]

// ================



    ldr q24, [sp,  #0*16]
    ldr q28, [sp,  #4*16]
    ldr q16, [sp,  #8*16]
    ldr q20, [sp, #12*16]

    add    v8.8H, v24.8H, v28.8H
    sub   v12.8H, v24.8H, v28.8H
    add   v16.8H, v16.8H, v16.8H
    add   v20.8H, v20.8H, v20.8H

    add   v24.8H,  v8.8H, v16.8H
    sub   v16.8H,  v8.8H, v16.8H
    add   v28.8H, v12.8H, v20.8H
    sub   v20.8H, v12.8H, v20.8H

    str q24, [x0,  #des0]
    str q28, [x0,  #des4]
    str q16, [x0,  #des8]
    str q20, [x0, #des12]

    ldr q25, [sp,  #1*16]
    ldr q29, [sp,  #5*16]
    ldr q17, [sp,  #9*16]
    ldr q21, [sp, #13*16]

    add    v9.8H, v25.8H, v29.8H
    sub   v13.8H, v25.8H, v29.8H
    add   v17.8H, v17.8H, v17.8H
    add   v21.8H, v21.8H, v21.8H

    add   v25.8H,  v9.8H, v17.8H
    sub   v17.8H,  v9.8H, v17.8H
    add   v29.8H, v13.8H, v21.8H
    sub   v21.8H, v13.8H, v21.8H

    str q25, [x0,  #des1]
    str q29, [x0,  #des5]
    str q17, [x0,  #des9]
    str q21, [x0, #des13]

    ldr q26, [sp,  #2*16]
    ldr q30, [sp,  #6*16]
    ldr q18, [sp, #10*16]
    ldr q22, [sp, #14*16]

    add   v10.8H, v26.8H, v30.8H
    sub   v14.8H, v26.8H, v30.8H
    add   v18.8H, v18.8H, v18.8H
    add   v22.8H, v22.8H, v22.8H

    add   v26.8H, v10.8H, v18.8H
    sub   v18.8H, v10.8H, v18.8H
    add   v30.8H, v14.8H, v22.8H
    sub   v22.8H, v14.8H, v22.8H

    str q26, [x0,  #des2]
    str q30, [x0,  #des6]
    str q18, [x0, #des10]
    str q22, [x0, #des14]

    ldr q27, [sp,  #3*16]
    ldr q31, [sp,  #7*16]
    ldr q19, [sp, #11*16]
    ldr q23, [sp, #15*16]

    add   v11.8H, v27.8H, v31.8H
    sub   v15.8H, v27.8H, v31.8H
    add   v19.8H, v19.8H, v19.8H
    add   v23.8H, v23.8H, v23.8H

    add   v27.8H, v11.8H, v19.8H
    sub   v19.8H, v11.8H, v19.8H
    add   v31.8H, v15.8H, v23.8H
    sub   v23.8H, v15.8H, v23.8H

    str q27, [x0,  #des3]
    str q31, [x0,  #des7]
    str q19, [x0, #des11]
    str q23, [x0, #des15]

    add x0, x0, #16
    add x4, x4, #32

// ================

.endr


    add sp, sp, #(16*16)
    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.align 6
.global __asm_rader17_primitive_twist
.global ___asm_rader17_primitive_twist
__asm_rader17_primitive_twist:
___asm_rader17_primitive_twist:

    counter     .req  x8

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]
    sub sp, sp, #(16*16)

    .equ  src00,  0*192
    .equ  src01,  5*192
    .equ  src02,  1*192
    .equ  src03, 11*192
    .equ  src04,  3*192
    .equ  src05,  6*192
    .equ  src06,  7*192
    .equ  src07, 13*192
    .equ  src08, 15*192
    .equ  src09, 10*192
    .equ src010, 14*192
    .equ src011,  4*192
    .equ src012, 12*192
    .equ src013,  9*192
    .equ src014,  8*192
    .equ src015,  2*192

    .equ   des0,  0*192
    .equ   des1,  2*192
    .equ   des2,  8*192
    .equ   des3,  9*192
    .equ   des4, 12*192
    .equ   des5,  4*192
    .equ   des6, 14*192
    .equ   des7, 10*192
    .equ   des8, 15*192
    .equ   des9, 13*192
    .equ  des10,  7*192
    .equ  des11,  6*192
    .equ  des12,  3*192
    .equ  des13, 11*192
    .equ  des14,  1*192
    .equ  des15,  5*192

.rept 12

// ================

    ldr  q0, [x1,  #src00]
    ldr  q4, [x1,  #src04]
    ldr  q8, [x1,  #src08]
    ldr q12, [x1, #src012]

    add   v16.8H,  v0.8H,  v8.8H
    sub   v24.8H,  v0.8H,  v8.8H
    add   v20.8H,  v4.8H, v12.8H
    sub   v28.8H,  v4.8H, v12.8H
    add    v8.8H, v16.8H, v20.8H
    sub   v12.8H, v16.8H, v20.8H

    ldr  q1, [x1,  #src01]
    ldr  q5, [x1,  #src05]
    ldr  q9, [x1,  #src09]
    ldr q13, [x1, #src013]

    add   v17.8H,  v1.8H,  v9.8H
    sub   v25.8H,  v1.8H,  v9.8H
    add   v21.8H,  v5.8H, v13.8H
    sub   v29.8H,  v5.8H, v13.8H
    add    v9.8H, v17.8H, v21.8H
    sub   v13.8H, v17.8H, v21.8H

    ldr  q2, [x1,  #src02]
    ldr  q6, [x1,  #src06]
    ldr q10, [x1, #src010]
    ldr q14, [x1, #src014]

    add   v18.8H,  v2.8H, v10.8H
    sub   v26.8H,  v2.8H, v10.8H
    add   v22.8H,  v6.8H, v14.8H
    sub   v30.8H,  v6.8H, v14.8H
    add   v10.8H, v18.8H, v22.8H
    sub   v14.8H, v18.8H, v22.8H

    ldr  q3, [x1,  #src03]
    ldr  q7, [x1,  #src07]
    ldr q11, [x1, #src011]
    ldr q15, [x1, #src015]

    add   v19.8H,  v3.8H, v11.8H
    sub   v27.8H,  v3.8H, v11.8H
    add   v23.8H,  v7.8H, v15.8H
    sub   v31.8H,  v7.8H, v15.8H
    add   v11.8H, v19.8H, v23.8H
    sub   v15.8H, v19.8H, v23.8H

    add x1, x1, #16

    ldr d0, [x3]

    ldr q2, [x2,  #0*16]
    ldr q3, [x2,  #1*16]

// ================

    ldr  d0, [x3]

    // 0
    smull  v16.4S,  v8.4H,  v2.H[0]
    smull2 v17.4S,  v8.8H,  v2.H[0]
    smlal  v16.4S,  v9.4H,  v2.H[3]
    smlal2 v17.4S,  v9.8H,  v2.H[3]
    smlal  v16.4S, v10.4H,  v2.H[2]
    smlal2 v17.4S, v10.8H,  v2.H[2]
    smlal  v16.4S, v11.4H,  v2.H[1]
    smlal2 v17.4S, v11.8H,  v2.H[1]

    // 1
    smull  v18.4S,  v8.4H,  v2.H[1]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S,  v8.8H,  v2.H[1]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S,  v9.4H,  v2.H[0]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S,  v9.8H,  v2.H[0]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlal  v18.4S, v10.4H,  v2.H[3]
    uzp2    v4.8H, v16.8H, v17.8H
    smlal2 v19.4S, v10.8H,  v2.H[3]
    str  q4, [sp,  #0*16]
    smlal  v18.4S, v11.4H,  v2.H[2]
    smlal2 v19.4S, v11.8H,  v2.H[2]

    // 2
    smull  v20.4S,  v8.4H,  v2.H[2]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S,  v8.8H,  v2.H[2]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S,  v9.4H,  v2.H[1]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S,  v9.8H,  v2.H[1]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v10.4H,  v2.H[0]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v10.8H,  v2.H[0]
    str  q5, [sp,  #1*16]
    smlal  v20.4S, v11.4H,  v2.H[3]
    smlal2 v21.4S, v11.8H,  v2.H[3]

    // 3
    smull  v22.4S,  v8.4H,  v2.H[3]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S,  v8.8H,  v2.H[3]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S,  v9.4H,  v2.H[2]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S,  v9.8H,  v2.H[2]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v10.4H,  v2.H[1]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v10.8H,  v2.H[1]
    str  q6, [sp,  #2*16]
    smlal  v22.4S, v11.4H,  v2.H[0]
    smlal2 v23.4S, v11.8H,  v2.H[0]

    // 4
    smull  v16.4S, v12.4H,  v2.H[4]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v12.8H,  v2.H[4]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlsl  v16.4S, v13.4H,  v2.H[7]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlsl2 v17.4S, v13.8H,  v2.H[7]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlsl  v16.4S, v14.4H,  v2.H[6]
    uzp2    v7.8H, v22.8H, v23.8H
    smlsl2 v17.4S, v14.8H,  v2.H[6]
    str  q7, [sp,  #3*16]

// ================

    smlsl  v16.4S, v15.4H,  v2.H[5]
    smlsl2 v17.4S, v15.8H,  v2.H[5]

    // 5
    smull  v18.4S, v12.4H,  v2.H[5]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v12.8H,  v2.H[5]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v13.4H,  v2.H[4]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v13.8H,  v2.H[4]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlsl  v18.4S, v14.4H,  v2.H[7]
    uzp2    v4.8H, v16.8H, v17.8H
    smlsl2 v19.4S, v14.8H,  v2.H[7]
    str  q4, [sp,  #4*16]
    smlsl  v18.4S, v15.4H,  v2.H[6]
    smlsl2 v19.4S, v15.8H,  v2.H[6]

    // 6
    smull  v20.4S, v12.4H,  v2.H[6]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v12.8H,  v2.H[6]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v13.4H,  v2.H[5]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v13.8H,  v2.H[5]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v14.4H,  v2.H[4]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v14.8H,  v2.H[4]
    str  q5, [sp,  #5*16]
    smlsl  v20.4S, v15.4H,  v2.H[7]
    smlsl2 v21.4S, v15.8H,  v2.H[7]

    // 7
    smull  v22.4S, v12.4H,  v2.H[7]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v12.8H,  v2.H[7]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v13.4H,  v2.H[6]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v13.8H,  v2.H[6]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v14.4H,  v2.H[5]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v14.8H,  v2.H[5]
    str  q6, [sp,  #6*16]
    smlal  v22.4S, v15.4H,  v2.H[4]
    smlal2 v23.4S, v15.8H,  v2.H[4]

    // 0
    smull  v16.4S, v24.4H,  v3.H[0]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v24.8H,  v3.H[0]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlsl  v16.4S, v25.4H,  v3.H[7]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlsl2 v17.4S, v25.8H,  v3.H[7]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlsl  v16.4S, v26.4H,  v3.H[6]
    uzp2    v7.8H, v22.8H, v23.8H
    smlsl2 v17.4S, v26.8H,  v3.H[6]
    str  q7, [sp,  #7*16]

// ================

    smlsl  v16.4S, v27.4H,  v3.H[5]
    smlsl2 v17.4S, v27.8H,  v3.H[5]
    smlsl  v16.4S, v28.4H,  v3.H[4]
    smlsl2 v17.4S, v28.8H,  v3.H[4]
    smlsl  v16.4S, v29.4H,  v3.H[3]
    smlsl2 v17.4S, v29.8H,  v3.H[3]
    smlsl  v16.4S, v30.4H,  v3.H[2]
    smlsl2 v17.4S, v30.8H,  v3.H[2]
    smlsl  v16.4S, v31.4H,  v3.H[1]
    smlsl2 v17.4S, v31.8H,  v3.H[1]

    // 1
    smull  v18.4S, v24.4H,  v3.H[1]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v24.8H,  v3.H[1]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v25.4H,  v3.H[0]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v25.8H,  v3.H[0]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlsl  v18.4S, v26.4H,  v3.H[7]
    uzp2    v4.8H, v16.8H, v17.8H
    smlsl2 v19.4S, v26.8H,  v3.H[7]
    str  q4, [sp,  #(8+0)*16]

    smlsl  v18.4S, v27.4H,  v3.H[6]
    smlsl2 v19.4S, v27.8H,  v3.H[6]
    smlsl  v18.4S, v28.4H,  v3.H[5]
    smlsl2 v19.4S, v28.8H,  v3.H[5]
    smlsl  v18.4S, v29.4H,  v3.H[4]
    smlsl2 v19.4S, v29.8H,  v3.H[4]
    smlsl  v18.4S, v30.4H,  v3.H[3]
    smlsl2 v19.4S, v30.8H,  v3.H[3]
    smlsl  v18.4S, v31.4H,  v3.H[2]
    smlsl2 v19.4S, v31.8H,  v3.H[2]

    // 2
    smull  v20.4S, v24.4H,  v3.H[2]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v24.8H,  v3.H[2]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v25.4H,  v3.H[1]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v25.8H,  v3.H[1]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v26.4H,  v3.H[0]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v26.8H,  v3.H[0]
    str  q5, [sp,  #(8+1)*16]

    smlsl  v20.4S, v27.4H,  v3.H[7]
    smlsl2 v21.4S, v27.8H,  v3.H[7]
    smlsl  v20.4S, v28.4H,  v3.H[6]
    smlsl2 v21.4S, v28.8H,  v3.H[6]
    smlsl  v20.4S, v29.4H,  v3.H[5]
    smlsl2 v21.4S, v29.8H,  v3.H[5]
    smlsl  v20.4S, v30.4H,  v3.H[4]
    smlsl2 v21.4S, v30.8H,  v3.H[4]
    smlsl  v20.4S, v31.4H,  v3.H[3]
    smlsl2 v21.4S, v31.8H,  v3.H[3]

    // 3
    smull  v22.4S, v24.4H,  v3.H[3]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v24.8H,  v3.H[3]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v25.4H,  v3.H[2]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v25.8H,  v3.H[2]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v26.4H,  v3.H[1]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v26.8H,  v3.H[1]
    str  q6, [sp,  #(8+2)*16]

    smlal  v22.4S, v27.4H,  v3.H[0]
    smlal2 v23.4S, v27.8H,  v3.H[0]
    smlsl  v22.4S, v28.4H,  v3.H[7]
    smlsl2 v23.4S, v28.8H,  v3.H[7]
    smlsl  v22.4S, v29.4H,  v3.H[6]
    smlsl2 v23.4S, v29.8H,  v3.H[6]
    smlsl  v22.4S, v30.4H,  v3.H[5]
    smlsl2 v23.4S, v30.8H,  v3.H[5]
    smlsl  v22.4S, v31.4H,  v3.H[4]
    smlsl2 v23.4S, v31.8H,  v3.H[4]

    // 4
    smull  v16.4S, v24.4H,  v3.H[4]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v24.8H,  v3.H[4]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlal  v16.4S, v25.4H,  v3.H[3]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlal2 v17.4S, v25.8H,  v3.H[3]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlal  v16.4S, v26.4H,  v3.H[2]
    uzp2    v7.8H, v22.8H, v23.8H
    smlal2 v17.4S, v26.8H,  v3.H[2]
    str  q7, [sp,  #(8+3)*16]

    smlal  v16.4S, v27.4H,  v3.H[1]
    smlal2 v17.4S, v27.8H,  v3.H[1]
    smlal  v16.4S, v28.4H,  v3.H[0]
    smlal2 v17.4S, v28.8H,  v3.H[0]
    smlsl  v16.4S, v29.4H,  v3.H[7]
    smlsl2 v17.4S, v29.8H,  v3.H[7]
    smlsl  v16.4S, v30.4H,  v3.H[6]
    smlsl2 v17.4S, v30.8H,  v3.H[6]
    smlsl  v16.4S, v31.4H,  v3.H[5]
    smlsl2 v17.4S, v31.8H,  v3.H[5]

    // 5
    smull  v18.4S, v24.4H,  v3.H[5]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v24.8H,  v3.H[5]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v25.4H,  v3.H[4]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v25.8H,  v3.H[4]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlal  v18.4S, v26.4H,  v3.H[3]
    uzp2    v4.8H, v16.8H, v17.8H
    smlal2 v19.4S, v26.8H,  v3.H[3]
    str  q4, [sp,  #(8+4)*16]

    smlal  v18.4S, v27.4H,  v3.H[2]
    smlal2 v19.4S, v27.8H,  v3.H[2]
    smlal  v18.4S, v28.4H,  v3.H[1]
    smlal2 v19.4S, v28.8H,  v3.H[1]
    smlal  v18.4S, v29.4H,  v3.H[0]
    smlal2 v19.4S, v29.8H,  v3.H[0]
    smlsl  v18.4S, v30.4H,  v3.H[7]
    smlsl2 v19.4S, v30.8H,  v3.H[7]
    smlsl  v18.4S, v31.4H,  v3.H[6]
    smlsl2 v19.4S, v31.8H,  v3.H[6]

    // 6
    smull  v20.4S, v24.4H,  v3.H[6]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v24.8H,  v3.H[6]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v25.4H,  v3.H[5]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v25.8H,  v3.H[5]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v26.4H,  v3.H[4]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v26.8H,  v3.H[4]
    str  q5, [sp,  #(8+5)*16]

    smlal  v20.4S, v27.4H,  v3.H[3]
    smlal2 v21.4S, v27.8H,  v3.H[3]
    smlal  v20.4S, v28.4H,  v3.H[2]
    smlal2 v21.4S, v28.8H,  v3.H[2]
    smlal  v20.4S, v29.4H,  v3.H[1]
    smlal2 v21.4S, v29.8H,  v3.H[1]
    smlal  v20.4S, v30.4H,  v3.H[0]
    smlal2 v21.4S, v30.8H,  v3.H[0]
    smlsl  v20.4S, v31.4H,  v3.H[7]
    smlsl2 v21.4S, v31.8H,  v3.H[7]

    // 7
    smull  v22.4S, v24.4H,  v3.H[7]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v24.8H,  v3.H[7]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v25.4H,  v3.H[6]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v25.8H,  v3.H[6]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v26.4H,  v3.H[5]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v26.8H,  v3.H[5]
    str  q6, [sp,  #(8+6)*16]

    smlal  v22.4S, v27.4H,  v3.H[4]
    smlal2 v23.4S, v27.8H,  v3.H[4]
    smlal  v22.4S, v28.4H,  v3.H[3]
    smlal2 v23.4S, v28.8H,  v3.H[3]
    smlal  v22.4S, v29.4H,  v3.H[2]
    smlal2 v23.4S, v29.8H,  v3.H[2]
    smlal  v22.4S, v30.4H,  v3.H[1]
    smlal2 v23.4S, v30.8H,  v3.H[1]
    smlal  v22.4S, v31.4H,  v3.H[0]
    smlal2 v23.4S, v31.8H,  v3.H[0]

    uzp1    v7.8H, v22.8H, v23.8H
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    uzp2    v7.8H, v22.8H, v23.8H
    str  q7, [sp,  #(8+7)*16]

// ================

    ldr q18, [sp,  #0*16]
    ldr q19, [sp,  #4*16]
    ldr q20, [sp,  #8*16]
    ldr q21, [sp, #12*16]

    ldr  q8, [x4, #( 2*des0+1*16)]
    ldr  q9, [x4, #( 2*des4+1*16)]
    ldr q10, [x4, #( 2*des8+1*16)]
    ldr q11, [x4, #(2*des12+1*16)]

    ldr  q4, [x4, #( 2*des0+0*16)]
    ldr  q5, [x4, #( 2*des4+0*16)]
    ldr  q6, [x4, #( 2*des8+0*16)]
    ldr  q7, [x4, #(2*des12+0*16)]

    ldr q24, [sp,  #1*16]
    add   v16.8H, v18.8H, v19.8H
    sub   v17.8H, v18.8H, v19.8H
    ldr q25, [sp,  #5*16]
    add   v20.8H, v20.8H, v20.8H
    add   v21.8H, v21.8H, v21.8H

    ldr q26, [sp,  #9*16]
    add   v18.8H, v16.8H, v20.8H
    add   v19.8H, v17.8H, v21.8H
    ldr q27, [sp, #13*16]
    sub   v20.8H, v16.8H, v20.8H
    sub   v21.8H, v17.8H, v21.8H

    sqrdmulh v12.8H, v18.8H,  v8.8H
    add   v22.8H, v24.8H, v25.8H
    ldr  q8, [x4, #( 2*des1+1*16)]
    sqrdmulh v13.8H, v19.8H,  v9.8H
    sub   v23.8H, v24.8H, v25.8H
    ldr  q9, [x4, #( 2*des5+1*16)]
    sqrdmulh v14.8H, v20.8H, v10.8H
    add   v26.8H, v26.8H, v26.8H
    ldr q10, [x4, #( 2*des9+1*16)]
    sqrdmulh v15.8H, v21.8H, v11.8H
    add   v27.8H, v27.8H, v27.8H
    ldr q11, [x4, #(2*des13+1*16)]

    mul      v18.8H, v18.8H,  v4.8H
    add   v24.8H, v22.8H, v26.8H
    ldr  q4, [x4, #( 2*des1+0*16)]
    mul      v19.8H, v19.8H,  v5.8H
    add   v25.8H, v23.8H, v27.8H
    ldr  q5, [x4, #( 2*des5+0*16)]
    mul      v20.8H, v20.8H,  v6.8H
    sub   v26.8H, v22.8H, v26.8H
    ldr  q6, [x4, #( 2*des9+0*16)]
    mul      v21.8H, v21.8H,  v7.8H
    sub   v27.8H, v23.8H, v27.8H
    ldr  q7, [x4, #(2*des13+0*16)]

    mls      v18.8H, v12.8H,  v0.H[1]
    mls      v19.8H, v13.8H,  v0.H[1]
    mls      v20.8H, v14.8H,  v0.H[1]
    mls      v21.8H, v15.8H,  v0.H[1]

    str q18, [x0,  #des0]
    ldr q18, [sp,  #2*16]
    str q19, [x0,  #des4]
    ldr q19, [sp,  #6*16]
    str q20, [x0,  #des8]
    ldr q20, [sp, #10*16]
    str q21, [x0, #des12]
    ldr q21, [sp, #14*16]

    sqrdmulh v28.8H, v24.8H,  v8.8H
    add   v16.8H, v18.8H, v19.8H
    ldr  q8, [x4, #( 2*des2+1*16)]
    sqrdmulh v29.8H, v25.8H,  v9.8H
    sub   v17.8H, v18.8H, v19.8H
    ldr  q9, [x4, #( 2*des6+1*16)]
    sqrdmulh v30.8H, v26.8H, v10.8H
    add   v20.8H, v20.8H, v20.8H
    ldr q10, [x4, #(2*des10+1*16)]
    sqrdmulh v31.8H, v27.8H, v11.8H
    add   v21.8H, v21.8H, v21.8H
    ldr q11, [x4, #(2*des14+1*16)]

    mul      v24.8H, v24.8H,  v4.8H
    add   v18.8H, v16.8H, v20.8H
    ldr  q4, [x4, #( 2*des2+0*16)]
    mul      v25.8H, v25.8H,  v5.8H
    add   v19.8H, v17.8H, v21.8H
    ldr  q5, [x4, #( 2*des6+0*16)]
    mul      v26.8H, v26.8H,  v6.8H
    sub   v20.8H, v16.8H, v20.8H
    ldr  q6, [x4, #(2*des10+0*16)]
    mul      v27.8H, v27.8H,  v7.8H
    sub   v21.8H, v17.8H, v21.8H
    ldr  q7, [x4, #(2*des14+0*16)]

    mls      v24.8H, v28.8H,  v0.H[1]
    mls      v25.8H, v29.8H,  v0.H[1]
    mls      v26.8H, v30.8H,  v0.H[1]
    mls      v27.8H, v31.8H,  v0.H[1]

    str q24, [x0,  #des1]
    ldr q24, [sp,  #3*16]
    str q25, [x0,  #des5]
    ldr q25, [sp,  #7*16]
    str q26, [x0,  #des9]
    ldr q26, [sp, #11*16]
    str q27, [x0, #des13]
    ldr q27, [sp, #15*16]

    sqrdmulh v12.8H, v18.8H,  v8.8H
    add   v22.8H, v24.8H, v25.8H
    ldr  q8, [x4, #( 2*des3+1*16)]
    sqrdmulh v13.8H, v19.8H,  v9.8H
    sub   v23.8H, v24.8H, v25.8H
    ldr  q9, [x4, #( 2*des7+1*16)]
    sqrdmulh v14.8H, v20.8H, v10.8H
    add   v26.8H, v26.8H, v26.8H
    ldr q10, [x4, #(2*des11+1*16)]
    sqrdmulh v15.8H, v21.8H, v11.8H
    add   v27.8H, v27.8H, v27.8H
    ldr q11, [x4, #(2*des15+1*16)]

    mul      v18.8H, v18.8H,  v4.8H
    add   v24.8H, v22.8H, v26.8H
    ldr  q4, [x4, #( 2*des3+0*16)]
    mul      v19.8H, v19.8H,  v5.8H
    add   v25.8H, v23.8H, v27.8H
    ldr  q5, [x4, #( 2*des7+0*16)]
    mul      v20.8H, v20.8H,  v6.8H
    sub   v26.8H, v22.8H, v26.8H
    ldr  q6, [x4, #(2*des11+0*16)]
    mul      v21.8H, v21.8H,  v7.8H
    sub   v27.8H, v23.8H, v27.8H
    ldr  q7, [x4, #(2*des15+0*16)]

    mls      v18.8H, v12.8H,  v0.H[1]
    mls      v19.8H, v13.8H,  v0.H[1]
    mls      v20.8H, v14.8H,  v0.H[1]
    mls      v21.8H, v15.8H,  v0.H[1]

    str q18, [x0,  #des2]
    str q19, [x0,  #des6]
    str q20, [x0, #des10]
    str q21, [x0, #des14]

    sqrdmulh v28.8H, v24.8H,  v8.8H
    sqrdmulh v29.8H, v25.8H,  v9.8H
    sqrdmulh v30.8H, v26.8H, v10.8H
    sqrdmulh v31.8H, v27.8H, v11.8H

    mul      v24.8H, v24.8H,  v4.8H
    mul      v25.8H, v25.8H,  v5.8H
    mul      v26.8H, v26.8H,  v6.8H
    mul      v27.8H, v27.8H,  v7.8H

    mls      v24.8H, v28.8H,  v0.H[1]
    mls      v25.8H, v29.8H,  v0.H[1]
    mls      v26.8H, v30.8H,  v0.H[1]
    mls      v27.8H, v31.8H,  v0.H[1]

    str q24, [x0,  #des3]
    str q25, [x0,  #des7]
    str q26, [x0, #des11]
    str q27, [x0, #des15]

    add x0, x0, #16
    add x4, x4, #32

// ================

.endr


    add sp, sp, #(16*16)
    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr

.if 0

i mapsto rader_dlog_permute[i] =
{
0, 14, 1, 12,
5, 15, 11, 10,
2, 3, 7, 13,
4, 9, 6, 8
}

rader_dlog_permute[i] mapsto i =
{
0, 2, 8, 9,
12, 4, 14, 10,
15, 13, 7, 6,
3, 11, 1, 5
}

i mapsto 15 - rader_dlog_permute[i] =
{
15, 1, 14, 3,
10, 0, 4, 5,
13, 12, 8, 2,
11, 6, 9, 7
}

15 - rader_dlog_permute[i] mapsto i =
{
5, 1, 11, 3,
6, 7, 13, 15,
10, 14, 4, 12,
9, 8, 2, 0
}

.endif

.align 6
.global __asm_irader17_primitive
.global ___asm_irader17_primitive
__asm_irader17_primitive:
___asm_irader17_primitive:

    counter     .req  x8

    sub sp, sp, #(16*4)
    stp  d8,  d9, [sp, #16*0]
    stp d10, d11, [sp, #16*1]
    stp d12, d13, [sp, #16*2]
    stp d14, d15, [sp, #16*3]
    sub sp, sp, #(16*16)

    .equ  src00,  0*192
    .equ  src01,  2*192
    .equ  src02,  8*192
    .equ  src03,  9*192
    .equ  src04, 12*192
    .equ  src05,  4*192
    .equ  src06, 14*192
    .equ  src07, 10*192
    .equ  src08, 15*192
    .equ  src09, 13*192
    .equ src010,  7*192
    .equ src011,  6*192
    .equ src012,  3*192
    .equ src013, 11*192
    .equ src014,  1*192
    .equ src015,  5*192

    .equ   des0,  5*192
    .equ   des1,  1*192
    .equ   des2, 11*192
    .equ   des3,  3*192
    .equ   des4,  6*192
    .equ   des5,  7*192
    .equ   des6, 13*192
    .equ   des7, 15*192
    .equ   des8, 10*192
    .equ   des9, 14*192
    .equ  des10,  4*192
    .equ  des11, 12*192
    .equ  des12,  9*192
    .equ  des13,  8*192
    .equ  des14,  2*192
    .equ  des15,  0*192

    ldr  q0, [x1,  #src00]
    ldr  q4, [x1,  #src04]
    ldr  q8, [x1,  #src08]
    ldr q12, [x1, #src012]

    add   v16.8H,  v0.8H,  v8.8H
    sub   v24.8H,  v0.8H,  v8.8H
    add   v20.8H,  v4.8H, v12.8H
    sub   v28.8H,  v4.8H, v12.8H
    add    v8.8H, v16.8H, v20.8H
    sub   v12.8H, v16.8H, v20.8H

    ldr  q1, [x1,  #src01]
    ldr  q5, [x1,  #src05]
    ldr  q9, [x1,  #src09]
    ldr q13, [x1, #src013]

    add   v17.8H,  v1.8H,  v9.8H
    sub   v25.8H,  v1.8H,  v9.8H
    add   v21.8H,  v5.8H, v13.8H
    sub   v29.8H,  v5.8H, v13.8H
    add    v9.8H, v17.8H, v21.8H
    sub   v13.8H, v17.8H, v21.8H

    ldr  q2, [x1,  #src02]
    ldr  q6, [x1,  #src06]
    ldr q10, [x1, #src010]
    ldr q14, [x1, #src014]

    add   v18.8H,  v2.8H, v10.8H
    sub   v26.8H,  v2.8H, v10.8H
    add   v22.8H,  v6.8H, v14.8H
    sub   v30.8H,  v6.8H, v14.8H
    add   v10.8H, v18.8H, v22.8H
    sub   v14.8H, v18.8H, v22.8H

    ldr  q3, [x1,  #src03]
    ldr  q7, [x1,  #src07]
    ldr q11, [x1, #src011]
    ldr q15, [x1, #src015]

    add   v19.8H,  v3.8H, v11.8H
    sub   v27.8H,  v3.8H, v11.8H
    add   v23.8H,  v7.8H, v15.8H
    sub   v31.8H,  v7.8H, v15.8H
    add   v11.8H, v19.8H, v23.8H
    sub   v15.8H, v19.8H, v23.8H

    add x1, x1, #16

    ldr d0, [x3]

    ldr q2, [x2,  #0*16]
    ldr q3, [x2,  #1*16]

// ================

    ldr  d0, [x3]

    // 0
    smull  v16.4S,  v8.4H,  v2.H[0]
    smull2 v17.4S,  v8.8H,  v2.H[0]
    smlal  v16.4S,  v9.4H,  v2.H[3]
    smlal2 v17.4S,  v9.8H,  v2.H[3]
    smlal  v16.4S, v10.4H,  v2.H[2]
    smlal2 v17.4S, v10.8H,  v2.H[2]
    smlal  v16.4S, v11.4H,  v2.H[1]
    smlal2 v17.4S, v11.8H,  v2.H[1]

    // 1
    smull  v18.4S,  v8.4H,  v2.H[1]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S,  v8.8H,  v2.H[1]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S,  v9.4H,  v2.H[0]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S,  v9.8H,  v2.H[0]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlal  v18.4S, v10.4H,  v2.H[3]
    uzp2    v4.8H, v16.8H, v17.8H
    smlal2 v19.4S, v10.8H,  v2.H[3]
    str  q4, [sp,  #0*16]
    smlal  v18.4S, v11.4H,  v2.H[2]
    smlal2 v19.4S, v11.8H,  v2.H[2]

    // 2
    smull  v20.4S,  v8.4H,  v2.H[2]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S,  v8.8H,  v2.H[2]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S,  v9.4H,  v2.H[1]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S,  v9.8H,  v2.H[1]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v10.4H,  v2.H[0]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v10.8H,  v2.H[0]
    str  q5, [sp,  #1*16]
    smlal  v20.4S, v11.4H,  v2.H[3]
    smlal2 v21.4S, v11.8H,  v2.H[3]

    // 3
    smull  v22.4S,  v8.4H,  v2.H[3]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S,  v8.8H,  v2.H[3]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S,  v9.4H,  v2.H[2]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S,  v9.8H,  v2.H[2]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v10.4H,  v2.H[1]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v10.8H,  v2.H[1]
    str  q6, [sp,  #2*16]
    smlal  v22.4S, v11.4H,  v2.H[0]
    smlal2 v23.4S, v11.8H,  v2.H[0]

    // 4
    smull  v16.4S, v12.4H,  v2.H[4]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v12.8H,  v2.H[4]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlsl  v16.4S, v13.4H,  v2.H[7]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlsl2 v17.4S, v13.8H,  v2.H[7]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlsl  v16.4S, v14.4H,  v2.H[6]
    uzp2    v7.8H, v22.8H, v23.8H
    smlsl2 v17.4S, v14.8H,  v2.H[6]
    str  q7, [sp,  #3*16]

// ================

    smlsl  v16.4S, v15.4H,  v2.H[5]
    smlsl2 v17.4S, v15.8H,  v2.H[5]

    // 5
    smull  v18.4S, v12.4H,  v2.H[5]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v12.8H,  v2.H[5]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v13.4H,  v2.H[4]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v13.8H,  v2.H[4]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlsl  v18.4S, v14.4H,  v2.H[7]
    uzp2    v4.8H, v16.8H, v17.8H
    smlsl2 v19.4S, v14.8H,  v2.H[7]
    str  q4, [sp,  #4*16]
    smlsl  v18.4S, v15.4H,  v2.H[6]
    smlsl2 v19.4S, v15.8H,  v2.H[6]

    // 6
    smull  v20.4S, v12.4H,  v2.H[6]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v12.8H,  v2.H[6]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v13.4H,  v2.H[5]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v13.8H,  v2.H[5]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v14.4H,  v2.H[4]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v14.8H,  v2.H[4]
    str  q5, [sp,  #5*16]
    smlsl  v20.4S, v15.4H,  v2.H[7]
    smlsl2 v21.4S, v15.8H,  v2.H[7]

    // 7
    smull  v22.4S, v12.4H,  v2.H[7]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v12.8H,  v2.H[7]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v13.4H,  v2.H[6]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v13.8H,  v2.H[6]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v14.4H,  v2.H[5]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v14.8H,  v2.H[5]
    str  q6, [sp,  #6*16]
    smlal  v22.4S, v15.4H,  v2.H[4]
    smlal2 v23.4S, v15.8H,  v2.H[4]

    // 0
    smull  v16.4S, v24.4H,  v3.H[0]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v24.8H,  v3.H[0]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlsl  v16.4S, v25.4H,  v3.H[7]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlsl2 v17.4S, v25.8H,  v3.H[7]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlsl  v16.4S, v26.4H,  v3.H[6]
    uzp2    v7.8H, v22.8H, v23.8H
    smlsl2 v17.4S, v26.8H,  v3.H[6]
    str  q7, [sp,  #7*16]

// ================

    smlsl  v16.4S, v27.4H,  v3.H[5]
    smlsl2 v17.4S, v27.8H,  v3.H[5]
    smlsl  v16.4S, v28.4H,  v3.H[4]
    smlsl2 v17.4S, v28.8H,  v3.H[4]
    smlsl  v16.4S, v29.4H,  v3.H[3]
    smlsl2 v17.4S, v29.8H,  v3.H[3]
    smlsl  v16.4S, v30.4H,  v3.H[2]
    smlsl2 v17.4S, v30.8H,  v3.H[2]
    smlsl  v16.4S, v31.4H,  v3.H[1]
    smlsl2 v17.4S, v31.8H,  v3.H[1]

    // 1
    smull  v18.4S, v24.4H,  v3.H[1]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v24.8H,  v3.H[1]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v25.4H,  v3.H[0]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v25.8H,  v3.H[0]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlsl  v18.4S, v26.4H,  v3.H[7]
    uzp2    v4.8H, v16.8H, v17.8H
    smlsl2 v19.4S, v26.8H,  v3.H[7]
    str  q4, [sp,  #(8+0)*16]

    smlsl  v18.4S, v27.4H,  v3.H[6]
    smlsl2 v19.4S, v27.8H,  v3.H[6]
    smlsl  v18.4S, v28.4H,  v3.H[5]
    smlsl2 v19.4S, v28.8H,  v3.H[5]
    smlsl  v18.4S, v29.4H,  v3.H[4]
    smlsl2 v19.4S, v29.8H,  v3.H[4]
    smlsl  v18.4S, v30.4H,  v3.H[3]
    smlsl2 v19.4S, v30.8H,  v3.H[3]
    smlsl  v18.4S, v31.4H,  v3.H[2]
    smlsl2 v19.4S, v31.8H,  v3.H[2]

    // 2
    smull  v20.4S, v24.4H,  v3.H[2]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v24.8H,  v3.H[2]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v25.4H,  v3.H[1]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v25.8H,  v3.H[1]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v26.4H,  v3.H[0]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v26.8H,  v3.H[0]
    str  q5, [sp,  #(8+1)*16]

    smlsl  v20.4S, v27.4H,  v3.H[7]
    smlsl2 v21.4S, v27.8H,  v3.H[7]
    smlsl  v20.4S, v28.4H,  v3.H[6]
    smlsl2 v21.4S, v28.8H,  v3.H[6]
    smlsl  v20.4S, v29.4H,  v3.H[5]
    smlsl2 v21.4S, v29.8H,  v3.H[5]
    smlsl  v20.4S, v30.4H,  v3.H[4]
    smlsl2 v21.4S, v30.8H,  v3.H[4]
    smlsl  v20.4S, v31.4H,  v3.H[3]
    smlsl2 v21.4S, v31.8H,  v3.H[3]

    // 3
    smull  v22.4S, v24.4H,  v3.H[3]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v24.8H,  v3.H[3]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v25.4H,  v3.H[2]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v25.8H,  v3.H[2]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v26.4H,  v3.H[1]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v26.8H,  v3.H[1]
    str  q6, [sp,  #(8+2)*16]

    smlal  v22.4S, v27.4H,  v3.H[0]
    smlal2 v23.4S, v27.8H,  v3.H[0]
    smlsl  v22.4S, v28.4H,  v3.H[7]
    smlsl2 v23.4S, v28.8H,  v3.H[7]
    smlsl  v22.4S, v29.4H,  v3.H[6]
    smlsl2 v23.4S, v29.8H,  v3.H[6]
    smlsl  v22.4S, v30.4H,  v3.H[5]
    smlsl2 v23.4S, v30.8H,  v3.H[5]
    smlsl  v22.4S, v31.4H,  v3.H[4]
    smlsl2 v23.4S, v31.8H,  v3.H[4]

    // 4
    smull  v16.4S, v24.4H,  v3.H[4]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v24.8H,  v3.H[4]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlal  v16.4S, v25.4H,  v3.H[3]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlal2 v17.4S, v25.8H,  v3.H[3]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlal  v16.4S, v26.4H,  v3.H[2]
    uzp2    v7.8H, v22.8H, v23.8H
    smlal2 v17.4S, v26.8H,  v3.H[2]
    str  q7, [sp,  #(8+3)*16]

    smlal  v16.4S, v27.4H,  v3.H[1]
    smlal2 v17.4S, v27.8H,  v3.H[1]
    smlal  v16.4S, v28.4H,  v3.H[0]
    smlal2 v17.4S, v28.8H,  v3.H[0]
    smlsl  v16.4S, v29.4H,  v3.H[7]
    smlsl2 v17.4S, v29.8H,  v3.H[7]
    smlsl  v16.4S, v30.4H,  v3.H[6]
    smlsl2 v17.4S, v30.8H,  v3.H[6]
    smlsl  v16.4S, v31.4H,  v3.H[5]
    smlsl2 v17.4S, v31.8H,  v3.H[5]

    // 5
    smull  v18.4S, v24.4H,  v3.H[5]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v24.8H,  v3.H[5]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v25.4H,  v3.H[4]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v25.8H,  v3.H[4]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlal  v18.4S, v26.4H,  v3.H[3]
    uzp2    v4.8H, v16.8H, v17.8H
    smlal2 v19.4S, v26.8H,  v3.H[3]
    str  q4, [sp,  #(8+4)*16]

    smlal  v18.4S, v27.4H,  v3.H[2]
    smlal2 v19.4S, v27.8H,  v3.H[2]
    smlal  v18.4S, v28.4H,  v3.H[1]
    smlal2 v19.4S, v28.8H,  v3.H[1]
    smlal  v18.4S, v29.4H,  v3.H[0]
    smlal2 v19.4S, v29.8H,  v3.H[0]
    smlsl  v18.4S, v30.4H,  v3.H[7]
    smlsl2 v19.4S, v30.8H,  v3.H[7]
    smlsl  v18.4S, v31.4H,  v3.H[6]
    smlsl2 v19.4S, v31.8H,  v3.H[6]

    // 6
    smull  v20.4S, v24.4H,  v3.H[6]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v24.8H,  v3.H[6]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v25.4H,  v3.H[5]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v25.8H,  v3.H[5]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v26.4H,  v3.H[4]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v26.8H,  v3.H[4]
    str  q5, [sp,  #(8+5)*16]

    smlal  v20.4S, v27.4H,  v3.H[3]
    smlal2 v21.4S, v27.8H,  v3.H[3]
    smlal  v20.4S, v28.4H,  v3.H[2]
    smlal2 v21.4S, v28.8H,  v3.H[2]
    smlal  v20.4S, v29.4H,  v3.H[1]
    smlal2 v21.4S, v29.8H,  v3.H[1]
    smlal  v20.4S, v30.4H,  v3.H[0]
    smlal2 v21.4S, v30.8H,  v3.H[0]
    smlsl  v20.4S, v31.4H,  v3.H[7]
    smlsl2 v21.4S, v31.8H,  v3.H[7]

    // 7
    smull  v22.4S, v24.4H,  v3.H[7]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v24.8H,  v3.H[7]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v25.4H,  v3.H[6]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v25.8H,  v3.H[6]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v26.4H,  v3.H[5]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v26.8H,  v3.H[5]
    str  q6, [sp,  #(8+6)*16]

    smlal  v22.4S, v27.4H,  v3.H[4]
    smlal2 v23.4S, v27.8H,  v3.H[4]
    smlal  v22.4S, v28.4H,  v3.H[3]
    smlal2 v23.4S, v28.8H,  v3.H[3]
    smlal  v22.4S, v29.4H,  v3.H[2]
    smlal2 v23.4S, v29.8H,  v3.H[2]
    smlal  v22.4S, v30.4H,  v3.H[1]
    smlal2 v23.4S, v30.8H,  v3.H[1]
    smlal  v22.4S, v31.4H,  v3.H[0]
    smlal2 v23.4S, v31.8H,  v3.H[0]

    uzp1    v7.8H, v22.8H, v23.8H
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    uzp2    v7.8H, v22.8H, v23.8H
    str  q7, [sp,  #(8+7)*16]

    mov counter, #11
    __asm_irader17_primitive_loop:

// ================================

    ldr q24, [sp,  #0*16]
    ldr q28, [sp,  #4*16]
    ldr q16, [sp,  #8*16]
    ldr q20, [sp, #12*16]

    ldr q25, [sp,  #1*16]
    add    v8.8H, v24.8H, v28.8H
    sub   v12.8H, v24.8H, v28.8H
    ldr q29, [sp,  #5*16]
    add   v16.8H, v16.8H, v16.8H
    add   v20.8H, v20.8H, v20.8H

    ldr q17, [sp,  #9*16]
    add   v24.8H,  v8.8H, v16.8H
    sub   v16.8H,  v8.8H, v16.8H
    ldr q21, [sp, #13*16]
    add   v28.8H, v12.8H, v20.8H
    sub   v20.8H, v12.8H, v20.8H

    ldr  q0, [x1,  #src00]
    add    v9.8H, v25.8H, v29.8H
    sub   v13.8H, v25.8H, v29.8H
    ldr  q4, [x1,  #src04]
    add   v17.8H, v17.8H, v17.8H
    add   v21.8H, v21.8H, v21.8H
    ldr  q8, [x1,  #src08]
    add   v25.8H,  v9.8H, v17.8H
    sub   v17.8H,  v9.8H, v17.8H
    ldr q12, [x1, #src012]
    add   v29.8H, v13.8H, v21.8H
    sub   v21.8H, v13.8H, v21.8H

    ldr  q1, [x1,  #src01]
    str q24, [x0,  #des0]
    sub   v24.8H,  v0.8H,  v8.8H
    ldr  q5, [x1,  #src05]
    str q28, [x0,  #des4]
    sub   v28.8H,  v4.8H, v12.8H
    ldr  q9, [x1,  #src09]
    str q16, [x0,  #des8]
    add   v16.8H,  v0.8H,  v8.8H
    ldr q13, [x1, #src013]
    str q20, [x0, #des12]
    add   v20.8H,  v4.8H, v12.8H

    add    v8.8H, v16.8H, v20.8H
    sub   v12.8H, v16.8H, v20.8H

// ================

    ldr q26, [sp,  #2*16]
    str q25, [x0,  #des1]
    sub   v25.8H,  v1.8H,  v9.8H
    ldr q30, [sp,  #6*16]
    str q29, [x0,  #des5]
    sub   v29.8H,  v5.8H, v13.8H
    ldr q18, [sp, #10*16]
    str q17, [x0,  #des9]
    add   v17.8H,  v1.8H,  v9.8H
    ldr q22, [sp, #14*16]
    str q21, [x0, #des13]
    add   v21.8H,  v5.8H, v13.8H

    add    v9.8H, v17.8H, v21.8H
    sub   v13.8H, v17.8H, v21.8H

// ================

    ldr q27, [sp,  #3*16]
    add   v10.8H, v26.8H, v30.8H
    sub   v14.8H, v26.8H, v30.8H
    ldr q31, [sp,  #7*16]
    add   v18.8H, v18.8H, v18.8H
    add   v22.8H, v22.8H, v22.8H

    ldr q19, [sp, #11*16]
    add   v26.8H, v10.8H, v18.8H
    sub   v18.8H, v10.8H, v18.8H
    ldr q23, [sp, #15*16]
    add   v30.8H, v14.8H, v22.8H
    sub   v22.8H, v14.8H, v22.8H

    ldr  q2, [x1,  #src02]
    add   v11.8H, v27.8H, v31.8H
    sub   v15.8H, v27.8H, v31.8H
    ldr  q6, [x1,  #src06]
    add   v19.8H, v19.8H, v19.8H
    add   v23.8H, v23.8H, v23.8H
    ldr q10, [x1, #src010]
    add   v27.8H, v11.8H, v19.8H
    sub   v19.8H, v11.8H, v19.8H
    ldr q14, [x1, #src014]
    add   v31.8H, v15.8H, v23.8H
    sub   v23.8H, v15.8H, v23.8H

    ldr  q3, [x1,  #src03]
    str q26, [x0,  #des2]
    sub   v26.8H,  v2.8H, v10.8H
    ldr  q7, [x1,  #src07]
    str q30, [x0,  #des6]
    sub   v30.8H,  v6.8H, v14.8H
    ldr q11, [x1, #src011]
    str q18, [x0, #des10]
    add   v18.8H,  v2.8H, v10.8H
    ldr q15, [x1, #src015]
    str q22, [x0, #des14]
    add   v22.8H,  v6.8H, v14.8H



// ================

    str q27, [x0,  #des3]
    add   v10.8H, v18.8H, v22.8H
    sub   v14.8H, v18.8H, v22.8H
    str q31, [x0,  #des7]
    sub   v27.8H,  v3.8H, v11.8H
    sub   v31.8H,  v7.8H, v15.8H
    str q19, [x0, #des11]
    str q23, [x0, #des15]
    add   v19.8H,  v3.8H, v11.8H
    add   v23.8H,  v7.8H, v15.8H

    add   v11.8H, v19.8H, v23.8H
    sub   v15.8H, v19.8H, v23.8H

// ================

    add x0, x0, #16
    add x1, x1, #16

    ldr q2, [x2,  #0*16]
    ldr q3, [x2,  #1*16]

// ================================

    ldr  d0, [x3]

    // 0
    smull  v16.4S,  v8.4H,  v2.H[0]
    smull2 v17.4S,  v8.8H,  v2.H[0]
    smlal  v16.4S,  v9.4H,  v2.H[3]
    smlal2 v17.4S,  v9.8H,  v2.H[3]
    smlal  v16.4S, v10.4H,  v2.H[2]
    smlal2 v17.4S, v10.8H,  v2.H[2]
    smlal  v16.4S, v11.4H,  v2.H[1]
    smlal2 v17.4S, v11.8H,  v2.H[1]

    // 1
    smull  v18.4S,  v8.4H,  v2.H[1]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S,  v8.8H,  v2.H[1]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S,  v9.4H,  v2.H[0]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S,  v9.8H,  v2.H[0]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlal  v18.4S, v10.4H,  v2.H[3]
    uzp2    v4.8H, v16.8H, v17.8H
    smlal2 v19.4S, v10.8H,  v2.H[3]
    str  q4, [sp,  #0*16]
    smlal  v18.4S, v11.4H,  v2.H[2]
    smlal2 v19.4S, v11.8H,  v2.H[2]

    // 2
    smull  v20.4S,  v8.4H,  v2.H[2]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S,  v8.8H,  v2.H[2]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S,  v9.4H,  v2.H[1]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S,  v9.8H,  v2.H[1]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v10.4H,  v2.H[0]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v10.8H,  v2.H[0]
    str  q5, [sp,  #1*16]
    smlal  v20.4S, v11.4H,  v2.H[3]
    smlal2 v21.4S, v11.8H,  v2.H[3]

    // 3
    smull  v22.4S,  v8.4H,  v2.H[3]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S,  v8.8H,  v2.H[3]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S,  v9.4H,  v2.H[2]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S,  v9.8H,  v2.H[2]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v10.4H,  v2.H[1]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v10.8H,  v2.H[1]
    str  q6, [sp,  #2*16]
    smlal  v22.4S, v11.4H,  v2.H[0]
    smlal2 v23.4S, v11.8H,  v2.H[0]

    // 4
    smull  v16.4S, v12.4H,  v2.H[4]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v12.8H,  v2.H[4]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlsl  v16.4S, v13.4H,  v2.H[7]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlsl2 v17.4S, v13.8H,  v2.H[7]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlsl  v16.4S, v14.4H,  v2.H[6]
    uzp2    v7.8H, v22.8H, v23.8H
    smlsl2 v17.4S, v14.8H,  v2.H[6]
    str  q7, [sp,  #3*16]

// ================

    smlsl  v16.4S, v15.4H,  v2.H[5]
    smlsl2 v17.4S, v15.8H,  v2.H[5]

    // 5
    smull  v18.4S, v12.4H,  v2.H[5]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v12.8H,  v2.H[5]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v13.4H,  v2.H[4]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v13.8H,  v2.H[4]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlsl  v18.4S, v14.4H,  v2.H[7]
    uzp2    v4.8H, v16.8H, v17.8H
    smlsl2 v19.4S, v14.8H,  v2.H[7]
    str  q4, [sp,  #4*16]
    smlsl  v18.4S, v15.4H,  v2.H[6]
    smlsl2 v19.4S, v15.8H,  v2.H[6]

    // 6
    smull  v20.4S, v12.4H,  v2.H[6]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v12.8H,  v2.H[6]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v13.4H,  v2.H[5]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v13.8H,  v2.H[5]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v14.4H,  v2.H[4]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v14.8H,  v2.H[4]
    str  q5, [sp,  #5*16]
    smlsl  v20.4S, v15.4H,  v2.H[7]
    smlsl2 v21.4S, v15.8H,  v2.H[7]

    // 7
    smull  v22.4S, v12.4H,  v2.H[7]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v12.8H,  v2.H[7]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v13.4H,  v2.H[6]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v13.8H,  v2.H[6]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v14.4H,  v2.H[5]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v14.8H,  v2.H[5]
    str  q6, [sp,  #6*16]
    smlal  v22.4S, v15.4H,  v2.H[4]
    smlal2 v23.4S, v15.8H,  v2.H[4]

    // 0
    smull  v16.4S, v24.4H,  v3.H[0]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v24.8H,  v3.H[0]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlsl  v16.4S, v25.4H,  v3.H[7]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlsl2 v17.4S, v25.8H,  v3.H[7]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlsl  v16.4S, v26.4H,  v3.H[6]
    uzp2    v7.8H, v22.8H, v23.8H
    smlsl2 v17.4S, v26.8H,  v3.H[6]
    str  q7, [sp,  #7*16]

// ================

    smlsl  v16.4S, v27.4H,  v3.H[5]
    smlsl2 v17.4S, v27.8H,  v3.H[5]
    smlsl  v16.4S, v28.4H,  v3.H[4]
    smlsl2 v17.4S, v28.8H,  v3.H[4]
    smlsl  v16.4S, v29.4H,  v3.H[3]
    smlsl2 v17.4S, v29.8H,  v3.H[3]
    smlsl  v16.4S, v30.4H,  v3.H[2]
    smlsl2 v17.4S, v30.8H,  v3.H[2]
    smlsl  v16.4S, v31.4H,  v3.H[1]
    smlsl2 v17.4S, v31.8H,  v3.H[1]

    // 1
    smull  v18.4S, v24.4H,  v3.H[1]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v24.8H,  v3.H[1]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v25.4H,  v3.H[0]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v25.8H,  v3.H[0]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlsl  v18.4S, v26.4H,  v3.H[7]
    uzp2    v4.8H, v16.8H, v17.8H
    smlsl2 v19.4S, v26.8H,  v3.H[7]
    str  q4, [sp,  #(8+0)*16]

    smlsl  v18.4S, v27.4H,  v3.H[6]
    smlsl2 v19.4S, v27.8H,  v3.H[6]
    smlsl  v18.4S, v28.4H,  v3.H[5]
    smlsl2 v19.4S, v28.8H,  v3.H[5]
    smlsl  v18.4S, v29.4H,  v3.H[4]
    smlsl2 v19.4S, v29.8H,  v3.H[4]
    smlsl  v18.4S, v30.4H,  v3.H[3]
    smlsl2 v19.4S, v30.8H,  v3.H[3]
    smlsl  v18.4S, v31.4H,  v3.H[2]
    smlsl2 v19.4S, v31.8H,  v3.H[2]

    // 2
    smull  v20.4S, v24.4H,  v3.H[2]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v24.8H,  v3.H[2]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v25.4H,  v3.H[1]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v25.8H,  v3.H[1]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v26.4H,  v3.H[0]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v26.8H,  v3.H[0]
    str  q5, [sp,  #(8+1)*16]

    smlsl  v20.4S, v27.4H,  v3.H[7]
    smlsl2 v21.4S, v27.8H,  v3.H[7]
    smlsl  v20.4S, v28.4H,  v3.H[6]
    smlsl2 v21.4S, v28.8H,  v3.H[6]
    smlsl  v20.4S, v29.4H,  v3.H[5]
    smlsl2 v21.4S, v29.8H,  v3.H[5]
    smlsl  v20.4S, v30.4H,  v3.H[4]
    smlsl2 v21.4S, v30.8H,  v3.H[4]
    smlsl  v20.4S, v31.4H,  v3.H[3]
    smlsl2 v21.4S, v31.8H,  v3.H[3]

    // 3
    smull  v22.4S, v24.4H,  v3.H[3]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v24.8H,  v3.H[3]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v25.4H,  v3.H[2]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v25.8H,  v3.H[2]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v26.4H,  v3.H[1]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v26.8H,  v3.H[1]
    str  q6, [sp,  #(8+2)*16]

    smlal  v22.4S, v27.4H,  v3.H[0]
    smlal2 v23.4S, v27.8H,  v3.H[0]
    smlsl  v22.4S, v28.4H,  v3.H[7]
    smlsl2 v23.4S, v28.8H,  v3.H[7]
    smlsl  v22.4S, v29.4H,  v3.H[6]
    smlsl2 v23.4S, v29.8H,  v3.H[6]
    smlsl  v22.4S, v30.4H,  v3.H[5]
    smlsl2 v23.4S, v30.8H,  v3.H[5]
    smlsl  v22.4S, v31.4H,  v3.H[4]
    smlsl2 v23.4S, v31.8H,  v3.H[4]

    // 4
    smull  v16.4S, v24.4H,  v3.H[4]
    uzp1    v7.8H, v22.8H, v23.8H
    smull2 v17.4S, v24.8H,  v3.H[4]
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlal  v16.4S, v25.4H,  v3.H[3]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlal2 v17.4S, v25.8H,  v3.H[3]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    smlal  v16.4S, v26.4H,  v3.H[2]
    uzp2    v7.8H, v22.8H, v23.8H
    smlal2 v17.4S, v26.8H,  v3.H[2]
    str  q7, [sp,  #(8+3)*16]

    smlal  v16.4S, v27.4H,  v3.H[1]
    smlal2 v17.4S, v27.8H,  v3.H[1]
    smlal  v16.4S, v28.4H,  v3.H[0]
    smlal2 v17.4S, v28.8H,  v3.H[0]
    smlsl  v16.4S, v29.4H,  v3.H[7]
    smlsl2 v17.4S, v29.8H,  v3.H[7]
    smlsl  v16.4S, v30.4H,  v3.H[6]
    smlsl2 v17.4S, v30.8H,  v3.H[6]
    smlsl  v16.4S, v31.4H,  v3.H[5]
    smlsl2 v17.4S, v31.8H,  v3.H[5]

    // 5
    smull  v18.4S, v24.4H,  v3.H[5]
    uzp1    v4.8H, v16.8H, v17.8H
    smull2 v19.4S, v24.8H,  v3.H[5]
    mul     v4.8H,  v4.8H,  v0.H[0]
    smlal  v18.4S, v25.4H,  v3.H[4]
    smlal  v16.4S,  v4.4H,  v0.H[1]
    smlal2 v19.4S, v25.8H,  v3.H[4]
    smlal2 v17.4S,  v4.8H,  v0.H[1]
    smlal  v18.4S, v26.4H,  v3.H[3]
    uzp2    v4.8H, v16.8H, v17.8H
    smlal2 v19.4S, v26.8H,  v3.H[3]
    str  q4, [sp,  #(8+4)*16]

    smlal  v18.4S, v27.4H,  v3.H[2]
    smlal2 v19.4S, v27.8H,  v3.H[2]
    smlal  v18.4S, v28.4H,  v3.H[1]
    smlal2 v19.4S, v28.8H,  v3.H[1]
    smlal  v18.4S, v29.4H,  v3.H[0]
    smlal2 v19.4S, v29.8H,  v3.H[0]
    smlsl  v18.4S, v30.4H,  v3.H[7]
    smlsl2 v19.4S, v30.8H,  v3.H[7]
    smlsl  v18.4S, v31.4H,  v3.H[6]
    smlsl2 v19.4S, v31.8H,  v3.H[6]

    // 6
    smull  v20.4S, v24.4H,  v3.H[6]
    uzp1    v5.8H, v18.8H, v19.8H
    smull2 v21.4S, v24.8H,  v3.H[6]
    mul     v5.8H,  v5.8H,  v0.H[0]
    smlal  v20.4S, v25.4H,  v3.H[5]
    smlal  v18.4S,  v5.4H,  v0.H[1]
    smlal2 v21.4S, v25.8H,  v3.H[5]
    smlal2 v19.4S,  v5.8H,  v0.H[1]
    smlal  v20.4S, v26.4H,  v3.H[4]
    uzp2    v5.8H, v18.8H, v19.8H
    smlal2 v21.4S, v26.8H,  v3.H[4]
    str  q5, [sp,  #(8+5)*16]

    smlal  v20.4S, v27.4H,  v3.H[3]
    smlal2 v21.4S, v27.8H,  v3.H[3]
    smlal  v20.4S, v28.4H,  v3.H[2]
    smlal2 v21.4S, v28.8H,  v3.H[2]
    smlal  v20.4S, v29.4H,  v3.H[1]
    smlal2 v21.4S, v29.8H,  v3.H[1]
    smlal  v20.4S, v30.4H,  v3.H[0]
    smlal2 v21.4S, v30.8H,  v3.H[0]
    smlsl  v20.4S, v31.4H,  v3.H[7]
    smlsl2 v21.4S, v31.8H,  v3.H[7]

    // 7
    smull  v22.4S, v24.4H,  v3.H[7]
    uzp1    v6.8H, v20.8H, v21.8H
    smull2 v23.4S, v24.8H,  v3.H[7]
    mul     v6.8H,  v6.8H,  v0.H[0]
    smlal  v22.4S, v25.4H,  v3.H[6]
    smlal  v20.4S,  v6.4H,  v0.H[1]
    smlal2 v23.4S, v25.8H,  v3.H[6]
    smlal2 v21.4S,  v6.8H,  v0.H[1]
    smlal  v22.4S, v26.4H,  v3.H[5]
    uzp2    v6.8H, v20.8H, v21.8H
    smlal2 v23.4S, v26.8H,  v3.H[5]
    str  q6, [sp,  #(8+6)*16]

    smlal  v22.4S, v27.4H,  v3.H[4]
    smlal2 v23.4S, v27.8H,  v3.H[4]
    smlal  v22.4S, v28.4H,  v3.H[3]
    smlal2 v23.4S, v28.8H,  v3.H[3]
    smlal  v22.4S, v29.4H,  v3.H[2]
    smlal2 v23.4S, v29.8H,  v3.H[2]
    smlal  v22.4S, v30.4H,  v3.H[1]
    smlal2 v23.4S, v30.8H,  v3.H[1]
    smlal  v22.4S, v31.4H,  v3.H[0]
    smlal2 v23.4S, v31.8H,  v3.H[0]

    uzp1    v7.8H, v22.8H, v23.8H
    mul     v7.8H,  v7.8H,  v0.H[0]
    smlal  v22.4S,  v7.4H,  v0.H[1]
    smlal2 v23.4S,  v7.8H,  v0.H[1]
    uzp2    v7.8H, v22.8H, v23.8H
    str  q7, [sp,  #(8+7)*16]

// ================

    sub counter, counter, #1
    cbnz counter, __asm_irader17_primitive_loop

    ldr q24, [sp,  #0*16]
    ldr q28, [sp,  #4*16]
    ldr q16, [sp,  #8*16]
    ldr q20, [sp, #12*16]

    add    v8.8H, v24.8H, v28.8H
    sub   v12.8H, v24.8H, v28.8H
    add   v16.8H, v16.8H, v16.8H
    add   v20.8H, v20.8H, v20.8H

    add   v24.8H,  v8.8H, v16.8H
    sub   v16.8H,  v8.8H, v16.8H
    add   v28.8H, v12.8H, v20.8H
    sub   v20.8H, v12.8H, v20.8H

    str q24, [x0,  #des0]
    str q28, [x0,  #des4]
    str q16, [x0,  #des8]
    str q20, [x0, #des12]

    ldr q25, [sp,  #1*16]
    ldr q29, [sp,  #5*16]
    ldr q17, [sp,  #9*16]
    ldr q21, [sp, #13*16]

    add    v9.8H, v25.8H, v29.8H
    sub   v13.8H, v25.8H, v29.8H
    add   v17.8H, v17.8H, v17.8H
    add   v21.8H, v21.8H, v21.8H

    add   v25.8H,  v9.8H, v17.8H
    sub   v17.8H,  v9.8H, v17.8H
    add   v29.8H, v13.8H, v21.8H
    sub   v21.8H, v13.8H, v21.8H

    str q25, [x0,  #des1]
    str q29, [x0,  #des5]
    str q17, [x0,  #des9]
    str q21, [x0, #des13]

    ldr q26, [sp,  #2*16]
    ldr q30, [sp,  #6*16]
    ldr q18, [sp, #10*16]
    ldr q22, [sp, #14*16]

    add   v10.8H, v26.8H, v30.8H
    sub   v14.8H, v26.8H, v30.8H
    add   v18.8H, v18.8H, v18.8H
    add   v22.8H, v22.8H, v22.8H

    add   v26.8H, v10.8H, v18.8H
    sub   v18.8H, v10.8H, v18.8H
    add   v30.8H, v14.8H, v22.8H
    sub   v22.8H, v14.8H, v22.8H

    str q26, [x0,  #des2]
    str q30, [x0,  #des6]
    str q18, [x0, #des10]
    str q22, [x0, #des14]

    ldr q27, [sp,  #3*16]
    ldr q31, [sp,  #7*16]
    ldr q19, [sp, #11*16]
    ldr q23, [sp, #15*16]

    add   v11.8H, v27.8H, v31.8H
    sub   v15.8H, v27.8H, v31.8H
    add   v19.8H, v19.8H, v19.8H
    add   v23.8H, v23.8H, v23.8H

    add   v27.8H, v11.8H, v19.8H
    sub   v19.8H, v11.8H, v19.8H
    add   v31.8H, v15.8H, v23.8H
    sub   v23.8H, v15.8H, v23.8H

    str q27, [x0,  #des3]
    str q31, [x0,  #des7]
    str q19, [x0, #des11]
    str q23, [x0, #des15]

    // add x0, x0, #16

    add sp, sp, #(16*16)
    ldp  d8,  d9, [sp, #16*0]
    ldp d10, d11, [sp, #16*1]
    ldp d12, d13, [sp, #16*2]
    ldp d14, d15, [sp, #16*3]
    add sp, sp, #(16*4)

    br lr



