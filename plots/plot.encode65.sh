#!/bin/bash

dir=`pwd`
datadir=$dir/encode65/collect.B759
outdir=$dir/encode65/adjust2
texdir=$dir/tex
mkdir -p $outdir

#for ppp in `echo "multi"`
#do
#	for kkk in `echo "default zero"`
#	do
#		for sss in `echo "correct2 correct3 precision2 precision3"`
#		do
#			# plot summary
#			accfile=$datadir/$ppp.$kkk.$sss
#			tmpfile=$dir/tmpfile.R
#			rm -rf $tmpfile
#			
#			echo "library(\"tikzDevice\")" > $tmpfile
#			echo "source(\"$dir/R/adjust2.R\")" >> $tmpfile
#			
#			echo "plot.$sss.summary(\"$accfile\", \"$ppp-$kkk-$sss-summary.tex\")" >> $tmpfile
#			
#			cd $outdir
#			
#			R CMD BATCH $tmpfile
#			
#			for id in `echo "$ppp-$kkk-$sss-summary"`
#			do
#				$dir/wrap.sh $id.tex
#				$dir/myepstool.sh $id
#			done
#
#			rm -rf $tmpfile
#
#			# individial figures
#			for ttt in `echo "A B C"`
#			do
#				max=""
#				if [ "$sss" == "correct2" ] || [ "$sss" == "precision2" ]; then
#					ttt=""
#				fi
#
#				if [ "$kkk" == "default" ] && [ "$sss" == "correct3" ]; then
#					max=19000
#				elif [ "$kkk" == "default" ] && [ "$sss" == "correct2" ]; then
#					max=19000
#				elif [ "$kkk" == "default" ] && [ "$sss" == "precision2" ]; then
#					max=70
#				elif [ "$kkk" == "default" ] && [ "$sss" == "precision3" ]; then
#					max=70
#				elif [ "$kkk" == "zero" ] && [ "$sss" == "correct3" ]; then
#					max=20000
#				elif [ "$kkk" == "zero" ] && [ "$sss" == "correct2" ]; then
#					max=20000
#				elif [ "$kkk" == "zero" ] && [ "$sss" == "precision2" ]; then
#					max=60
#				elif [ "$kkk" == "zero" ] && [ "$sss" == "precision3" ]; then
#					max=60
#				fi
#
#				pl="0"
#				if [ "$ttt" == "C" ]; then
#					pl="1"
#				fi
#
#				accfile=$datadir/$ppp.$kkk.$sss$ttt
#				tmpfile=$dir/tmpfile.R
#				rm -rf $tmpfile
#				
#				echo "library(\"tikzDevice\")" > $tmpfile
#				echo "source(\"$dir/R/adjust2.R\")" >> $tmpfile
#				
#				echo "plot.$sss(\"$accfile\", \"$ppp-$kkk-$sss$ttt.tex\", $max, $pl)" >> $tmpfile
#				
#				cd $outdir
#				
#				R CMD BATCH $tmpfile
#				
#				for id in `echo "$ppp-$kkk-$sss$ttt"`
#				do
#					$dir/wrap.sh $id.tex
#					cat $id.tex | sed 's/ENCFF//g' > NOENCFF;
#					mv NOENCFF $id.tex
#					$dir/myepstool.sh $id
#				done
#
#				rm -rf $tmpfile
#			done
#		done
#	done
#done

cd $outdir
cat $texdir/adjust2.tex | sed 's/NAME/multi-default-correct/g' > multi-default-correct.tex; $dir/myepstool.sh multi-default-correct
cat $texdir/adjust2.tex | sed 's/NAME/multi-default-precision/g' > multi-default-precision.tex; $dir/myepstool.sh multi-default-precision

cat $texdir/adjust2.tex | sed 's/NAME/multi-zero-correct/g' > multi-zero-correct.tex; $dir/myepstool.sh multi-zero-correct
cat $texdir/adjust2.tex | sed 's/NAME/multi-zero-precision/g' > multi-zero-precision.tex; $dir/myepstool.sh multi-zero-precision

exit
