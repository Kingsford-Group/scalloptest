#!/bin/bash

dir=`pwd`
list=$dir/../data/sequin.list

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

sumdir=$dir/../summary/sequin/roc.B759.6

echo "library(\"tikzDevice\")" > $tmpfile
echo "source(\"$dir/R/sequin.roc.R\")" >> $tmpfile

cnt=0
for k in `cat $list`
do
	id=`echo $k | cut -f 1 -d ":"`
	let cnt=$cnt+1
#echo "draw.roc(\"$sumdir/$id\", \"$id\", \"$id.tex\", 1)" >> $tmpfile
	echo "draw.roc(\"$sumdir/$id\", \"SQ$cnt\", \"$id.tex\", 1)" >> $tmpfile
done

outdir=$dir/sequin/roc
mkdir -p $outdir

cd $outdir

R CMD BATCH $tmpfile

for k in `cat $list`
do
	id=`echo $k | cut -f 1 -d ":"`
	$dir/wrap.sh $id.tex
	cat $id.tex | sed 's/Sensitivity/Sensitivity~(\\%)/g' > x; mv x $id.tex
	cat $id.tex | sed 's/Precision/Precision~(\\%)/g' > x; mv x $id.tex
	$dir/myepstool.sh $id
done

rm -rf $tmpfile
