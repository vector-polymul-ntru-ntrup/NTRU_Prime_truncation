
#include "__avx2_wrap.h"
#include "__avx2_mulmod.h"
#include "__avx2_const.h"
#include "__avx2.h"


#include <memory.h>

static inline
void _twist_transpose_pre(int16_t out[16][16], const int16_t in[31][16], int16_t *twist_table)
{
    int16x16_t a0 = load_int16x16((int16x16_t*)&in[ 0][0]);
    int16x16_t a1 = load_int16x16((int16x16_t*)&in[ 2][0]);

    a0 = montmulmod_int16x16(a0, load_int16x16((int16x16_t*)(twist_table +  0 * 16)));
    a1 = montmulmod_int16x16(a1, load_int16x16((int16x16_t*)(twist_table +  2 * 16)));

    int16x16_t b0 = _mm256_unpacklo_epi16(a0,a1);
    int16x16_t b1 = _mm256_unpackhi_epi16(a0,a1);
    int16x16_t a2 = load_int16x16((int16x16_t*)&in[ 4][0]);
    int16x16_t a3 = load_int16x16((int16x16_t*)&in[ 6][0]);

    a2 = montmulmod_int16x16(a2, load_int16x16((int16x16_t*)(twist_table +  4 * 16)));
    a3 = montmulmod_int16x16(a3, load_int16x16((int16x16_t*)(twist_table +  6 * 16)));

    int16x16_t b2 = _mm256_unpacklo_epi16(a2,a3);
    int16x16_t b3 = _mm256_unpackhi_epi16(a2,a3);
    int16x16_t c0 = _mm256_unpacklo_epi32(b0,b2);
    int16x16_t c2 = _mm256_unpackhi_epi32(b0,b2);
    int16x16_t c1 = _mm256_unpacklo_epi32(b1,b3);
    int16x16_t c3 = _mm256_unpackhi_epi32(b1,b3);
    int16x16_t a4 = load_int16x16((int16x16_t*)&in[ 8][0]);
    int16x16_t a5 = load_int16x16((int16x16_t*)&in[10][0]);

    a4 = montmulmod_int16x16(a4, load_int16x16((int16x16_t*)(twist_table +  8 * 16)));
    a5 = montmulmod_int16x16(a5, load_int16x16((int16x16_t*)(twist_table + 10 * 16)));

    int16x16_t b4 = _mm256_unpacklo_epi16(a4,a5);
    int16x16_t b5 = _mm256_unpackhi_epi16(a4,a5);
    int16x16_t a6 = load_int16x16((int16x16_t*)&in[12][0]);
    int16x16_t a7 = load_int16x16((int16x16_t*)&in[14][0]);

    a6 = montmulmod_int16x16(a6, load_int16x16((int16x16_t*)(twist_table + 12 * 16)));
    a7 = montmulmod_int16x16(a7, load_int16x16((int16x16_t*)(twist_table + 14 * 16)));

    int16x16_t b6 = _mm256_unpacklo_epi16(a6,a7);
    int16x16_t b7 = _mm256_unpackhi_epi16(a6,a7);
    int16x16_t c4 = _mm256_unpacklo_epi32(b4,b6);
    int16x16_t c6 = _mm256_unpackhi_epi32(b4,b6);
    int16x16_t c5 = _mm256_unpacklo_epi32(b5,b7);
    int16x16_t c7 = _mm256_unpackhi_epi32(b5,b7);
    int16x16_t a8 = load_int16x16((int16x16_t*)&in[16][0]);
    int16x16_t a9 = load_int16x16((int16x16_t*)&in[18][0]);

    a8 = montmulmod_int16x16(a8, load_int16x16((int16x16_t*)(twist_table + 16 * 16)));
    a9 = montmulmod_int16x16(a9, load_int16x16((int16x16_t*)(twist_table + 18 * 16)));

    int16x16_t b8 = _mm256_unpacklo_epi16(a8,a9);
    int16x16_t b9 = _mm256_unpackhi_epi16(a8,a9);
    int16x16_t a10 = load_int16x16((int16x16_t*)&in[20][0]);
    int16x16_t a11 = load_int16x16((int16x16_t*)&in[22][0]);

    a10 = montmulmod_int16x16(a10, load_int16x16((int16x16_t*)(twist_table + 20 * 16)));
    a11 = montmulmod_int16x16(a11, load_int16x16((int16x16_t*)(twist_table + 22 * 16)));

    int16x16_t b10 = _mm256_unpacklo_epi16(a10,a11);
    int16x16_t b11 = _mm256_unpackhi_epi16(a10,a11);
    int16x16_t c8 = _mm256_unpacklo_epi32(b8,b10);
    int16x16_t c10 = _mm256_unpackhi_epi32(b8,b10);
    int16x16_t c9 = _mm256_unpacklo_epi32(b9,b11);
    int16x16_t c11 = _mm256_unpackhi_epi32(b9,b11);
    int16x16_t a12 = load_int16x16((int16x16_t*)&in[24][0]);
    int16x16_t a13 = load_int16x16((int16x16_t*)&in[26][0]);

    a12 = montmulmod_int16x16(a12, load_int16x16((int16x16_t*)(twist_table + 24 * 16)));
    a13 = montmulmod_int16x16(a13, load_int16x16((int16x16_t*)(twist_table + 26 * 16)));

    int16x16_t b12 = _mm256_unpacklo_epi16(a12,a13);
    int16x16_t b13 = _mm256_unpackhi_epi16(a12,a13);
    int16x16_t a14 = load_int16x16((int16x16_t*)&in[28][0]);
    int16x16_t a15 = load_int16x16((int16x16_t*)&in[30][0]);

    a14 = montmulmod_int16x16(a14, load_int16x16((int16x16_t*)(twist_table + 28 * 16)));
    a15 = montmulmod_int16x16(a15, load_int16x16((int16x16_t*)(twist_table + 30 * 16)));

    int16x16_t b14 = _mm256_unpacklo_epi16(a14,a15);
    int16x16_t b15 = _mm256_unpackhi_epi16(a14,a15);
    int16x16_t c12 = _mm256_unpacklo_epi32(b12,b14);
    int16x16_t c14 = _mm256_unpackhi_epi32(b12,b14);
    int16x16_t c13 = _mm256_unpacklo_epi32(b13,b15);
    int16x16_t c15 = _mm256_unpackhi_epi32(b13,b15);

    int16x16_t d0 = _mm256_unpacklo_epi64(c0,c4);
    int16x16_t d4 = _mm256_unpackhi_epi64(c0,c4);
    int16x16_t d8 = _mm256_unpacklo_epi64(c8,c12);
    int16x16_t d12 = _mm256_unpackhi_epi64(c8,c12);
    int16x16_t e0 = _mm256_permute2x128_si256(d0,d8,0x20);
    int16x16_t e8 = _mm256_permute2x128_si256(d0,d8,0x31);
    int16x16_t e4 = _mm256_permute2x128_si256(d4,d12,0x20);
    int16x16_t e12 = _mm256_permute2x128_si256(d4,d12,0x31);
    store_int16x16((int16x16_t*)(out[0]),  e0);
    store_int16x16((int16x16_t*)(out[8]),  e8);
    store_int16x16((int16x16_t*)(out[1]),  e4);
    store_int16x16((int16x16_t*)(out[9]), e12);

    int16x16_t d1 = _mm256_unpacklo_epi64(c1,c5);
    int16x16_t d5 = _mm256_unpackhi_epi64(c1,c5);
    int16x16_t d9 = _mm256_unpacklo_epi64(c9,c13);
    int16x16_t d13 = _mm256_unpackhi_epi64(c9,c13);
    int16x16_t e1 = _mm256_permute2x128_si256(d1,d9,0x20);
    int16x16_t e9 = _mm256_permute2x128_si256(d1,d9,0x31);
    int16x16_t e5 = _mm256_permute2x128_si256(d5,d13,0x20);
    int16x16_t e13 = _mm256_permute2x128_si256(d5,d13,0x31);
    store_int16x16((int16x16_t*)(out[ 4]),  e1);
    store_int16x16((int16x16_t*)(out[12]),  e9);
    store_int16x16((int16x16_t*)(out[ 5]),  e5);
    store_int16x16((int16x16_t*)(out[13]), e13);

    int16x16_t d2 = _mm256_unpacklo_epi64(c2,c6);
    int16x16_t d6 = _mm256_unpackhi_epi64(c2,c6);
    int16x16_t d10 = _mm256_unpacklo_epi64(c10,c14);
    int16x16_t d14 = _mm256_unpackhi_epi64(c10,c14);
    int16x16_t e2 = _mm256_permute2x128_si256(d2,d10,0x20);
    int16x16_t e10 = _mm256_permute2x128_si256(d2,d10,0x31);
    int16x16_t e6 = _mm256_permute2x128_si256(d6,d14,0x20);
    int16x16_t e14 = _mm256_permute2x128_si256(d6,d14,0x31);
    store_int16x16((int16x16_t*)(out[ 2]),  e2);
    store_int16x16((int16x16_t*)(out[ 3]),  e6);
    store_int16x16((int16x16_t*)(out[10]), e10);
    store_int16x16((int16x16_t*)(out[11]), e14);

    int16x16_t d3 = _mm256_unpacklo_epi64(c3,c7);
    int16x16_t d7 = _mm256_unpackhi_epi64(c3,c7);
    int16x16_t d11 = _mm256_unpacklo_epi64(c11,c15);
    int16x16_t d15 = _mm256_unpackhi_epi64(c11,c15);
    int16x16_t e3 = _mm256_permute2x128_si256(d3,d11,0x20);
    int16x16_t e11 = _mm256_permute2x128_si256(d3,d11,0x31);
    int16x16_t e7 = _mm256_permute2x128_si256(d7,d15,0x20);
    int16x16_t e15 = _mm256_permute2x128_si256(d7,d15,0x31);
    store_int16x16((int16x16_t*)(out[ 6]),  e3);
    store_int16x16((int16x16_t*)(out[ 7]),  e7);
    store_int16x16((int16x16_t*)(out[14]), e11);
    store_int16x16((int16x16_t*)(out[15]), e15);

}

