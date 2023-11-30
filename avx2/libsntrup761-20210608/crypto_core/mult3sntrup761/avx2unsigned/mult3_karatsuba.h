#ifndef _CORE_KARATSUBA_H_
#define _CORE_KARATSUBA_H_


#if defined(CRYPTO_NAMESPACE)

#define mult3_32x32  CRYPTO_NAMESPACE(mult3_32x32)
#define mult3_64x64  CRYPTO_NAMESPACE(mult3_64x64)
#define mult3_128x128  CRYPTO_NAMESPACE(mult3_128x128)
#define mult3_256x256  CRYPTO_NAMESPACE(mult3_256x256)
#define mult3_320x320  CRYPTO_NAMESPACE(mult3_320x320)

#define mult3_768_karatsuba3 CRYPTO_NAMESPACE(mult3_768_karatsuba3)
#define mult3_766_refined_karatsuba3 CRYPTO_NAMESPACE(mult3_766_refined_karatsuba3)


#endif



void mult3_32x32( unsigned char * h , const unsigned char * f , const unsigned char * g );
void mult3_64x64( unsigned char * h , const unsigned char * f , const unsigned char * g );
void mult3_128x128( unsigned char * h , const unsigned char * f , const unsigned char * g );
void mult3_256x256( unsigned char * h , const unsigned char * f , const unsigned char * g );
void mult3_320x320( unsigned char * h , const unsigned char * f , const unsigned char * g );

void mult3_768_karatsuba3( unsigned char * c , const unsigned char * a , const unsigned char * b );

// assume: a[512+254]=a[512+255]=0  b[512+254]=b[512+255]=0
void mult3_766_refined_karatsuba3( unsigned char * c , const unsigned char * a , const unsigned char * b );

#endif
