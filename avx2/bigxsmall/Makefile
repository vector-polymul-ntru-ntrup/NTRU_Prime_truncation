
CC = gcc

CFLAGS += -mcpu=native -mtune=native -O3 -Wall -mavx2 -z noexecstack -Wno-unused-command-line-argument

COMMON_PATH = ../../common

CFLAGS += -I$(COMMON_PATH)

COMMON_SOURCE = $(COMMON_PATH)/tools.c $(COMMON_PATH)/naive_mult.c $(COMMON_PATH)/gen_table.c $(COMMON_PATH)/ntt_c.c


C_HEADERs = params.h NTT_params.h ring.h ntt.h
C_SOURCEs = ring.c mult768.c ntt.c
ASM_HEADERs =
ASM_SOURCEs =

HEADERs = $(ASM_HEADERs) $(C_HEADERs)
SOURCEs = $(ASM_SOURCEs) $(COMMON_SOURCE) $(C_SOURCEs)

all: test

bench: bench_mulcore bench_polymul

test: test.c $(HEADERs) $(SOURCEs)
	$(CC) $(CFLAGS) $(SOURCEs) -o $@ $(addsuffix .c, $@)

gen: gen.c $(HEADERs) $(SOURCEs)
	$(CC) $(CFLAGS) $(SOURCEs) -o $@ $(addsuffix .c, $@)

bench_mulcore: bench_mulcore.c $(HEADERs) $(SOURCEs)
	$(CC) $(CFLAGS) $(SOURCEs) -o $@ $(addsuffix .c, $@)

bench_polymul: bench_polymul.c $(HEADERs) $(SOURCEs)
	$(CC) $(CFLAGS) $(SOURCEs) -o $@ $(addsuffix .c, $@)

microbench: microbench.c $(HEADERs) $(SOURCEs)
	$(CC) $(CFLAGS) $(SOURCEs) -o $@ $(addsuffix .c, $@)

.PHONY: clean
clean:
	rm -f test
	rm -f unit_test
	rm -f bench_mulcore
	rm -f bench_polymul
	rm -f microbench
	rm -f gen
