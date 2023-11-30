#!env bash

set -eux

cat <<- EOF
	prefix=${INSTALL_PREFIX}
	exec_prefix=\${prefix}
	libdir=\${exec_prefix}/lib
	includedir=\${prefix}/include
	
	Name: lib${LIBNAME}
	Description: ${DESCRIPTION}
	Version: ${VERSION}
	Requires: libcrypto
	
	Libs: -L\${libdir} -l${LIBNAME}
	Cflags: -I\${includedir}
EOF
