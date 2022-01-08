#!/bin/bash

CALL_DIR=`pwd -P`

CACHE_DIR=$CALL_DIR/'env_cpm/cache'
BUILD_DIR=$CALL_DIR/'env_cpm/build'
INST_PATH=$CALL_DIR/'env_cpm/local'
mkdir -p $CACHE_DIR
mkdir -p $BUILD_DIR
mkdir -p $INST_PATH

URL=http://ftp.gnu.org/gnu/m4/m4-1.4.15.tar.gz
fName=${URL##*/}         #isl-0.18.tar.bz2
fName_base=${fName%.*.*} # isl-0.18
fName_ext=${fName#*.*.}  # tar.bz2
binName=${fName%-*}      # isl

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
if [ ! -e $INST_PATH/bin/$binName ]; then
	cd $BUILD_DIR/$fName_base/
	
	# fix installation error
	cd lib
	sed -i -e '/gets is a security/d' ./stdio.in.h
	cd ..
	
	# ref: http://programcode.blog.fc2.com/blog-entry-16.html	#export PATH
	#export CFLAGS
	#export LDFLAGS
	#PATH=$PATH:$INST_PATH/bin
	#CFLAGS=-I$INST_PATH/include
	#LDFLAGS=-L$INST_PATH/lib

	./configure --prefix=$INST_PATH --enable-cxx
	make -j
	make check
	make install

	cd $CALL_DIR
fi
# ----------------------------------------------- installation: end ---

