#!/bin/bash

cdir=`pwd`/sequin/collect.B759

./plot.sequin.accuracy.sh $cdir
./plot.sequin.roc.sh $cdir
