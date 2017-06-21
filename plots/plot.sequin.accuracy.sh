#!/bin/bash

dir=`pwd`
outdir=$dir/sequin/accuracy
mkdir -p $outdir

for tt in `echo "spike neat"`
do
	for ppp in `echo "multi"`
	do
		for kkk in `echo "default"`
		do
			if [ "$ppp" == "single" ] && [ "$kkk" == "zero" ]; then
				continue
			fi
	
			accfile=$dir//sequin/collect.B759/$tt.$ppp.$kkk
			tmpfile=$dir/tmpfile.R
			rm -rf $tmpfile
			
			echo "library(\"tikzDevice\")" > $tmpfile
			echo "source(\"$dir/R/accuracy.R\")" >> $tmpfile
			
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
