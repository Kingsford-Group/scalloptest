#!/bin/bash

dir=`pwd`
#cdir=$dir/encode10/collect.B759
texdir=$dir/tex

cdir=$dir/encode10/collect.B771


./plot.encode10.roc.star.sh $cdir

exit

./plot.encode10.quant.star.sh $cdir
./plot.encode10.roc.tophat.sh $cdir
./plot.encode10.roc.hisat.sh $cdir
./plot.encode10.auc.star.sh $cdir
./plot.encode10.auc.tophat.sh $cdir
./plot.encode10.auc.hisat.sh $cdir
./plot.encode10.roc.sh $cdir
./plot.encode10.cuff.sh $cdir
./plot.encode10.venn.sh $cdir
./plot.encode10.class.sh $cdir
./plot.encode10.time.sh $cdir
./plot.encode10.time.star.sh $cdir
./plot.encode10.accuracy.sh $cdir
./plot.encode10.accuracy.star.sh $cdir
./plot.encode10.auc.sh $cdir
./plot.encode10.quant.sh $cdir
./plot.encode10.cov.sh $cdir
./plot.encode10.salmon.sh $cdir



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
