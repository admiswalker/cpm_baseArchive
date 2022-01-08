#!/bin/bash

CALL_DIR=`pwd -P`

CACHE_DIR=$CALL_DIR/'env_cpm/cache'
BUILD_DIR=$CALL_DIR/'env_cpm/build'
INST_PATH=$CALL_DIR/'env_cpm/local'
mkdir -p $CACHE_DIR
mkdir -p $BUILD_DIR
mkdir -p $INST_PATH

URL=https://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz
fName=${URL##*/}         #isl-0.18.tar.bz2
fName_base=${fName%.*.*} # isl-0.18
fName_ext=${fName#*.*.}  # tar.bz2
libName=${fName%-*}      # isl

# installing depending packages


# downloading source file
if [ ! -e $CACHE_DIR/$fName ]; then
	wget -P $CACHE_DIR $URL
fi

# unpacking the archive file
if [ ! -e $BUILD_DIR/$fName_base/ ]; then
	tar -xvf $CACHE_DIR/$fName -C $BUILD_DIR
fi

# --- installation: begin ---------------------------------------------
if [ ! -e $INST_PATH/lib/lib$libName.a ]; then
	cd $BUILD_DIR/$fName_base/
	
	#export PATH
	#export CFLAGS
	#export LDFLAGS
	#PATH=$PATH:$INST_PATH/bin
	#CFLAGS=-I$INST_PATH/include
	#LDFLAGS=-L$INST_PATH/lib

	./configure --prefix=$INST_PATH --with-gmp=$INST_PATH --with-mpfr=$INST_PATH
	make -j
	make check
	make install

	cd $CALL_DIR
fi
# ----------------------------------------------- installation: end ---

