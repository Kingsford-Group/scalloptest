#!/bin/bash

dir=`pwd`
cdir=$dir/sequin/collect.B759
texdir=$dir/tex

#./plot.sequin.accuracy.sh $cdir
#./plot.sequin.roc.sh $cdir

# plot all
outdir=$dir/sequin/sequin
mkdir -p $outdir

cp $texdir/sequin.tex $outdir

cd $outdir
$dir/myepstool.sh sequin
