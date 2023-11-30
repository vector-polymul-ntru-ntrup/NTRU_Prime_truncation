#include "crypto_core.h"

#include "params.h"


//x^19 + x^18 + 2*x^16 + x^15 + x^14 + x^13 + x^12 + 2*x^11 + 2*x^9 + x^8 +
//        2*x^7 + x^6 + 2*x^5 + 2*x^4 + 2*x^3 + 2*x + 2,
static const
unsigned char fac0[20] = { 2, 2, 0, 2, 2, 2, 1, 2, 1, 2, 0, 2, 1, 1, 1, 1, 2, 0, 1, 1 };

static const
unsigned char fac1[61] = {
1, 2, 1, 1,  0, 0, 1, 2,  0, 2, 0, 2,  0, 1, 1, 1,  1, 1, 0, 0,  2, 0, 1, 1,  0, 0, 1, 0,  1, 0, 0, 2,
2, 1, 1, 2,  0, 1, 1, 0,  0, 1, 1, 2,  0, 0, 1, 1,  1, 1, 2, 0,  0, 1, 2, 0,  2, 2, 1, 0,  1 };

static const
unsigned char fac2[683] = {
1, 1, 0, 0, 2, 1, 1, 1, 0, 1, 2, 0, 2, 1, 0, 0, 0, 1, 1, 1, 2, 2, 1, 0, 1, 0, 1, 1, 0, 2, 1, 0, 2, 0, 2, 
1, 0, 0, 2, 1, 0, 1, 2, 2, 2, 2, 2, 2, 0, 1, 1, 1, 1, 2, 2, 2, 0, 1, 1, 0, 1, 0, 0, 0, 1, 2, 0, 2, 2, 1, 
0, 2, 1, 2, 2, 0, 2, 0, 2, 1, 2, 0, 1, 0, 0, 1, 2, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 2, 0, 0, 0, 1, 1, 1, 2, 
2, 2, 0, 0, 2, 0, 1, 2, 2, 1, 2, 1, 1, 0, 2, 2, 1, 2, 0, 0, 1, 2, 1, 2, 1, 2, 0, 1, 1, 2, 1, 0, 0, 0, 2, 
1, 0, 0, 1, 1, 0, 0, 0, 0, 2, 0, 2, 1, 0, 1, 1, 2, 0, 1, 1, 0, 0, 1, 2, 2, 1, 0, 0, 1, 0, 1, 2, 0, 1, 1, 
1, 2, 0, 1, 0, 1, 2, 2, 1, 2, 2, 1, 2, 1, 0, 2, 1, 1, 1, 0, 2, 1, 1, 0, 1, 0, 0, 2, 0, 1, 1, 0, 0, 0, 0, 
1, 2, 2, 0, 2, 2, 1, 2, 0, 0, 0, 2, 0, 0, 1, 2, 2, 2, 1, 2, 2, 0, 1, 0, 2, 1, 1, 2, 2, 0, 0, 0, 2, 2, 0, 
2, 1, 2, 2, 1, 1, 2, 0, 2, 0, 0, 2, 2, 0, 0, 1, 0, 2, 0, 2, 2, 0, 0, 0, 0, 1, 2, 0, 1, 1, 0, 2, 2, 1, 0, 
1, 2, 2, 2, 2, 1, 0, 1, 0, 0, 0, 1, 2, 0, 2, 2, 0, 2, 2, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 2, 0, 
0, 2, 0, 1, 2, 1, 0, 1, 2, 2, 2, 1, 1, 2, 1, 1, 2, 1, 2, 2, 1, 0, 0, 0, 0, 1, 0, 2, 0, 1, 0, 2, 0, 0, 2, 
0, 0, 1, 1, 2, 0, 1, 1, 2, 0, 2, 0, 2, 1, 2, 2, 2, 1, 2, 2, 0, 0, 1, 2, 1, 0, 1, 2, 0, 0, 1, 0, 2, 2, 0, 
0, 2, 1, 1, 2, 2, 1, 0, 1, 0, 2, 2, 0, 0, 1, 1, 1, 1, 0, 2, 1, 1, 2, 2, 2, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 
1, 0, 1, 1, 1, 2, 2, 0, 1, 1, 0, 0, 2, 2, 2, 1, 0, 0, 2, 0, 2, 1, 0, 0, 1, 0, 2, 2, 0, 0, 2, 1, 0, 2, 1, 
0, 1, 1, 2, 1, 1, 2, 1, 1, 0, 0, 2, 1, 2, 0, 0, 0, 2, 2, 0, 0, 0, 1, 0, 0, 2, 0, 1, 2, 1, 1, 2, 0, 1, 1, 
1, 1, 2, 2, 2, 2, 0, 0, 2, 1, 1, 0, 0, 0, 2, 0, 2, 0, 0, 2, 2, 2, 1, 1, 2, 1, 0, 2, 0, 1, 1, 1, 1, 0, 1, 
0, 1, 1, 2, 1, 1, 2, 2, 0, 1, 2, 0, 1, 1, 0, 0, 1, 1, 0, 2, 2, 0, 2, 2, 2, 1, 2, 2, 2, 1, 1, 1, 0, 1, 1, 
1, 0, 2, 2, 1, 1, 1, 1, 1, 0, 0, 1, 1, 2, 2, 2, 2, 2, 0, 0, 0, 1, 1, 2, 1, 1, 0, 1, 1, 2, 1, 0, 1, 0, 2, 
1, 1, 1, 1, 0, 1, 0, 1, 1, 2, 0, 0, 2, 0, 0, 0, 2, 1, 1, 0, 0, 0, 0, 2, 0, 1, 1, 2, 0, 2, 0, 2, 2, 1, 0, 
1, 1, 0, 1, 2, 0, 2, 1, 1, 2, 2, 0, 2, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 0, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 1, 
1, 1, 2, 2, 2, 2, 0, 0, 1, 0, 2, 1, 0, 1, 2, 0, 2, 1
};



