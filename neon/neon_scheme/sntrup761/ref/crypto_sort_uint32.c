#include "crypto_sort_uint32.h"

#ifdef BENCH_SORT
#define ACC sort_cycles

#define TIME0 sort_time0
#define TIME1 sort_time1

extern uint64_t ACC;
uint64_t TIME0, TIME1;


#ifdef __APPLE__
#include "m1cycles.h"
#define GET_TIME rdtsc()
#else
#include "hal.h"
#define GET_TIME hal_get_time()
#endif

#define BENCH_INIT() { TIME0 = GET_TIME;}
#define BENCH_TAIL() { TIME1 = GET_TIME; ACC += TIME1 - TIME0;}

#else

#define BENCH_INIT() {}
#define BENCH_TAIL() {}

#endif

static void minmax(uint32 *x,uint32 *y)
{
  uint32 xi = *x;
  uint32 yi = *y;
  uint32 xy = xi ^ yi;
  uint32 c = yi - xi;
  c ^= xy & (c ^ yi ^ 0x80000000);
  c >>= 31;
  c = -c;
  c &= xy;
  *x = xi ^ c;
  *y = yi ^ c;
}

void crypto_sort_uint32(uint32 *x,int n)
{
  BENCH_INIT();
  int top,p,q,i;

  if (n < 2) return;
  top = 1;
  while (top < n - top) top += top;

  for (p = top;p > 0;p >>= 1) {
    for (i = 0;i < n - p;++i)
      if (!(i & p))
        minmax(x + i,x + i + p);
    for (q = top;q > p;q >>= 1)
      for (i = 0;i < n - q;++i)
        if (!(i & p))
          minmax(x + i + p,x + i + q);
  }
  BENCH_TAIL();
}
