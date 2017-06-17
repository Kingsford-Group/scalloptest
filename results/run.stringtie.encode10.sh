#!/bin/bash

coverage="default"
scripts=""

while getopts "c:t:" arg
do
	case $arg in 
	c) 
		coverage=$OPTARG
		;;
	t) 
		scripts=$OPTARG
		;;
	esac
done

dir=`pwd`
bin=$dir/../programs

if [ ! -x $bin/stringtie ]; then
	echo "please make sure $bin/stringtie is available/executable"
	exit
fi

if [ ! -x $bin/gffcompare ]; then
	echo "please make sure $bin/gffcompare is available/executable"
	exit
fi

list=$dir/../data/encode10.list
datadir=$dir/../data/encode10
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

	st="";
	if [ "$ss" == "first" ]; then
		st="--rf"
	elif [ "$ss" == "second" ]; then
		st="--fr"
	fi

	for aa in `echo "tophat star hisat"`
	do
		bam=$datadir/$id/$aa.sort.bam

		if [ ! -s $bam ]; then
			echo "make sure $bam is available"
			exit
		fi

		cur=$results/$id.$aa/stringtie.$coverage
		mkdir -p $cur

		cd $cur

		echo "./run.stringtie.single.sh $cur $bam $gtf $coverage $st" >> $scripts
	done
done
