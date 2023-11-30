
#include "hash.h"
#include "sha2.h"

/* ----- underlying hash function */

/* e.g., b = 0 means out = Hash0(in) */
void Hash_prefix(unsigned char *out,int b,const unsigned char *in,int inlen)
{
  unsigned char x[inlen+1];
  unsigned char h[64];
  int i;

  x[0] = b;
  for (i = 0;i < inlen;++i) x[i+1] = in[i];
  sha512(h,x,inlen+1);
  for (i = 0;i < 32;++i) out[i] = h[i];
}

