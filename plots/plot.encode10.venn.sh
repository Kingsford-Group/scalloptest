#!/bin/bash

if [ "$#" != "1" ]; then
	echo "$0 collectdir"
	exit
fi

dir=`pwd`
texdir=`pwd`/tex

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

sumdir=$1
outdir=$dir/encode10/venn
mkdir -p $outdir

echo "library(\"tikzDevice\")" > $tmpfile
echo "source(\"$dir/R/venn.R\")" >> $tmpfile

echo "plot.venn(\"$sumdir/venn.algo\")" >> $tmpfile

cd $outdir

R CMD BATCH $tmpfile

for k in `seq 1 10`
do
	echo $k
	$dir/unwrap.sh venn-tophat-$k.tex
	$dir/unwrap.sh venn-star-$k.tex
	$dir/unwrap.sh venn-hisat-$k.tex
done

for k in `echo "tophat star hisat"`
do
	cp $texdir/venn-$k.tex .
	$dir/myepstool.sh venn-$k
done

rm -rf $tmpfile
