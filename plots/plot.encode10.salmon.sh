#!/bin/bash

if [ "$#" != "1" ]; then
	echo "$0 collectdir"
	exit
fi

dir=`pwd`

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

sumdir=$1

echo "library(\"tikzDevice\")" > $tmpfile
echo "source(\"$dir/R/salmon.R\")" >> $tmpfile

echo "plot.salmon(\"$sumdir/salmon\", \"salmon.tex\")" >> $tmpfile

outdir=$dir/encode10/salmon
mkdir -p $outdir

cd $outdir

R CMD BATCH $tmpfile

for k in `echo "salmon"`
do
	id=`echo $k | cut -f 1 -d ":"`
	$dir/wrap.sh $id.tex
	$dir/myepstool.sh $id
done

rm -rf $tmpfile
