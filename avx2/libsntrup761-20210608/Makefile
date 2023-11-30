
SCRIPTS=./scripts
DATA=./data


BUILD = build

SUPERCOP_DIR = supercop
SUPERCOP     = $(SUPERCOP_DIR)/lib/libsupercop.a
SUPERCOP_INC = $(SUPERCOP_DIR)/include
SUPERCOP_LIB = $(SUPERCOP_DIR)/lib

LIBNAME = sntrup761batch
SHARED = lib$(LIBNAME).so
EXPORTED_HEADER = crypto_kem_sntrup761.h



PREFIX = /usr/local
install_libdir = $(PREFIX)/lib
install_includedir = $(PREFIX)/include

INSTALL = install
INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644
INSTALL_LIB = $(INSTALL_PROGRAM)
INSTALL_HEADER = $(INSTALL_DATA)


ifndef $(SRC)
  #SRC=crypto_kem/sntrup761/ref
  #SRC=crypto_kem/sntrup761/factored
  SRC=crypto_kem/sntrup761/avx
endif

###

PKGCONFIG_SRC_DIR = pkgconfig/
PKGCONFIG_TARGET = $(PKGCONFIG_SRC_DIR)lib$(LIBNAME).pc

###

ifeq ($(USE_RPATH),RPATH)
  _LDFLAGS_RPATH = '-Wl,-rpath,$(LIBRPATH)'
else ifeq ($(USE_RPATH),RUNPATH)
  _LDFLAGS_RPATH = '-Wl,--enable-new-dtags,-rpath,$(LIBRPATH)'
else
  _LDFLAGS_RPATH =
endif


TESTDIR = unit-test
TESTS = batchgenkey-test

#############################

#CC = gcc

CFLAGS_OPT ?= -O3 #-DN_KEYBATCH=16
ifdef N_KEYBATCH
CFLAGS_OPT += -DN_KEYBATCH=$(N_KEYBATCH)
endif

CFLAGS_MARCH ?= -march=native
CFLAGS_WARN ?= -Wall -Wextra
CFLAGS_PIC ?= -fPIC #-g -fsanitize=address
CFLAGS_INCLUDEDIRS ?= -I./ -I$(BUILD)/include -I$(SUPERCOP_INC)

CFLAGS ?= $(CFLAGS_OPT)
CFLAGS += $(CFLAGS_MARCH)
CFLAGS += $(CFLAGS_DEBUG) # <---- define externally, e.g. `-g` to include debug symbols
CFLAGS += $(CFLAGS_WARN)
CFLAGS += $(CFLAGS_PIC)
CFLAGS += $(CFLAGS_INCLUDEDIRS)
CFLAGS += $(CFLAGS_EXTRA) # <---- never redefined, use externally to add arbitrary CFLAGS options

LDFLAGS += $(LDFLAGS_LIBDIRS)
LDFLAGS += $(LDFLAGS_EXTRA) # <---- never redefined, use externally to add arbitrary LDFLAGS options

# LDLIBS =
LDLIBS += $(LDLIBS_EXTRA) # <---- never redefined, use externally to add arbitrary LDLIBS options


#############################

ifneq ($(OPENSSL_PREFIX),)
  OPENSSL_LIBDIR = $(OPENSSL_PREFIX)/lib
  OPENSSL_INCLUDEDIR = $(OPENSSL_PREFIX)/include

  CFLAGS_INCLUDEDIRS += -I$(OPENSSL_INCLUDEDIR)
  LDFLAGS_LIBDIRS += -L$(OPENSSL_LIBDIR)
  LIBRPATH = $(OPENSSL_LIBDIR):
  LDFLAGS_RPATH = $(_LDFLAGS_RPATH)
endif

#############################

.PHONY: all
all: shared compile-tests

.PHONY: compile_info
compile_info:
	$(info %%% INFO: $$CFLAGS=$(CFLAGS))
	$(info %%% INFO: $$LDFLAGS=$(LDFLAGS))
	$(info %%% INFO: $$LDLIBS=$(LDLIBS))
	$(info %%% INFO: $$LOADLIBES=$(LOADLIBES))

###

# The dependencies of this target are all .PHONY targets, and
# due to this, anything that depends on this target will force
# recompilation every time.
#
# For this reason `install` and `test` don't declare dependencies
# to avoid recompiling all the targets every time.
#
# This is awkward, but it allows for the familiar workflow:
# 	- make [OPENSSL_PREFIX=/opt/some/path] [all]
# 	- make test
# 	- make [DESTDIR=/tmp/test_tree] [PREFIX=/usr/local] install
$(SUPERCOP):
	python3 build/build_static_lib.py crypto_verify
	python3 build/build_static_lib.py crypto_sort
	python3 build/build_static_lib.py crypto_encode
	python3 build/build_static_lib.py crypto_decode
	python3 build/build_static_lib.py crypto_core
	python3 build/build_static_lib.py crypto_kem
	cp supercop/include/crypto_kem_sntrup761.h crypto_kem_sntrup761.h

.PHONY: supercop
supercop: $(SUPERCOP)

###

lib:
	@if [ ! -d "lib" ]; then mkdir lib; fi

###

h_hash:
	python3 build/gen_crypto_xxx_h.py crypto_hash/sha512/openssl

