/*
   PQCgenKAT_kem.c
   Created by Bassham, Lawrence E (Fed) on 8/29/17.
   Copyright © 2017 Bassham, Lawrence E (Fed). All rights reserved.
   + mods from djb: see KATNOTES
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "crypto_kem_sntrup761.h"

#define crypto_kem_keypair   crypto_kem_sntrup761_keypair
#define crypto_kem_enc       crypto_kem_sntrup761_enc
#define crypto_kem_dec       crypto_kem_sntrup761_dec
#define crypto_kem_keypair_batch  crypto_kem_sntrup761_keypair_batch

#define crypto_kem_BYTES crypto_kem_sntrup761_BYTES
#define crypto_kem_SECRETKEYBYTES crypto_kem_sntrup761_SECRETKEYBYTES
#define crypto_kem_CIPHERTEXTBYTES crypto_kem_sntrup761_CIPHERTEXTBYTES
#define crypto_kem_PUBLICKEYBYTES crypto_kem_sntrup761_PUBLICKEYBYTES



int cmp_llu(const void *a, const void*b)
{   
    if(*(long long *)a < *(long long *)b) return -1;
    if(*(long long *)a > *(long long *)b) return 1;

    return 0;
}

long long median(long long *l, size_t llen)
{   
    qsort(l,llen,sizeof(long long),cmp_llu);

    if(llen%2) return l[llen/2];
    else return (l[llen/2-1]+l[llen/2])/2;
}

long long get_cycles(void)
{   
    unsigned long long result;
    asm volatile(".byte 15;.byte 49;shlq $32,%%rdx;orq %%rdx,%%rax"
    : "=a" (result) ::  "%rdx");

    return result;
}




void    fprintBstr(FILE *fp, char *S, unsigned char *A, unsigned long long L);
void    fprint16(FILE *fp, char *S, int16_t *A, unsigned long long L);
void    fprint8(FILE *fp, char *S, int8_t *A, unsigned long long L);


#if defined(N_KEYBATCH)
#define TESTNUM  N_KEYBATCH
#else
#define TESTNUM 64
#endif

int8_t pk[TESTNUM*crypto_kem_PUBLICKEYBYTES];
int8_t sk[TESTNUM*crypto_kem_SECRETKEYBYTES];
int8_t ct[TESTNUM*crypto_kem_CIPHERTEXTBYTES];
int8_t ss[TESTNUM*crypto_kem_BYTES];
int8_t ss1[TESTNUM*crypto_kem_BYTES];

long long tkeypairbatch;
long long tkeypair[TESTNUM];
long long tenc[TESTNUM];
long long tdec[TESTNUM];

void printtimings(const char *label,long long *t)
{
    int i;

    printf("%s median %llu, individual", label, median(t, TESTNUM));
    for (i=0; i<TESTNUM; i++)
        printf(" %llu", t[i]);
    printf("\n");
}

int
main()
{
    int   nfail = 0;
    int i;
    long long t0, t1;
    int batch;

#if defined(N_KEYBATCH)
    printf("N_KEYBATCH = %d, TESTNUM = %d.\n", N_KEYBATCH , TESTNUM);
#else
    printf("no N_LEYBATCH defined. TESTNUM = %d.\n", TESTNUM );
#endif

    for (batch=0; batch<4; batch++) {
        if (batch) {
            t0 = get_cycles();
            crypto_kem_keypair_batch(pk, sk, TESTNUM);
            tkeypairbatch = get_cycles() - t0;
        }
        for (i=0; i<TESTNUM; i++) {
            int8_t *pki = pk+i*crypto_kem_PUBLICKEYBYTES;
            int8_t *ski = sk+i*crypto_kem_SECRETKEYBYTES;
            int8_t *cti = ct+i*crypto_kem_CIPHERTEXTBYTES;
            int8_t *ssi = ss+i*crypto_kem_BYTES;
            int8_t *ss1i = ss1+i*crypto_kem_BYTES;

            t0 = get_cycles();

            if (!batch) {
                crypto_kem_keypair(pki, ski);
                t1 = get_cycles();
                tkeypair[i] = t1 - t0;
                t0 = t1;
            }

            crypto_kem_enc(cti, ssi, pki);
            t1 = get_cycles();
            tenc[i] = t1 - t0;
            t0 = t1;

            crypto_kem_dec(ss1i, cti, ski);
            t1 = get_cycles();
            tdec[i] = t1 - t0;
            t0 = t1;

            for(int j=0;j<crypto_kem_BYTES;j++) {
                if( ss1i[j] != ssi[j] ) {
                    nfail++;
                    printf("shared secret in-consistent: %d.\n", j );
                    fprintBstr( stdout , "enc: " , ss , crypto_kem_BYTES );
                    fprintBstr( stdout , "dec: " , ss1 , crypto_kem_BYTES );
                    break;
                }
            }
        }
        if (batch) {
            printf("keypairbatch %llu per key\n", (tkeypairbatch+TESTNUM-1)/TESTNUM);
	    printf("latency %llu\n",tkeypairbatch);
	}
        else
            printtimings("keypair",tkeypair);
        printtimings("enc",tenc);
        printtimings("dec",tdec);
        printf("%d tests, %d passed\n", TESTNUM, TESTNUM-nfail);
    }

    return 0;
}









///////////////////////////////////////////////////////////////////



void
fprintBstr(FILE *fp, char *S, unsigned char *A, unsigned long long L)
{
    unsigned long long i;

    fprintf(fp, "%s", S);

    for ( i=0; i<L; i++ )
        fprintf(fp, "%02X", A[i]);

    if ( L == 0 )
        fprintf(fp, "00");

    fprintf(fp, "\n");
}


void    fprint8(FILE *fp, char *S, int8_t *A, unsigned long long L)
{
    unsigned long long i;

    fprintf(fp, "%s", S);

    for ( i=0; i<L; i++ )
        fprintf(fp, " %3d", A[i]);

    if ( L == 0 )
        fprintf(fp, "-");

    fprintf(fp, "\n");
}

void    fprint16(FILE *fp, char *S, int16_t *A, unsigned long long L)
{
    unsigned long long i;

    fprintf(fp, "%s", S);

    for ( i=0; i<L; i++ )
        fprintf(fp, " %5d", A[i]);

    if ( L == 0 )
        fprintf(fp, "-");

    fprintf(fp, "\n");
}

