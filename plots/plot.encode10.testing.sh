#!/bin/bash

dir=`pwd`
texdir=`pwd`/tex
outdir=$dir/encode10/testing
mkdir -p $outdir

cp $texdir/testing.tex $outdir

cd $outdir
$dir/myepstool.sh testing
