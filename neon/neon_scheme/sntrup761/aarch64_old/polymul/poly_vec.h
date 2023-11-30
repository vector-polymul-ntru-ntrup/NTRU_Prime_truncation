#ifndef POLY_VEC_H
#define POLY_VEC_H

#include <stddef.h>
#include <stdint.h>

#include <arm_neon.h>

int16x8_t cmod_int16x8(int16x8_t v);
int16x8_t mulmod_int16x8(int16x8_t a, int16x8_t b);

void schoolbook_corex8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, size_t len);
void weightedx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, int16x8_t zeta, size_t len);
void cyclicx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, size_t len);
void negacyclicx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, size_t len);
void schoolbook_Rmodx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, size_t len);
void cyclic_Rmodx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, size_t len);
void negacyclic_Rmodx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, size_t len);

void weighted_Rmodx8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2, 
                     int16x8_t wlo, int16x8_t whi, size_t len);
void weighted_Rmod_16x16_x8(int16x8_t *des, int16x8_t *src1, int16x8_t *src2,
                            int16x8_t wlo, int16x8_t whi);


extern void __asm_cyclic_basemul4x4(int16x8_t*, int16x8_t*, int16x8_t*, int16_t*);
extern void __asm_negacyclic_basemul4x4(int16x8_t*, int16x8_t*, int16x8_t*, int16_t*);
extern void __asm_cyclic_negacyclic_basemul4x4(int16x8_t*, int16x8_t*, int16x8_t*, int16_t*);
// 8x8 below
extern void __asm_schoolbook8x8(int16x8_t*, int16x8_t*, int16x8_t*);
extern void __asm_cyclic_basemul8x8(int16x8_t*, int16x8_t*, int16x8_t*, int16_t*);
extern void __asm_negacyclic_basemul8x8(int16x8_t*, int16x8_t*, int16x8_t*, int16_t*);

void interleave16x8(int16_t *des,
                int16_t *src0, int16_t *src1, int16_t *src2, int16_t *src3,
                int16_t *src4, int16_t *src5, int16_t *src6, int16_t *src7,
                size_t len);
void deinterleave16x8(int16_t *des0, int16_t *des1, int16_t *des2, int16_t *des3,
                      int16_t *des4, int16_t *des5, int16_t *des6, int16_t *des7,
                int16_t *src, size_t len);


#endif




