#include <assert.h>
#include <inttypes.h>
#include "ref.h"

#define q 4591
#define qinv 15631 /* reciprocal of q mod 2^16 */
#define q15 7 /* round(2^15/q) */

long long nummul = 0; /* mullo, mulhi, mulhrs */
long long numadd = 0; /* add, sub */
long long numneg = 0; /* counted separately since neg wants to be eliminated */

static int16 neg(int16 x)
{
  ++numneg;
  return -x;
}

static int16 add(int16 x,int16 y)
{
  ++numadd;
  return x+y;
}

static int16 sub(int16 x,int16 y)
{
  ++numadd;
  return x-y;
}

static int16 mullo(int16 x,int16 y)
{
  ++nummul;
  return x*y;
}

static int16 mulhi(int16 x,int16 y)
{
  ++nummul;
  return (x*(int32)y)>>16;
}

static int16 mulhrs(int16 x,int16 y)
{
  ++nummul;
  return (x*(int32)y+16384)>>15;
}

/* input range: -2^15 <= x < 2^15 */
/* output range: -4000 < out < 4000 */
static int16 squeeze13(int16 x)
{
  /* XXX: for q=5167, need to do mulhi+mulhrs+mullo to achieve this range */
  x = sub(x,mullo(mulhrs(x,q15),q));
  assert(x >= -4000);
  assert(x <= 4000);
  return x;
}

/* input range: -2^15 <= x < 2^15 */
/* output range: -8000 < out < 8000 */
static int16 squeeze14(int16 x)
{
  x = sub(x,mullo(mulhrs(x,q15),q));
  assert(x >= -8000);
  assert(x <= 8000);
  return x;
}

static int16x16 add_x16(int16x16 f,int16x16 g)
{
  int p;
  int16x16 result;

  for (p = 0;p < 16;++p)
    result.lane[p] = add(f.lane[p],g.lane[p]);
  return result;
}

static int16x16 neg_x16(int16x16 f)
{
  int p;
  int16x16 result;

  for (p = 0;p < 16;++p)
    result.lane[p] = neg(f.lane[p]);
  return result;
}

static int16x16 sub_x16(int16x16 f,int16x16 g)
{
  int p;
  int16x16 result;

  for (p = 0;p < 16;++p)
    result.lane[p] = sub(f.lane[p],g.lane[p]);
  return result;
}

static int16x16 squeeze13_x16(int16x16 f)
{
  int p;
  int16x16 result;

  for (p = 0;p < 16;++p)
    result.lane[p] = squeeze13(f.lane[p]);
  return result;
}

static int16x16 squeeze14_x16(int16x16 f)
{
  int p;
  int16x16 result;

  for (p = 0;p < 16;++p)
    result.lane[p] = squeeze14(f.lane[p]);
  return result;
}

static void assertrange_x16(int16x16 f,int limit)
{
  int p;
  for (p = 0;p < 16;++p) {
    assert(f.lane[p] >= -limit);
    assert(f.lane[p] <= limit);
  }
}

/* h = fg/65536 in (k^16)[x] */
/* where f,g are 1-coeff polys */
/* input range: +-16000 */
/* output range: +-8000 */
void mult1_over65536_x16(int16x16 h[1],const int16x16 f[1],const int16x16 g[1])
{
  /* 4 mul + 1 add */

  int p;

  assertrange_x16(f[0],16000);
  assertrange_x16(g[0],16000);

  for (p = 0;p < 16;++p) {
    int16 fp = f[0].lane[p];
    int16 gp = g[0].lane[p];
    int16 gpqinv = mullo(gp,qinv);
    int16 b = mulhi(fp,gp);
    int16 d = mullo(fp,gpqinv);
    int16 e = mulhi(d,q);
    int16 hp = sub(b,e);
    h[0].lane[p] = hp;
  }

  assertrange_x16(h[0],8000);
}

/* h = fg/65536 in (k^16)[x] */
/* where f,g are 2-coeff polys */
/* input range: +-8000 */
/* output range: +-8000 */
void mult2_over65536_x16(int16x16 h[3],const int16x16 f[2],const int16x16 g[2])
{
  /* strategy: refined Karatsuba */
  /* 14 mul + 8 add */
  /* XXX: can replace mullo(g01p,qinv) with an add */
  /* XXX: similarly at higher levels */

  int16x16 f01[1];
  int16x16 g01[1];

  int i;
  for (i = 0;i < 2;++i) {
    assertrange_x16(f[i],8000);
    assertrange_x16(g[i],8000);
  }

  f01[0] = add_x16(f[0],f[1]);
  g01[0] = add_x16(g[0],g[1]);

  mult1_over65536_x16(h,f,g);
  mult1_over65536_x16(h+2,f+1,g+1);
  mult1_over65536_x16(h+1,f01,g01);

  h[1] = squeeze14_x16(sub_x16(h[1],add_x16(h[0],h[2])));

  for (i = 0;i < 3;++i)
    assertrange_x16(h[i],8000);
}

/* h = fg/65536 in (k^16)[x] */
/* where f,g are 4-coeff polys */
/* input range: +-4000 */
/* output range: +-8000 */
void mult4_over65536_x16(int16x16 h[7],const int16x16 f[4],const int16x16 g[4])
{
  /* strategy: refined Karatsuba */
  /* 48 mul + 38 add */

  int16x16 f01[2];
  int16x16 g01[2];
  int16x16 h01[3];
  int16x16 c;

  int i;
  for (i = 0;i < 4;++i) {
    assertrange_x16(f[i],4000);
    assertrange_x16(g[i],4000);
  }

  f01[0] = add_x16(f[0],f[2]);
  f01[1] = add_x16(f[1],f[3]);
  g01[0] = add_x16(g[0],g[2]);
  g01[1] = add_x16(g[1],g[3]);

  mult2_over65536_x16(h,f,g);
  mult2_over65536_x16(h+4,f+2,g+2);
  mult2_over65536_x16(h01,f01,g01);

  c = sub_x16(h[2],h[4]);
  h[2] = squeeze14_x16(add_x16(sub_x16(h01[0],h[0]),c));
  h[3] = squeeze14_x16(sub_x16(h01[1],add_x16(h[1],h[5])));
  h[4] = squeeze14_x16(sub_x16(sub_x16(h01[2],h[6]),c));

  for (i = 0;i < 7;++i)
    assertrange_x16(h[i],8000);
}

