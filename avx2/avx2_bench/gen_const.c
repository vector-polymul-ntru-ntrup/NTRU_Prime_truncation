
#include "gen_const.h"
#include "NTT_params.h"

// // map x to log_g (x + 1)
size_t rader_dlog_permute[16] = {
0, 14, 1, 12,
5, 15, 11, 10,
2, 3, 7, 13,
4, 9, 6, 8
};

int16_t twiddle_rader17[17] = {
1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080
};

int16_t twiddle_rader17_inv[17] = {
1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152
};

int16_t twiddle_inv_rader17[17] = {
0, 1151, 304, -2148, 1204, 1677, 244, 2188, 1268, 1949, 1400, -2081, 341, -843, -1284, 285, -1081
};

int16_t id16[16] = {
1, 1, 1, 1,
1, 1, 1, 1,
1, 1, 1, 1,
1, 1, 1, 1
};

int16_t _3x2_table[6] = {
1, -OMEGA3, OMEGA3INV,
-1, OMEGA3, -OMEGA3INV
};

int16_t twist16[16] = {
1, OMEGA3, OMEGA3INV, 1,
OMEGA3, OMEGA3INV, 1, OMEGA3,
OMEGA3INV, 1, OMEGA3, OMEGA3INV,
1, OMEGA3, OMEGA3INV, 1
};

int16_t twist16inv[16] = {
1, OMEGA3INV, OMEGA3, 1,
OMEGA3INV, OMEGA3, 1, OMEGA3INV,
OMEGA3, 1, OMEGA3INV, OMEGA3,
1, OMEGA3INV, OMEGA3, 1
};

