#!/bin/bash

coverage="default"

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

if [ ! -x $bin/transcomb ]; then
	echo "please make sure $bin/transcomb is available/executable"
	exit
fi

if [ ! -x $bin/gffcompare ]; then
	echo "please make sure $bin/gffcompare is available/executable"
	exit
fi

list=$dir/../data/sequin.list
datadir=$dir/../data/sequin
results=$dir/../results/sequin

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

	for aa in `echo "tophat star"`
	do
		bb="$aa"."$gm"
		bam=$datadir/$id/$bb/$aa.sort.bam

		if [ ! -s $bam ]; then
			echo "make sure $bam is available"
			exit
		fi

		cur=$results/$id.$bb/transcomb.$coverage

		echo "./run.transcomb.single.sh $cur $bam $gtf $coverage $ss" >> $scripts

	done
done
