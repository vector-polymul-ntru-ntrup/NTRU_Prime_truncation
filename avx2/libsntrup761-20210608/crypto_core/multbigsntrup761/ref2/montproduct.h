#ifndef montproduct_H
#define montproduct_H


#include "ref.h"

// note : montproduct with v4158_16 to multiply by R=2^16

static inline
int16 mullo__(int16 x,int16 y) { return x*y; }

static inline
int16 mulhi__(int16 x,int16 y) { return (x*(int32)y)>>16; }

static inline
int16 montproduct( int16 x , int16 y )
{
  int i;
  int16 lo = mullo__( x , y );
  int16 hi = mulhi__( x , y );
  int16 d = mullo__( lo , 15631 );
  int16 e = mulhi__( d , 4591 );
  return hi-e;
}

#endif