/* h = fg/65536 in (k^16)[x] */
/* where f,g are 8-coeff polys */
/* input range: +-4000 */
/* output range: +-8000 */
void mult8_over65536_x16(int16x16 h[15],const int16x16 f[8],const int16x16 g[8])
{
  /* strategy: refined Karatsuba */
  /* 174 mul + 154 add */

  int16x16 f01[4],g01[4],h01[7],c0,c1,c2;

  int i;
  for (i = 0;i < 8;++i) {
    assertrange_x16(f[i],4000);
    assertrange_x16(g[i],4000);
  }

  f01[0] = squeeze13_x16(add_x16(f[0],f[4]));
  f01[1] = squeeze13_x16(add_x16(f[1],f[5]));
  f01[2] = squeeze13_x16(add_x16(f[2],f[6]));
  f01[3] = squeeze13_x16(add_x16(f[3],f[7]));
  g01[0] = squeeze13_x16(add_x16(g[0],g[4]));
  g01[1] = squeeze13_x16(add_x16(g[1],g[5]));
  g01[2] = squeeze13_x16(add_x16(g[2],g[6]));
  g01[3] = squeeze13_x16(add_x16(g[3],g[7]));

  mult4_over65536_x16(h,f,g);
  mult4_over65536_x16(h+8,f+4,g+4);
  mult4_over65536_x16(h01,f01,g01);

  c0 = sub_x16(h[4],h[8]);
  c1 = sub_x16(h[5],h[9]);
  c2 = sub_x16(h[6],h[10]);

  h[4] = squeeze14_x16(add_x16(sub_x16(h01[0],h[0]),c0));
  h[5] = squeeze14_x16(add_x16(sub_x16(h01[1],h[1]),c1));
  h[6] = squeeze14_x16(add_x16(sub_x16(h01[2],h[2]),c2));
  h[7] = squeeze14_x16(sub_x16(h01[3],add_x16(h[3],h[11])));
  h[8] = squeeze14_x16(sub_x16(sub_x16(h01[4],h[12]),c0));
  h[9] = squeeze14_x16(sub_x16(sub_x16(h01[5],h[13]),c1));
  h[10] = squeeze14_x16(sub_x16(sub_x16(h01[6],h[14]),c2));

  for (i = 0;i < 15;++i)
    assertrange_x16(h[i],8000);
}

/* h = fg/65536 in (k^16)[x]/(x^8+1) */
/* input range: +-4000 */
/* output range: +-4000 */
void mult8_nega_over65536_x16(int16x16 h[8],const int16x16 f[8],const int16x16 g[8])
{
  /* strategy: reduced refined Karatsuba */
  /* 176 mul + 159 add */

  int16x16 f01[4],g01[4],h01[7],htop[7],c0,c1,c2,d0,d1,d2;

  int i;
  for (i = 0;i < 8;++i) {
    assertrange_x16(f[i],4000);
    assertrange_x16(g[i],4000);
  }

  f01[0] = squeeze13_x16(add_x16(f[0],f[4]));
  f01[1] = squeeze13_x16(add_x16(f[1],f[5]));
  f01[2] = squeeze13_x16(add_x16(f[2],f[6]));
  f01[3] = squeeze13_x16(add_x16(f[3],f[7]));
  g01[0] = squeeze13_x16(add_x16(g[0],g[4]));
  g01[1] = squeeze13_x16(add_x16(g[1],g[5]));
  g01[2] = squeeze13_x16(add_x16(g[2],g[6]));
  g01[3] = squeeze13_x16(add_x16(g[3],g[7]));

  mult4_over65536_x16(h,f,g);
  mult4_over65536_x16(htop,f+4,g+4);
  mult4_over65536_x16(h01,f01,g01);

  c0 = sub_x16(h[4],htop[0]);
  c1 = sub_x16(h[5],htop[1]);
  c2 = sub_x16(h[6],htop[2]);
  d0 = add_x16(h[0],htop[4]);
  d1 = add_x16(h[1],htop[5]);
  d2 = add_x16(h[2],htop[6]);

  h[7] = squeeze13_x16(sub_x16(h01[3],add_x16(h[3],htop[3])));
  h[3] = squeeze13_x16(sub_x16(h[3],htop[3]));

  h[0] = squeeze13_x16(add_x16(sub_x16(c0,h01[4]),d0));
  h[1] = squeeze13_x16(add_x16(sub_x16(c1,h01[5]),d1));
  h[2] = squeeze13_x16(add_x16(sub_x16(c2,h01[6]),d2));
  h[4] = squeeze13_x16(sub_x16(add_x16(c0,h01[0]),d0));
  h[5] = squeeze13_x16(sub_x16(add_x16(c1,h01[1]),d1));
  h[6] = squeeze13_x16(sub_x16(add_x16(c2,h01[2]),d2));

  for (i = 0;i < 8;++i)
    assertrange_x16(h[i],4000);
}

/* multiply f by x in (k^16)[x]/(x^8+1) */
static void twist8_1(int16x16 f[8])
{
  int16x16 f0 = f[0];
  int16x16 f1 = f[1];
  int16x16 f2 = f[2];
  int16x16 f3 = f[3];
  int16x16 f4 = f[4];
  int16x16 f5 = f[5];
  int16x16 f6 = f[6];
  int16x16 f7 = f[7];
  f[0] = neg_x16(f7);
  f[1] = f0;
  f[2] = f1;
  f[3] = f2;
  f[4] = f3;
  f[5] = f4;
  f[6] = f5;
  f[7] = f6;
}

