#!/bin/bash

if [ "$#" != "1" ]; then
	echo "$0 collectdir"
	exit
fi

dir=`pwd`

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

sumdir=$1
outdir=$dir/encode10/class
texdir=$dir/tex
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
	$dir/myepstool.sh $id
done

cp $texdir/class.tex .
$dir/myepstool.sh class

rm -rf $tmpfile
