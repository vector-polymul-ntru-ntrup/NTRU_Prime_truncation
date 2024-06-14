
# Structure of This Folder

- `neon`: Neon polynomial multiplier.
- `neon_bench`: Benchmarking the Neon polynomial multiplier.
- `neon_scheme`: Neon implementation of `sntrup761` with our Neon polynomial multiplier.

# How to Test for Correctness

## Polynomial Multiplier

Go to folder `neon_bench`, type `make`, and type `./test`.
If you see the following then the polynomial multiplications are correct.
```
mulcore finished!
polymul finished!
```

## Scheme

TBA

# How to Benchmark

## Polynomial Multiplier

Go to folder `neon_bench` and type `make`.
Typing `./bench` reports the overall performance of polynomial multiplications,
and typing `./microbench` reports the performance of each of the components.

## Scheme

TBA