/* multiply f by x^2 in (k^16)[x]/(x^8+1) */
static void twist8_2(int16x16 f[8])
{
  int16x16 f0 = f[0];
  int16x16 f1 = f[1];
  int16x16 f2 = f[2];
  int16x16 f3 = f[3];
  int16x16 f4 = f[4];
  int16x16 f5 = f[5];
  int16x16 f6 = f[6];
  int16x16 f7 = f[7];
  f[0] = neg_x16(f6);
  f[1] = neg_x16(f7);
  f[2] = f0;
  f[3] = f1;
  f[4] = f2;
  f[5] = f3;
  f[6] = f4;
  f[7] = f5;
}

/* multiply f by x^3 in (k^16)[x]/(x^8+1) */
static void twist8_3(int16x16 f[8])
{
  int16x16 f0 = f[0];
  int16x16 f1 = f[1];
  int16x16 f2 = f[2];
  int16x16 f3 = f[3];
  int16x16 f4 = f[4];
  int16x16 f5 = f[5];
  int16x16 f6 = f[6];
  int16x16 f7 = f[7];
  f[0] = neg_x16(f5);
  f[1] = neg_x16(f6);
  f[2] = neg_x16(f7);
  f[3] = f0;
  f[4] = f1;
  f[5] = f2;
  f[6] = f3;
  f[7] = f4;
}

/* multiply f by x^4 in (k^16)[x]/(x^8+1) */
static void twist8_4(int16x16 f[8])
{
  int16x16 f0 = f[0];
  int16x16 f1 = f[1];
  int16x16 f2 = f[2];
  int16x16 f3 = f[3];
  int16x16 f4 = f[4];
  int16x16 f5 = f[5];
  int16x16 f6 = f[6];
  int16x16 f7 = f[7];
  f[0] = neg_x16(f4);
  f[1] = neg_x16(f5);
  f[2] = neg_x16(f6);
  f[3] = neg_x16(f7);
  f[4] = f0;
  f[5] = f1;
  f[6] = f2;
  f[7] = f3;
}

/* multiply f by x^6 in (k^16)[x]/(x^8+1) */
static void twist8_6(int16x16 f[8])
{
  int16x16 f0 = f[0];
  int16x16 f1 = f[1];
  int16x16 f2 = f[2];
  int16x16 f3 = f[3];
  int16x16 f4 = f[4];
  int16x16 f5 = f[5];
  int16x16 f6 = f[6];
  int16x16 f7 = f[7];
  f[0] = neg_x16(f2);
  f[1] = neg_x16(f3);
  f[2] = neg_x16(f4);
  f[3] = neg_x16(f5);
  f[4] = neg_x16(f6);
  f[5] = neg_x16(f7);
  f[6] = f0;
  f[7] = f1;
}

/* multiply f by x^10 in (k^16)[x]/(x^8+1) */
static void twist8_10(int16x16 f[8])
{
  int16x16 f0 = f[0];
  int16x16 f1 = f[1];
  int16x16 f2 = f[2];
  int16x16 f3 = f[3];
  int16x16 f4 = f[4];
  int16x16 f5 = f[5];
  int16x16 f6 = f[6];
  int16x16 f7 = f[7];
  f[0] = f6;
  f[1] = f7;
  f[2] = neg_x16(f0);
  f[3] = neg_x16(f1);
  f[4] = neg_x16(f2);
  f[5] = neg_x16(f3);
  f[6] = neg_x16(f4);
  f[7] = neg_x16(f5);
}

/* multiply f by x^12 in (k^16)[x]/(x^8+1) */
static void twist8_12(int16x16 f[8])
{
  int16x16 f0 = f[0];
  int16x16 f1 = f[1];
  int16x16 f2 = f[2];
  int16x16 f3 = f[3];
  int16x16 f4 = f[4];
  int16x16 f5 = f[5];
  int16x16 f6 = f[6];
  int16x16 f7 = f[7];
  f[0] = f4;
  f[1] = f5;
  f[2] = f6;
  f[3] = f7;
  f[4] = neg_x16(f0);
  f[5] = neg_x16(f1);
  f[6] = neg_x16(f2);
  f[7] = neg_x16(f3);
}

/* multiply f by x^13 in (k^16)[x]/(x^8+1) */
static void twist8_13(int16x16 f[8])
{
  int16x16 f0 = f[0];
  int16x16 f1 = f[1];
  int16x16 f2 = f[2];
  int16x16 f3 = f[3];
  int16x16 f4 = f[4];
  int16x16 f5 = f[5];
  int16x16 f6 = f[6];
  int16x16 f7 = f[7];
  f[0] = f3;
  f[1] = f4;
  f[2] = f5;
  f[3] = f6;
  f[4] = f7;
  f[5] = neg_x16(f0);
  f[6] = neg_x16(f1);
  f[7] = neg_x16(f2);
}

/* multiply f by x^14 in (k^16)[x]/(x^8+1) */
static void twist8_14(int16x16 f[8])
{
  int16x16 f0 = f[0];
  int16x16 f1 = f[1];
  int16x16 f2 = f[2];
  int16x16 f3 = f[3];
  int16x16 f4 = f[4];
  int16x16 f5 = f[5];
  int16x16 f6 = f[6];
  int16x16 f7 = f[7];
  f[0] = f2;
  f[1] = f3;
  f[2] = f4;
  f[3] = f5;
  f[4] = f6;
  f[5] = f7;
  f[6] = neg_x16(f0);
  f[7] = neg_x16(f1);
}

/* multiply f by x^15 in (k^16)[x]/(x^8+1) */
static void twist8_15(int16x16 f[8])
{
  int16x16 f0 = f[0];
  int16x16 f1 = f[1];
  int16x16 f2 = f[2];
  int16x16 f3 = f[3];
  int16x16 f4 = f[4];
  int16x16 f5 = f[5];
  int16x16 f6 = f[6];
  int16x16 f7 = f[7];
  f[0] = f1;
  f[1] = f2;
  f[2] = f3;
  f[3] = f4;
  f[4] = f5;
  f[5] = f6;
  f[6] = f7;
  f[7] = neg_x16(f0);
}

