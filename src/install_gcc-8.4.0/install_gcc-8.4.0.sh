#!/bin/bash

# tested env
# - gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0

CALL_DIR=`pwd -P`

CACHE_DIR=$CALL_DIR/'env_cpm/cache'
BUILD_DIR=$CALL_DIR/'env_cpm/build'
INST_PATH=$CALL_DIR/'env_cpm/local'
mkdir -p $CACHE_DIR
mkdir -p $BUILD_DIR
mkdir -p $INST_PATH

URL=http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-8.4.0/gcc-8.4.0.tar.gz
fName=${URL##*/}         # gcc-8.4.0.tar.gz
fName_base=${fName%.*.*} # gcc-8.4.0
fName_ext=${fName#*.*.}  # tar.gz
libName=${fName%-*}      # gcc

# installing depending packages
#   See: contrib/download_prerequisites of gcc-8.4.0.tar.gz
SCRIPT_DIR=./src/install_gcc-8.4.0/
$SCRIPT_DIR/install_m4-1.4.15.sh
$SCRIPT_DIR/install_gmp-6.1.0.sh
$SCRIPT_DIR/install_mpfr-3.1.4.sh
$SCRIPT_DIR/install_mpc-1.0.3.sh
$SCRIPT_DIR/install_isl-0.18.sh

# downloading source file
if [ ! -e $CACHE_DIR/$fName -a -e $CACHE_DIR/$fName-00 -a -e $CACHE_DIR/$fName-01 ]; then
    cat $CACHE_DIR/$fName-* >> $CACHE_DIR/$fName
fi
if [ ! -e $CACHE_DIR/$fName ]; then
	wget -P $CACHE_DIR $URL
fi

# unpacking the archive file
if [ ! -e $BUILD_DIR/$fName_base/ ]; then
	tar -xvf $CACHE_DIR/$fName -C $BUILD_DIR
fi

# --- installation: begin ---------------------------------------------
if [ ! -e $INST_PATH/bin/$libName ]; then
	cd $BUILD_DIR/$fName_base/
	
	unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE
	
	#export PATH
	#export CFLAGS
	#export LDFLAGS
	#export LD_LIBRARY
	#PATH=$PATH:$INST_PATH/bin
	#CFLAGS=-I$INST_PATH/include\ -fpermissive
	#LDFLAGS=-L$INST_PATH/lib
	export LD_LIBRARY_PATH=$INST_PATH/lib

	#./configure --prefix=$INST_PATH --enable-cxx --disable-multilib --enable-languages=c,c++
	#./configure --disable-bootstrap --disable-multilib --enable-languages=c,c++,fortran --prefix=$INST_PATH --with-gmp=$INST_PATH --with-mpc=$INST_PATH --with-mpfr=$INST_PATH --with-isl=$INST_PATH
	./configure --disable-multilib --enable-languages=c,c++ --prefix=$INST_PATH --with-gmp=$INST_PATH --with-mpc=$INST_PATH --with-mpfr=$INST_PATH --with-isl=$INST_PATH
	make -j
	make check
	make install

	cd $CALL_DIR
fi
# ----------------------------------------------- installation: end ---
