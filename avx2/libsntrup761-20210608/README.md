# Shared Library for sntrup761

## Installation from source

- `make [OPENSSL_PREFIX=/opt/some/path] [USE_RPATH=RPATH|RUNPATH][all]`

  This operation will generate `libsntrup761batch.so` and the test binaries.
  The variable `OPENSSL_PREFIX` can **optionally** be defined to link against an
  alternative version of OpenSSL: if specified it is assumed that

  * `${OPENSSL_PREFIX}/lib/libcrypto.so` exists
  * `${OPENSSL_PREFIX}/include` contains the associated `openssl/*.h` headers

  `USE_RPATH` can be optionally set to either `RPATH` or `RUNPATH`, read the
  section below for further information about `USE_RPATH`.

- `make test` (optional)

  This operation will run unit-tests locally

- `[sudo] make [DESTDIR=/tmp/test_tree] [PREFIX=/usr/local] install`

  This operation will install

  1. `libsntrup761batch.so` to `${DESTDIR}$PREFIX/lib`
  2. `include/crypto_kem_sntrup761.h` to `${DESTDIR}$PREFIX/include`

  If not otherwise redefined, by default

  * `PREFIX=/usr/local`
  * [`DESTDIR=''`][DESTDIR]

[DESTDIR]: https://www.gnu.org/prep/standards/html_node/DESTDIR.html

### Support for `RPATH` and `RUNPATH`

During the compilation step, optionally `USE_RPATH` can be set to either `RPATH`
or `RUNPATH`, to enable passing either option to the linker for the shared
library and the test binaries.

More details about RPATH and RUNPATH can be found at [RPATH].

If either of the two strategies is enabled, test binaries will include `$ORIGIN`
in the ELF attribute corresponding to the chosen strategy.
This means that when executing the test binaries, the folder containing the
binary at execution time can be used by the loader to find required dynamic
libraries.

Additionally, if a custom OpenSSL installation is selected at compile time via
the `OPENSSL_PREFIX` variable, setting `USE_RPATH` to one of the two strategies
will ensure that the shared library and the test binaries will include the hint
to the location of `libcrypto.so` in the relevant ELF attribute.

[RPATH]: https://en.wikipedia.org/wiki/Rpath

## API: `crypto_kem_sntrup761.h``

### Constants

- `crypto_kem_sntrup761_BYTES`

  length of shared secret, 32 bytes.

- `crypto_kem_sntrup761_CIPHERTEXTBYTES`

  length of cipher text, 1039 bytes.

- `crypto_kem_sntrup761_SECRETKEYBYTES`

  length of secret key, 1763 bytes.

- `crypto_kem_sntrup761_PUBLICKEYBYTES`

  length of public key, 1158 bytes

### Functions

- `int crypto_kem_sntrup761_keypair(unsigned char *pk, unsigned char *sk);`

  * `pk`: public key
  * `sk`: secret key

- `int crypto_kem_sntrup761_keypair_batch(unsigned char *pk, unsigned char *sk, unsigned num);`

  * `pk`: public keys, output, pointing to a buffer of `crypto_kem_sntrup761_PUBLICKEYBYTES * num` bytes.
  * `sk`: secret keys, output, pointing to a buffer of `crypto_kem_sntrup761_SECRETKEYBYTES * num` bytes.
  * `num`: number of keys in one batch, better to be a multiple of 32.

- `int crypto_kem_sntrup761_enc(unsigned char * c, unsigned char *k, const unsigned char *pk);`

  * `c`: cipher text, output
  * `k`: shared secret
  * `pk`: public key

- `int crypto_kem_sntrup761_dec(unsigned char *k, const unsigned char *c, const unsigned char *sk);`

  * `k`: shared secret, output
  * `c`: cipher text
  * `sk`: secret key

