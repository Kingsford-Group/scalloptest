#!/bin/bash

dir=`pwd`
tmpfile=$dir/tmpfile.R

echo "library(\"tikzDevice\")" > $tmpfile
echo "source(\"$dir/R/legend.R\")" >> $tmpfile
echo "plot.legend(\"legend.tex\")" >> $tmpfile
echo "plot.cuff.legend(\"cuff-legend.tex\")" >> $tmpfile

outdir=$dir/encode10/legend
mkdir -p $outdir

cd $outdir

R CMD BATCH $tmpfile

$dir/wrap.sh legend.tex
$dir/myepstool.sh legend

$dir/wrap.sh cuff-legend.tex
$dir/myepstool.sh cuff-legend

rm -rf $tmpfile
