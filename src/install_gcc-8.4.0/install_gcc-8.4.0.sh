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

# modify to compile on gcc 7.5.0
# /home/admis/projects/gcc_local_install/.env_cpm/build/gcc-8.5.0/host-x86_64-pc-linux-gnu/gcc/auto-host.h

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


#../configure --disable-multilib --enable-languages=c,c++,fortran --prefix=$HOME/mygcc --with-gmp=$HOME/mygcc --with-mpc=$HOME/mygcc --with-mpfr=$HOME/mygcc --with-isl=$HOME/mygcc
#unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE
#LD_LIBRARY_PATH=$HOME/mygcc/lib make -j4
#make install



#checking for the correct version of the gmp/mpfr/mpc libraries... yes
#checking for isl 0.15 or later... yes
#*** This configuration is not supported in the following subdirectories:
#     gnattools gotools target-libada target-libhsail-rt target-libgfortran target-libbacktrace target-libgo target-libffi target-libobjc target-liboffloadmic
#    (Any other directories should still work fine.)
#checking for default BUILD_CONFIG... bootstrap-debug
#checking for --enable-vtable-verify... no
#/usr/bin/ld: cannot find Scrt1.o: No such file or directory
#/usr/bin/ld: cannot find crti.o: No such file or directory
#/usr/bin/ld: skipping incompatible /usr/lib/gcc/x86_64-linux-gnu/7/libgcc.a when searching for -lgcc
#/usr/bin/ld: cannot find -lgcc
#/usr/bin/ld: skipping incompatible /usr/lib/gcc/x86_64-linux-gnu/7/libgcc_s.so.1 when searching for libgcc_s.so.1
#/usr/bin/ld: cannot find libgcc_s.so.1
#/usr/bin/ld: skipping incompatible /usr/lib/gcc/x86_64-linux-gnu/7/libgcc.a when searching for -lgcc
#/usr/bin/ld: cannot find -lgcc
#collect2: error: ld returned 1 exit status
#configure: error: I suspect your system does not have 32-bit development libraries (libc and headers). If you have them, rerun configure with --enable-multilib. If you do not have them, and want to build a 64-bit-only compiler, rerun configure with --disable-multilib.
#make: *** ターゲットが指定されておらず, makefile も見つかりません.  中止.
#make: *** ターゲット 'check' を make するルールがありません.  中止.
#make: *** ターゲット 'install' を make するルールがありません.  中止.





#$ make check
#make[1]: Entering directory '/home/admis/projects/gcc_local_install/.env_cpm/build/gcc-8.4.0'
#make[2]: Entering directory '/home/admis/projects/gcc_local_install/.env_cpm/build/gcc-8.4.0/host-x86_64-pc-linux-gnu/fixincludes'
#autogen -T ../.././fixincludes/check.tpl ../.././fixincludes/inclhack.def
#/bin/bash: autogen: command not found
#Makefile:176: recipe for target 'check' failed
#make[2]: *** [check] Error 127
#make[2]: Leaving directory '/home/admis/projects/gcc_local_install/.env_cpm/build/gcc-8.4.0/host-x86_64-pc-linux-gnu/fixincludes'
#Makefile:3745: recipe for target 'check-fixincludes' failed
#make[1]: *** [check-fixincludes] Error 2
#make[1]: Leaving directory '/home/admis/projects/gcc_local_install/.env_cpm/build/gcc-8.4.0'
#Makefile:2274: recipe for target 'do-check' failed
#make: *** [do-check] Error 2


# sudo apt-get update -y
# sudo apt-get install -y autogen



