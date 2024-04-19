# NTRU_Prime_truncation

This repository accompanies the paper
**Pushing the Limit of Vectorized Polynomial Multiplications for NTRU Prime**
to appear at Australasian Conference on Information Security and Privacy, 2024.
The paper is currently available at [ePrint 2023/604](https://eprint.iacr.org/2023/604).

Author: [Vincent Hwang](https://vincentvbh.github.io/) `<vincentvbh7@gmail.com>`

# Overview of This Artifact

## Schemes and Parameter Set
- NTRU Prime
    - `sntrup761`

## Architecture
- Armv8-A for Neon
- Haswell or Skylake for AVX2

## Benchmarking Platform
- Neon
    - Cortex-A72
    - Apple M1 Pro
- AVX2
    - Intel(R) Core(TM) i7-4770K (Haswell)
    - Intel(R) Xeon(R) CPU E3-1275 v5 (Skylake)

## Minimum Requirements
- A hardware supporting 64-bit Armv8.0-A.
- A hardware supporting Intel AVX2.

# Structure of This Artifact
- `avx2`
- `C`
- `common`: File involved during the development.
- `neon`

# How to Test for Correctness

# How to Benchmark
