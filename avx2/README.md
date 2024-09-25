
# Structure of This Folder

- `avx2`: AVX2 polynomial multiplier.
- `avx2_bench`: Benchmarking the AVX2 polynomial multiplier.
- `libsntrup761-20210608`: Benchmarking the full `sntrup761` scheme. The performance of batched key generation is reported in our paper.
- `supercop-20230530_new.tar.gz`: Benchmarking the full `sntrup761` scheme under the SUPERCOP framework. The performance numbers of encapsulation and decapsulation are reported in our paper.

# How to Test for Correctness

## Polynomial Multiplication
Go to the folder `avx2_bench`.

### Polynomial Multiplication
Type `make test` to produce the binary file `test`, and execute it as follows:
```
./test
```
Sample output:
```
mulcore finished!
polymul finished!
```

### Twiddle Factor Generation
Type `make gen` to produce the binary file `gen`, and execute it as follows:
```
./gen
```
Sample output:
```
gen finished!
```

## Batch Key Generation

Please follow the instructions in `libsntrup761-20210608/README.md`.
We integrated our multiplier to this folder.

## Encapsulation and Decapsulation

Please uncompress `supercop-20230530_new.tar.gz` and follow the instructions there.
We integrated our multiplier to this package.

# How to Benchmark

Sample outputs are Haswell cycles.

## Polynomial Multiplication
Go to the folder `avx2_bench`.
Type `make bench` to product the binary files `bench_mulcore`, `bench_polymul`, and `microbench`.

For the core polynomial multiplication,
type
```
./bench_mulcore
```
Sample output:
```
mulcore cycles: 12952, 12972, 12992
```

For the polynomial multiplication in NTRU Prime,
type
```
./bench_polymul
```
Sample output:
```
polymul cycles: 13052, 13072, 13092
```

For the micro-benchmark,
type
```
./microbench
```
Sample output:
```
__asm_rader17_truncated (x128) cycles: 2616, 2620, 2628
__asm_3x2_pre (256x8) cycles: 5108, 5112, 5120
twist_transpose_pre (x8, 16x16) cycles: 920, 920, 920
__asm_cyclic_FFT16 (x128) cycles: 3304, 3308, 3316
__asm_negacyclic_FFT16 (x128) cycles: 4800, 4808, 4816
__asm_weighted_karatsuba16 (x128) cycles: 5576, 5592, 5612
twist_transpose_post (x8, 16x16) cycles: 808, 812, 816
__asm_3x2_post (256x8) cycles: 4888, 4900, 4908
__asm_irader17_truncated (x128) cycles: 2676, 2688, 2700
```

## Batch Key Generation

Please follow the instructions in `libsntrup761-20210608/README.md`.
We integrated our multiplier to this folder.

## Encapsulation and Decapsulation

Please uncompress `supercop-20230530_new.tar.gz` and follow the instructions there.
We integrated our multiplier to this package.

