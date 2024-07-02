
# Structure of this folder

- `neon`: Neon polynomial multiplier.
- `neon_bench`: Benchmarking the Neon polynomial multiplier.
- `neon_scheme`: Neon implementation of `sntrup761` with our Neon polynomial multiplier.

# How to test for correctness

## Polynomial Multiplier

Go to the folder `neon_bench`, type `make`, and type `./test`.
If you see the following then the polynomial multiplications are correct.
```
mulcore finished!
polymul finished!
```

## Scheme

Go to the folder `neon_scheme/sntrup761/{imple}`, type `make` where `{imple}` is one of the following:
- `aarch64_new`
- `aarch64_old`
Two binary files will be produced: `test` and `testvectors`.

### KEM

Run `test`.

### Sample outputs
```
DONE key pair generation!
DONE encapsulation!
DONE decapsulation!
OK KEYS
DONE key pair generation!
DONE encapsulation!
DONE decapsulation!
OK KEYS
DONE key pair generation!
DONE encapsulation!
DONE decapsulation!
OK KEYS
DONE key pair generation!
DONE encapsulation!
DONE decapsulation!
OK KEYS
DONE key pair generation!
DONE encapsulation!
DONE decapsulation!
OK KEYS
DONE key pair generation!
DONE encapsulation!
DONE decapsulation!
OK KEYS
DONE key pair generation!
DONE encapsulation!
DONE decapsulation!
OK KEYS
DONE key pair generation!
DONE encapsulation!
DONE decapsulation!
OK KEYS
DONE key pair generation!
DONE encapsulation!
DONE decapsulation!
OK KEYS
DONE key pair generation!
DONE encapsulation!
DONE decapsulation!
OK KEYS
```

### Test vectors

Run `testvectors`.

# How to benchmark

## Polynomial Multiplier

Go to folder `neon_bench` and type `make`.
Typing `./bench` reports the overall performance of polynomial multiplications,
and typing `./microbench` reports the performance of each of the components.

### Sample outputs

#### Cortex-A72

Old:
```

```

New:
```

```

#### Apple M1 Pro

Old:
```

```

New:
```
mulcore: 6519
polymul: 6727
polymul finished!
```

## Scheme

Go to folder `neon_scheme/sntrup761/{imple}` where `{imple}` is one of the following
- `aarch64_new`
- `aarch64_old`
and type `make speed`.
The binary file `speed` will be produced.
Typing `./speed` on Cortex-A72 or `sudo ./speed` on Apple M1 Pro reports the performance of the overall scheme.

### Sample outputs

#### Cortex-A72

Old:
```

```

New:
```

```

#### Apple M1 Pro

Old:
```
crypto_kem_keypair: 1827835
crypto_kem_enc: 64589
crypto_kem_dec: 43876
ZKeyGen: 1806117
ZEncrypt: 10696
ZDecrypt: 19822
KeyGen: 1793990
Encrypt: 9223
Decrypt: 18583
```

New:
```
crypto_kem_keypair: 1812409
crypto_kem_enc: 62569
crypto_kem_dec: 38101
ZKeyGen: 1791233
ZEncrypt: 8832
ZDecrypt: 16084
KeyGen: 1737420
Encrypt: 7278
Decrypt: 14823
```