/* input range: +-4000 */
/* output range: +-4000 */
static void fft64(int16x16 fpad[16][8],const int16x16 f[64])
{
  /* 256 mul + 512 add + some negations */

  int i,j;

  /* stage 1: y^16-1 -> y^8-1, y^8+1 */
  /* integrated with initial lift */
  /* XXX: integrate more */

  for (i = 0;i < 8;++i)
    for (j = 0;j < 8;++j)
      fpad[i+8][j] = fpad[i][j] = f[i+8*j];

  /* stage 2a: y^8-1 -> y^4-1, y^4+1 */

  for (i = 0;i < 4;++i)
    for (j = 0;j < 8;++j) {
      int16x16 a = fpad[i][j];
      int16x16 A = fpad[i+4][j];

      /* a y^i x^j + A y^(i+4) x^j */
      /* -> (a+A) y^i x^j, (a-A) y^i x^j */

      fpad[i][j] = add_x16(a,A);
      fpad[i+4][j] = sub_x16(a,A);
    }

  /* stage 2b: y^8+1 -> y^4-x^4, y^4+x^4 */

  for (i = 8;i < 12;++i)
    for (j = 0;j < 4;++j) {
      int16x16 a = fpad[i][j];
      int16x16 b = fpad[i][j+4];
      int16x16 A = fpad[i+4][j];
      int16x16 B = fpad[i+4][j+4];

      /* a y^i x^j + b y^i x^(j+4) + A y^(i+4) x^j + B y^(i+4) x^(j+4) */
      /* -> (a-B) y^i x^j + (b+A) y^i x^(j+4), */
      /*    (a+B) y^i x^j + (b-A) y^i x^(j+4) */

      fpad[i][j] = sub_x16(a,B);
      fpad[i][j+4] = add_x16(b,A);
      fpad[i+4][j] = add_x16(a,B);
      fpad[i+4][j+4] = sub_x16(b,A);
    }

  /* twist y^4-1,y^4+1,y^4-x^4,y^4+x^4 -> z^4-1,z^4-1,z^4-1,z^4-1: */
  /* 1,y,y^2,y^3,1,y,y^2,y^3,1,y,y^2,y^3,1,y,y^2,y^3 */
  /* -> 1,z,z^2,z^3,1,zx^2,z^2x^4,z^3x^6,1,zx,z^2x^2,z^3x^3,1,z/x,z^2/x^2,z^3/x^3 */

  twist8_2(fpad[5]);
  twist8_4(fpad[6]);
  twist8_6(fpad[7]);
  twist8_1(fpad[9]);
  twist8_2(fpad[10]);
  twist8_3(fpad[11]);
  twist8_15(fpad[13]);
  twist8_14(fpad[14]);
  twist8_13(fpad[15]);

  /* rename z as y: y^4-1,y^4-1,y^4-1,y^4-1 */

  /* stage 3: y^4-1 -> y^2-1,y^2+1 */

  for (i = 0;i < 16;++i) if (!(i & 2))
    for (j = 0;j < 8;++j) {
      int16x16 a = fpad[i][j];
      int16x16 A = fpad[i+2][j];
      fpad[i][j] = add_x16(a,A);
      fpad[i+2][j] = sub_x16(a,A);
    }

  /* stage 4a: y^2-1 -> y-1, y+1 */

  for (i = 0;i < 16;i += 4)
    for (j = 0;j < 8;++j) {
      int16x16 a = fpad[i][j];
      int16x16 A = fpad[i+1][j];
      fpad[i][j] = add_x16(a,A);
      fpad[i+1][j] = sub_x16(a,A);
    }

  /* stage 4b: y^2+1 -> y-x^4, y+x^4 */

  for (i = 2;i < 16;i += 4)
    for (j = 0;j < 4;++j) {
      int16x16 a = fpad[i][j];
      int16x16 b = fpad[i][j+4];
      int16x16 A = fpad[i+1][j];
      int16x16 B = fpad[i+1][j+4];

      fpad[i][j] = sub_x16(a,B);
      fpad[i][j+4] = add_x16(b,A);
      fpad[i+1][j] = add_x16(a,B);
      fpad[i+1][j+4] = sub_x16(b,A);
    }

  for (i = 0;i < 16;++i)
    for (j = 0;j < 8;++j)
      fpad[i][j] = squeeze13_x16(fpad[i][j]);
}

