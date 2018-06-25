#!/bin/bash

if [ "$#" != "1" ]; then
	echo "$0 collectdir"
	exit
fi


dir=`pwd`

for ppp in `echo "train test"`
do
	for k in `echo "1:Low 2:Middle 3:High"`
	do
		kkk=`echo $k | cut -f 1 -d ":"`
		lab=`echo $k | cut -f 2 -d ":"`

		accfile=$1/$ppp.quant$kkk.zero
		tmpfile=$dir/tmpfile.R
		rm -rf $tmpfile
		
		outdir=$dir/encode10/quant.star
		mkdir -p $outdir
		
		echo "library(\"tikzDevice\")" > $tmpfile
		echo "source(\"$dir/R/quant.star.R\")" >> $tmpfile
		
		echo "plot.quant(\"$accfile\", \"$ppp-quant$kkk-correct.tex\", \"$ppp-quant$kkk-precision.tex\", \"$lab\")" >> $tmpfile

		cd $outdir
		
		R CMD BATCH $tmpfile

		for id in `echo "$ppp-quant$kkk-correct $ppp-quant$kkk-precision"`
		do
			$dir/wrap.sh $id.tex
			$dir/myepstool.sh $id
		done
		
		rm -rf $tmpfile
	done
done
