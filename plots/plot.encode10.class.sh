#!/bin/bash

dir=`pwd`

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

sumdir=$dir/../summary/encode10/class.B759
outdir=$dir/encode10/class
mkdir -p $outdir

echo "library(\"tikzDevice\")" > $tmpfile
echo "source(\"$dir/R/class.R\")" >> $tmpfile

echo "plot.class(\"$sumdir/train.class.zero\", \"train-class.tex\")" >> $tmpfile
echo "plot.class(\"$sumdir/test.class.zero\", \"test-class.tex\")" >> $tmpfile

cd $outdir

R CMD BATCH $tmpfile

for id in `echo "train-class test-class"`
do
	$dir/wrap.sh $id.tex
	cat $id.tex | sed 's/Sensitivity/Sensitivity~(\\%)/g' > x; mv x $id.tex
	cat $id.tex | sed 's/Precision/Precision~(\\%)/g' > x; mv x $id.tex
	$dir/myepstool.sh $id
done

rm -rf $tmpfile
