#!/bin/bash

dir=`pwd`
tmpfile=$dir/tmpfile.R

echo "library(\"tikzDevice\")" > $tmpfile
echo "source(\"$dir/R/legend.R\")" >> $tmpfile
echo "plot.legend(\"legend.tex\")" >> $tmpfile
echo "plot.legend2(\"legend2.tex\")" >> $tmpfile
echo "plot.legend3(\"legend3.tex\")" >> $tmpfile
echo "plot.legend4(\"legend4.tex\")" >> $tmpfile
echo "plot.cuff.legend(\"cuff-legend.tex\")" >> $tmpfile

outdir=$dir/legend
mkdir -p $outdir

cd $outdir

R CMD BATCH $tmpfile

$dir/wrap.sh legend.tex
$dir/myepstool.sh legend

$dir/wrap.sh legend4.tex
$dir/myepstool.sh legend4

$dir/wrap.sh legend3.tex
$dir/myepstool.sh legend3

$dir/wrap.sh legend2.tex
$dir/myepstool.sh legend2

$dir/wrap.sh cuff-legend.tex
$dir/myepstool.sh cuff-legend

rm -rf $tmpfile