lib_hash: lib h_hash  crypto_hash/sha512/openssl/hash.o
	$(AR) rcs $(SUPERCOP) hash.o

###

$(SHARED): LDFLAGS_LIBDIRS += -L$(SUPERCOP_LIB)
$(SHARED): LDFLAGS += $(LDFLAGS_RPATH)
$(SHARED): LDLIBS := -lcrypto
$(SHARED): compile_info $(SUPERCOP)
	$(CC) -o $@ -shared $(LDFLAGS) $(LOADLIBES) -Wl,--whole-archive supercop/lib/libsupercop.a -Wl,--no-whole-archive $(LDLIBS)

.PHONY: shared
shared: $(SHARED)

###

librm:
	$(AR) dv $(SUPERCOP)

libins: $(SUPERCOP)
	$(AR) rcs $(SUPERCOP)

###

.PHONY: test
test: # avoid dependencies to avoid recompilation
	@for test in $(TESTS); do \
		if [ ! -x $$test ]; then \
			echo "./$$test : Run 'make [all | compile-tests]' first"; \
			exit 1; \
		fi ; \
	done
	@for test in $(TESTS); do \
		echo %%% RUNNING: LD_LIBRARY_PATH=. ./$$test; \
		LD_LIBRARY_PATH=. ./$$test; \
	done

.PHONY: tests
tests: test

.PHONY: compile-tests
compile-tests: $(TESTS)

###

%-test: LIBRPATH := $(LIBRPATH)$$ORIGIN
%-test: LDFLAGS_RPATH = $(_LDFLAGS_RPATH)
%-test: LDFLAGS_LIBDIRS := -L. $(LDFLAGS_LIBDIRS)
%-test: LDLIBS := -l$(LIBNAME) -lcrypto
%-test: LDFLAGS += $(LDFLAGS_RPATH)
%-test: $(TESTDIR)/%-test.o $(SHARED) compile_info
	$(CC) -o $@ $(LDFLAGS) $< $(LOADLIBES) $(LDLIBS)

$(TESTDIR)/batchgenkey-test.o: CFLAGS_WARN += -Wno-pointer-sign -Wno-incompatible-pointer-types -Wno-unused-function #-g -fsanitize=address

%.o: randombytes/%.c
	$(CC) -o $@ $(CFLAGS) -c $<

%.o: $(SRC)/%.c
	$(CC) -o $@ $(CFLAGS) -c $<

%.o: $(EXTRA)/%.c
	$(CC) -o $@ $(CFLAGS) -c $<

%.o: %.S
	$(CC) -o $@ $(CFLAGS) -c $<

#%.S: %.q
#	$(QQ) < $^ > $@

#%.q: $(SCRIPTS)/gen_%.py
#	$(SS) $< > $@

#############################

.PHONY: pkgconfig
pkgconfig: $(PKGCONFIG_TARGET)

$(PKGCONFIG_TARGET): export INSTALL_PREFIX = $(PREFIX)
$(PKGCONFIG_TARGET): export LIBNAME := $(LIBNAME)
$(PKGCONFIG_TARGET): export DESCRIPTION = sntrup761 KEM, in batches.
$(PKGCONFIG_TARGET): export VERSION = 0.0.2

$(PKGCONFIG_SRC_DIR)%.pc: $(PKGCONFIG_SRC_DIR)%.pc.bash FORCE
	sh $< >$@

#############################

.PHONY: install_lib
install_lib: install_headers # $(SHARED) <--- avoid dependency to avoid recompilation
	@for i in $(SHARED); do \
		if [ ! -e $$i ]; then \
			echo "Missing $$i : Run 'make' first"; exit 1; \
		fi ; \
	done

	$(INSTALL_LIB) -D -t $(DESTDIR)$(install_libdir) $(SHARED)

.PHONY: install_headers
install_headers:
	@for i in $(EXPORTED_HEADER); do \
		if [ ! -e $$i ]; then \
			echo "Missing $$i : Run 'make' first"; exit 1; \
		fi ; \
	done
	$(INSTALL_HEADER) -D -t $(DESTDIR)$(install_includedir) $(EXPORTED_HEADER)

.PHONY: install_pkgconfig
install_pkgconfig: $(PKGCONFIG_TARGET)
	$(INSTALL_DATA) -D -t $(DESTDIR)$(install_libdir)/pkgconfig $(PKGCONFIG_TARGET)

.PHONY: install
install: install_lib install_pkgconfig

#############################

.PHONY: FORCE
FORCE:

#############################

.PHONY: FORCE
FORCE:

.PHONY: cleantest
cleantest:
	-rm -f $(TESTDIR)/*.o
	-rm *-test


.PHONY: clean
clean:
	-rm -f *.o
	-rm -f *.s
	-rm -f *.q
	-rmdir lib || true
	-rm -f a.out
	-rm -f $(SHARED)
	-rm -f $(EXPORTED_HEADER)
	-rm -f $(TESTDIR)/*.o
	-rm -f *.h
	-rm -f $(PKGCONFIG_TARGET)
	-rm -f $(TESTS)
	-rm -f $(BUILD)/*.pyc
	-rm -f $(SUPERCOP)
	-rm -rf $(SUPERCOP_DIR)
