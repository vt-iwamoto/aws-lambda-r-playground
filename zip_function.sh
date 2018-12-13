#!/bin/sh

set -eu

mkdir /tmp/work
cd /tmp/work

cp /opt/work/{bootstrap,plot.R} ./

mkdir -p R/bin/exec
cp /usr/lib64/R/bin/exec/R ./R/bin/exec/

mkdir R/etc
cp /usr/lib64/R/etc/Renviron ./R/etc/

mkdir lib
cp /usr/lib64/{libgfortran.so.3,libquadmath.so.0,libtre.so.5} ./lib/
cp /usr/lib64/R/lib/{libR.so,libRblas.so,libRlapack.so} ./lib/

copy_r_lib() {
  for lib in $@
  do
    rsync -a /usr/lib64/R/library/$lib R/library/ \
          --exclude afm \
          --exclude demo \
          --exclude doc \
          --exclude enc \
          --exclude help \
          --exclude html \
          --exclude icc \
          --exclude misc \
          --exclude Sweave
  done
}

mkdir R/library
copy_r_lib base compiler datasets graphics grDevices methods stats utils txtplot

rm -f /opt/work/function.zip
zip -r /opt/work/function.zip .