/* inverse of fft64 except for a multiplication by 16 */
static void unfft64_scale16(int16x16 f[64],int16x16 fpad[16][8])
{
  int i,j;

  /* undo stage 4 */

  for (i = 0;i < 16;i += 4)
    for (j = 0;j < 8;++j) {
      int16x16 a = fpad[i][j];
      int16x16 A = fpad[i+1][j];
      fpad[i][j] = add_x16(a,A);
      fpad[i+1][j] = sub_x16(a,A);
    }

  for (i = 2;i < 16;i += 4)
    for (j = 0;j < 4;++j) {
      int16x16 a = fpad[i][j];
      int16x16 b = fpad[i][j+4];
      int16x16 A = fpad[i+1][j];
      int16x16 B = fpad[i+1][j+4];

      fpad[i][j] = add_x16(A,a);
      fpad[i][j+4] = add_x16(b,B);
      fpad[i+1][j] = sub_x16(b,B);
      fpad[i+1][j+4] = sub_x16(A,a);
    }

  /* undo stage 3 */

  for (i = 0;i < 16;++i) if (!(i & 2))
    for (j = 0;j < 8;++j) {
      int16x16 a = fpad[i][j];
      int16x16 A = fpad[i+2][j];
      fpad[i][j] = add_x16(a,A);
      fpad[i+2][j] = sub_x16(a,A);
    }

  /* undo twists */

  twist8_14(fpad[5]);
  twist8_12(fpad[6]);
  twist8_10(fpad[7]);
  twist8_15(fpad[9]);
  twist8_14(fpad[10]);
  twist8_13(fpad[11]);
  twist8_1(fpad[13]);
  twist8_2(fpad[14]);
  twist8_3(fpad[15]);

  for (i = 0;i < 16;++i)
    for (j = 0;j < 8;++j)
      fpad[i][j] = squeeze13_x16(fpad[i][j]);

  /* undo stage 2 */

  for (i = 0;i < 4;++i)
    for (j = 0;j < 8;++j) {
      int16x16 a = fpad[i][j];
      int16x16 A = fpad[i+4][j];

      fpad[i][j] = add_x16(a,A);
      fpad[i+4][j] = sub_x16(a,A);
    }

  for (i = 8;i < 12;++i)
    for (j = 0;j < 4;++j) {
      int16x16 a = fpad[i][j];
      int16x16 b = fpad[i][j+4];
      int16x16 A = fpad[i+4][j];
      int16x16 B = fpad[i+4][j+4];

      fpad[i][j] = add_x16(A,a);
      fpad[i][j+4] = add_x16(b,B);
      fpad[i+4][j] = sub_x16(b,B);
      fpad[i+4][j+4] = sub_x16(A,a);
    }

  /* undo stage 1 */

  for (i = 0;i < 7;++i)
    for (j = 0;j < 8;++j) {
      int16x16 a = fpad[i][j];
      int16x16 A = fpad[i+8][j];

      fpad[i][j] = add_x16(a,A);
      fpad[i+8][j] = sub_x16(a,A);
    }
  for (i = 7;i < 8;++i)
    for (j = 0;j < 8;++j) {
      int16x16 a = fpad[i][j];
      fpad[i][j] = add_x16(a,a);
      /* fpad[i+8][j] = 0; */ /* unused below */
    }

  /* map to (k[x]/(x^8+1))[y]/(y^8-x) */

  for (i = 0;i < 7;++i) {
    f[i] = squeeze13_x16(sub_x16(fpad[i][0],fpad[i+8][7]));
    for (j = 1;j < 8;++j)
      f[i+8*j] = squeeze13_x16(add_x16(fpad[i][j],fpad[i+8][j-1]));
  }
  for (i = 7;i < 8;++i) {
    /* y^15 does not appear; i.e., fpad[i+8] is 0 */
    for (j = 0;j < 8;++j)
      f[i+8*j] = squeeze13_x16(fpad[i][j]);
  }
}

/* h = fg/4096 in (k^16)[y]/(y^64+1) */
/* input range: +-4000 */
/* output range: +-4000 */
void mult64_nega_over4096_x16(int16x16 h[64],const int16x16 f[64],const int16x16 g[64])
{
  /* strategy: Nussbaumer's trick */
  /* map k[y]/(y^64+1) to (k[x]/(x^8+1))[y]/(y^8-x) */
  /* lift to (k[x]/(x^8+1))[y] */
  /* map to (k[x]/(x^8+1))[y]/(y^16-1) */
  /* then use size-16 FFT, and 16 mults in k[x]/(x^8+1) */

  int16x16 fpad[16][8];
  int16x16 gpad[16][8];
  int16x16 hpad[16][8]; /* XXX: overlap fpad */
  int i;

  for (i = 0;i < 64;++i) {
    assertrange_x16(f[i],4000);
    assertrange_x16(g[i],4000);
  }

  fft64(fpad,f);
  fft64(gpad,g);

  for (i = 0;i < 16;++i)
    mult8_nega_over65536_x16(hpad[i],fpad[i],gpad[i]);

  unfft64_scale16(h,hpad);

  for (i = 0;i < 64;++i)
    assertrange_x16(h[i],4000);
}

static void assertrange8_64(const int16 f[8][64],int limit)
{
  int i,j;
  for (i = 0;i < 8;++i)
    for (j = 0;j < 64;++j) {
      assert(f[i][j] >= -limit);
      assert(f[i][j] <= limit);
    }
}