void twist_transpose_pre(int16_t out[16][16], const int16_t in[31][16], int16_t *twist_table){
    _twist_transpose_pre((int16_t (*)[16])out, (const int16_t (*)[16])in, twist_table);
}

static inline
void _twist_transpose_post(int16_t out[31][16], const int16_t in[16][16], int16_t *twist_table)
{
    int16x16_t a0 = load_int16x16((int16x16_t*)&in[0][0]);
    int16x16_t a1 = load_int16x16((int16x16_t*)&in[1][0]);
    int16x16_t b0 = _mm256_unpacklo_epi16(a0,a1);
    int16x16_t b1 = _mm256_unpackhi_epi16(a0,a1);
    int16x16_t a2 = load_int16x16((int16x16_t*)&in[2][0]);
    int16x16_t a3 = load_int16x16((int16x16_t*)&in[3][0]);
    int16x16_t b2 = _mm256_unpacklo_epi16(a2,a3);
    int16x16_t b3 = _mm256_unpackhi_epi16(a2,a3);
    int16x16_t c0 = _mm256_unpacklo_epi32(b0,b2);
    int16x16_t c2 = _mm256_unpackhi_epi32(b0,b2);
    int16x16_t c1 = _mm256_unpacklo_epi32(b1,b3);
    int16x16_t c3 = _mm256_unpackhi_epi32(b1,b3);
    int16x16_t a4 = load_int16x16((int16x16_t*)&in[4][0]);
    int16x16_t a5 = load_int16x16((int16x16_t*)&in[5][0]);
    int16x16_t b4 = _mm256_unpacklo_epi16(a4,a5);
    int16x16_t b5 = _mm256_unpackhi_epi16(a4,a5);
    int16x16_t a6 = load_int16x16((int16x16_t*)&in[6][0]);
    int16x16_t a7 = load_int16x16((int16x16_t*)&in[7][0]);
    int16x16_t b6 = _mm256_unpacklo_epi16(a6,a7);
    int16x16_t b7 = _mm256_unpackhi_epi16(a6,a7);
    int16x16_t c4 = _mm256_unpacklo_epi32(b4,b6);
    int16x16_t c6 = _mm256_unpackhi_epi32(b4,b6);
    int16x16_t c5 = _mm256_unpacklo_epi32(b5,b7);
    int16x16_t c7 = _mm256_unpackhi_epi32(b5,b7);
    int16x16_t a8 = load_int16x16((int16x16_t*)&in[8][0]);
    int16x16_t a9 = load_int16x16((int16x16_t*)&in[9][0]);
    int16x16_t b8 = _mm256_unpacklo_epi16(a8,a9);
    int16x16_t b9 = _mm256_unpackhi_epi16(a8,a9);
    int16x16_t a10 = load_int16x16((int16x16_t*)&in[10][0]);
    int16x16_t a11 = load_int16x16((int16x16_t*)&in[11][0]);
    int16x16_t b10 = _mm256_unpacklo_epi16(a10,a11);
    int16x16_t b11 = _mm256_unpackhi_epi16(a10,a11);
    int16x16_t c8 = _mm256_unpacklo_epi32(b8,b10);
    int16x16_t c10 = _mm256_unpackhi_epi32(b8,b10);
    int16x16_t c9 = _mm256_unpacklo_epi32(b9,b11);
    int16x16_t c11 = _mm256_unpackhi_epi32(b9,b11);
    int16x16_t a12 = load_int16x16((int16x16_t*)&in[12][0]);
    int16x16_t a13 = load_int16x16((int16x16_t*)&in[13][0]);
    int16x16_t b12 = _mm256_unpacklo_epi16(a12,a13);
    int16x16_t b13 = _mm256_unpackhi_epi16(a12,a13);
    int16x16_t a14 = load_int16x16((int16x16_t*)&in[14][0]);
    int16x16_t a15 = load_int16x16((int16x16_t*)&in[15][0]);
    int16x16_t b14 = _mm256_unpacklo_epi16(a14,a15);
    int16x16_t b15 = _mm256_unpackhi_epi16(a14,a15);
    int16x16_t c12 = _mm256_unpacklo_epi32(b12,b14);
    int16x16_t c14 = _mm256_unpackhi_epi32(b12,b14);
    int16x16_t c13 = _mm256_unpacklo_epi32(b13,b15);
    int16x16_t c15 = _mm256_unpackhi_epi32(b13,b15);

    int16x16_t d0 = _mm256_unpacklo_epi64(c0,c4);
    int16x16_t d4 = _mm256_unpackhi_epi64(c0,c4);
    int16x16_t d8 = _mm256_unpacklo_epi64(c8,c12);
    int16x16_t d12 = _mm256_unpackhi_epi64(c8,c12);
    int16x16_t e0 = _mm256_permute2x128_si256(d0,d8,0x20);
    int16x16_t e8 = _mm256_permute2x128_si256(d0,d8,0x31);
    int16x16_t e4 = _mm256_permute2x128_si256(d4,d12,0x20);
    int16x16_t e12 = _mm256_permute2x128_si256(d4,d12,0x31);

     e0 = montmulmod_int16x16( e0, load_int16x16((int16x16_t*)(twist_table +  0 * 16)));
     e8 = montmulmod_int16x16( e8, load_int16x16((int16x16_t*)(twist_table + 16 * 16)));
     e4 = montmulmod_int16x16( e4, load_int16x16((int16x16_t*)(twist_table +  2 * 16)));
    e12 = montmulmod_int16x16(e12, load_int16x16((int16x16_t*)(twist_table + 18 * 16)));


    store_int16x16((int16x16_t*)(out[ 0]),  e0);
    store_int16x16((int16x16_t*)(out[16]),  e8);
    store_int16x16((int16x16_t*)(out[ 2]),  e4);
    store_int16x16((int16x16_t*)(out[18]), e12);

    int16x16_t d1 = _mm256_unpacklo_epi64(c1,c5);
    int16x16_t d5 = _mm256_unpackhi_epi64(c1,c5);
    int16x16_t d9 = _mm256_unpacklo_epi64(c9,c13);
    int16x16_t d13 = _mm256_unpackhi_epi64(c9,c13);
    int16x16_t e1 = _mm256_permute2x128_si256(d1,d9,0x20);
    int16x16_t e9 = _mm256_permute2x128_si256(d1,d9,0x31);
    int16x16_t e5 = _mm256_permute2x128_si256(d5,d13,0x20);
    int16x16_t e13 = _mm256_permute2x128_si256(d5,d13,0x31);

     e1 = montmulmod_int16x16( e1, load_int16x16((int16x16_t*)(twist_table +  8 * 16)));
     e9 = montmulmod_int16x16( e9, load_int16x16((int16x16_t*)(twist_table + 24 * 16)));
     e5 = montmulmod_int16x16( e5, load_int16x16((int16x16_t*)(twist_table + 10 * 16)));
    e13 = montmulmod_int16x16(e13, load_int16x16((int16x16_t*)(twist_table + 26 * 16)));

    store_int16x16((int16x16_t*)(out[ 8]),  e1);
    store_int16x16((int16x16_t*)(out[24]),  e9);
    store_int16x16((int16x16_t*)(out[10]),  e5);
    store_int16x16((int16x16_t*)(out[26]), e13);

    int16x16_t d2 = _mm256_unpacklo_epi64(c2,c6);
    int16x16_t d6 = _mm256_unpackhi_epi64(c2,c6);
    int16x16_t d10 = _mm256_unpacklo_epi64(c10,c14);
    int16x16_t d14 = _mm256_unpackhi_epi64(c10,c14);
    int16x16_t e2 = _mm256_permute2x128_si256(d2,d10,0x20);
    int16x16_t e10 = _mm256_permute2x128_si256(d2,d10,0x31);
    int16x16_t e6 = _mm256_permute2x128_si256(d6,d14,0x20);
    int16x16_t e14 = _mm256_permute2x128_si256(d6,d14,0x31);

     e2 = montmulmod_int16x16( e2, load_int16x16((int16x16_t*)(twist_table +  4 * 16)));
     e6 = montmulmod_int16x16( e6, load_int16x16((int16x16_t*)(twist_table +  6 * 16)));
    e10 = montmulmod_int16x16(e10, load_int16x16((int16x16_t*)(twist_table + 20 * 16)));
    e14 = montmulmod_int16x16(e14, load_int16x16((int16x16_t*)(twist_table + 22 * 16)));

    store_int16x16((int16x16_t*)(out[ 4]),  e2);
    store_int16x16((int16x16_t*)(out[ 6]),  e6);
    store_int16x16((int16x16_t*)(out[20]), e10);
    store_int16x16((int16x16_t*)(out[22]), e14);

    int16x16_t d3 = _mm256_unpacklo_epi64(c3,c7);
    int16x16_t d7 = _mm256_unpackhi_epi64(c3,c7);
    int16x16_t d11 = _mm256_unpacklo_epi64(c11,c15);
    int16x16_t d15 = _mm256_unpackhi_epi64(c11,c15);
    int16x16_t e3 = _mm256_permute2x128_si256(d3,d11,0x20);
    int16x16_t e11 = _mm256_permute2x128_si256(d3,d11,0x31);
    int16x16_t e7 = _mm256_permute2x128_si256(d7,d15,0x20);
    int16x16_t e15 = _mm256_permute2x128_si256(d7,d15,0x31);

     e3 = montmulmod_int16x16( e3, load_int16x16((int16x16_t*)(twist_table + 12 * 16)));
     e7 = montmulmod_int16x16( e7, load_int16x16((int16x16_t*)(twist_table + 14 * 16)));
    e11 = montmulmod_int16x16(e11, load_int16x16((int16x16_t*)(twist_table + 28 * 16)));
    e15 = montmulmod_int16x16(e15, load_int16x16((int16x16_t*)(twist_table + 30 * 16)));

    store_int16x16((int16x16_t*)(out[12]),  e3);
    store_int16x16((int16x16_t*)(out[14]),  e7);
    store_int16x16((int16x16_t*)(out[28]), e11);
    store_int16x16((int16x16_t*)(out[30]), e15);

}