/* works for -16384 <= x < 16384 */
static char F3_freeze(short x)
{
  return x-3*((10923*x+16384)>>15);
}

static
void mulsub3( unsigned char * a , unsigned char m, const unsigned char * b , unsigned len_b )
{
  for(unsigned i=0;i<len_b;i++) {
    a[i] += 6 - m*b[i];
    char fz = F3_freeze(a[i]); // 1,0,-1
    fz += ((fz>>2)&0x3);  // 1,0,2
    a[i] = (unsigned char)fz;
  }
}

static
void mod3( unsigned char * dividend , unsigned len_dividen , const unsigned char *divisor , unsigned len_divisor )
{
  for(int i=len_dividen-len_divisor;i>=0;i--){
    mulsub3(dividend+i, dividend[i+len_divisor-1] , divisor , len_divisor );
  }
}


static
void mod3_fac0( unsigned char * poly )
{
  mod3( poly , p , fac0 , sizeof(fac0) );
}

static
void mod3_fac1( unsigned char * poly )
{
  mod3( poly , p , fac1 , sizeof(fac1) );
}

static
void mod3_fac2( unsigned char * poly )
{
  mod3( poly , p , fac2 , sizeof(fac2) );
}


static
unsigned char is_zero( const unsigned char * v , int len )
{
  unsigned char r = 0;
  for(int i=0;i<len;i++) r |= v[i];

  unsigned rr = r;
  rr -= 1;  // 0->-1, else ->   0 <= v < 254
  rr >>= 8;
  return (rr&1);
}

#include "string.h"

/* byte 0 of output is 1 if input is 0 on GF(3)[x]/x^p-x-1; else 0 */
int crypto_core(unsigned char *outbytes,const unsigned char *inbytes,const unsigned char *kbytes,const unsigned char *cbytes)
{
  unsigned char mm[p];
  // only use lsb 2 bits
  // 00->0 , 01->1, 10->0, 11->2
  for(int i=0;i<p;i++) {
    char fi = (char)inbytes[i];
    char fi0 = fi&1;
    fi = fi0-(fi&(fi0<<1)); // 1,0,or -1
    fi += ((fi>>2)&0x3);  // 1,0,2
    mm[i] = (unsigned char)fi;
  }

  unsigned char r = 0;
  unsigned char mm2[p];
  memcpy(mm2,mm,p);
  mod3_fac0( mm2 );
  r |= is_zero( mm2 , sizeof(fac0)-1 );

  memcpy(mm2,mm,p);
  mod3_fac1( mm2 );
  r |= is_zero( mm2 , sizeof(fac1)-1 );

  mod3_fac2( mm );
  r |= is_zero( mm , sizeof(fac2)-1 );

  outbytes[0] = r;

  return 0;
}