/* input in (k[x]/(x^64+1))[y]/(y^8-1) */
/* f represents poly: sum f[i][j] y^i x^j */
/* output (in place): 8 elements of k[x]/(x^64+1) */
/* input range: +-4000 */
/* output range: +-4000 */
static void fft8_64(int16 f[8][64])
{
  int i,j;

  assertrange8_64(f,4000);

  /* stage 1: y^8-1 -> y^4-1, y^4+1 */
  for (i = 0;i < 4;++i)
    for (j = 0;j < 64;++j) {
      int16 a = f[i][j];
      int16 A = f[i+4][j];
      f[i][j] = add(a,A);
      f[i+4][j] = sub(a,A);
    }

  assertrange8_64(f,8000);

  /* stage 2: y^2-1, y^2+1, y^2-x^32, y^2+x^32 */
  for (i = 0;i < 2;++i)
    for (j = 0;j < 64;++j) {
      int16 a = f[i][j];
      int16 A = f[i+2][j];
      f[i][j] = add(a,A);
      f[i+2][j] = sub(a,A);
    }
  for (i = 4;i < 6;++i)
    for (j = 0;j < 32;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+32];
      int16 A = f[i+2][j];
      int16 B = f[i+2][j+32];
      f[i][j] = sub(a,B);
      f[i][j+32] = add(b,A);
      f[i+2][j] = add(a,B);
      f[i+2][j+32] = sub(b,A);
    }

  assertrange8_64(f,16000);

  /* stage 3: y-1,y+1,y-x^32,y+x^32,y-x^16,y+x^16,y-x^48,y+x^48 */
  for (i = 0;i < 1;++i)
    for (j = 0;j < 64;++j) {
      int16 a = f[i][j];
      int16 A = f[i+1][j];
      f[i][j] = add(a,A);
      f[i+1][j] = sub(a,A);
    }
  for (i = 2;i < 3;++i)
    for (j = 0;j < 32;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+32];
      int16 A = f[i+1][j];
      int16 B = f[i+1][j+32];
      f[i][j] = sub(a,B);
      f[i][j+32] = add(b,A);
      f[i+1][j] = add(a,B);
      f[i+1][j+32] = sub(b,A);
    }
  for (i = 4;i < 5;++i)
    for (j = 0;j < 16;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+16];
      int16 c = f[i][j+32];
      int16 d = f[i][j+48];
      int16 A = f[i+1][j];
      int16 B = f[i+1][j+16];
      int16 C = f[i+1][j+32];
      int16 D = f[i+1][j+48];
      f[i][j] = sub(a,D);
      f[i][j+16] = add(b,A);
      f[i][j+32] = add(c,B);
      f[i][j+48] = add(d,C);
      f[i+1][j] = add(a,D);
      f[i+1][j+16] = sub(b,A);
      f[i+1][j+32] = sub(c,B);
      f[i+1][j+48] = sub(d,C);
    }
  for (i = 6;i < 7;++i)
    for (j = 0;j < 16;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+16];
      int16 c = f[i][j+32];
      int16 d = f[i][j+48];
      int16 A = f[i+1][j];
      int16 B = f[i+1][j+16];
      int16 C = f[i+1][j+32];
      int16 D = f[i+1][j+48];
      f[i][j] = sub(a,B);
      f[i][j+16] = sub(b,C);
      f[i][j+32] = sub(c,D);
      f[i][j+48] = add(d,A);
      f[i+1][j] = add(a,B);
      f[i+1][j+16] = add(b,C);
      f[i+1][j+32] = add(c,D);
      f[i+1][j+48] = sub(d,A);
    }

  assertrange8_64(f,32000);

  for (i = 0;i < 8;++i)
    for (j = 0;j < 64;++j)
      f[i][j] = squeeze13(f[i][j]);

  assertrange8_64(f,4000);
}

/* input range: +-4000 */
/* output range: +-32000 */
static void unfft8_64_scale8(int16 f[8][64])
{
  int i,j;

  assertrange8_64(f,4000);

  /* undo stage 3: y-1,y+1,y-x^32,y+x^32,y-x^16,y+x^16,y-x^48,y+x^48 */
  for (i = 0;i < 1;++i)
    for (j = 0;j < 64;++j) {
      int16 a = f[i][j];
      int16 A = f[i+1][j];
      f[i][j] = add(a,A);
      f[i+1][j] = sub(a,A);
    }
  for (i = 2;i < 3;++i)
    for (j = 0;j < 32;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+32];
      int16 A = f[i+1][j];
      int16 B = f[i+1][j+32];
      f[i][j] = add(a,A);
      f[i][j+32] = add(b,B);
      f[i+1][j] = sub(b,B);
      f[i+1][j+32] = sub(A,a);
    }
  for (i = 4;i < 5;++i)
    for (j = 0;j < 16;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+16];
      int16 c = f[i][j+32];
      int16 d = f[i][j+48];
      int16 A = f[i+1][j];
      int16 B = f[i+1][j+16];
      int16 C = f[i+1][j+32];
      int16 D = f[i+1][j+48];
      f[i][j] = add(a,A);
      f[i][j+16] = add(b,B);
      f[i][j+32] = add(c,C);
      f[i][j+48] = add(d,D);
      f[i+1][j] = sub(b,B);
      f[i+1][j+16] = sub(c,C);
      f[i+1][j+32] = sub(d,D);
      f[i+1][j+48] = sub(A,a);
    }
  for (i = 6;i < 7;++i)
    for (j = 0;j < 16;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+16];
      int16 c = f[i][j+32];
      int16 d = f[i][j+48];
      int16 A = f[i+1][j];
      int16 B = f[i+1][j+16];
      int16 C = f[i+1][j+32];
      int16 D = f[i+1][j+48];
      f[i][j] = add(a,A);
      f[i][j+16] = add(b,B);
      f[i][j+32] = add(c,C);
      f[i][j+48] = add(d,D);
      f[i+1][j] = sub(d,D);
      f[i+1][j+16] = sub(A,a);
      f[i+1][j+32] = sub(B,b);
      f[i+1][j+48] = sub(C,c);
    }

  assertrange8_64(f,8000);

  /* undo stage 2: y^2-1, y^2+1, y^2-x^32, y^2+x^32 */
  for (i = 0;i < 2;++i)
    for (j = 0;j < 64;++j) {
      int16 a = f[i][j];
      int16 A = f[i+2][j];
      f[i][j] = add(a,A);
      f[i+2][j] = sub(a,A);
    }
  for (i = 4;i < 6;++i)
    for (j = 0;j < 32;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+32];
      int16 A = f[i+2][j];
      int16 B = f[i+2][j+32];
      f[i][j] = add(a,A);
      f[i][j+32] = add(b,B);
      f[i+2][j] = sub(b,B);
      f[i+2][j+32] = sub(A,a);
    }

  assertrange8_64(f,16000);

  /* undo stage 1: y^4-1, y^4+1 */
  for (i = 0;i < 4;++i)
    for (j = 0;j < 64;++j) {
      int16 a = f[i][j];
      int16 A = f[i+4][j];
      f[i][j] = add(a,A);
      f[i+4][j] = sub(a,A);
    }

  assertrange8_64(f,32000);
}

/* input in (k[x]/(x^64+1))[y]/(y^8-x^8t) */
/* output (in place): (k[x]/(x^64+1))[z]/(z^8-1) */
/* mapping y to z x^t */
/* allowed values of t: -8...8 */
static void twist64(int16 f[8][64],int t)
{
  int16 fi[64];
  int i,j;

  if (t > 0) {
    for (i = 1;i < 8;++i) {
      for (j = 0;j < 64;++j) fi[j] = f[i][j];
      for (j = 0;j < i*t;++j) f[i][j] = -fi[j+64-i*t];
      for (j = i*t;j < 64;++j) f[i][j] = fi[j-i*t];
    }
  } else {
    t = -t;
    for (i = 1;i < 8;++i) {
      for (j = 0;j < 64;++j) fi[j] = f[i][j];
      for (j = 0;j < i*t;++j) f[i][j+64-i*t] = -fi[j];
      for (j = i*t;j < 64;++j) f[i][j-i*t] = fi[j];
    }
  }
}

