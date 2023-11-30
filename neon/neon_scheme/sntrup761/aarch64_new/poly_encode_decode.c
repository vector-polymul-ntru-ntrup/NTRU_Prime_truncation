
#include "params.h"
#include "poly_type.h"
#include "poly_encode_decode.h"
#include "Encode.h"
#include "Decode.h"
#include <arm_neon.h>

/* ----- encoding small polynomials (including short polynomials) */
static inline int16_t mullo(int16_t x, int16_t y)
{
  return x * y;
}

static inline int16_t mulhi(int16_t x, int16_t y)
{
  return (int16_t)((x * (int32_t)y) >> 16);
}

/* these are the only functions that rely on p mod 4 = 1 */

void Small_encode(unsigned char *s, const small *f)
{
  small x;
  int i;

  for (i = 0; i < p / 4; ++i)
  {
    x = *f++ + 1;
    x += (*f++ + 1) << 2;
    x += (*f++ + 1) << 4;
    x += (*f++ + 1) << 6;
    *s++ = x;
  }
  x = *f++ + 1;
  *s++ = x;
}

void Small_decode(small *f, const unsigned char *s)
{
  unsigned char x;
  int i;

  for (i = 0; i < p / 4; ++i)
  {
    x = *s++;
    *f++ = ((small)(x & 3)) - 1;
    x >>= 2;
    *f++ = ((small)(x & 3)) - 1;
    x >>= 2;
    *f++ = ((small)(x & 3)) - 1;
    x >>= 2;
    *f++ = ((small)(x & 3)) - 1;
  }
  x = *s++;
  *f++ = ((small)(x & 3)) - 1;
}

/* ----- encoding general polynomials */

void Rq_encode(unsigned char *s, const Fq *r)
{
  uint16 R[p], M[p];
  int i;

  for (i = 0; i < p; ++i)
    R[i] = r[i] + q12;
  for (i = 0; i < p; ++i)
    M[i] = q;
  Encode(s, R, M, p);
}

void Rq_encode_neon(unsigned char *s, const Fq *r)
{
  const int16_t *R0 = r;
  /* XXX: caller could overlap R with input */
  uint16_t R[381];
  long i;
  const uint16_t *reading;
  uint16_t *writing;
  uint16_t r0, r1;
  uint32_t r2;
  uint32_t s0;

  int16x8_t tmp;
  int32x4_t mask = {65535, 65535, 65535, 65535};
  int32x4_t N = {4591, 4591, 4591, 4591};
  uint8x16_t shuffle1 = {0, 1, 4, 5, 8, 9, 12, 13, 2, 3, 6, 7, 10, 11, 14, 15};
  uint8x16_t shuffle2 = {1, 2, 5, 6, 9, 10, 13, 14, 0, 4, 8, 12, 0, 4, 8, 12};

  int64x1_t tmp2, tmp3;

  int16x8_t x0, x1, x2, x3, y0, y1, y2, y3;

  reading = (uint16_t *)R0;
  writing = R;
  i = 24;
  while (i > 0)
  {
    --i;
    if (!i)
    {
      reading -= 8;
      writing -= 4;
      s -= 8;
    }
    x0 = (int16x8_t)vld1q_u16(reading + 0);
    x1 = (int16x8_t)vld1q_u16(reading + 8);
    x2 = (int16x8_t)vld1q_u16(reading + 16);
    x3 = (int16x8_t)vld1q_u16(reading + 24);

    tmp = vdupq_n_s16(2295);
    x0 = vaddq_s16(x0, tmp);
    x1 = vaddq_s16(x1, tmp);
    x2 = vaddq_s16(x2, tmp);
    x3 = vaddq_s16(x3, tmp);

    tmp = vdupq_n_s16(16383);
    x0 = vandq_s16(x0, tmp);
    x1 = vandq_s16(x1, tmp);
    x2 = vandq_s16(x2, tmp);
    x3 = vandq_s16(x3, tmp);

    y0 = vandq_s16(x0, (int16x8_t)mask);
    y1 = vandq_s16(x1, (int16x8_t)mask);
    y2 = vandq_s16(x2, (int16x8_t)mask);
    y3 = vandq_s16(x3, (int16x8_t)mask);

    x0 = (int16x8_t)vshrq_n_s32((int32x4_t)x0, 16);
    x1 = (int16x8_t)vshrq_n_s32((int32x4_t)x1, 16);
    x2 = (int16x8_t)vshrq_n_s32((int32x4_t)x2, 16);
    x3 = (int16x8_t)vshrq_n_s32((int32x4_t)x3, 16);

    x0 = (int16x8_t)vmulq_s32((int32x4_t)x0, N);
    x1 = (int16x8_t)vmulq_s32((int32x4_t)x1, N);
    x2 = (int16x8_t)vmulq_s32((int32x4_t)x2, N);
    x3 = (int16x8_t)vmulq_s32((int32x4_t)x3, N);

    x0 = (int16x8_t)vaddq_s32((int32x4_t)y0, (int32x4_t)x0);
    x1 = (int16x8_t)vaddq_s32((int32x4_t)y1, (int32x4_t)x1);
    x2 = (int16x8_t)vaddq_s32((int32x4_t)y2, (int32x4_t)x2);
    x3 = (int16x8_t)vaddq_s32((int32x4_t)y3, (int32x4_t)x3);

    x0 = (int16x8_t)vqtbl1q_s8((int8x16_t)x0, shuffle1);
    x1 = (int16x8_t)vqtbl1q_s8((int8x16_t)x1, shuffle1);
    x2 = (int16x8_t)vqtbl1q_s8((int8x16_t)x2, shuffle1);
    x3 = (int16x8_t)vqtbl1q_s8((int8x16_t)x3, shuffle1);

    tmp2 = vget_high_s64((int64x2_t)x0);
    tmp3 = vget_low_s64((int64x2_t)x1);
    x0 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x0), tmp3);
    x1 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x1));

    tmp2 = vget_high_s64((int64x2_t)x2);
    tmp3 = vget_low_s64((int64x2_t)x3);
    x2 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x2), tmp3);
    x3 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x3));

    vst1q_u16(writing, (uint16x8_t)x1);
    vst1q_u16(writing + 8, (uint16x8_t)x3);
    vst1q_u8(s, (uint8x16_t)x0);
    vst1q_u8(s + 16, (uint8x16_t)x2);

    reading += 32;
    writing += 16;
    s += 32;
  }

  R[380] = (uint16_t)(((R0[760] + 2295) & 16383));
  reading = (uint16_t *)R;
  writing = R;
  i = 24;
  while (i > 0)
  {

    --i;
    if (!i)
    {
      reading -= 4;
      writing -= 2;
      s -= 2;
    }
    x0 = (int16x8_t)vld1q_u16(reading);
    x1 = (int16x8_t)vld1q_u16(reading + 8);
    y0 = vandq_s16(x0, (int16x8_t)mask);
    y1 = vandq_s16(x1, (int16x8_t)mask);

    x0 = (int16x8_t)vshrq_n_s32((int32x4_t)x0, 16);
    x1 = (int16x8_t)vshrq_n_s32((int32x4_t)x1, 16);

    tmp = (int16x8_t)vdupq_n_s32(322);
    x0 = (int16x8_t)vmulq_s32((int32x4_t)x0, (int32x4_t)tmp);
    x1 = (int16x8_t)vmulq_s32((int32x4_t)x1, (int32x4_t)tmp);

    x0 = (int16x8_t)vaddq_s32((int32x4_t)x0, (int32x4_t)y0);
    x1 = (int16x8_t)vaddq_s32((int32x4_t)x1, (int32x4_t)y1);

    x0 = (int16x8_t)vqtbl1q_s8((int8x16_t)x0, shuffle2);
    x1 = (int16x8_t)vqtbl1q_s8((int8x16_t)x1, shuffle2);

    tmp2 = vget_high_s64((int64x2_t)x0);
    tmp3 = vget_low_s64((int64x2_t)x1);
    x0 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x0), tmp3);
    x1 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x1));

    vst1q_u16(writing, (uint16x8_t)x0);
    s0 = vgetq_lane_u32((uint32x4_t)x1, 0);

    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;

    s0 = vgetq_lane_u32((uint32x4_t)x1, 2);
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    reading += 16;
    writing += 8;
  }
  R[190] = R[380];

  reading = (uint16_t *)R;
  writing = R;
  i = 12;
  while (i > 0)
  {
    --i;
    if (!i)
    {
      reading -= 2;
      writing -= 1;
      s -= 1;
    }
    x0 = (int16x8_t)vld1q_u16(reading);
    x1 = (int16x8_t)vld1q_u16(reading + 8);
    y0 = vandq_s16(x0, (int16x8_t)mask);
    y1 = vandq_s16(x1, (int16x8_t)mask);

    x0 = (int16x8_t)vshrq_n_s32((int32x4_t)x0, 16);
    x1 = (int16x8_t)vshrq_n_s32((int32x4_t)x1, 16);

    tmp = (int16x8_t)vdupq_n_s32(406);
    x0 = (int16x8_t)vmulq_s32((int32x4_t)x0, (int32x4_t)tmp);
    x1 = (int16x8_t)vmulq_s32((int32x4_t)x1, (int32x4_t)tmp);

    x0 = (int16x8_t)vaddq_s32((int32x4_t)x0, (int32x4_t)y0);
    x1 = (int16x8_t)vaddq_s32((int32x4_t)x1, (int32x4_t)y1);

    x0 = (int16x8_t)vqtbl1q_s8((int8x16_t)x0, shuffle2);
    x1 = (int16x8_t)vqtbl1q_s8((int8x16_t)x1, shuffle2);

    tmp2 = vget_high_s64((int64x2_t)x0);
    tmp3 = vget_low_s64((int64x2_t)x1);
    x0 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x0), tmp3);
    x1 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x1));

    vst1q_u16(writing, (uint16x8_t)x0);
    s0 = vgetq_lane_u32((uint32x4_t)x1, 0);

    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;

    s0 = vgetq_lane_u32((uint32x4_t)x1, 2);
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    reading += 16;
    writing += 8;
  }
  R[95] = R[190];

  reading = (uint16_t *)R;
  writing = R;
  i = 6;
  while (i > 0)
  {
    --i;
    x0 = (int16x8_t)vld1q_u16(reading);
    x1 = (int16x8_t)vld1q_u16(reading + 8);
    y0 = vandq_s16(x0, (int16x8_t)mask);
    y1 = vandq_s16(x1, (int16x8_t)mask);

    x0 = (int16x8_t)vshrq_n_s32((int32x4_t)x0, 16);
    x1 = (int16x8_t)vshrq_n_s32((int32x4_t)x1, 16);

    tmp = (int16x8_t)vdupq_n_s32(644);
    x0 = (int16x8_t)vmulq_s32((int32x4_t)x0, (int32x4_t)tmp);
    x1 = (int16x8_t)vmulq_s32((int32x4_t)x1, (int32x4_t)tmp);

    x0 = (int16x8_t)vaddq_s32((int32x4_t)y0, (int32x4_t)x0);
    x1 = (int16x8_t)vaddq_s32((int32x4_t)y1, (int32x4_t)x1);

    x0 = (int16x8_t)vqtbl1q_s8((int8x16_t)x0, shuffle2);
    x1 = (int16x8_t)vqtbl1q_s8((int8x16_t)x1, shuffle2);

    tmp2 = vget_high_s64((int64x2_t)x0);
    tmp3 = vget_low_s64((int64x2_t)x1);
    x0 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x0), tmp3);
    x1 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x1));

    vst1q_u16(writing, (uint16x8_t)x0);
    s0 = vgetq_lane_u32((uint32x4_t)x1, 0);

    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;

    s0 = vgetq_lane_u32((uint32x4_t)x1, 2);
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    reading += 16;
    writing += 8;
  }

  reading = (uint16_t *)R;
  writing = R;
  i = 3;
  while (i > 0)
  {
    --i;
    if (!i)
    {
      reading -= 2;
      writing -= 1;
      s -= 1;
    }
    x0 = (int16x8_t)vld1q_u16(reading);
    x1 = (int16x8_t)vld1q_u16(reading + 8);
    y0 = vandq_s16(x0, (int16x8_t)mask);
    y1 = vandq_s16(x1, (int16x8_t)mask);

    x0 = (int16x8_t)vshrq_n_s32((int32x4_t)x0, 16);
    x1 = (int16x8_t)vshrq_n_s32((int32x4_t)x1, 16);

    tmp = (int16x8_t)vdupq_n_s32(1621);
    x0 = (int16x8_t)vmulq_s32((int32x4_t)x0, (int32x4_t)tmp);
    x1 = (int16x8_t)vmulq_s32((int32x4_t)x1, (int32x4_t)tmp);

    x0 = (int16x8_t)vaddq_s32((int32x4_t)x0, (int32x4_t)y0);
    x1 = (int16x8_t)vaddq_s32((int32x4_t)x1, (int32x4_t)y1);

    x0 = (int16x8_t)vqtbl1q_s8((int8x16_t)x0, shuffle2);
    x1 = (int16x8_t)vqtbl1q_s8((int8x16_t)x1, shuffle2);

    tmp2 = vget_high_s64((int64x2_t)x0);
    tmp3 = vget_low_s64((int64x2_t)x1);
    x0 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x0), tmp3);
    x1 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x1));

    vst1q_u16(writing, (uint16x8_t)x0);
    s0 = vgetq_lane_u32((uint32x4_t)x1, 0);

    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;

    s0 = vgetq_lane_u32((uint32x4_t)x1, 2);
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    reading += 16;
    writing += 8;
  }
  r0 = R[46];
  r1 = R[47];
  r2 = r0 + r1 * (uint32_t)1621;
  *s++ = (unsigned char)r2;
  r2 >>= 8;
  *s++ = (unsigned char)r2;
  r2 >>= 8;
  R[23] = (uint16_t)r2;

  for (i = 0; i < 11; ++i)
  {
    r0 = R[2 * i];
    r1 = R[2 * i + 1];
    r2 = r0 + r1 * (uint32_t)10265;
    *s++ = (unsigned char)r2;
    r2 >>= 8;
    *s++ = (unsigned char)r2;
    r2 >>= 8;
    R[i] = (uint16_t)r2;
  }
  r0 = R[22];
  r1 = R[23];
  r2 = r0 + r1 * (uint32_t)10265;
  *s++ = (unsigned char)r2;
  r2 >>= 8;
  R[11] = (uint16_t)r2;

  for (i = 0; i < 5; ++i)
  {
    r0 = R[2 * i];
    r1 = R[2 * i + 1];
    r2 = r0 + r1 * (uint32_t)1608;
    *s++ = (unsigned char)r2;
    r2 >>= 8;
    R[i] = (uint16_t)r2;
  }
  r0 = R[10];
  r1 = R[11];
  r2 = r0 + r1 * (uint32_t)1608;
  *s++ = (unsigned char)r2;
  r2 >>= 8;
  *s++ = (unsigned char)r2;
  r2 >>= 8;
  R[5] = (uint16_t)r2;

  for (i = 0; i < 2; ++i)
  {
    r0 = R[2 * i];
    r1 = R[2 * i + 1];
    r2 = r0 + r1 * (uint32_t)10101;
    *s++ = (unsigned char)r2;
    r2 >>= 8;
    *s++ = (unsigned char)r2;
    r2 >>= 8;
    R[i] = (uint16_t)r2;
  }
  r0 = R[4];
  r1 = R[5];
  r2 = r0 + r1 * (uint32_t)10101;
  *s++ = (unsigned char)r2;
  r2 >>= 8;
  R[2] = (uint16_t)r2;

  r0 = R[0];
  r1 = R[1];
  r2 = r0 + r1 * (uint32_t)1557;
  *s++ = (unsigned char)r2;
  r2 >>= 8;
  R[0] = (uint16_t)r2;
  R[1] = R[2];

  r0 = R[0];
  r1 = R[1];
  r2 = r0 + r1 * (uint32_t)9470;
  *s++ = (unsigned char)r2;
  r2 >>= 8;
  *s++ = (unsigned char)r2;
  r2 >>= 8;
  R[0] = (uint16_t)r2;
  r0 = R[0];
  *s++ = (unsigned char)r0;
  r0 >>= 8;
  *s++ = (unsigned char)r0;
}

