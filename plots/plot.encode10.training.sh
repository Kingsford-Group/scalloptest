#!/bin/bash

dir=`pwd`
texdir=`pwd`/tex
outdir=$dir/encode10/training
mkdir -p $outdir

cp $texdir/training.tex $outdir

cd $outdir
$dir/myepstool.sh training
