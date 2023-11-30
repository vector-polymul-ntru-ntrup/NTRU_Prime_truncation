#ifndef ref_H
#define ref_H

#include <inttypes.h>

typedef int16_t int16;
typedef int32_t int32;

typedef struct {
  int16 lane[16];
} int16x16;

extern void mult1_over65536_x16(int16x16 *,const int16x16 *,const int16x16 *);
extern void mult2_over65536_x16(int16x16 *,const int16x16 *,const int16x16 *);
extern void mult4_over65536_x16(int16x16 *,const int16x16 *,const int16x16 *);
extern void mult8_over65536_x16(int16x16 *,const int16x16 *,const int16x16 *);
extern void mult8_nega_over65536_x16(int16x16 *,const int16x16 *,const int16x16 *);
extern void mult64_nega_over4096_x16(int16x16 *,const int16x16 *,const int16x16 *);
extern void mult768_over64(int16 *,const int16 *,const int16 *);

extern long long nummul;
extern long long numadd;
extern long long numneg;

#endif
