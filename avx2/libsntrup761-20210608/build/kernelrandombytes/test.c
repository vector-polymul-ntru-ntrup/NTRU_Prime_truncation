#include <unistd.h>
#include <stdio.h>
#include "kernelrandombytes.h"

unsigned char x[65536];
unsigned long long freq[256];

int main()
{
  unsigned long long i;
  unsigned long long j;

  alarm(1);

  for (j = 0;j < 3;++j) {
    kernelrandombytes(x,sizeof x);
    for (i = 0;i < 256;++i) freq[i] = 0;
    for (i = 0;i < sizeof x;++i) ++freq[255 & (int) x[i]];
    for (i = 0;i < 256;++i) if (!freq[i]) { printf("-1"); return 111;}
  }
  printf("1");
  return 0;
}
