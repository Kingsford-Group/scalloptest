#!/bin/bash

dir=`pwd`
list=$dir/../data/encode10.list

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

sumdir=$dir//encode10/collect.B759
outdir=$dir/encode10/auc
mkdir -p $outdir

echo "library(\"tikzDevice\")" > $tmpfile
echo "source(\"$dir/R/auc.R\")" >> $tmpfile

aucfile1=$outdir/aucfile1
aucfile2=$outdir/aucfile2

rm -rf $aucfile1 $aucfile2

for k in `cat $list | head -n 5`
do
	id=`echo $k | cut -f 1 -d ":"`
	ss=`echo $k | cut -f 4 -d ":"`
	echo "auc_file(\"$sumdir/$id\", \"$aucfile1\")" >> $tmpfile
done

for k in `cat $list | tail -n 5`
do
	id=`echo $k | cut -f 1 -d ":"`
	ss=`echo $k | cut -f 4 -d ":"`
	echo "auc_file(\"$sumdir/$id\", \"$aucfile2\")" >> $tmpfile
done

echo "plot.auc(\"$aucfile1\", \"train-auc.tex\")" >> $tmpfile
echo "plot.auc(\"$aucfile2\", \"test-auc.tex\")" >> $tmpfile

cd $outdir

R CMD BATCH $tmpfile

for id in `echo "train-auc test-auc"`
do
	$dir/wrap.sh $id.tex
	$dir/myepstool.sh $id
done

rm -rf $tmpfile
