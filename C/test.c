
#include <stdio.h>
#include <stdint.h>
#include <assert.h>
#include <memory.h>

#include "tools.h"
#include "naive_mult.h"

#include "params.h"
#include "NTT_params.h"

#include "ring.h"

#include "rader.h"

int16_t twiddle_rader17[17] = {
1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080
};

int16_t twiddle_rader17_inv[17] = {
1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152
};

int16_t twiddle_inv_rader17[17] = {
0, 1151, 304, -2148, 1204, 1677, 244, 2188, 1268, 1949, 1400, -2081, 341, -843, -1284, 285, -1081
};

int16_t twist_table[16 * 96] = {
1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1152, 286, 342, 1950, 245, -2147, 1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1152, 286, 342, 1950, 245, -2147, 1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1152, 286, 342, 1950, 245, -2147, 1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1152, 286, 342, 1950, 245, -2147, 1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1152, 286, 342, 1950, 245, -2147, 1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 305, -842, 2189, 1152, 342, 245, 1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 305, -842, 2189, 1152, 342, 245, 1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 305, -842, 2189, 1152, 342, 245, 1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 305, -842, 2189, 1152, 342, 245, 1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 305, -842, 2189, 1152, 342, 245, 1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, -2147, -2080, 305, 1401, 1152, 1950, 1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, -2147, -2080, 305, 1401, 1152, 1950, 1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, -2147, -2080, 305, 1401, 1152, 1950, 1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, -2147, -2080, 305, 1401, 1152, 1950, 1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, -2147, -2080, 305, 1401, 1152, 1950, 1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, 1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1205, 1950, -1283, 305, 2189, 342, 1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1205, 1950, -1283, 305, 2189, 342, 1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1205, 1950, -1283, 305, 2189, 342, 1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1205, 1950, -1283, 305, 2189, 342, 1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1205, 1950, -1283, 305, 2189, 342, 1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1678, 2189, 1950, -2080, -842, 286, 1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1678, 2189, 1950, -2080, -842, 286, 1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1678, 2189, 1950, -2080, -842, 286, 1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1678, 2189, 1950, -2080, -842, 286, 1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1678, 2189, 1950, -2080, -842, 286, 1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152, 1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152, 1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152, 1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152, 1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152, 1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 2189, -2147, -1080, 342, 1269, 1205, 1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 2189, -2147, -1080, 342, 1269, 1205, 1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 2189, -2147, -1080, 342, 1269, 1205, 1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 2189, -2147, -1080, 342, 1269, 1205, 1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 2189, -2147, -1080, 342, 1269, 1205, 1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1269, 1152, -2080, 1205, -1283, 2189, 1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1269, 1152, -2080, 1205, -1283, 2189, 1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1269, 1152, -2080, 1205, -1283, 2189, 1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1269, 1152, -2080, 1205, -1283, 2189, 1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1269, 1152, -2080, 1205, -1283, 2189, 1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1950, -1080, 245, -842, -2147, 1401, 1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1950, -1080, 245, -842, -2147, 1401, 1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1950, -1080, 245, -842, -2147, 1401, 1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1950, -1080, 245, -842, -2147, 1401, 1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1950, -1080, 245, -842, -2147, 1401, 1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1401, -1283, 1152, 1678, 1950, -842, 1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1401, -1283, 1152, 1678, 1950, -842, 1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1401, -1283, 1152, 1678, 1950, -842, 1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1401, -1283, 1152, 1678, 1950, -842, 1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1401, -1283, 1152, 1678, 1950, -842, 1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080, 1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080, 1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080, 1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080, 1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080, 1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, 1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 342, 1401, 1269, 245, 1205, 305, 1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 342, 1401, 1269, 245, 1205, 305, 1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 342, 1401, 1269, 245, 1205, 305, 1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 342, 1401, 1269, 245, 1205, 305, 1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 342, 1401, 1269, 245, 1205, 305, 1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, -842, 1269, -2147, 286, 1401, 1678, 1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, -842, 1269, -2147, 286, 1401, 1678, 1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, -842, 1269, -2147, 286, 1401, 1678, 1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, -842, 1269, -2147, 286, 1401, 1678, 1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, -842, 1269, -2147, 286, 1401, 1678, 1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, 1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, -1283, 245, 286, 2189, -1080, 1269, 1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, -1283, 245, 286, 2189, -1080, 1269, 1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, -1283, 245, 286, 2189, -1080, 1269, 1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, -1283, 245, 286, 2189, -1080, 1269, 1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, -1283, 245, 286, 2189, -1080, 1269, 1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, 1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 286, 1205, 1401, -1080, 1678, -2080, 1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 286, 1205, 1401, -1080, 1678, -2080, 1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 286, 1205, 1401, -1080, 1678, -2080, 1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 286, 1205, 1401, -1080, 1678, -2080, 1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 286, 1205, 1401, -1080, 1678, -2080, 1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, -1080, 305, 1678, 1269, -2080, -1283, 1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, -1080, 305, 1678, 1269, -2080, -1283, 1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, -1080, 305, 1678, 1269, -2080, -1283, 1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, -1080, 305, 1678, 1269, -2080, -1283, 1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, -1080, 305, 1678, 1269, -2080, -1283, 1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842
};

