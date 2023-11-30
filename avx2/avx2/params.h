#ifndef PARAMS_H
#define PARAMS_H

#define p 761
#define q 4591

// https://stackoverflow.com/a/1489985/1711232
#define PASTER(x, y) x##y
#define EVALUATOR(x, y) PASTER(x, y)
#define NAME(fun) EVALUATOR(, fun)

#endif

