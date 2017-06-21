#!/bin/bash

dir=`pwd`

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

sumdir=$dir/encode10/collect.B759

echo "library(\"tikzDevice\")" > $tmpfile
echo "source(\"$dir/R/time.R\")" >> $tmpfile

echo "plot.time(\"$sumdir/time\", \"time.tex\")" >> $tmpfile

outdir=$dir/encode10/time
mkdir -p $outdir

cd $outdir

R CMD BATCH $tmpfile

for k in `echo "time"`
do
	id=`echo $k | cut -f 1 -d ":"`
	$dir/wrap.sh $id.tex
	$dir/myepstool.sh $id
done

rm -rf $tmpfile
