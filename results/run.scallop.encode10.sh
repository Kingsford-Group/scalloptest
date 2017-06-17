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

datadir=$dir/../data/encode10
list=$dir/../data/encode10.list
results=$dir/../results/encode10

mkdir -p $results

for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	ss=`echo $x | cut -f 2 -d ":"`
	gm=`echo $x | cut -f 3 -d ":"`
	gtf=$dir/../data/ensembl/$gm.gtf

	if [ ! -s $gtf ]; then
		echo "make sure $gtf is available"
		exit
	fi

	for aa in `echo "tophat star hisat"`
	do
		bam=$datadir/$id/$aa.sort.bam
		cur=$results/$id.$aa/scallop.$suffix

		if [ ! -s $bam ]; then
			echo "make sure $bam is available"
			exit
		fi

		echo "./run.scallop.single.sh $cur $bam $gtf $coverage $ss" >> $scripts
	done
done
