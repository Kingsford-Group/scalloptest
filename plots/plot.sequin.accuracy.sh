#!/bin/bash

dir=`pwd`

accfile=$dir/../summary/sequin/accuracy.B759/multi.default
tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "library(\"tikzDevice\")" > $tmpfile
echo "source(\"$dir/R/accuracy.R\")" >> $tmpfile

file1=$dir/accfile1
file2=$dir/accfile2

cat $accfile | head -n 4 > $file1
cat $accfile | tail -n 4 > $file2

echo "plot.correct(\"$file1\", \"spike.correct.tex\")" >> $tmpfile
echo "plot.correct(\"$file2\", \"neat.correct.tex\")" >> $tmpfile
echo "plot.precision(\"$file1\", \"spike.precision.tex\")" >> $tmpfile
echo "plot.precision(\"$file2\", \"neat.precision.tex\")" >> $tmpfile

outdir=$dir/sequin/accuracy
mkdir -p $outdir

cd $outdir

R CMD BATCH $tmpfile

for id in `echo "spike.correct spike.precision neat.correct neat.precision"`
do
	$dir/wrap.sh $id.tex
	cat $id.tex | sed 's/Sensitivity/Sensitivity~(\\%)/g' > x; mv x $id.tex
	cat $id.tex | sed 's/Precision/Precision~(\\%)/g' > x; mv x $id.tex
	$dir/myepstool.sh $id
done

rm -rf $tmpfile $file1 $file2