void Rq_decode(Fq *r, const unsigned char *s)
{
  uint16 R[p], M[p];
  int i;

  for (i = 0; i < p; ++i)
    M[i] = q;
  Decode(R, s, M, p);
  for (i = 0; i < p; ++i)
    r[i] = ((Fq)R[i]) - q12;
}

void Rq_decode_neon(Fq *v, const unsigned char *s)
{
  int16_t *R0 = v;
  int16_t R1[381], R2[191], R3[96], R4[48], R5[24], R6[12], R7[6], R8[3], R9[2], R10[1];
  long long i;
  int16_t a0, a1, a2;

  int16x8_t A00, A01, A10, A11, A20, A21;
  int16x8_t S00, S01, S10, S11;
  int16x8_t B00, B01, B10, B11;
  int16x8_t tmp, tmp2;

  s += 1158;
  a1 = 0;
  a1 += *--s; /* 0...255 */
  a1 = mulhi(a1, -656) - mulhi(mullo(a1, -10434), 1608);
  a1 += *--s;              /* -804...1056 */
  a1 += (a1 >> 15) & 1608; /* 0...1607 */
  R10[0] = a1;

  /* R10 ------> R9: reconstruct mod 1*[9470]+[11127] */

  i = 0;
  s -= 2;
  a2 = a0 = R10[0];
  a0 = mulhi(a0, -3624) - mulhi(mullo(a0, -1772), 9470); /* -5641...4735 */
  a0 += s[2 * i + 1];                                    /* -5641...4990 */
  a0 = mulhi(a0, -3624) - mulhi(mullo(a0, -1772), 9470); /* -5011...5046 */
  a0 += s[2 * i + 0];                                    /* -5011...5301 */
  a0 += (a0 >> 15) & 9470;                               /* 0...9469 */
  a1 = (int16_t)((a2 << 15) + (s[2 * i + 1] << 7) + ((s[2 * i] - a0) >> 1));
  a1 = mullo(a1, -21121);

  /* invalid inputs might need reduction mod 11127 */
  a1 -= 11127;
  a1 += (a1 >> 15) & 11127;

  R9[0] = a0;
  R9[1] = a1;
  s -= 0;

  /* R9 ------> R8: reconstruct mod 2*[1557]+[11127] */

  R8[2] = R9[1];
  s -= 1;
  for (i = 0; i >= 0; --i)
  {
    a2 = a0 = R9[i];
    a0 = mulhi(a0, 541) - mulhi(mullo(a0, -10775), 1557); /* -779...913 */
    a0 += s[1 * i + 0];                                   /* -779...1168 */
    a0 += (a0 >> 15) & 1557;                              /* 0...1556 */
    a1 = (int16_t)((a2 << 8) + s[i] - a0);
    a1 = mullo(a1, -26307);

    /* invalid inputs might need reduction mod 1557 */
    a1 -= 1557;
    a1 += (a1 >> 15) & 1557;

    R8[2 * i] = a0;
    R8[2 * i + 1] = a1;
  }

  /* R8 ------> R7: reconstruct mod 5*[10101]+[282] */

  i = 0;
  s -= 1;
  a2 = a0 = R8[2];
  a0 = mulhi(a0, -545) - mulhi(mullo(a0, -1661), 10101); /* -5187...5050 */
  a0 += s[1 * i + 0];                                    /* -5187...5305 */
  a0 += (a0 >> 15) & 10101;                              /* 0...10100 */
  a1 = (int16_t)((a2 << 8) + s[i] - a0);
  a1 = mullo(a1, 12509);

  /* invalid inputs might need reduction mod 282 */
  a1 -= 282;
  a1 += (a1 >> 15) & 282;

  R7[4] = a0;
  R7[5] = a1;
  s -= 4;
  for (i = 1; i >= 0; --i)
  {
    a0 = R8[i];
    a0 = mulhi(a0, -545) - mulhi(mullo(a0, -1661), 10101); /* -5187...5050 */
    a0 += s[2 * i + 1];                                    /* -5187...5305 */
    a0 = mulhi(a0, -545) - mulhi(mullo(a0, -1661), 10101); /* -5095...5093 */
    a0 += s[2 * i + 0];                                    /* -5095...5348 */
    a0 += (a0 >> 15) & 10101;                              /* 0...10100 */
    a1 = (int16_t)((s[2 * i + 1] << 8) + s[2 * i] - a0);
    a1 = mullo(a1, 12509);

    /* invalid inputs might need reduction mod 10101 */
    a1 -= 10101;
    a1 += (a1 >> 15) & 10101;

    R7[2 * i] = a0;
    R7[2 * i + 1] = a1;
  }

  /* R7 ------> R6: reconstruct mod 11*[1608]+[11468] */

  i = 0;
  s -= 2;
  a2 = a0 = R7[5];
  a0 = mulhi(a0, -656) - mulhi(mullo(a0, -10434), 1608); /* -968...804 */
  a0 += s[2 * i + 1];                                    /* -968...1059 */
  a0 = mulhi(a0, -656) - mulhi(mullo(a0, -10434), 1608); /* -815...813 */
  a0 += s[2 * i + 0];                                    /* -815...1068 */
  a0 += (a0 >> 15) & 1608;                               /* 0...1607 */
  a1 = (int16_t)((a2 << 13) + (s[2 * i + 1] << 5) + ((s[2 * i] - a0) >> 3));
  a1 = mullo(a1, 6521);

  /* invalid inputs might need reduction mod 11468 */
  a1 -= 11468;
  a1 += (a1 >> 15) & 11468;

  R6[10] = a0;
  R6[11] = a1;
  s -= 5;
  for (i = 4; i >= 0; --i)
  {
    a2 = a0 = R7[i];
    a0 = mulhi(a0, -656) - mulhi(mullo(a0, -10434), 1608); /* -968...804 */
    a0 += s[1 * i + 0];                                    /* -968...1059 */
    a0 += (a0 >> 15) & 1608;                               /* 0...1607 */
    a1 = (int16_t)((a2 << 5) + ((s[i] - a0) >> 3));
    a1 = mullo(a1, 6521);

    /* invalid inputs might need reduction mod 1608 */
    a1 -= 1608;
    a1 += (a1 >> 15) & 1608;

    R6[2 * i] = a0;
    R6[2 * i + 1] = a1;
  }

  /* R6 ------> R5: reconstruct mod 23*[10265]+[286] */

  i = 0;
  s -= 1;
  a2 = a0 = R6[11];
  a0 = mulhi(a0, 4206) - mulhi(mullo(a0, -1634), 10265); /* -5133...6184 */
  a0 += s[1 * i + 0];                                    /* -5133...6439 */
  a0 += (a0 >> 15) & 10265;                              /* 0...10264 */
  a1 = (int16_t)((a2 << 8) + s[i] - a0);
  a1 = mullo(a1, -19415);

  /* invalid inputs might need reduction mod 286 */
  a1 -= 286;
  a1 += (a1 >> 15) & 286;

  R5[22] = a0;
  R5[23] = a1;
  s -= 22;
  for (i = 10; i >= 0; --i)
  {
    a0 = R6[i];
    a0 = mulhi(a0, 4206) - mulhi(mullo(a0, -1634), 10265); /* -5133...6184 */
    a0 += s[2 * i + 1];                                    /* -5133...6439 */
    a0 = mulhi(a0, 4206) - mulhi(mullo(a0, -1634), 10265); /* -5462...5545 */
    a0 += s[2 * i + 0];                                    /* -5462...5800 */
    a0 += (a0 >> 15) & 10265;                              /* 0...10264 */
    a1 = (int16_t)((s[2 * i + 1] << 8) + s[2 * i] - a0);
    a1 = mullo(a1, -19415);

    /* invalid inputs might need reduction mod 10265 */
    a1 -= 10265;
    a1 += (a1 >> 15) & 10265;

    R5[2 * i] = a0;
    R5[2 * i + 1] = a1;
  }

  /* R5 ------> R4: reconstruct mod 47*[1621]+[11550] */

  i = 0;
  s -= 2;
  a0 = R5[23];
  a0 = mulhi(a0, -134) - mulhi(mullo(a0, -10350), 1621); /* -844...810 */
  a0 += s[2 * i + 1];                                    /* -844...1065 */
  a0 = mulhi(a0, -134) - mulhi(mullo(a0, -10350), 1621); /* -813...812 */
  a0 += s[2 * i + 0];                                    /* -813...1067 */
  a0 += (a0 >> 15) & 1621;                               /* 0...1620 */
  a1 = (int16_t)((s[2 * i + 1] << 8) + s[2 * i] - a0);
  a1 = mullo(a1, -14595);

  /* invalid inputs might need reduction mod 11550 */
  a1 -= 11550;
  a1 += (a1 >> 15) & 11550;

  R4[46] = a0;
  R4[47] = a1;
  s -= 23;
  i = 7;

  for (;;)
  {
    A20 = A00 = vld1q_s16(&(R5[i]));
    A21 = A01 = vld1q_s16(&(R5[i + 8]));

    S00 = (int16x8_t)vmovl_u8(vld1_u8(s + i));
    S01 = (int16x8_t)vmovl_u8(vld1_u8(s + i + 8));

    tmp2 = vmulq_s16(A00, vdupq_n_s16(-10350));
    tmp = vdupq_n_s16(1621);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(-67)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(-10350));
    tmp = vdupq_n_s16(1621);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(-67)), tmp);

    A00 = vaddq_s16(A00, S00);
    A01 = vaddq_s16(A01, S01);

    tmp = vdupq_n_s16(1621);
    A00 = vaddq_s16(A00, vandq_s16(vshrq_n_s16(A00, 15), tmp));
    A01 = vaddq_s16(A01, vandq_s16(vshrq_n_s16(A01, 15), tmp));

    A10 = vaddq_s16(vshlq_n_s16(A20, 8), vsubq_s16(S00, A00));
    A11 = vaddq_s16(vshlq_n_s16(A21, 8), vsubq_s16(S01, A01));

    tmp = vdupq_n_s16(-14595);
    A10 = vmulq_s16(A10, tmp);
    A11 = vmulq_s16(A11, tmp);

    A10 = vsubq_s16(A10, vandq_s16((int16x8_t)vcgtq_s16(A10, vdupq_n_s16(1620)), vdupq_n_s16(1621)));
    A11 = vsubq_s16(A11, vandq_s16((int16x8_t)vcgtq_s16(A11, vdupq_n_s16(1620)), vdupq_n_s16(1621)));

    B00 = vzip1q_s16(A00, A10);
    B10 = vzip2q_s16(A00, A10);

    B01 = vzip1q_s16(A01, A11);
    B11 = vzip2q_s16(A01, A11);

    vst1q_s16(&R4[2 * i], B00);
    vst1q_s16(&R4[2 * i] + 8, B10);
    vst1q_s16(&R4[2 * i] + 16, B01);
    vst1q_s16(&R4[2 * i] + 24, B11);
    if (!i)
    {
      break;
    }
    i = -16 - ((~15) & -i);
  }
  i = 0;
  s -= 1;
  a2 = a0 = R4[47];
  a0 = mulhi(a0, -272) - mulhi(mullo(a0, -26052), 644); /* -390...322 */
  a0 += s[1 * i + 0];                                   /* -390...577 */
  a0 += (a0 >> 15) & 644;                               /* 0...643 */
  a1 = (int16_t)((a2 << 6) + ((s[i] - a0) >> 2));
  a1 = mullo(a1, -7327);

  /* invalid inputs might need reduction mod 4591 */
  a1 -= 4591;
  a1 += (a1 >> 15) & 4591;

  R3[94] = a0;
  R3[95] = a1;
  s -= 47;
  i = 31;
  for (;;)
  {
    A20 = A00 = vld1q_s16(&(R4[i]));
    A21 = A01 = vld1q_s16(&(R4[i + 8]));

    S00 = (int16x8_t)vmovl_u8(vld1_u8(s + i));
    S01 = (int16x8_t)vmovl_u8(vld1_u8(s + i + 8));

    tmp2 = vmulq_s16(A00, vdupq_n_s16(-26052));
    tmp = vdupq_n_s16(644);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(-136)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(-26052));
    tmp = vdupq_n_s16(644);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(-136)), tmp);

    A00 = vaddq_s16(A00, S00);
    A01 = vaddq_s16(A01, S01);

    tmp = vdupq_n_s16(644);
    A00 = vaddq_s16(A00, vandq_s16(vshrq_n_s16(A00, 15), tmp));
    A01 = vaddq_s16(A01, vandq_s16(vshrq_n_s16(A01, 15), tmp));

    A10 = vaddq_s16(vshlq_n_s16(A20, 6), vshrq_n_s16(vsubq_s16(S00, A00), 2));
    A11 = vaddq_s16(vshlq_n_s16(A21, 6), vshrq_n_s16(vsubq_s16(S01, A01), 2));

    tmp = vdupq_n_s16(-7327);
    A10 = vmulq_s16(A10, tmp);
    A11 = vmulq_s16(A11, tmp);

    A10 = vsubq_s16(A10, vandq_s16((int16x8_t)vcgtq_s16(A10, vdupq_n_s16(643)), vdupq_n_s16(644)));
    A11 = vsubq_s16(A11, vandq_s16((int16x8_t)vcgtq_s16(A11, vdupq_n_s16(643)), vdupq_n_s16(644)));

    B00 = vzip1q_s16(A00, A10);
    B10 = vzip2q_s16(A00, A10);

    B01 = vzip1q_s16(A01, A11);
    B11 = vzip2q_s16(A01, A11);

    vst1q_s16(&R3[2 * i], B00);
    vst1q_s16(&R3[2 * i] + 8, B10);
    vst1q_s16(&R3[2 * i] + 16, B01);
    vst1q_s16(&R3[2 * i] + 24, B11);

    if (!i)
    {
      break;
    }
    i = -16 - ((~15) & -i);
  }
  R2[190] = R3[95];
  s -= 95;
  i = 79;
  for (;;)
  {
    A20 = A00 = vld1q_s16(&(R3[i]));
    A21 = A01 = vld1q_s16(&(R3[i + 8]));

    S00 = (int16x8_t)vmovl_u8(vld1_u8(s + i));
    S01 = (int16x8_t)vmovl_u8(vld1_u8(s + i + 8));

    tmp2 = vmulq_s16(A00, vdupq_n_s16(24213));
    tmp = vdupq_n_s16(406);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(39)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(24213));
    tmp = vdupq_n_s16(406);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(39)), tmp);

    A00 = vaddq_s16(A00, S00);
    A01 = vaddq_s16(A01, S01);

    tmp = vdupq_n_s16(406);
    A00 = vsubq_s16(A00, tmp);
    A01 = vsubq_s16(A01, tmp);

    A00 = vaddq_s16(A00, vandq_s16(vshrq_n_s16(A00, 15), tmp));
    A01 = vaddq_s16(A01, vandq_s16(vshrq_n_s16(A01, 15), tmp));

    A00 = vaddq_s16(A00, vandq_s16(vshrq_n_s16(A00, 15), tmp));
    A01 = vaddq_s16(A01, vandq_s16(vshrq_n_s16(A01, 15), tmp));

    A10 = vaddq_s16(vshlq_n_s16(A20, 7), vshrq_n_s16(vsubq_s16(S00, A00), 1));
    A11 = vaddq_s16(vshlq_n_s16(A21, 7), vshrq_n_s16(vsubq_s16(S01, A01), 1));

    tmp = vdupq_n_s16(25827);
    A10 = vmulq_s16(A10, tmp);
    A11 = vmulq_s16(A11, tmp);

    A10 = vsubq_s16(A10, vandq_s16((int16x8_t)vcgtq_s16(A10, vdupq_n_s16(405)), vdupq_n_s16(406)));
    A11 = vsubq_s16(A11, vandq_s16((int16x8_t)vcgtq_s16(A11, vdupq_n_s16(405)), vdupq_n_s16(406)));

    B00 = vzip1q_s16(A00, A10);
    B10 = vzip2q_s16(A00, A10);

    B01 = vzip1q_s16(A01, A11);
    B11 = vzip2q_s16(A01, A11);

    vst1q_s16(&R2[2 * i], B00);
    vst1q_s16(&R2[2 * i] + 8, B10);
    vst1q_s16(&R2[2 * i] + 16, B01);
    vst1q_s16(&R2[2 * i] + 24, B11);

    if (!i)
    {
      break;
    }
    i = -16 - ((~15) & -i);
  }
  R1[380] = R2[190];
  s -= 190;
  i = 174;

  for (;;)
  {
    A20 = A00 = vld1q_s16(&(R2[i]));
    A21 = A01 = vld1q_s16(&(R2[i + 8]));

    S00 = (int16x8_t)vmovl_u8(vld1_u8(s + i));
    S01 = (int16x8_t)vmovl_u8(vld1_u8(s + i + 8));

    tmp2 = vmulq_s16(A00, vdupq_n_s16(13433));
    tmp = vdupq_n_s16(322);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(25)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(13433));
    tmp = vdupq_n_s16(322);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(25)), tmp);

    A00 = vaddq_s16(A00, S00);
    A01 = vaddq_s16(A01, S01);

    tmp = vdupq_n_s16(322);
    A00 = vsubq_s16(A00, tmp);
    A01 = vsubq_s16(A01, tmp);

    A00 = vaddq_s16(A00, vandq_s16(vshrq_n_s16(A00, 15), tmp));
    A01 = vaddq_s16(A01, vandq_s16(vshrq_n_s16(A01, 15), tmp));

    A00 = vaddq_s16(A00, vandq_s16(vshrq_n_s16(A00, 15), tmp));
    A01 = vaddq_s16(A01, vandq_s16(vshrq_n_s16(A01, 15), tmp));

    A10 = vaddq_s16(vshlq_n_s16(A20, 7), vshrq_n_s16(vsubq_s16(S00, A00), 1));
    A11 = vaddq_s16(vshlq_n_s16(A21, 7), vshrq_n_s16(vsubq_s16(S01, A01), 1));

    tmp = vdupq_n_s16(-7327);
    A10 = vmulq_s16(A10, tmp);
    A11 = vmulq_s16(A11, tmp);

    A10 = vsubq_s16(A10, vandq_s16((int16x8_t)vcgtq_s16(A10, vdupq_n_s16(321)), vdupq_n_s16(322)));
    A11 = vsubq_s16(A11, vandq_s16((int16x8_t)vcgtq_s16(A11, vdupq_n_s16(321)), vdupq_n_s16(322)));

    B00 = vzip1q_s16(A00, A10);
    B10 = vzip2q_s16(A00, A10);

    B01 = vzip1q_s16(A01, A11);
    B11 = vzip2q_s16(A01, A11);

    vst1q_s16(&R1[2 * i], B00);
    vst1q_s16(&R1[2 * i] + 8, B10);
    vst1q_s16(&R1[2 * i] + 16, B01);
    vst1q_s16(&R1[2 * i] + 24, B11);

    if (!i)
    {
      break;
    }
    i = -16 - ((~15) & -i);
  }
  R0[760] = R1[380] - 2295;
  s -= 760;
  i = 364;
  for (;;)
  {
    A00 = vld1q_s16(&(R1[i]));
    A01 = vld1q_s16(&(R1[i + 8]));

    S00 = (int16x8_t)vld1q_u8(s + 2 * i);
    S01 = (int16x8_t)vld1q_u8(s + 2 * i + 16);

    S10 = (int16x8_t)vshrq_n_u16((uint16x8_t)S00, 8);
    S11 = (int16x8_t)vshrq_n_u16((uint16x8_t)S01, 8);

    tmp = vdupq_n_s16(255);
    S00 = vandq_s16(S00, tmp);
    S01 = vandq_s16(S01, tmp);

    tmp2 = vmulq_s16(A00, vdupq_n_s16(-3654));
    tmp = vdupq_n_s16(4591);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(851)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(-3654));
    tmp = vdupq_n_s16(4591);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(851)), tmp);

    A00 = vaddq_s16(A00, S10);
    A01 = vaddq_s16(A01, S11);

    tmp2 = vmulq_s16(A00, vdupq_n_s16(-3654));
    tmp = vdupq_n_s16(4591);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(851)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(-3654));
    tmp = vdupq_n_s16(4591);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(851)), tmp);

    A00 = vaddq_s16(A00, S00);
    A01 = vaddq_s16(A01, S01);

    tmp = vdupq_n_s16(4591);
    A00 = vaddq_s16(A00, vandq_s16(vshrq_n_s16(A00, 15), tmp));
    A01 = vaddq_s16(A01, vandq_s16(vshrq_n_s16(A01, 15), tmp));

    A10 = vaddq_s16(vshlq_n_s16(S10, 8), vsubq_s16(S00, A00));
    A11 = vaddq_s16(vshlq_n_s16(S11, 8), vsubq_s16(S01, A01));

    tmp = vdupq_n_s16(15631);
    A10 = vmulq_s16(A10, tmp);
    A11 = vmulq_s16(A11, tmp);

    A10 = vsubq_s16(A10, vandq_s16((int16x8_t)vcgtq_s16(A10, vdupq_n_s16(4590)), vdupq_n_s16(4591)));
    A11 = vsubq_s16(A11, vandq_s16((int16x8_t)vcgtq_s16(A11, vdupq_n_s16(4590)), vdupq_n_s16(4591)));

    tmp = vdupq_n_s16(2295);
    A00 = vsubq_s16(A00, tmp);
    A01 = vsubq_s16(A01, tmp);
    A10 = vsubq_s16(A10, tmp);
    A11 = vsubq_s16(A11, tmp);

    B00 = vzip1q_s16(A00, A10);
    B10 = vzip2q_s16(A00, A10);

    B01 = vzip1q_s16(A01, A11);
    B11 = vzip2q_s16(A01, A11);

    vst1q_s16(&R0[2 * i], B00);
    vst1q_s16(&R0[2 * i] + 8, B10);
    vst1q_s16(&R0[2 * i] + 16, B01);
    vst1q_s16(&R0[2 * i] + 24, B11);
    if (!i)
    {
      break;
    }
    i = -16 - ((~15) & -i);
  }
}

