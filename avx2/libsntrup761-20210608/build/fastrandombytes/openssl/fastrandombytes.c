
#include "randombytes.h"
#include <openssl/rand.h>

unsigned long long randombytes_calls = 0;
unsigned long long randombytes_bytes = 0;


void randombytes(unsigned char *buf,unsigned long long num)
{
  randombytes_calls += 1;
  randombytes_bytes += num;

  RAND_bytes(buf, num);
}

