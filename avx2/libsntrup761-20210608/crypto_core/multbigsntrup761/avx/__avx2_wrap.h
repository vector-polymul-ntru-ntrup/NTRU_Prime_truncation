#ifndef __AVX2_WRAP_H
#define __AVX2_WRAP_H

#include "params.h"
#include <immintrin.h>

// ================================
// architecture-related wrapping

#define int16x16_t __m256i
#define dup_const_int16x16 _mm256_set1_epi16

#define load_int16x16 _mm256_loadu_si256
#define store_int16x16 _mm256_storeu_si256

#define mullo_int16x16 _mm256_mullo_epi16
#define mulhi_int16x16 _mm256_mulhi_epi16
#define mulhrs_int16x16 _mm256_mulhrs_epi16
#define add_int16x16 _mm256_add_epi16
#define sub_int16x16 _mm256_sub_epi16




#endif

