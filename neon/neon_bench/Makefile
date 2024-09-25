
CC = gcc

CFLAGS += -mcpu=native -mtune=native -march=native -O3 -Wall

COMMON_PATH = ../../common

CFLAGS += -I$(COMMON_PATH) -Icycles

COMMON_SOURCE = $(COMMON_PATH)/tools.c $(COMMON_PATH)/naive_mult.c $(COMMON_PATH)/gen_table.c $(COMMON_PATH)/ntt_c.c \
				cycles/hal.c cycles/m1cycles.c

ASM_HEADERs =
ASM_SOURCEs = __asm_rader17.S __asm_NTT.S __asm_basemul.S __asm_basemul_Toeplitz.S
C_HEADERs = params.h NTT_params.h ring.h rader.h __neon_basemul.h polymul.h
C_SOURCEs = ring.c rader.c __neon_basemul.c polymul.c

HEADERs = $(ASM_HEADERs) $(C_HEADERs)
SOURCEs = $(ASM_SOURCEs) $(COMMON_SOURCE) $(C_SOURCEs)

all: test bench microbench

test: test.c $(HEADERs) $(SOURCEs)
	$(CC) $(CFLAGS) $(SOURCEs) -o $@ $<

bench: bench.c $(HEADERs) $(SOURCEs)
	$(CC) $(CFLAGS) $(SOURCEs) -o $@ $<

microbench: microbench.c $(HEADERs) $(SOURCEs)
	$(CC) $(CFLAGS) $(SOURCEs) -o $@ $<

gen: gen.c $(HEADERs) $(SOURCEs)
	$(CC) $(CFLAGS) $(SOURCEs) -o $@ $<

.PHONY: clean
clean:
	rm -f test
	rm -f bench
	rm -f microbench
	rm -f gen