int16_t twist_inv_table[16 * 96] = {
1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, -1080, 305, 1678, 1269, -2080, -1283, 1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, -1080, 305, 1678, 1269, -2080, -1283, 1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, -1080, 305, 1678, 1269, -2080, -1283, 1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, -1080, 305, 1678, 1269, -2080, -1283, 1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, -1080, 305, 1678, 1269, -2080, -1283, 1, -2147, 245, 1950, 342, 286, 1152, 1205, 2189, 1401, -842, 1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 286, 1205, 1401, -1080, 1678, -2080, 1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 286, 1205, 1401, -1080, 1678, -2080, 1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 286, 1205, 1401, -1080, 1678, -2080, 1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 286, 1205, 1401, -1080, 1678, -2080, 1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 286, 1205, 1401, -1080, 1678, -2080, 1, 245, 342, 1152, 2189, -842, 305, 1269, -1283, -2147, 1950, 1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, -1283, 245, 286, 2189, -1080, 1269, 1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, -1283, 245, 286, 2189, -1080, 1269, 1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, -1283, 245, 286, 2189, -1080, 1269, 1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, -1283, 245, 286, 2189, -1080, 1269, 1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, -1283, 245, 286, 2189, -1080, 1269, 1, 1950, 1152, 1401, 305, -2080, -2147, 342, 1205, -842, 1678, 1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, -842, 1269, -2147, 286, 1401, 1678, 1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, -842, 1269, -2147, 286, 1401, 1678, 1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, -842, 1269, -2147, 286, 1401, 1678, 1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, -842, 1269, -2147, 286, 1401, 1678, 1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, -842, 1269, -2147, 286, 1401, 1678, 1, 342, 2189, 305, -1283, 1950, 1205, -1080, -2080, 245, 1152, 1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 342, 1401, 1269, 245, 1205, 305, 1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 342, 1401, 1269, 245, 1205, 305, 1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 342, 1401, 1269, 245, 1205, 305, 1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 342, 1401, 1269, 245, 1205, 305, 1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 342, 1401, 1269, 245, 1205, 305, 1, 286, -842, -2080, 1950, 2189, 1678, -2147, 1152, -1080, -1283, 1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080, 1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080, 1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080, 1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080, 1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, -2080, 342, -842, -1283, 286, -1080, 1, 1152, 305, -2147, 1205, 1678, 245, 2189, 1269, 1950, 1401, 1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1401, -1283, 1152, 1678, 1950, -842, 1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1401, -1283, 1152, 1678, 1950, -842, 1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1401, -1283, 1152, 1678, 1950, -842, 1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1401, -1283, 1152, 1678, 1950, -842, 1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1401, -1283, 1152, 1678, 1950, -842, 1, 1205, 1269, 342, -1080, -2147, 2189, -2080, 286, 305, 245, 1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1950, -1080, 245, -842, -2147, 1401, 1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1950, -1080, 245, -842, -2147, 1401, 1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1950, -1080, 245, -842, -2147, 1401, 1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1950, -1080, 245, -842, -2147, 1401, 1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1950, -1080, 245, -842, -2147, 1401, 1, 2189, -1283, 1205, -2080, 1152, 1269, 286, 1678, 342, 305, 1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1269, 1152, -2080, 1205, -1283, 2189, 1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1269, 1152, -2080, 1205, -1283, 2189, 1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1269, 1152, -2080, 1205, -1283, 2189, 1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1269, 1152, -2080, 1205, -1283, 2189, 1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1269, 1152, -2080, 1205, -1283, 2189, 1, 1401, -2147, -842, 245, -1080, 1950, 305, 342, 1678, 286, 1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 2189, -2147, -1080, 342, 1269, 1205, 1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 2189, -2147, -1080, 342, 1269, 1205, 1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 2189, -2147, -1080, 342, 1269, 1205, 1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 2189, -2147, -1080, 342, 1269, 1205, 1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 2189, -2147, -1080, 342, 1269, 1205, 1, -842, 1950, 1678, 1152, -1283, 1401, 245, 305, 286, -2080, 1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152, 1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152, 1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152, 1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152, 1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 245, 1678, 1205, -2147, 305, 1152, 1, -1080, 286, -1283, -842, 342, -2080, 1401, 1950, 1269, 2189, 1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1678, 2189, 1950, -2080, -842, 286, 1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1678, 2189, 1950, -2080, -842, 286, 1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1678, 2189, 1950, -2080, -842, 286, 1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1678, 2189, 1950, -2080, -842, 286, 1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1678, 2189, 1950, -2080, -842, 286, 1, 305, 1205, 245, 1269, 1401, 342, -1283, -1080, 1152, -2147, 1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1205, 1950, -1283, 305, 2189, 342, 1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1205, 1950, -1283, 305, 2189, 342, 1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1205, 1950, -1283, 305, 2189, 342, 1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1205, 1950, -1283, 305, 2189, 342, 1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1205, 1950, -1283, 305, 2189, 342, 1, 1678, 1401, 286, -2147, 1269, -842, 1152, 245, -2080, -1080, 1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, -2147, -2080, 305, 1401, 1152, 1950, 1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, -2147, -2080, 305, 1401, 1152, 1950, 1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, -2147, -2080, 305, 1401, 1152, 1950, 1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, -2147, -2080, 305, 1401, 1152, 1950, 1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, -2147, -2080, 305, 1401, 1152, 1950, 1, 1269, -1080, 2189, 286, 245, -1283, 1678, -842, 1205, 342, 1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 305, -842, 2189, 1152, 342, 245, 1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 305, -842, 2189, 1152, 342, 245, 1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 305, -842, 2189, 1152, 342, 245, 1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 305, -842, 2189, 1152, 342, 245, 1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 305, -842, 2189, 1152, 342, 245, 1, -2080, 1678, -1080, 1401, 1205, 286, 1950, -2147, -1283, 1269, 1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1152, 286, 342, 1950, 245, -2147, 1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1152, 286, 342, 1950, 245, -2147, 1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1152, 286, 342, 1950, 245, -2147, 1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1152, 286, 342, 1950, 245, -2147, 1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205, 1152, 286, 342, 1950, 245, -2147, 1, -1283, -2080, 1269, 1678, 305, -1080, -842, 1401, 2189, 1205
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

// w17 = = w17^(FACTOR96 * 96) = (w17^FACTOR96)^96
#define FACTOR96 (14)

void print_int16(int16_t *src, size_t len){

    for(size_t i = 0; i < len; i++){
        printf("%d%s", src[i], (i == len - 1)? ("\n"):(", "));
    }

}

void GT_3x2(int16_t *des, int16_t *src, int16_t omega, size_t jump){

    int16_t a0, a1, a2, a3, a4, a5;
    int16_t t0, t1, t2, t3, t4, t5;

    a0 = src[0 * jump];
    a4 = src[1 * jump];
    a2 = src[2 * jump];
    a3 = src[3 * jump];
    a1 = src[4 * jump];
    a5 = src[5 * jump];

    coeff_ring.addZ(&t0, &a0, &a3);
    coeff_ring.subZ(&t3, &a0, &a3);
    coeff_ring.addZ(&t1, &a1, &a4);
    coeff_ring.subZ(&t4, &a1, &a4);
    coeff_ring.addZ(&t2, &a2, &a5);
    coeff_ring.subZ(&t5, &a2, &a5);

    a0 = t0;
    a1 = t1;
    a2 = t2;
    a3 = t3;
    a4 = t4;
    a5 = t5;

    coeff_ring.subZ(&t1, &a1, &a2);
    coeff_ring.mulZ(&t1, &t1, &omega);
    coeff_ring.subZ(&t2, &a0, &a1);
    coeff_ring.subZ(&t2, &t2, &t1);
    coeff_ring.addZ(&t1, &t1, &a0);
    coeff_ring.subZ(&t1, &t1, &a2);
    coeff_ring.addZ(&t0, &a0, &a1);
    coeff_ring.addZ(&t0, &t0, &a2);

    coeff_ring.subZ(&t4, &a4, &a5);
    coeff_ring.mulZ(&t4, &t4, &omega);
    coeff_ring.subZ(&t5, &a3, &a4);
    coeff_ring.subZ(&t5, &t5, &t4);
    coeff_ring.addZ(&t4, &t4, &a3);
    coeff_ring.subZ(&t4, &t4, &a5);
    coeff_ring.addZ(&t3, &a3, &a4);
    coeff_ring.addZ(&t3, &t3, &a5);

    des[0 * jump] = t0;
    des[1 * jump] = t4;
    des[2 * jump] = t2;
    des[3 * jump] = t3;
    des[4 * jump] = t1;
    des[5 * jump] = t5;

}

int main(void){

    int16_t poly1[ARRAY_N], poly2[ARRAY_N];
    int16_t poly1_NTT[ARRAY_N], poly2_NTT[ARRAY_N];
    int16_t ref[ARRAY_N], res[ARRAY_N];
    int16_t res_NTT[ARRAY_N];
    int16_t twiddle, t, scale, omega;

    for(size_t i = 0; i < NTRU_P; i++){
        t = rand() % Q;
        coeff_ring.memberZ(poly1 + i, &t);
        t = rand() % Q;
        coeff_ring.memberZ(poly2 + i, &t);
    }
    for(size_t i = NTRU_P; i < ARRAY_N; i++){
        poly1[i] = poly2[i] = 0;
    }

    twiddle = 1;
    naive_mulR(ref, poly1, poly2, ARRAY_N, &twiddle, coeff_ring);

    for(size_t i = 0; i < 96; i++){
        rader_17_primitive(poly1_NTT + i, poly1 + i, twiddle_rader17, twiddle_rader17_inv, 96);
        rader_17_primitive(poly2_NTT + i, poly2 + i, twiddle_rader17, twiddle_rader17_inv, 96);
    }

    point_mul(poly1_NTT, poly1_NTT, twist_table, 1536, 1, coeff_ring);
    point_mul(poly2_NTT, poly2_NTT, twist_table, 1536, 1, coeff_ring);

    for(size_t i = 0; i < 1536; i += 96){
        for(size_t j = 0; j < 16; j++){
            GT_3x2(poly1_NTT + i + j, poly1_NTT + i + j, OMEGA3, 16);
            GT_3x2(poly2_NTT + i + j, poly2_NTT + i + j, OMEGA3, 16);
        }
    }

    for(size_t i = 0; i < 1536; i += 96){
        point_mul(poly1_NTT + i + 1 * 16, poly1_NTT + i + 1 * 16,    twist16, 16, 1, coeff_ring);
        point_mul(poly1_NTT + i + 4 * 16, poly1_NTT + i + 4 * 16,    twist16, 16, 1, coeff_ring);
        point_mul(poly1_NTT + i + 2 * 16, poly1_NTT + i + 2 * 16, twist16inv, 16, 1, coeff_ring);
        point_mul(poly1_NTT + i + 5 * 16, poly1_NTT + i + 5 * 16, twist16inv, 16, 1, coeff_ring);

        point_mul(poly2_NTT + i + 1 * 16, poly2_NTT + i + 1 * 16,    twist16, 16, 1, coeff_ring);
        point_mul(poly2_NTT + i + 4 * 16, poly2_NTT + i + 4 * 16,    twist16, 16, 1, coeff_ring);
        point_mul(poly2_NTT + i + 2 * 16, poly2_NTT + i + 2 * 16, twist16inv, 16, 1, coeff_ring);
        point_mul(poly2_NTT + i + 5 * 16, poly2_NTT + i + 5 * 16, twist16inv, 16, 1, coeff_ring);
    }

    for(size_t i = 0; i < 1536; i += 96){
        twiddle = 1;
        naive_mulR(res_NTT + i + 0 * 16, poly1_NTT + i + 0 * 16, poly2_NTT + i + 0 * 16, 16, &twiddle, coeff_ring);
        naive_mulR(res_NTT + i + 2 * 16, poly1_NTT + i + 2 * 16, poly2_NTT + i + 2 * 16, 16, &twiddle, coeff_ring);
        naive_mulR(res_NTT + i + 4 * 16, poly1_NTT + i + 4 * 16, poly2_NTT + i + 4 * 16, 16, &twiddle, coeff_ring);
        twiddle = -1;
        naive_mulR(res_NTT + i + 1 * 16, poly1_NTT + i + 1 * 16, poly2_NTT + i + 1 * 16, 16, &twiddle, coeff_ring);
        naive_mulR(res_NTT + i + 3 * 16, poly1_NTT + i + 3 * 16, poly2_NTT + i + 3 * 16, 16, &twiddle, coeff_ring);
        naive_mulR(res_NTT + i + 5 * 16, poly1_NTT + i + 5 * 16, poly2_NTT + i + 5 * 16, 16, &twiddle, coeff_ring);
    }

    for(size_t i = 0; i < 1536; i += 96){
        point_mul(res_NTT + i + 1 * 16, res_NTT + i + 1 * 16, twist16inv, 16, 1, coeff_ring);
        point_mul(res_NTT + i + 4 * 16, res_NTT + i + 4 * 16, twist16inv, 16, 1, coeff_ring);
        point_mul(res_NTT + i + 2 * 16, res_NTT + i + 2 * 16,    twist16, 16, 1, coeff_ring);
        point_mul(res_NTT + i + 5 * 16, res_NTT + i + 5 * 16,    twist16, 16, 1, coeff_ring);
    }

    for(size_t i = 0; i < 1536; i += 96){
        for(size_t j = 0; j < 16; j++){
            GT_3x2(res_NTT + i + j, res_NTT + i + j, OMEGA3INV, 16);
        }
    }

    point_mul(res_NTT, res_NTT, twist_inv_table, 1536, 1, coeff_ring);


    for(size_t i = 0; i < 96; i++){
        rader_17_primitive_inv(res + i, res_NTT + i, twiddle_inv_rader17, twiddle_rader17, 96);
    }

    scale = INV17;
    for(size_t i = 0; i < 1536; i++){
        coeff_ring.mulZ(res + i, res + i, &scale);
    }

    scale = INV3;
    for(size_t i = 0; i < 1536; i++){
        coeff_ring.mulZ(res + i, res + i, &scale);
    }

    scale = INV2;
    for(size_t i = 0; i < 1536; i++){
        coeff_ring.mulZ(res + i, res + i, &scale);
    }

    for(size_t i = 0; i < 1536; i++){
        if(ref[i] != res[i]){
            printf("%4zu: %8d, %8d\n", i, ref[i], res[i]);
        }
    }

    printf("polymul finished!\n");

}


