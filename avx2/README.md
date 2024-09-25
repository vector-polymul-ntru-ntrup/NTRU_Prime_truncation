
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
Type `make gen`


## Batch Key Generation

Please follow the instructions in `libsntrup761-20210608/README.md`.
We integrated our multiplier to this folder.

## Encapsulation and Decapsulation

Please uncompress `supercop-20230530_new.tar.gz` and follow the instructions there.
We integrated our multiplier to this package.

# How to Benchmark

## Polynomial Multiplication
Go to the folder `avx2_bench`.

TBA

## Batch Key Generation

Please follow the instructions in `libsntrup761-20210608/README.md`.
We integrated our multiplier to this folder.

## Encapsulation and Decapsulation

Please uncompress `supercop-20230530_new.tar.gz` and follow the instructions there.
We integrated our multiplier to this package.

