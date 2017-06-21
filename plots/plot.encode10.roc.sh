#!/bin/bash

if [ "$#" != "1" ]; then
	echo "$0 collectdir"
	exit
fi


dir=`pwd`
list=$dir/../data/encode10.list

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

sumdir=$1

echo "library(\"tikzDevice\")" > $tmpfile
echo "source(\"$dir/R/roc.R\")" >> $tmpfile

for k in `cat $list`
do
	id=`echo $k | cut -f 1 -d ":"`
	ss=`echo $k | cut -f 4 -d ":"`
	echo "plot.roc(\"$sumdir/$id\", \"$ss\", \"$id.tex\", 1, 0.6, 0.9)" >> $tmpfile
done

outdir=$dir/encode10/roc
mkdir -p $outdir

cd $outdir

R CMD BATCH $tmpfile

for k in `cat $list`
do
	id=`echo $k | cut -f 1 -d ":"`
	$dir/wrap.sh $id.tex
	$dir/myepstool.sh $id
done

rm -rf $tmpfile
