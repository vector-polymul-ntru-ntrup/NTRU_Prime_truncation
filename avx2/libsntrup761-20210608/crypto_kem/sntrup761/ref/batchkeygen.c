#include "batchkeygen_params.h"

#include "randombytes.h"
#include "crypto_hash_sha512.h"
#include "crypto_sort_uint32.h"

#include "crypto_int8.h"
#include "crypto_int16.h"
#include "crypto_int32.h"
#include "crypto_uint16.h"
#include "crypto_uint32.h"
#define int8 crypto_int8
#define int16 crypto_int16
#define int32 crypto_int32
#define uint16 crypto_uint16
#define uint32 crypto_uint32


/* ----- arithmetic mod 3 */

typedef int8 small;

/* ----- arithmetic mod q */

typedef int16 Fq;
/* always represented as -(q-1)/2...(q-1)/2 */


/* ----- underlying hash function */

#define Hash_bytes 32

static void Hash(unsigned char *out,const unsigned char *in,int inlen)
{
  unsigned char h[64];
  int i;
  crypto_hash_sha512(h,in,inlen);
  for (i = 0;i < 32;++i) out[i] = h[i];
}


#if defined( LPR )
error here: Support SNTRUP only
#endif


/* ----- higher-level randomness */
/* XXX:repeated function from kem.c */
static void Short_random(small *out)
{
  uint32 L[ppadsort];
  int i;

  randombytes((unsigned char *) L,4*p);
  crypto_decode_pxint32(L,(unsigned char *) L);
  for (i = 0;i < w;++i) L[i] = L[i]&(uint32)-2;
  for (i = w;i < p;++i) L[i] = (L[i]&(uint32)-3)|1;
  for (i = p;i < ppadsort;++i) L[i] = 0xffffffff;
  crypto_sort_uint32(L,ppadsort);
  for (i = 0;i < p;++i) out[i] = (L[i]&3)-1;
}

/* XXX:repeated function from kem.c */
static void Small_random(small *out)
{
  uint32 L[p];
  int i;

  randombytes((unsigned char *) L,sizeof L);
  crypto_decode_pxint32(L,(unsigned char *) L);
  for (i = 0;i < p;++i) out[i] = (((L[i]&0x3fffffff)*3)>>30)-1;
}




/* ----- Streamlined NTRU Prime */

typedef small Inputs[p]; /* passed by reference */
#define Ciphertexts_bytes Rounded_bytes
#define SecretKeys_bytes (2*Small_bytes)
#define PublicKeys_bytes Rq_bytes



#include "crypto_kem.h"

#if !defined(N_KEYBATCH)
#define N_KEYBATCH (32)
#endif

#define KemSk_bytes (SecretKeys_bytes+PublicKeys_bytes+Small_bytes+Hash_bytes)

#include <stdlib.h>


#if N_KEYBATCH > 1

