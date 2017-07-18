#!/bin/bash

if [ "$#" != "1" ]; then
	echo "$0 collectdir"
	exit
fi

dir=`pwd`
result=$1
datadir=$dir/../data
covdir=$result/cov
testcov=$result/test.cov
traincov=$result/train.cov
testacc=$result/test.multi.default
trainacc=$result/train.multi.default
tmpfile=$dir/tmpfile.R
outdir=$dir/encode10/cov

mkdir -p $outdir
rm -rf $testcov $traincov $tmpfile

# make test.cov
for k in `cat $datadir/testing5.list | cut -f 1 -d ":"`
do
	x1=`cat $covdir/$k.tophat | awk '{print $4,$9,$14,$18}'`
	x2=`cat $covdir/$k.star | awk '{print $4,$9,$14,$18}'`
	x3=`cat $covdir/$k.hisat | awk '{print $4,$9,$14,$18}'`
	echo $k $x1 $x2 $x3 >> $testcov
done

# make train.cov
for k in `cat $datadir/training5.list | cut -f 1 -d ":"`
do
	x1=`cat $covdir/$k.tophat | awk '{print $4,$9,$14,$18}'`
	x2=`cat $covdir/$k.star | awk '{print $4,$9,$14,$18}'`
	x3=`cat $covdir/$k.hisat | awk '{print $4,$9,$14,$18}'`
	echo $k $x1 $x2 $x3 >> $traincov
done


echo "source(\"$dir/R/cov.R\")" >> $tmpfile
echo "plot.cov(\"$testacc\", \"$trainacc\", \"$testcov\", \"$traincov\", \"cov.tex\")" >> $tmpfile

cd $outdir

R CMD BATCH $tmpfile

$dir/wrap.sh cov.tex
$dir/myepstool.sh cov

rm -rf $tmpfile
