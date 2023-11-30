#include <string.h>

//#define _INI_KERNELRANDOM_

#ifdef _INI_KERNELRANDOM_
#include "kernelrandombytes.h"
#else
#include <openssl/rand.h>
#endif

#include "crypto_rng.h"
#include "randombytes.h"

unsigned long long randombytes_calls = 0;
unsigned long long randombytes_bytes = 0;

static unsigned int init = 0;

static unsigned char g[crypto_rng_KEYBYTES];
static unsigned char r[crypto_rng_OUTPUTBYTES];
static unsigned long long pos = crypto_rng_OUTPUTBYTES;

void randombytes(unsigned char *x,unsigned long long xlen)
{
  randombytes_calls += 1;
  randombytes_bytes += xlen;

  if (!init) {
#ifdef _INI_KERNELRANDOM_
    kernelrandombytes(g,sizeof g);
#else
    RAND_bytes(g, sizeof g);
#endif
    init = 1;
  }

#ifdef SIMPLE

  while (xlen > 0) {
    if (pos == crypto_rng_OUTPUTBYTES) {
      crypto_rng(r,g,g);
      pos = 0;
    }
    *x++ = r[pos]; xlen -= 1;
    r[pos++] = 0;
  }

#else /* same output but optimizing copies */

  while (xlen > 0) {
    unsigned long long ready;

    if (pos == crypto_rng_OUTPUTBYTES) {
      while (xlen > crypto_rng_OUTPUTBYTES) {
        crypto_rng(x,g,g);
        x += crypto_rng_OUTPUTBYTES;
        xlen -= crypto_rng_OUTPUTBYTES;
      }
      if (xlen == 0) return;

      crypto_rng(r,g,g);
      pos = 0;
    }

    ready = crypto_rng_OUTPUTBYTES - pos;
    if (xlen <= ready) ready = xlen;
    memcpy(x,r + pos,ready);
    memset(r + pos,0,ready);
    x += ready;
    xlen -= ready;
    pos += ready;
  }

#endif

}