static
int _kem_keypair_fixedbatch(unsigned char *pk,unsigned char *sk)
{
  if( 1 >= N_KEYBATCH ) {
    int n = N_KEYBATCH;
    while( n ) {
      crypto_kem_keypair(pk,sk);
      pk += PublicKeys_bytes;
      sk += KemSk_bytes;
      n--;
    }
    return 0;
  }

  Fq temp[p+1];
  small *_buffer = malloc( sizeof(small)*p*N_KEYBATCH*2 + sizeof(Fq)*(p)*N_KEYBATCH );
  small *f = (small*)  _buffer;
  small *g = (small*) (_buffer + sizeof(small)*p*N_KEYBATCH);
  Fq *_finv = (Fq*)   (_buffer + sizeof(small)*2*p*N_KEYBATCH);

  int i;

  /* generate secret keys */
  for(i=0;i<N_KEYBATCH;i++) {
    for (;;) {
      small *v = (small *)temp;
      Small_random(g+i*p);
      crypto_core_iszeromod3((unsigned char *)v, (const unsigned char *)(g+i*p),0,0);
      if( 0==v[0] ) break;
    }
    Short_random(f+i*p);
    randombytes(sk+ i*KemSk_bytes + (SecretKeys_bytes+PublicKeys_bytes),Small_bytes);
  }
  /* calculate secret keys */
  {
    small * ginv = (small*)_finv;
    small * gs   = ginv;
    small * v    = (small*)temp;

    for(i=0;i<p;i++) gs[i] = g[i];
    for(i=1;i<N_KEYBATCH;i++)
      crypto_core_mult3((unsigned char *) &gs[i*p],(const unsigned char *) &gs[(i-1)*p],(const unsigned char *) (g+i*p),0);

    crypto_core_inv3((unsigned char *)v, (const unsigned char *)&gs[(N_KEYBATCH-1)*p],0,0);
    for(i=N_KEYBATCH-1;i>=2;i--) {
      crypto_core_mult3((unsigned char *)&ginv[i*p] , (const unsigned char *)v , (const unsigned char *)&gs[(i-1)*p],0);
      crypto_core_mult3((unsigned char *)v , (const unsigned char *)v , (const unsigned char *)(g+i*p),0);
    }
#if (N_KEYBATCH<2)
error here. N_KEYBATCH < 2
#endif
    crypto_core_mult3((unsigned char *) &ginv[p] , (const unsigned char *)v , (const unsigned char *)g,0);
    crypto_core_mult3((unsigned char *) &ginv[0] , (const unsigned char *)v , (const unsigned char *)(g+p),0);

    for(i=0;i<N_KEYBATCH;i++) {
      Small_encode(sk + i*(KemSk_bytes) ,&ginv[i*p]);  // stored in the wrong place
    }
  }

  /* calculate public keys */
  {
    Fq * finv = _finv;
    Fq * fs   = finv;

    for(i=0;i<p;i++) fs[i] = f[i];
    crypto_encode_pxint16((unsigned char *) fs, fs);
    for(i=1;i<N_KEYBATCH;i++) {
      crypto_core_mult((unsigned char *) &fs[i*p],(const unsigned char *) &fs[(i-1)*p],(const unsigned char *) (f+i*p),0);
    }

    crypto_core_invbig((unsigned char *)temp, (const unsigned char *)&fs[(N_KEYBATCH-1)*p],0,0);
    for(i=N_KEYBATCH-1;i>=2;i--) {
      crypto_core_multbig((unsigned char *)&finv[i*p] , (const unsigned char *)temp , (const unsigned char *)&fs[(i-1)*p],0);
      crypto_core_mult((unsigned char *)temp , (const unsigned char *)temp , (const unsigned char *)(f+i*p),0);
    }
    crypto_core_mult((unsigned char *) &finv[p] , (const unsigned char *)temp , (const unsigned char *)f,0);
    crypto_core_mult((unsigned char *) &finv[0] , (const unsigned char *)temp , (const unsigned char *)(f+p),0);

    for(i=0;i<N_KEYBATCH;i++) {
      crypto_core_mult((unsigned char *) temp , (const unsigned char *) (finv+i*p) , (const unsigned char *)(g+i*p),0);
      Rq_encode(pk,temp);
      pk += PublicKeys_bytes;
    }
    pk -= PublicKeys_bytes*N_KEYBATCH;
  }

  /* encode secret keys */
  {
    int j;
    for(j=0;j<N_KEYBATCH;j++) {
      for (i = 0;i < PublicKeys_bytes;++i) sk[SecretKeys_bytes+i] = pk[i];
      sk[SecretKeys_bytes-1] = 4;
      Hash(sk+SecretKeys_bytes+PublicKeys_bytes+Small_bytes,sk+SecretKeys_bytes-1,1+PublicKeys_bytes);
      for (i=0;i<Small_bytes;i++) sk[Small_bytes+i]=sk[i];   // move to the correct place
      Small_encode(sk,f+j*p);

      pk += PublicKeys_bytes;
      sk += KemSk_bytes;
    }
  }
  free( _buffer );
  return 0;
}

#endif  // N_KEYBATCH > 1



int crypto_kem_keypair_batch(unsigned char *pk,unsigned char *sk, unsigned num)
{
  int n = (int)num;

#if N_KEYBATCH > 1
  while( n >= N_KEYBATCH ) {
    _kem_keypair_fixedbatch(pk,sk);
    n -= N_KEYBATCH;
    pk += N_KEYBATCH*PublicKeys_bytes;
    sk += N_KEYBATCH*KemSk_bytes;
  }
#endif

  while( n ) {
    crypto_kem_keypair(pk,sk);
    n --;
    pk += PublicKeys_bytes;
    sk += KemSk_bytes;
  }

  return 0;
}


