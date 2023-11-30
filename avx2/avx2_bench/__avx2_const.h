#ifndef __AVX2_CONST_H
#define __AVX2_CONST_H

#include "params.h"
#include "NTT_params.h"

#define const_buff NAME(const_buff)
#define twist96_table NAME(twist96_table)
#define twist96_inv_table NAME(twist96_inv_table)
#define twist_full_pre NAME(twist_full_pre)
#define twist_full_post NAME(twist_full_post)
#define OMEGA3_buff NAME(OMEGA3_buff)
#define OMEGA3INV_buff NAME(OMEGA3INV_buff)
#define twiddle_rader17_full NAME(twiddle_rader17_full)
#define twiddle_rader17_qinv_full NAME(twiddle_rader17_qinv_full)
#define twiddle_irader17_full NAME(twiddle_irader17_full)
#define twiddle_irader17_qinv_full NAME(twiddle_irader17_qinv_full)


extern
int16_t const_buff[80];

extern
int16_t twist96_table[16 * 96];

extern
int16_t twist96_inv_table[16 * 96];

extern
int16_t twist_full_pre[NTT_N];

extern
int16_t twist_full_post[NTT_N];

extern
int16_t OMEGA3_buff[16];

extern
int16_t OMEGA3INV_buff[16];

extern
int16_t twiddle_rader17_full[16 * 16];

extern
int16_t twiddle_rader17_qinv_full[16 * 16];

extern
int16_t twiddle_irader17_full[16 * 16];

extern
int16_t twiddle_irader17_qinv_full[16 * 16];

#endif

