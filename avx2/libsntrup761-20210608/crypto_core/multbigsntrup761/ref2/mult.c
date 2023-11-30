#include "crypto_core.h"
#include "params.h"

#include "crypto_int8.h"
#include "crypto_int16.h"
#include "crypto_int32.h"
#define int8 crypto_int8
#define int16 crypto_int16
#define int32 crypto_int32
typedef int8 small;

typedef int16 Fq;
/* always represented as -(q-1)/2...(q-1)/2 */

/* works for -14000000 < x < 14000000 if q in 4591, 4621, 5167 */
static Fq Fq_freeze(int32 x)
{
  x -= q*((q18*x)>>18);
  x -= q*((q27*x+67108864)>>27);
  return x;
}


#include "ref.h"
#include "montproduct.h"

int crypto_core(unsigned char *outbytes,const unsigned char *inbytes,const unsigned char *kbytes,const unsigned char *cbytes)
{
  Fq f[768];
  Fq g[768];
  Fq fg[1536];
  int i;

  crypto_decode_pxint16(f,inbytes);
  for(i=p;i<768;i++) f[i] = 0;

  crypto_decode_pxint16(g,kbytes);
  for(i=p;i<768;i++) g[i] = 0;

  mult768_over64( fg , f , g );

  for (i = p+p-2;i >= p;--i) {
    fg[i-p] = (fg[i-p]+fg[i]);
    fg[i-p+1] = (fg[i-p+1]+fg[i]);
  }

  for(i=0;i<p;i++) fg[i] = montproduct( fg[i] , 2721 );
  crypto_encode_pxint16(outbytes,fg);


  return 0;
}
