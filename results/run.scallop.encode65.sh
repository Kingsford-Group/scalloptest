#!/bin/bash

suffix=""
coverage="default"
scripts=""

while getopts "c:x:t:" arg
do
	case $arg in 
	c) 
		coverage=$OPTARG
		;;
	x) 
		suffix=$OPTARG
		;;
	t) 
		scripts=$OPTARG
		;;
	esac
done

if [ "$suffix" == "" ]; then
	echo "please provide -x to specify suffix"
	exit
fi

dir=`pwd`
bin=$dir/../programs

if [ ! -x $bin/scallop ]; then
	echo "please make sure $bin/scallop is available/executable"
	exit
fi

if [ ! -x $bin/gffcompare ]; then
	echo "please make sure $bin/gffcompare is available/executable"
	exit
fi

list=$dir/encode65.list
datadir=$dir/../data/encode65
results=$dir/../results/encode65

mkdir -p $results

for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	ss=`echo $x | cut -f 2 -d ":"`
	gm=`echo $x | cut -f 3 -d ":"`
	gtf=$dir/../data/ensembl/$gm.gtf
	bam=$datadir/$id.bam

	if [ ! -s $gtf ]; then
		echo "make sure $gtf is available"
		exit
	fi

	if [ ! -s $bam ]; then
		echo "make sure $bam is available"
		exit
	fi

	cur=$results/$id/scallop.$suffix

	echo "./run.scallop.single.sh $cur $bam $gtf $coverage $ss" >> $scripts
done
