# NTRU_Prime_truncation

This repository accompanies the paper
**Pushing the Limit of Vectorized Polynomial Multiplications for NTRU Prime**
to appear at Australasian Conference on Information Security and Privacy, 2024.
The paper is currently available at [ePrint 2023/604](https://eprint.iacr.org/2023/604).

Author: [Vincent Hwang](https://vincentvbh.github.io/) `<vincentvbh7@gmail.com>`

# Overview of this artifact

## Schemes and parameter set
- NTRU Prime
    - `sntrup761`

## Architectures
- Armv8-A for Neon
- Haswell or Skylake for AVX2

## Benchmarking platforms
- Neon
    - Cortex-A72
    - Apple M1 Pro
- AVX2
    - Intel(R) Core(TM) i7-4770K (Haswell)
    - Intel(R) Xeon(R) CPU E3-1275 v5 (Skylake)

## Minimum requirements
- A hardware supporting 64-bit Armv8.0-A.
- A hardware supporting Intel AVX2.

# Structure of this artifact
- `avx2`: AVX2 implementation.
- `C`: C implementation.
- `common`: File involved during the development.
- `neon`: Neon implementation.

# How to test for correctness

Please refer to
- `neon/README.md`
- `avx2/README.md`

# How to benchmark

Please refer to
- `neon/README.md`
- `avx2/README.md`