/* ----- encoding rounded polynomials */

void Rounded_encode(unsigned char *s, const Fq *r)
{
  uint16 R[p], M[p];
  int i;

  for (i = 0; i < p; ++i)
    R[i] = ((r[i] + q12) * 10923) >> 15;
  for (i = 0; i < p; ++i)
    M[i] = (q + 2) / 3;
  Encode(s, R, M, p);
}

void Rounded_encode_neon(unsigned char *s, const int16_t *r)
{
  const int16_t *R0 = r;
  /* XXX: caller could overlap R with input */
  uint16_t R[381];
  long i;
  const uint16_t *reading;
  uint16_t *writing;
  uint16_t r0, r1;
  uint32_t r2;
  uint32_t s0;

  reading = (uint16_t *)R0;
  writing = R;
  i = 48;

  int16x8_t x0, x1, y0, y1;
  int16x8_t x2, x3, y2, y3;

  int16x8_t tmp;
  int64x1_t tmp2, tmp3;
  int16x8_t tmp4, tmp5;

  int32x4_t mask = {65535, 65535, 65535, 65535};

  uint8x16_t shuffle1 = {0, 1, 4, 5, 8, 9, 12, 13, 2, 3, 6, 7, 10, 11, 14, 15};
  uint8x16_t shuffle2 = {1, 2, 5, 6, 9, 10, 13, 14, 0, 4, 8, 12, 0, 4, 8, 12};

  while (i > 0)
  {
    --i;
    if (!i)
    {
      reading -= 8;
      writing -= 4;
      s -= 4;
    }
    x0 = (int16x8_t)vld1q_u16(reading + 0);
    x1 = (int16x8_t)vld1q_u16(reading + 8);

    tmp = vdupq_n_s16(10923);
    x0 = vqrdmulhq_s16(x0, tmp);
    x1 = vqrdmulhq_s16(x1, tmp);

    tmp4 = vaddq_s16(x0, x0);
    tmp5 = vaddq_s16(x1, x1);

    x0 = vaddq_s16(x0, tmp4);
    x1 = vaddq_s16(x1, tmp5);

    tmp = vdupq_n_s16(2295);
    x0 = vaddq_s16(x0, tmp);
    x1 = vaddq_s16(x1, tmp);

    tmp = vdupq_n_s16(16383);
    x0 = vandq_s16(x0, tmp);
    x1 = vandq_s16(x1, tmp);

    tmp = vdupq_n_s16(10923);
    x0 = vqdmulhq_s16(x0, tmp);
    x1 = vqdmulhq_s16(x1, tmp);

    y0 = vandq_s16(x0, (int16x8_t)mask);
    y1 = vandq_s16(x1, (int16x8_t)mask);

    x0 = (int16x8_t)vshrq_n_s32((int32x4_t)x0, 16);
    x1 = (int16x8_t)vshrq_n_s32((int32x4_t)x1, 16);

    tmp = (int16x8_t)vdupq_n_s32(1531);
    x0 = (int16x8_t)vmulq_s32((int32x4_t)x0, (int32x4_t)tmp);
    x1 = (int16x8_t)vmulq_s32((int32x4_t)x1, (int32x4_t)tmp);

    x0 = (int16x8_t)vaddq_s32((int32x4_t)y0, (int32x4_t)x0);
    x1 = (int16x8_t)vaddq_s32((int32x4_t)y1, (int32x4_t)x1);

    x0 = (int16x8_t)vqtbl1q_s8((int8x16_t)x0, shuffle2);
    x1 = (int16x8_t)vqtbl1q_s8((int8x16_t)x1, shuffle2);

    tmp2 = vget_high_s64((int64x2_t)x0);
    tmp3 = vget_low_s64((int64x2_t)x1);
    x0 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x0), tmp3);
    x1 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x1));

    vst1q_u16(writing, (uint16x8_t)x0);
    s0 = vgetq_lane_u32((uint32x4_t)x1, 0);

    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;

    s0 = vgetq_lane_u32((uint32x4_t)x1, 2);
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    reading += 16;
    writing += 8;
  }

  R[380] = (uint16_t)((((3 * ((10923 * R0[760] + 16384) >> 15) + 2295) & 16383) * 10923) >> 15);

  reading = (uint16_t *)R;
  writing = R;
  i = 12;
  while (i > 0)
  {
    --i;
    if (!i)
    {
      reading -= 4;
      writing -= 2;
      s -= 4;
    }

    x0 = (int16x8_t)vld1q_u16(reading + 0);
    x1 = (int16x8_t)vld1q_u16(reading + 8);
    x2 = (int16x8_t)vld1q_u16(reading + 16);
    x3 = (int16x8_t)vld1q_u16(reading + 24);

    y0 = vandq_s16(x0, (int16x8_t)mask);
    y1 = vandq_s16(x1, (int16x8_t)mask);
    y2 = vandq_s16(x2, (int16x8_t)mask);
    y3 = vandq_s16(x3, (int16x8_t)mask);

    x0 = (int16x8_t)vshrq_n_s32((int32x4_t)x0, 16);
    x1 = (int16x8_t)vshrq_n_s32((int32x4_t)x1, 16);
    x2 = (int16x8_t)vshrq_n_s32((int32x4_t)x2, 16);
    x3 = (int16x8_t)vshrq_n_s32((int32x4_t)x3, 16);

    tmp = (int16x8_t)vdupq_n_s32(9157);
    x0 = (int16x8_t)vmulq_s32((int32x4_t)x0, (int32x4_t)tmp);
    x1 = (int16x8_t)vmulq_s32((int32x4_t)x1, (int32x4_t)tmp);
    x2 = (int16x8_t)vmulq_s32((int32x4_t)x2, (int32x4_t)tmp);
    x3 = (int16x8_t)vmulq_s32((int32x4_t)x3, (int32x4_t)tmp);

    x0 = (int16x8_t)vaddq_s32((int32x4_t)y0, (int32x4_t)x0);
    x1 = (int16x8_t)vaddq_s32((int32x4_t)y1, (int32x4_t)x1);
    x2 = (int16x8_t)vaddq_s32((int32x4_t)y2, (int32x4_t)x2);
    x3 = (int16x8_t)vaddq_s32((int32x4_t)y3, (int32x4_t)x3);

    x0 = (int16x8_t)vqtbl1q_s8((int8x16_t)x0, shuffle1);
    x1 = (int16x8_t)vqtbl1q_s8((int8x16_t)x1, shuffle1);
    x2 = (int16x8_t)vqtbl1q_s8((int8x16_t)x2, shuffle1);
    x3 = (int16x8_t)vqtbl1q_s8((int8x16_t)x3, shuffle1);

    tmp2 = vget_high_s64((int64x2_t)x0);
    tmp3 = vget_low_s64((int64x2_t)x1);
    x0 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x0), tmp3);
    x1 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x1));

    tmp2 = vget_high_s64((int64x2_t)x2);
    tmp3 = vget_low_s64((int64x2_t)x3);
    x2 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x2), tmp3);
    x3 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x3));

    vst1q_u16(writing, (uint16x8_t)x1);
    vst1q_u16(writing + 8, (uint16x8_t)x3);
    vst1q_u8(s, (uint8x16_t)x0);
    vst1q_u8(s + 16, (uint8x16_t)x2);

    reading += 32;
    writing += 16;
    s += 32;
  }

  R[190] = R[380];

  reading = (uint16_t *)R;
  writing = R;
  i = 12;
  while (i > 0)
  {
    --i;
    if (!i)
    {
      reading -= 2;
      writing -= 1;
      s -= 1;
    }
    x0 = (int16x8_t)vld1q_u16(reading + 0);
    x1 = (int16x8_t)vld1q_u16(reading + 8);

    y0 = vandq_s16(x0, (int16x8_t)mask);
    y1 = vandq_s16(x1, (int16x8_t)mask);

    x0 = (int16x8_t)vshrq_n_s32((int32x4_t)x0, 16);
    x1 = (int16x8_t)vshrq_n_s32((int32x4_t)x1, 16);

    tmp = (int16x8_t)vdupq_n_s32(1280);
    x0 = (int16x8_t)vmulq_s32((int32x4_t)x0, (int32x4_t)tmp);
    x1 = (int16x8_t)vmulq_s32((int32x4_t)x1, (int32x4_t)tmp);

    x0 = (int16x8_t)vaddq_s32((int32x4_t)x0, (int32x4_t)y0);
    x1 = (int16x8_t)vaddq_s32((int32x4_t)x1, (int32x4_t)y1);

    x0 = (int16x8_t)vqtbl1q_s8((int8x16_t)x0, shuffle2);
    x1 = (int16x8_t)vqtbl1q_s8((int8x16_t)x1, shuffle2);

    tmp2 = vget_high_s64((int64x2_t)x0);
    tmp3 = vget_low_s64((int64x2_t)x1);
    x0 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x0), tmp3);
    x1 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x1));

    vst1q_u16(writing, (uint16x8_t)x0);
    s0 = vgetq_lane_u32((uint32x4_t)x1, 0);

    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;

    s0 = vgetq_lane_u32((uint32x4_t)x1, 2);
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    reading += 16;
    writing += 8;
  }
  R[95] = R[190];

  reading = (uint16_t *)R;
  writing = R;
  i = 3;
  while (i > 0)
  {
    --i;
    x0 = (int16x8_t)vld1q_u16(reading + 0);
    x1 = (int16x8_t)vld1q_u16(reading + 8);
    x2 = (int16x8_t)vld1q_u16(reading + 16);
    x3 = (int16x8_t)vld1q_u16(reading + 24);

    y0 = vandq_s16(x0, (int16x8_t)mask);
    y1 = vandq_s16(x1, (int16x8_t)mask);
    y2 = vandq_s16(x2, (int16x8_t)mask);
    y3 = vandq_s16(x3, (int16x8_t)mask);

    x0 = (int16x8_t)vshrq_n_s32((int32x4_t)x0, 16);
    x1 = (int16x8_t)vshrq_n_s32((int32x4_t)x1, 16);
    x2 = (int16x8_t)vshrq_n_s32((int32x4_t)x2, 16);
    x3 = (int16x8_t)vshrq_n_s32((int32x4_t)x3, 16);

    tmp = (int16x8_t)vdupq_n_s32(6400);
    x0 = (int16x8_t)vmulq_s32((int32x4_t)x0, (int32x4_t)tmp);
    x1 = (int16x8_t)vmulq_s32((int32x4_t)x1, (int32x4_t)tmp);
    x2 = (int16x8_t)vmulq_s32((int32x4_t)x2, (int32x4_t)tmp);
    x3 = (int16x8_t)vmulq_s32((int32x4_t)x3, (int32x4_t)tmp);

    x0 = (int16x8_t)vaddq_s32((int32x4_t)y0, (int32x4_t)x0);
    x1 = (int16x8_t)vaddq_s32((int32x4_t)y1, (int32x4_t)x1);
    x2 = (int16x8_t)vaddq_s32((int32x4_t)y2, (int32x4_t)x2);
    x3 = (int16x8_t)vaddq_s32((int32x4_t)y3, (int32x4_t)x3);

    x0 = (int16x8_t)vqtbl1q_s8((int8x16_t)x0, shuffle1);
    x1 = (int16x8_t)vqtbl1q_s8((int8x16_t)x1, shuffle1);
    x2 = (int16x8_t)vqtbl1q_s8((int8x16_t)x2, shuffle1);
    x3 = (int16x8_t)vqtbl1q_s8((int8x16_t)x3, shuffle1);

    tmp2 = vget_high_s64((int64x2_t)x0);
    tmp3 = vget_low_s64((int64x2_t)x1);
    x0 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x0), tmp3);
    x1 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x1));

    tmp2 = vget_high_s64((int64x2_t)x2);
    tmp3 = vget_low_s64((int64x2_t)x3);
    x2 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x2), tmp3);
    x3 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x3));

    vst1q_u16(writing, (uint16x8_t)x1);
    vst1q_u16(writing + 8, (uint16x8_t)x3);
    vst1q_u8(s, (uint8x16_t)x0);
    vst1q_u8(s + 16, (uint8x16_t)x2);

    reading += 32;
    writing += 16;
    s += 32;
  }
  reading = (uint16_t *)R;
  writing = R;
  i = 3;
  while (i > 0)
  {
    --i;
    x0 = (int16x8_t)vld1q_u16(reading + 0);
    x1 = (int16x8_t)vld1q_u16(reading + 8);

    y0 = vandq_s16(x0, (int16x8_t)mask);
    y1 = vandq_s16(x1, (int16x8_t)mask);

    x0 = (int16x8_t)vshrq_n_s32((int32x4_t)x0, 16);
    x1 = (int16x8_t)vshrq_n_s32((int32x4_t)x1, 16);

    tmp = (int16x8_t)vdupq_n_s32(625);
    x0 = (int16x8_t)vmulq_s32((int32x4_t)x0, (int32x4_t)tmp);
    x1 = (int16x8_t)vmulq_s32((int32x4_t)x1, (int32x4_t)tmp);

    x0 = (int16x8_t)vaddq_s32((int32x4_t)x0, (int32x4_t)y0);
    x1 = (int16x8_t)vaddq_s32((int32x4_t)x1, (int32x4_t)y1);

    x0 = (int16x8_t)vqtbl1q_s8((int8x16_t)x0, shuffle2);
    x1 = (int16x8_t)vqtbl1q_s8((int8x16_t)x1, shuffle2);

    tmp2 = vget_high_s64((int64x2_t)x0);
    tmp3 = vget_low_s64((int64x2_t)x1);
    x0 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x0), tmp3);
    x1 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x1));

    vst1q_u16(writing, (uint16x8_t)x0);
    s0 = vgetq_lane_u32((uint32x4_t)x1, 0);

    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;

    s0 = vgetq_lane_u32((uint32x4_t)x1, 2);
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    reading += 16;
    writing += 8;
  }
  reading = (uint16_t *)R;
  writing = R;
  i = 2;
  while (i > 0)
  {
    --i;
    if (!i)
    {
      reading -= 8;
      writing -= 4;
      s -= 4;
    }
    x0 = (int16x8_t)vld1q_u16(reading + 0);
    x1 = (int16x8_t)vld1q_u16(reading + 8);

    y0 = vandq_s16(x0, (int16x8_t)mask);
    y1 = vandq_s16(x1, (int16x8_t)mask);

    x0 = (int16x8_t)vshrq_n_s32((int32x4_t)x0, 16);
    x1 = (int16x8_t)vshrq_n_s32((int32x4_t)x1, 16);

    tmp = (int16x8_t)vdupq_n_s32(1526);
    x0 = (int16x8_t)vmulq_s32((int32x4_t)x0, (int32x4_t)tmp);
    x1 = (int16x8_t)vmulq_s32((int32x4_t)x1, (int32x4_t)tmp);

    x0 = (int16x8_t)vaddq_s32((int32x4_t)y0, (int32x4_t)x0);
    x1 = (int16x8_t)vaddq_s32((int32x4_t)y1, (int32x4_t)x1);

    x0 = (int16x8_t)vqtbl1q_s8((int8x16_t)x0, shuffle2);
    x1 = (int16x8_t)vqtbl1q_s8((int8x16_t)x1, shuffle2);

    tmp2 = vget_high_s64((int64x2_t)x0);
    tmp3 = vget_low_s64((int64x2_t)x1);
    x0 = (int16x8_t)vcombine_s64(vget_low_s64((int64x2_t)x0), tmp3);
    x1 = (int16x8_t)vcombine_s64(tmp2, vget_high_s64((int64x2_t)x1));

    vst1q_u16(writing, (uint16x8_t)x0);
    s0 = vgetq_lane_u32((uint32x4_t)x1, 0);

    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;

    s0 = vgetq_lane_u32((uint32x4_t)x1, 2);
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    s0 >>= 8;
    *s++ = (unsigned char)s0;
    reading += 16;
    writing += 8;
  }
  for (i = 0; i < 6; ++i)
  {
    r0 = R[2 * i];
    r1 = R[2 * i + 1];
    r2 = r0 + r1 * (uint32_t)9097;
    *s++ = (unsigned char)r2;
    r2 >>= 8;
    *s++ = (unsigned char)r2;
    r2 >>= 8;
    R[i] = (uint16_t)r2;
  }

  for (i = 0; i < 3; ++i)
  {
    r0 = R[2 * i];
    r1 = R[2 * i + 1];
    r2 = r0 + r1 * (uint32_t)1263;
    *s++ = (unsigned char)r2;
    r2 >>= 8;
    R[i] = (uint16_t)r2;
  }

  r0 = R[0];
  r1 = R[1];
  r2 = r0 + r1 * (uint32_t)6232;
  *s++ = (unsigned char)r2;
  r2 >>= 8;
  *s++ = (unsigned char)r2;
  r2 >>= 8;
  R[0] = (uint16_t)r2;
  R[1] = R[2];

  r0 = R[0];
  r1 = R[1];
  r2 = r0 + r1 * (uint32_t)593;
  *s++ = (unsigned char)r2;
  r2 >>= 8;
  R[0] = (uint16_t)r2;

  r0 = R[0];
  *s++ = (unsigned char)r0;
  r0 >>= 8;
  *s++ = (unsigned char)r0;
}

