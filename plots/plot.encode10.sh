#!/bin/bash

cdir=`pwd`/encode10/collect.B759

./plot.encode10.time.sh $cdir
./plot.encode10.roc.sh $cdir
./plot.encode10.accuracy.sh $cdir
./plot.encode10.auc.sh $cdir
./plot.encode10.class.sh $cdir
./plot.encode10.quant.sh $cdir
