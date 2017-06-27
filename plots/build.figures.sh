#!/bin/bash

./collect.encode10.sh
./collect.encode65.sh
./collect.sequin.sh

./plot.legend.sh

./plot.encode10.sh
./plot.encode65.sh
./plot.sequin.sh

figdir=./figures
mkdir -p $figdir

cp encode10/training/training.pdf $figdir
cp encode10/testing/testing.pdf $figdir
cp encode10/venn/venn.pdf $figdir
cp encode10/time/time.pdf $figdir
cp encode10/cuff/cuff.pdf $figdir
cp encode10/class/class.pdf $figdir

cp encode65/adjust/multi-default-correct.pdf $figdir
cp encode65/adjust/multi-default-precision.pdf $figdir
cp encode65/adjust/multi-zero-correct.pdf $figdir
cp encode65/adjust/multi-zero-precision.pdf $figdir

cp sequin/sequin/sequin.pdf $figdir
