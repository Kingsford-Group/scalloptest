#!/bin/bash

if [ "$#" != "1" ]; then
	echo "$0 collectdir"
	exit
fi

dir=`pwd`
outdir=$dir/encode10/accuracy.star
mkdir -p $outdir

for tt in `echo "train test"`
do
	for ppp in `echo "multi single"`
	do
		for kkk in `echo "default zero"`
		do
			if [ "$ppp" == "single" ] && [ "$kkk" == "zero" ]; then
				continue
			fi
	
			accfile=$1/$tt.$ppp.$kkk
			tmpfile=$dir/tmpfile.R
			rm -rf $tmpfile
			
			echo "library(\"tikzDevice\")" > $tmpfile
			echo "source(\"$dir/R/accuracy.star.R\")" >> $tmpfile
			
			echo "plot.accuracy(\"$accfile\", \"$tt-$ppp-$kkk-correct.tex\", \"$tt-$ppp-$kkk-precision.tex\")" >> $tmpfile
			
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
done