static void assertrange48_64(const int16 f[48][64],int limit)
{
  int i,j;
  for (i = 0;i < 48;++i)
    for (j = 0;j < 64;++j) {
      assert(f[i][j] >= -limit);
      assert(f[i][j] <= limit);
    }
}

/* size-48 truncated FFT over k[x]/(x^64+1) */
/* input in (k[x]/(x^64+1))[y]/(y^48-y^32+y^16-1) */
/* output (in place): 48 elements of k[x]/(x^64+1) */
/* input range: +-8000 */
/* output range: +-4000 */
static void fft48_64(int16 f[48][64])
{
  int i,j;

  /* XXX: take more advantage of zeros in inputs */

  assertrange48_64(f,8000);

  /* stage 1: y^48-y^32+y^16-1 -> y^32+1, y^16-1 */
  /* exploiting inputs having y-degree <24 */
  /* exploiting inputs having x-degree <32 */

  for (i = 0;i < 8;++i)
    for (j = 0;j < 32;++j) {
      f[i+32][j] = add(f[i][j],f[i+16][j]);
      f[i+40][j] = f[i+8][j];
    }

  assertrange48_64(f,16000);

  /* stage 2: y^32+1 -> y^16-x^32, y^16+x^32 */

  for (i = 0;i < 16;++i)
    for (j = 0;j < 32;++j) {
      int16 a = f[i][j];
      int16 A = f[i+16][j];
      /* a + 0 x^32 + A y^16 + 0 y^16 x^32 */
      /* (a-0) + (0+A) x^32, (a+0) + (0-A) x^32 */
      f[i][j] = a;
      f[i][j+32] = A;
      f[i+16][j] = a;
      f[i+16][j+32] = neg(A);
    }

  assertrange48_64(f,16000);

  /* stage 3: y^8-x^16, y^8+x^16, y^8-x^48, y^8+x^48, y^8-1, y^8+1 */

  for (i = 0;i < 8;++i)
    for (j = 0;j < 16;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+16];
      int16 c = f[i][j+32];
      int16 d = f[i][j+48];
      int16 A = f[i+8][j];
      int16 B = f[i+8][j+16];
      int16 C = f[i+8][j+32];
      int16 D = f[i+8][j+48];
      f[i][j] = sub(a,D);
      f[i][j+16] = add(b,A);
      f[i][j+32] = add(c,B);
      f[i][j+48] = add(d,C);
      f[i+8][j] = add(a,D);
      f[i+8][j+16] = sub(b,A);
      f[i+8][j+32] = sub(c,B);
      f[i+8][j+48] = sub(d,C);
    }

  for (i = 16;i < 24;++i)
    for (j = 0;j < 16;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+16];
      int16 c = f[i][j+32];
      int16 d = f[i][j+48];
      int16 A = f[i+8][j];
      int16 B = f[i+8][j+16];
      int16 C = f[i+8][j+32];
      int16 D = f[i+8][j+48];
      f[i][j] = sub(a,B);
      f[i][j+16] = sub(b,C);
      f[i][j+32] = sub(c,D);
      f[i][j+48] = add(d,A);
      f[i+8][j] = add(a,B);
      f[i+8][j+16] = add(b,C);
      f[i+8][j+32] = add(c,D);
      f[i+8][j+48] = sub(d,A);
    }

  for (i = 32;i < 40;++i)
    for (j = 0;j < 64;++j) {
      int16 a = f[i][j];
      int16 A = f[i+8][j];
      f[i][j] = add(a,A);
      f[i+8][j] = sub(a,A);
    }

  assertrange48_64(f,32000);

  twist64(f,2);
  twist64(f+8,-6);
  twist64(f+16,6);
  twist64(f+24,-2);
  twist64(f+40,8);

  assertrange48_64(f,32000);

  for (i = 0;i < 48;++i)
    for (j = 0;j < 64;++j)
      f[i][j] = squeeze13(f[i][j]);

  assertrange48_64(f,4000);

  fft8_64(f);
  fft8_64(f+8);
  fft8_64(f+16);
  fft8_64(f+24);
  fft8_64(f+32);
  fft8_64(f+40);

  assertrange48_64(f,4000);
}

