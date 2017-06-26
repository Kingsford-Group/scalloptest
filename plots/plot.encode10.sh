#!/bin/bash

dir=`pwd`
cdir=$dir/encode10/collect.B759
texdir=$dir/tex

./plot.encode10.cuff.sh $cdir
exit

./plot.encode10.roc.sh $cdir
./plot.encode10.time.sh $cdir
./plot.encode10.accuracy.sh $cdir
./plot.encode10.auc.sh $cdir
./plot.encode10.class.sh $cdir
./plot.encode10.quant.sh $cdir

# plot training
outdir=$dir/encode10/training
mkdir -p $outdir

cp $texdir/training.tex $outdir
cd $outdir
$dir/myepstool.sh training

# plot testing
outdir=$dir/encode10/testing
mkdir -p $outdir

cp $texdir/testing.tex $outdir
cd $outdir
$dir/myepstool.sh testing