void twist_transpose_post(int16_t out[31][16], const int16_t in[16][16], int16_t *twist_table){
    _twist_transpose_post((int16_t (*)[16])out, (const int16_t (*)[16])in, twist_table);
}

static inline
void _mulcore(int16_t *des, int16_t *src1, int16_t *src2){

    int16_t NTT_buff[NTT_N];

    int16_t permute1p[256 * 3], permute1n[256 * 3];
    int16_t permute2p[256 * 3], permute2n[256 * 3];

    int16_t *permuteresp = permute1p;
    int16_t *permuteresn = permute1n;

    int16_t *res_NTT = NTT_buff;

// ================

    for(size_t i = 0; i < 96; i += 16){
        __asm_rader17_truncated(NTT_buff + i, src1 + i, twiddle_rader17_full, twiddle_rader17_qinv_full, const_buff);
    }

    __asm_3x2_pre(NTT_buff, OMEGA3_buff, const_buff, twist96_table);

    for(size_t i = 0; i < (NTT_N / 2); i += 256){
        twist_transpose_pre((int16_t (*)[16])&permute1p[i], (int16_t (*)[16])(NTT_buff + (2 * i) + 0 * 16),
                                                                        twist_full_pre + (2 * i) + 0 * 16);
        twist_transpose_pre((int16_t (*)[16])&permute1n[i], (int16_t (*)[16])(NTT_buff + (2 * i) + 1 * 16),
                                                                        twist_full_pre + (2 * i) + 1 * 16);
    }

    // for(size_t i = 0; i < (NTT_N / 2); i += 256){
    //     for(size_t j = 0; j < 16; j++){
    //         memmove(permute1p + i + j * 16, poly1_NTT + (2 * i) + j * 32 + 0 * 16, 16 * sizeof(int16_t));
    //         memmove(permute1n + i + j * 16, poly1_NTT + (2 * i) + j * 32 + 1 * 16, 16 * sizeof(int16_t));
    //     }
    //     transpose((int16_t (*)[16])&permute1p[i], (int16_t (*)[16])&permute1p[i]);
    //     transpose((int16_t (*)[16])&permute1n[i], (int16_t (*)[16])&permute1n[i]);
    // }

// ================

    for(size_t i = 0; i < 96; i += 16){
        __asm_rader17_truncated(NTT_buff + i, src2 + i, twiddle_rader17_full, twiddle_rader17_qinv_full, const_buff);
    }

    __asm_3x2_pre(NTT_buff, OMEGA3_buff, const_buff, twist96_table);

    for(size_t i = 0; i < (NTT_N / 2); i += 256){
        twist_transpose_pre((int16_t (*)[16])&permute2p[i], (int16_t (*)[16])(NTT_buff + (2 * i) + 0 * 16),
                                                                        twist_full_pre + (2 * i) + 0 * 16);
        twist_transpose_pre((int16_t (*)[16])&permute2n[i], (int16_t (*)[16])(NTT_buff + (2 * i) + 1 * 16),
                                                                        twist_full_pre + (2 * i) + 1 * 16);
    }

// ================

    for(size_t i = 0; i < (NTT_N / 2); i += 256){
        __asm_cyclic_FFT16(permuteresp + i, permute1p + i, permute2p + i, const_buff);
    }

    for(size_t i = 0; i < (NTT_N / 2); i += 256){
        __asm_negacyclic_FFT16(permuteresn + i, permute1n + i, permute2n + i, const_buff);
    }

// ================

    for(size_t i = 0; i < (NTT_N / 2); i += 256){
        twist_transpose_post((int16_t (*)[16])(res_NTT + (2 * i) + 0 * 16), (int16_t (*)[16])&permuteresp[i],
                                       twist_full_post + (2 * i) + 0 * 16);
        twist_transpose_post((int16_t (*)[16])(res_NTT + (2 * i) + 1 * 16), (int16_t (*)[16])&permuteresn[i],
                                       twist_full_post + (2 * i) + 1 * 16);
    }

    // for(size_t i = 0; i < (NTT_N / 2); i += 256){
    //     transpose((int16_t (*)[16])&permuteresp[i], (int16_t (*)[16])&permuteresp[i]);
    //     transpose((int16_t (*)[16])&permuteresn[i], (int16_t (*)[16])&permuteresn[i]);
    //     for(size_t j = 0; j < 16; j++){
    //         memmove(res_NTT + (2 * i) + j * 32 + 0 * 16, permuteresp + i + j * 16, 16 * sizeof(int16_t));
    //         memmove(res_NTT + (2 * i) + j * 32 + 1 * 16, permuteresn + i + j * 16, 16 * sizeof(int16_t));
    //     }
    // }

// ================

    __asm_3x2_post(res_NTT, OMEGA3INV_buff, const_buff, twist96_inv_table);

// ================

    for(size_t i = 0; i < 96; i += 16){
        __asm_irader17_truncated(des + i, res_NTT + i, twiddle_irader17_full, twiddle_irader17_qinv_full, const_buff);
    }

}

void mulcore(int16_t *des, int16_t *src1, int16_t *src2){
    _mulcore(des, src1, src2);
}

void polymul(int16_t *des, int16_t *src1, int16_t *src2){

    int16x16_t scale;
    int16x16_t ti, tip, tip1;

    _mulcore(des, src1, src2);

    scale = dup_const_int16x16(FINAL_SCALE_Rmod);

    des[0] -= des[p - 1];
    for(size_t i = 0; i < 768; i += 16){
        ti = load_int16x16((int16x16_t*)(des + i));
        tip = load_int16x16((int16x16_t*)(des + i + p));
        tip1 = load_int16x16((int16x16_t*)(des + i + p - 1));
        ti = add_int16x16(ti, add_int16x16(tip, tip1));
        ti = montmulmod_int16x16(ti, scale);
        store_int16x16((int16x16_t*)(des + i), ti);
    }


}








