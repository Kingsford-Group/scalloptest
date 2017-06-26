#!/bin/bash

if [ "$#" != "1" ]; then
	echo "$0 collectdir"
	exit
fi

dir=`pwd`
outdir=$dir/encode10/cuff
texdir=$dir/tex
mkdir -p $outdir

for tt in `echo "train test"`
do
	ppp="multi-cuff"
	qqq="multi.cuff"
	for kkk in `echo "default"`
	do
		accfile=$1/$tt.$qqq.$kkk
		tmpfile=$dir/tmpfile.R
		rm -rf $tmpfile
		
		echo "library(\"tikzDevice\")" > $tmpfile
		echo "source(\"$dir/R/accuracy.R\")" >> $tmpfile
		
		echo "plot.accuracy2(\"$accfile\", \"$tt-$ppp-$kkk-correct.tex\", \"$tt-$ppp-$kkk-precision.tex\")" >> $tmpfile
		
		cd $outdir
		
		R CMD BATCH $tmpfile
		
		for id in `echo "$tt-$ppp-$kkk-correct $tt-$ppp-$kkk-precision"`
		do
			$dir/wrap.sh $id.tex
			$dir/myepstool.sh $id
		done

		rm -rf $tmpfile
	done
done

cd $outdir
cp $texdir/cuff.tex .
$dir/myepstool.sh cuff
