#ifndef HASH_H
#define HASH_H

/* ----- underlying hash function */

#define Hash_bytes 32

/* e.g., b = 0 means out = Hash0(in) */
void Hash_prefix(unsigned char *out,int b,const unsigned char *in,int inlen);

#endif