/* input range: +-4000 */
/* output range: +-16000 */
static void unfft48_64_scale64(int16 f[48][64])
{
  int i, j;

  assertrange48_64(f,4000);

  unfft8_64_scale8(f);
  unfft8_64_scale8(f+8);
  unfft8_64_scale8(f+16);
  unfft8_64_scale8(f+24);
  unfft8_64_scale8(f+32);
  unfft8_64_scale8(f+40);

  assertrange48_64(f,32000);

  twist64(f,-2);
  twist64(f+8,6);
  twist64(f+16,-6);
  twist64(f+24,2);
  twist64(f+40,-8);

  assertrange48_64(f,32000);

  for (i = 0;i < 48;++i)
    for (j = 0;j < 64;++j)
      f[i][j] = squeeze13(f[i][j]);

  assertrange48_64(f,4000);

  /* undo stage 3: y^8-x^16, y^8+x^16, y^8-x^48, y^8+x^48, y^8-1, y^8+1 */

  for (i = 0;i < 8;++i)
    for (j = 0;j < 16;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+16];
      int16 c = f[i][j+32];
      int16 d = f[i][j+48];
      int16 A = f[i+8][j];
      int16 B = f[i+8][j+16];
      int16 C = f[i+8][j+32];
      int16 D = f[i+8][j+48];
      f[i][j] = add(a,A);
      f[i][j+16] = add(b,B);
      f[i][j+32] = add(c,C);
      f[i][j+48] = add(d,D);
      f[i+8][j] = sub(b,B);
      f[i+8][j+16] = sub(c,C);
      f[i+8][j+32] = sub(d,D);
      f[i+8][j+48] = sub(A,a);
    }

  for (i = 16;i < 24;++i)
    for (j = 0;j < 16;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+16];
      int16 c = f[i][j+32];
      int16 d = f[i][j+48];
      int16 A = f[i+8][j];
      int16 B = f[i+8][j+16];
      int16 C = f[i+8][j+32];
      int16 D = f[i+8][j+48];
      f[i][j] = add(a,A);
      f[i][j+16] = add(b,B);
      f[i][j+32] = add(c,C);
      f[i][j+48] = add(d,D);
      f[i+8][j] = sub(d,D);
      f[i+8][j+16] = sub(A,a);
      f[i+8][j+32] = sub(B,b);
      f[i+8][j+48] = sub(C,c);
    }

  for (i = 32;i < 40;++i)
    for (j = 0;j < 64;++j) {
      int16 a = f[i][j];
      int16 A = f[i+8][j];
      f[i][j] = add(a,A);
      f[i+8][j] = sub(a,A);
    }

  assertrange48_64(f,8000);

  /* undo stage 2: y^16-x^32, y^16+x^32 */

  for (i = 0;i < 16;++i)
    for (j = 0;j < 32;++j) {
      int16 a = f[i][j];
      int16 b = f[i][j+32];
      int16 A = f[i+16][j];
      int16 B = f[i+16][j+32];
      f[i][j] = add(a,A);
      f[i][j+32] = add(b,B);
      f[i+16][j] = sub(b,B);
      f[i+16][j+32] = sub(A,a);
    }

  assertrange48_64(f,16000);

  for (i = 0;i < 48;++i)
    for (j = 0;j < 64;++j)
      f[i][j] = squeeze13(f[i][j]);

  assertrange48_64(f,4000);

  /* undo stage 1: y^32+1, y^16-1 */
  for (i = 0;i < 16;++i)
    for (j = 0;j < 64;++j) {
      int16 a = f[i][j];
      int16 b = f[i+16][j];
      int16 c = f[i+32][j];
      c = add(c,c);
      /* reconstruct r + s y^16 + t y^32 */
      /* from a = r - t, b = s, c = r + s + t */
      c = sub(c,b); /* now a = r - t, b = s, c = r + t */
      f[i][j] = add(a,c); /* 2r */
      f[i+16][j] = add(b,b); /* 2s */
      f[i+32][j] = sub(c,a); /* 2t */
    }

  assertrange48_64(f,16000);
}

static void transpose(int16x16 out[64],const int16 in[16][64])
{
  int i,j;
  for (i = 0;i < 16;++i)
    for (j = 0;j < 64;++j)
      out[j].lane[i] = in[i][j];
}

static void untranspose(int16 out[16][64],const int16x16 in[64])
{
  int i,j;
  for (i = 0;i < 16;++i)
    for (j = 0;j < 64;++j)
      out[i][j] = in[j].lane[i];
}

static void assertrange768(const int16 f[768],int limit)
{
  int i;
  for (i = 0;i < 768;++i) {
    assert(f[i] >= -limit);
    assert(f[i] <= limit);
  }
}

/* h = fg/64 in k[y] */
/* where f,g are 768-coeff polys */
/* input range: +-4000 */
/* output range: +-4000 */
void mult768_over64(int16 h[1535],const int16 f[768],const int16 g[768])
{
  /* strategy: truncated cyclic Schoenhage trick */
  /* map k[y]/(y^1536-y^1024+y^512-1) */
  /* to (k[z]/(z^48-z^32+z^16-1))[y]/(y^32-z) */
  /* lift to k[y][z]/(z^48-z^32+z^16-1) */
  /* map to (k[y]/(y^64+1))[z]/(z^48-z^32+z^16-1) */
  /* note that k[y]/(y^64+1) supports size-128 FFT */

  int i,j;
  int16 fpad[48][64]; /* sum fpad[i][j] z^i y^j */
  int16 gpad[48][64];
#define hpad fpad
  int16x16 ftr[64];
  int16x16 gtr[64];
  int16x16 htr[64];
  int16 result[1536];

  assertrange768(f,4000);
  assertrange768(g,4000);

  for (i = 0;i < 48;++i)
    for (j = 0;j < 64;++j)
      fpad[i][j] = 0;
  for (i = 0;i < 24;++i)
    for (j = 0;j < 32;++j)
      fpad[i][j] = f[i*32+j];

  /* fpad evaluated at z=y^32 is original poly f */

  for (i = 0;i < 48;++i)
    for (j = 0;j < 64;++j)
      gpad[i][j] = 0;
  for (i = 0;i < 24;++i)
    for (j = 0;j < 32;++j)
      gpad[i][j] = g[i*32+j];

  fft48_64(fpad);
  fft48_64(gpad);

  assertrange48_64(fpad,4000);
  assertrange48_64(gpad,4000);

  for (i = 0;i < 48;i += 16) {
    transpose(ftr,fpad+i);
    transpose(gtr,gpad+i);
    mult64_nega_over4096_x16(htr,ftr,gtr);
    untranspose(hpad+i,htr);
  }

  assertrange48_64(hpad,4000);

  unfft48_64_scale64(hpad);

  assertrange48_64(hpad,16000);
  
  for (j = 0;j < 1536;++j)
    result[j] = 0;

  for (i = 0;i <= 46;++i)
    for (j = 0;j < 64;++j)
      result[i*32+j] = add(result[i*32+j],hpad[i][j]);

  for (j = 0;j < 1535;++j)
    h[j] = squeeze13(result[j]);

  for (i = 0;i < 1535;++i) {
    assert(h[i] >= -4000); assert(h[i] <= 4000);
  }
}
