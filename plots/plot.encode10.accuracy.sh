#!/bin/bash

dir=`pwd`

for ppp in `echo "multi single"`
do
	for kkk in `echo "default zero"`
	do
		if [ "$ppp" == "single" ] && [ "$kkk" == "zero" ]; then
			continue
		fi

		accfile=$dir/../summary/encode10/accuracy.B759/$ppp.$kkk
		tmpfile=$dir/tmpfile.R
		rm -rf $tmpfile
		
		outdir=$dir/encode10/accuracy
		mkdir -p $outdir
		
		echo "library(\"tikzDevice\")" > $tmpfile
		echo "source(\"$dir/R/accuracy.R\")" >> $tmpfile
		
		file1=$dir/file1
		file2=$dir/file2
		
		cat $accfile | head -n 5 > $file1
		cat $accfile | tail -n 5 > $file2
		
		echo "plot.correct(\"$file1\", \"train-$ppp-$kkk-correct.tex\")" >> $tmpfile
		echo "plot.precision(\"$file1\", \"train-$ppp-$kkk-precision.tex\")" >> $tmpfile
		echo "plot.correct(\"$file2\", \"test-$ppp-$kkk-correct.tex\")" >> $tmpfile
		echo "plot.precision(\"$file2\", \"test-$ppp-$kkk-precision.tex\")" >> $tmpfile
		
		cd $outdir
		
		R CMD BATCH $tmpfile
		
		for id in `echo "train-$ppp-$kkk-correct train-$ppp-$kkk-precision test-$ppp-$kkk-correct test-$ppp-$kkk-precision"`
		do
			$dir/wrap.sh $id.tex
			cat $id.tex | sed 's/Sensitivity/Sensitivity~(\\%)/g' > x; mv x $id.tex
			cat $id.tex | sed 's/Precision/Precision~(\\%)/g' > x; mv x $id.tex
			$dir/myepstool.sh $id
		done
		
		rm -rf $file1 $file2
	done
done
