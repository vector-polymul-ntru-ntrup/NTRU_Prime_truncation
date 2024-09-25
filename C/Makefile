
CC = gcc

CFLAGS += -mcpu=native -mtune=native -march=native -O3 -Wall

COMMON_PATH = ../common

CFLAGS += -I$(COMMON_PATH)

COMMON_SOURCE = $(COMMON_PATH)/tools.c $(COMMON_PATH)/naive_mult.c $(COMMON_PATH)/gen_table.c $(COMMON_PATH)/ntt_c.c

ASM_HEADERs =
ASM_SOURCEs =
C_HEADERs = params.h NTT_params.h ring.h rader.h
C_SOURCEs = ring.c rader.c

HEADERs = $(ASM_HEADERs) $(C_HEADERs)
SOURCEs = $(ASM_SOURCEs) $(COMMON_SOURCE) $(C_SOURCEs)

all: test

test: test.c $(HEADERs) $(SOURCEs)
	$(CC) $(CFLAGS) $(SOURCEs) -o $@ $<

gen: gen.c $(HEADERs) $(SOURCEs)
	$(CC) $(CFLAGS) $(SOURCEs) -o $@ $<

.PHONY: clean
clean:
	rm -f test
	rm -f gen
