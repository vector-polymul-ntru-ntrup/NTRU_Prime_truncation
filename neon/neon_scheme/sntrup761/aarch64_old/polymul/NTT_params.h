
#ifndef NTT_PARAMS_H
#define NTT_PARAMS_H

#include <stdint.h>

#define _POLY_N 1632
#define NTRU_P 761

#define Q 4591

// R = 65536 below
// R mod Q
#define RmodQ (1262)
// -Q^{-1} mod R
#define Qprime (-15631)
// R^{-1} mod Q
#define RinvmodQ (-1095)
// round(2^27 / Q)
#define Qbar (29235)

#define OMEGA3 (-311)
#define OMEGA3SQ (310)
#define OMEGA (1152)
#define INV3 (-1530)
#define SEVENTEEN_INV (-270)
#define TWOINV (-2295)
#define FINAL_SCALE (-849)

// Barrett multiplication for the constant z (R = 65536):
// zlo = z
// zhi = ((even (z R cmod Q) in [-Q, Q]) * Qprime cmod R) / 2

#define OMEGA3lo (-311)
#define OMEGA3hi (-2220)
#define OMEGA3SQlo (310)
#define OMEGA3SQhi (2213)
#define FINAL_SCALElo (-849)
#define FINAL_SCALEhi (-6060)





#endif





