#!/bin/bash

mkdir -p ./base_archive

CALL_DIR=`pwd -P`

cd $CALL_DIR/env_cpm/local/
tar -Jcf $CALL_DIR/base_archive/local_amd64_gcc-8.4.0.tar.xz *  # tar.xz

cd $CALL_DIR/base_archive/
split -d -b 100m local_gcc-8.4.0.tar.xz local_amd64_gcc-8.4.0.tar.xz-
rm local_amd64_gcc-8.4.0.tar.xz

# Comparison results
#  of compression local gcc-8.4.0 head and binaries.
# 
# |         |  compress  | decompress | file size |
# | ------- | ---------- | ---------- | --------- |
# | on disk |      -     |      -     |      1 GB |
# | tar     |  0m52.114s |  0m12.273s |  331.6 MB |
# | tar.bz2 |  1m20.692s |  0m43.613s |  318.5 MB |
# | tar.gz  |  0m52.287s |  0m12.201s |  331.6 MB |
# | tar.xz  |  6m52.570s |  0m17.359s |  180.4 MB | <-
# | zip     |  1m6.476s  |  0m21.851s |  377.3 MB |


# --- compress ------------------------------------------------
#cd $CALL_DIR/env_cpm/local/
#echo 'tar'
#time tar -zcf $CALL_DIR/base_archive/local_gcc-8.4.0.tar *  # tar
#echo ''
#
#echo 'tar.bz2'
#time tar -jcf $CALL_DIR/base_archive/local_gcc-8.4.0.tar.bz2 * # tar.bz2
#echo ''
#
#echo 'tar.gz'
#time tar -zcf $CALL_DIR/base_archive/local_gcc-8.4.0.tar.gz *  # tar.gz
#echo ''
#
#echo 'tar.xz'
#time tar -Jcf $CALL_DIR/base_archive/local_gcc-8.4.0.tar.xz *  # tar.xz
#echo ''
#
#echo 'zip'
#time zip -r $CALL_DIR/base_archive/local_gcc-8.4.0.zip ./       # zip
# -------------------------------------------------------------


# --- decompress ----------------------------------------------
#cd $CALL_DIR/base_archive
#mkdir tar
#echo 'tar'
#time tar -zxf local_gcc-8.4.0.tar -C ./tar # tar
#echo ''
#
#mkdir bz2
#echo 'tar.bz2'
#time tar -jxf local_gcc-8.4.0.tar.bz2 -C ./bz2 # tar.bz2
#echo ''
#
#mkdir gz
#echo 'tar.gz'
#time tar -zxf local_gcc-8.4.0.tar.gz -C ./gz # tar.gz
#echo ''
#
#mkdir xz
#echo 'tar.xz'
#time tar -Jxf local_gcc-8.4.0.tar.xz -C ./xz  # tar.xz
#echo ''
#
#echo 'zip'
#time unzip local_gcc-8.4.0.zip       # zip
# -------------------------------------------------------------

