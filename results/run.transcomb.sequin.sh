#!/bin/bash

coverage="default"
sample="0.10"

while getopts "c:s:t:" arg
do
	case $arg in 
	c) 
		coverage=$OPTARG
		;;
	s) 
		sample=$OPTARG
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

list=$dir/sequin.list
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
		bam=$datadir/$id/$bb/$aa.sort."$sample".bam

		if [ ! -s $bam ]; then
			echo "make sure $bam is available"
			exit
		fi

		cur=$results/$id.$bb/transcomb.$coverage.$sample

		if [ "$scripts" == "" ]; then
			nohup ./run.transcomb.single.sh $cur $bam $gtf $coverage $ss &
		else
			echo "./run.transcomb.single.sh $cur $bam $gtf $coverage $ss" >> $scripts
		fi

	done
done