void Rounded_decode(Fq *r, const unsigned char *s)
{
  uint16 R[p], M[p];
  int i;

  for (i = 0; i < p; ++i)
    M[i] = (q + 2) / 3;
  Decode(R, s, M, p);
  for (i = 0; i < p; ++i)
    r[i] = R[i] * 3 - q12;
}

void Rounded_decode_neon(Fq *v, const unsigned char *s)
{
  int16_t *R0 = v;
  int16_t R1[381], R2[191], R3[96], R4[48], R5[24], R6[12], R7[6], R8[3], R9[2], R10[1];
  long long i;
  int16_t a0, a1, a2;

  int16x8_t A00, A01, A10, A11, A20, A21;
  int16x8_t S00, S01, S10, S11;
  int16x8_t B00, B01, B10, B11;
  int16x8_t tmp, tmp2;

  s += 1007;
  a1 = 0;
  a1 += *--s; /* 0...255 */
  a1 = mulhi(a1, -84) - mulhi(mullo(a1, -4828), 3475);
  a1 += *--s;              /* -1738...1992 */
  a1 += (a1 >> 15) & 3475; /* 0...3474 */
  R10[0] = a1;

  /* R10 ------> R9: reconstruct mod 1*[593]+[1500] */

  i = 0;
  s -= 1;
  a2 = a0 = R10[0];
  a0 = mulhi(a0, 60) - mulhi(mullo(a0, -28292), 593); /* -297...311 */
  a0 += s[1 * i + 0];                                 /* -297...566 */
  a0 += (a0 >> 15) & 593;                             /* 0...592 */
  a1 = (int16_t)((a2 << 8) + s[i] - a0);
  a1 = mullo(a1, -31055);

  /* invalid inputs might need reduction mod 1500 */
  a1 -= 1500;
  a1 += (a1 >> 15) & 1500;

  R9[0] = a0;
  R9[1] = a1;
  s -= 0;

  /* R9 ------> R8: reconstruct mod 2*[6232]+[1500] */

  R8[2] = R9[1];
  s -= 2;
  for (i = 0; i >= 0; --i)
  {
    a2 = a0 = R9[i];
    a0 = mulhi(a0, 672) - mulhi(mullo(a0, -2692), 6232); /* -3116...3284 */
    a0 += s[2 * i + 1];                                  /* -3116...3539 */
    a0 = mulhi(a0, 672) - mulhi(mullo(a0, -2692), 6232); /* -3148...3152 */
    a0 += s[2 * i + 0];                                  /* -3148...3407 */
    a0 += (a0 >> 15) & 6232;                             /* 0...6231 */
    a1 = (int16_t)((a2 << 13) + (s[2 * i + 1] << 5) + ((s[2 * i] - a0) >> 3));
    a1 = mullo(a1, 12451);

    /* invalid inputs might need reduction mod 6232 */
    a1 -= 6232;
    a1 += (a1 >> 15) & 6232;

    R8[2 * i] = a0;
    R8[2 * i + 1] = a1;
  }

  /* R8 ------> R7: reconstruct mod 5*[1263]+[304] */

  i = 0;
  s -= 1;
  a2 = a0 = R8[2];
  a0 = mulhi(a0, -476) - mulhi(mullo(a0, -13284), 1263); /* -751...631 */
  a0 += s[1 * i + 0];                                    /* -751...886 */
  a0 += (a0 >> 15) & 1263;                               /* 0...1262 */
  a1 = (int16_t)((a2 << 8) + s[i] - a0);
  a1 = mullo(a1, -22001);

  /* invalid inputs might need reduction mod 304 */
  a1 -= 304;
  a1 += (a1 >> 15) & 304;

  R7[4] = a0;
  R7[5] = a1;
  s -= 2;
  for (i = 1; i >= 0; --i)
  {
    a2 = a0 = R8[i];
    a0 = mulhi(a0, -476) - mulhi(mullo(a0, -13284), 1263); /* -751...631 */
    a0 += s[1 * i + 0];                                    /* -751...886 */
    a0 += (a0 >> 15) & 1263;                               /* 0...1262 */
    a1 = (int16_t)((a2 << 8) + s[i] - a0);
    a1 = mullo(a1, -22001);

    /* invalid inputs might need reduction mod 1263 */
    a1 -= 1263;
    a1 += (a1 >> 15) & 1263;

    R7[2 * i] = a0;
    R7[2 * i + 1] = a1;
  }

  /* R7 ------> R6: reconstruct mod 11*[9097]+[2188] */

  i = 0;
  s -= 2;
  a0 = R7[5];
  a0 = mulhi(a0, 2348) - mulhi(mullo(a0, -1844), 9097); /* -4549...5135 */
  a0 += s[2 * i + 1];                                   /* -4549...5390 */
  a0 = mulhi(a0, 2348) - mulhi(mullo(a0, -1844), 9097); /* -4712...4741 */
  a0 += s[2 * i + 0];                                   /* -4712...4996 */
  a0 += (a0 >> 15) & 9097;                              /* 0...9096 */
  a1 = (int16_t)((s[2 * i + 1] << 8) + s[2 * i] - a0);
  a1 = mullo(a1, 17081);

  /* invalid inputs might need reduction mod 2188 */
  a1 -= 2188;
  a1 += (a1 >> 15) & 2188;

  R6[10] = a0;
  R6[11] = a1;
  s -= 10;
  for (i = 4; i >= 0; --i)
  {
    a0 = R7[i];
    a0 = mulhi(a0, 2348) - mulhi(mullo(a0, -1844), 9097); /* -4549...5135 */
    a0 += s[2 * i + 1];                                   /* -4549...5390 */
    a0 = mulhi(a0, 2348) - mulhi(mullo(a0, -1844), 9097); /* -4712...4741 */
    a0 += s[2 * i + 0];                                   /* -4712...4996 */
    a0 += (a0 >> 15) & 9097;                              /* 0...9096 */
    a1 = (int16_t)((s[2 * i + 1] << 8) + s[2 * i] - a0);
    a1 = mullo(a1, 17081);

    /* invalid inputs might need reduction mod 9097 */
    a1 -= 9097;
    a1 += (a1 >> 15) & 9097;

    R6[2 * i] = a0;
    R6[2 * i + 1] = a1;
  }

  /* R6 ------> R5: reconstruct mod 23*[1526]+[367] */

  i = 0;
  s -= 1;
  a2 = a0 = R6[11];
  a0 = mulhi(a0, 372) - mulhi(mullo(a0, -10994), 1526); /* -763...856 */
  a0 += s[1 * i + 0];                                   /* -763...1111 */
  a0 += (a0 >> 15) & 1526;                              /* 0...1525 */
  a1 = (int16_t)((a2 << 7) + ((s[i] - a0) >> 1));
  a1 = mullo(a1, -18381);

  /* invalid inputs might need reduction mod 367 */
  a1 -= 367;
  a1 += (a1 >> 15) & 367;

  R5[22] = a0;
  R5[23] = a1;
  s -= 11;
  for (i = 10; i >= 0; --i)
  {
    a2 = a0 = R6[i];
    a0 = mulhi(a0, 372) - mulhi(mullo(a0, -10994), 1526); /* -763...856 */
    a0 += s[1 * i + 0];                                   /* -763...1111 */
    a0 += (a0 >> 15) & 1526;                              /* 0...1525 */
    a1 = (int16_t)((a2 << 7) + ((s[i] - a0) >> 1));
    a1 = mullo(a1, -18381);

    /* invalid inputs might need reduction mod 1526 */
    a1 -= 1526;
    a1 += (a1 >> 15) & 1526;

    R5[2 * i] = a0;
    R5[2 * i + 1] = a1;
  }

  /* R5 ------> R4: reconstruct mod 47*[625]+[150] */

  i = 0;
  s -= 1;
  a2 = a0 = R5[23];
  a0 = mulhi(a0, -284) - mulhi(mullo(a0, -26844), 625); /* -384...312 */
  a0 += s[1 * i + 0];                                   /* -384...567 */
  a0 += (a0 >> 15) & 625;                               /* 0...624 */
  a1 = (int16_t)((a2 << 8) + s[i] - a0);
  a1 = mullo(a1, 32401);

  /* invalid inputs might need reduction mod 150 */
  a1 -= 150;
  a1 += (a1 >> 15) & 150;

  R4[46] = a0;
  R4[47] = a1;
  s -= 23;
  i = 7;

  for (;;)
  {
    A20 = A00 = vld1q_s16(&(R5[i]));
    A21 = A01 = vld1q_s16(&(R5[i + 8]));

    S00 = (int16x8_t)vmovl_u8(vld1_u8(s + i));
    S01 = (int16x8_t)vmovl_u8(vld1_u8(s + i + 8));

    tmp2 = vmulq_s16(A00, vdupq_n_s16(-26844));
    tmp = vdupq_n_s16(625);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(-142)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(-26844));
    tmp = vdupq_n_s16(625);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(-142)), tmp);

    A00 = vaddq_s16(A00, S00);
    A01 = vaddq_s16(A01, S01);

    tmp = vdupq_n_s16(625);
    A00 = vaddq_s16(A00, vandq_s16(vshrq_n_s16(A00, 15), tmp));
    A01 = vaddq_s16(A01, vandq_s16(vshrq_n_s16(A01, 15), tmp));

    A10 = vaddq_s16(vshlq_n_s16(A20, 8), vsubq_s16(S00, A00));
    A11 = vaddq_s16(vshlq_n_s16(A21, 8), vsubq_s16(S01, A01));

    tmp = vdupq_n_s16(32401);
    A10 = vmulq_s16(A10, tmp);
    A11 = vmulq_s16(A11, tmp);

    A10 = vsubq_s16(A10, vandq_s16((int16x8_t)vcgtq_s16(A10, vdupq_n_s16(624)), vdupq_n_s16(625)));
    A11 = vsubq_s16(A11, vandq_s16((int16x8_t)vcgtq_s16(A11, vdupq_n_s16(624)), vdupq_n_s16(625)));

    B00 = vzip1q_s16(A00, A10);
    B10 = vzip2q_s16(A00, A10);

    B01 = vzip1q_s16(A01, A11);
    B11 = vzip2q_s16(A01, A11);

    vst1q_s16(&R4[2 * i], B00);
    vst1q_s16(&R4[2 * i] + 8, B10);
    vst1q_s16(&R4[2 * i] + 16, B01);
    vst1q_s16(&R4[2 * i] + 24, B11);
    if (!i)
    {
      break;
    }
    i = -16 - ((~15) & -i);
  }
  i = 0;
  s -= 2;
  a2 = a0 = R4[47];
  a0 = mulhi(a0, 2816) - mulhi(mullo(a0, -2621), 6400); /* -3200...3904 */
  a0 += s[2 * i + 1];                                   /* -3200...4159 */
  a0 = mulhi(a0, 2816) - mulhi(mullo(a0, -2621), 6400); /* -3338...3378 */
  a0 += s[2 * i + 0];                                   /* -3338...3633 */
  a0 += (a0 >> 15) & 6400;                              /* 0...6399 */
  a1 = (int16_t)((a2 << 8) + s[2 * i + 1] + ((s[2 * i] - a0) >> 8));
  a1 = mullo(a1, 23593);

  /* invalid inputs might need reduction mod 1531 */
  a1 -= 1531;
  a1 += (a1 >> 15) & 1531;

  R3[94] = a0;
  R3[95] = a1;
  s -= 94;
  i = 31;
  for (;;)
  {
    A20 = A00 = vld1q_s16(&(R4[i]));
    A21 = A01 = vld1q_s16(&(R4[i + 8]));

    S00 = (int16x8_t)vld1q_u8(s + 2 * i);
    S01 = (int16x8_t)vld1q_u8(s + 2 * i + 16);

    S10 = (int16x8_t)vshrq_n_u16((uint16x8_t)S00, 8);
    S11 = (int16x8_t)vshrq_n_u16((uint16x8_t)S01, 8);

    tmp = vdupq_n_s16(255);
    S00 = vandq_s16(S00, tmp);
    S01 = vandq_s16(S01, tmp);

    tmp2 = vmulq_s16(A00, vdupq_n_s16(-2621));
    tmp = vqdmulhq_s16(tmp2, vdupq_n_s16(3200));
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(1408)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(-2621));
    tmp = vqdmulhq_s16(tmp2, vdupq_n_s16(3200));
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(1408)), tmp);

    A00 = vaddq_s16(A00, S10);
    A01 = vaddq_s16(A01, S11);

    tmp2 = vmulq_s16(A00, vdupq_n_s16(-2621));
    tmp = vqdmulhq_s16(tmp2, vdupq_n_s16(3200));
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(1408)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(-2621));
    tmp = vqdmulhq_s16(tmp2, vdupq_n_s16(3200));
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(1408)), tmp);

    A00 = vaddq_s16(A00, S00);
    A01 = vaddq_s16(A01, S01);

    tmp = vdupq_n_s16(6400);
    A00 = vaddq_s16(A00, vandq_s16(vshrq_n_s16(A00, 15), tmp));
    A01 = vaddq_s16(A01, vandq_s16(vshrq_n_s16(A01, 15), tmp));

    A10 = vaddq_s16(vaddq_s16(vshlq_n_s16(A20, 8), S10), vshrq_n_s16(vsubq_s16(S00, A00), 8));
    A11 = vaddq_s16(vaddq_s16(vshlq_n_s16(A21, 8), S11), vshrq_n_s16(vsubq_s16(S01, A01), 8));

    tmp = vdupq_n_s16(23593);
    A10 = vmulq_s16(A10, tmp);
    A11 = vmulq_s16(A11, tmp);

    A10 = vsubq_s16(A10, vandq_s16((int16x8_t)vcgtq_s16(A10, vdupq_n_s16(6399)), vdupq_n_s16(6400)));
    A11 = vsubq_s16(A11, vandq_s16((int16x8_t)vcgtq_s16(A11, vdupq_n_s16(6399)), vdupq_n_s16(6400)));

    B00 = vzip1q_s16(A00, A10);
    B10 = vzip2q_s16(A00, A10);

    B01 = vzip1q_s16(A01, A11);
    B11 = vzip2q_s16(A01, A11);

    vst1q_s16(&R3[2 * i], B00);
    vst1q_s16(&R3[2 * i] + 8, B10);
    vst1q_s16(&R3[2 * i] + 16, B01);
    vst1q_s16(&R3[2 * i] + 24, B11);
    if (!i)
    {
      break;
    }
    i = -16 - ((~15) & -i);
  }
  R2[190] = R3[95];
  s -= 95;
  i = 79;
  for (;;)
  {
    A20 = A00 = vld1q_s16(&(R3[i]));
    A21 = A01 = vld1q_s16(&(R3[i + 8]));

    S00 = (int16x8_t)vmovl_u8(vld1_u8(s + i));
    S01 = (int16x8_t)vmovl_u8(vld1_u8(s + i + 8));

    tmp2 = vmulq_s16(A00, vdupq_n_s16(-13107));
    tmp = vqdmulhq_s16(tmp2, vdupq_n_s16(640));
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(128)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(-13107));
    tmp = vqdmulhq_s16(tmp2, vdupq_n_s16(640));
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(128)), tmp);

    A00 = vaddq_s16(A00, S00);
    A01 = vaddq_s16(A01, S01);

    tmp = vdupq_n_s16(1280);
    A00 = vaddq_s16(A00, vandq_s16(vshrq_n_s16(A00, 15), tmp));
    A01 = vaddq_s16(A01, vandq_s16(vshrq_n_s16(A01, 15), tmp));

    A10 = vaddq_s16(A20, vshrq_n_s16(vsubq_s16(S00, A00), 8));
    A11 = vaddq_s16(A21, vshrq_n_s16(vsubq_s16(S01, A01), 8));

    tmp = vdupq_n_s16(-13107);
    A10 = vmulq_s16(A10, tmp);
    A11 = vmulq_s16(A11, tmp);

    A10 = vsubq_s16(A10, vandq_s16((int16x8_t)vcgtq_s16(A10, vdupq_n_s16(1279)), vdupq_n_s16(1280)));
    A11 = vsubq_s16(A11, vandq_s16((int16x8_t)vcgtq_s16(A11, vdupq_n_s16(1279)), vdupq_n_s16(1280)));

    B00 = vzip1q_s16(A00, A10);
    B10 = vzip2q_s16(A00, A10);

    B01 = vzip1q_s16(A01, A11);
    B11 = vzip2q_s16(A01, A11);

    vst1q_s16(&R2[2 * i], B00);
    vst1q_s16(&R2[2 * i] + 8, B10);
    vst1q_s16(&R2[2 * i] + 16, B01);
    vst1q_s16(&R2[2 * i] + 24, B11);
    if (!i)
    {
      break;
    }
    i = -16 - ((~15) & -i);
  }

  R1[380] = R2[190];
  s -= 380;
  i = 174;
  for (;;)
  {
    A00 = vld1q_s16(&(R2[i]));
    A01 = vld1q_s16(&(R2[i + 8]));

    S00 = (int16x8_t)vld1q_u8(s + 2 * i);
    S01 = (int16x8_t)vld1q_u8(s + 2 * i + 16);

    S10 = (int16x8_t)vshrq_n_u16((uint16x8_t)S00, 8);
    S11 = (int16x8_t)vshrq_n_u16((uint16x8_t)S01, 8);

    tmp = vdupq_n_s16(255);
    S00 = vandq_s16(S00, tmp);
    S01 = vandq_s16(S01, tmp);

    tmp2 = vmulq_s16(A00, vdupq_n_s16(-1832));
    tmp = vdupq_n_s16(9157);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(796)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(-1832));
    tmp = vdupq_n_s16(9157);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(796)), tmp);

    A00 = vaddq_s16(A00, S10);
    A01 = vaddq_s16(A01, S11);

    tmp2 = vmulq_s16(A00, vdupq_n_s16(-1832));
    tmp = vdupq_n_s16(9157);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(796)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(-1832));
    tmp = vdupq_n_s16(9157);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(796)), tmp);

    A00 = vaddq_s16(A00, S00);
    A01 = vaddq_s16(A01, S01);

    tmp = vdupq_n_s16(9157);
    A00 = vaddq_s16(A00, vandq_s16(vshrq_n_s16(A00, 15), tmp));
    A01 = vaddq_s16(A01, vandq_s16(vshrq_n_s16(A01, 15), tmp));

    A10 = vaddq_s16(vshlq_n_s16(S10, 8), vsubq_s16(S00, A00));
    A11 = vaddq_s16(vshlq_n_s16(S11, 8), vsubq_s16(S01, A01));

    tmp = vdupq_n_s16(25357);
    A10 = vmulq_s16(A10, tmp);
    A11 = vmulq_s16(A11, tmp);

    A10 = vsubq_s16(A10, vandq_s16((int16x8_t)vcgtq_s16(A10, vdupq_n_s16(9156)), vdupq_n_s16(9157)));
    A11 = vsubq_s16(A11, vandq_s16((int16x8_t)vcgtq_s16(A11, vdupq_n_s16(9156)), vdupq_n_s16(9157)));

    B00 = vzip1q_s16(A00, A10);
    B10 = vzip2q_s16(A00, A10);

    B01 = vzip1q_s16(A01, A11);
    B11 = vzip2q_s16(A01, A11);

    vst1q_s16(&R1[2 * i], B00);
    vst1q_s16(&R1[2 * i] + 8, B10);
    vst1q_s16(&R1[2 * i] + 16, B01);
    vst1q_s16(&R1[2 * i] + 24, B11);
    if (!i)
    {
      break;
    }
    i = -16 - ((~15) & -i);
  }
  R0[760] = (int16_t)(3 * R1[380] - 2295);
  s -= 380;
  i = 364;
  for (;;)
  {
    A20 = A00 = vld1q_s16(&(R1[i]));
    A21 = A01 = vld1q_s16(&(R1[i + 8]));

    S00 = (int16x8_t)vmovl_u8(vld1_u8(s + i));
    S01 = (int16x8_t)vmovl_u8(vld1_u8(s + i + 8));

    tmp2 = vmulq_s16(A00, vdupq_n_s16(-10958));
    tmp = vdupq_n_s16(1531);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A00 = vsubq_s16(vqdmulhq_s16(A00, vdupq_n_s16(259)), tmp);

    tmp2 = vmulq_s16(A01, vdupq_n_s16(-10958));
    tmp = vdupq_n_s16(1531);
    tmp = (int16x8_t)vuzpq_s16((int16x8_t)vmull_s16(vget_low_s16(tmp), vget_low_s16(tmp2)), (int16x8_t)vmull_s16(vget_high_s16(tmp), vget_high_s16(tmp2))).val[1];
    A01 = vsubq_s16(vqdmulhq_s16(A01, vdupq_n_s16(259)), tmp);

    A00 = vaddq_s16(A00, S00);
    A01 = vaddq_s16(A01, S01);

    tmp = vdupq_n_s16(1531);
    A00 = vaddq_s16(A00, vandq_s16(vshrq_n_s16(A00, 15), tmp));
    A01 = vaddq_s16(A01, vandq_s16(vshrq_n_s16(A01, 15), tmp));

    A10 = vaddq_s16(vshlq_n_s16(A20, 8), vsubq_s16(S00, A00));
    A11 = vaddq_s16(vshlq_n_s16(A21, 8), vsubq_s16(S01, A01));

    tmp = vdupq_n_s16(15667);
    A10 = vmulq_s16(A10, tmp);
    A11 = vmulq_s16(A11, tmp);

    A10 = vsubq_s16(A10, vandq_s16((int16x8_t)vcgtq_s16(A10, vdupq_n_s16(1530)), vdupq_n_s16(1531)));
    A11 = vsubq_s16(A11, vandq_s16((int16x8_t)vcgtq_s16(A11, vdupq_n_s16(1530)), vdupq_n_s16(1531)));

    tmp = vdupq_n_s16(3);
    A00 = vmulq_s16(A00, tmp);
    A01 = vmulq_s16(A01, tmp);
    A10 = vmulq_s16(A10, tmp);
    A11 = vmulq_s16(A11, tmp);

    tmp = vdupq_n_s16(2295);
    A00 = vsubq_s16(A00, tmp);
    A01 = vsubq_s16(A01, tmp);
    A10 = vsubq_s16(A10, tmp);
    A11 = vsubq_s16(A11, tmp);

    B00 = vzip1q_s16(A00, A10);
    B10 = vzip2q_s16(A00, A10);

    B01 = vzip1q_s16(A01, A11);
    B11 = vzip2q_s16(A01, A11);

    vst1q_s16(&R0[2 * i], B00);
    vst1q_s16(&R0[2 * i] + 8, B10);
    vst1q_s16(&R0[2 * i] + 16, B01);
    vst1q_s16(&R0[2 * i] + 24, B11);

    if (!i)
    {
      break;
    }
    i = -16 - ((~15) & -i);
  }
}
