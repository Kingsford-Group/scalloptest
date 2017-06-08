#!/bin/bash

coverage="default"
sample="0.10"

while getopts "c:s:" arg
do
	case $arg in 
	c) 
		coverage=$OPTARG
		;;
	s) 
		sample=$OPTARG
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

list=$dir/sequin.list0
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

	st="";
	if [ "$ss" == "first" ]; then
		st="--rf"
	elif [ "$ss" == "second" ]; then
		st="--fr"
	fi

	for aa in `echo "star hisat"`
	do
		bb="$aa"."$gm"
		bam=$datadir/$id/$bb/$aa.sort."$sample".bam

		if [ ! -s $bam ]; then
			echo "make sure $bam is available"
			exit
		fi

		cur=$results/$id.$bb/stringtie.$coverage.$sample
		mkdir -p $cur

		cd $cur

		if [ "$coverage" == "default" ]
		then
			{ /usr/bin/time -v $bin/stringtie $bam -o stringtie.gtf $st > stringtie.log; } 2> time.log
		else
			{ /usr/bin/time -v $bin/stringtie $bam -o stringtie.gtf $st -c $coverage > stringtie.log; } 2> time.log
		fi

		cat stringtie.gtf | sed 's/^chr//g' > stringtie.tmp.xxx.gtf
		mv stringtie.tmp.xxx.gtf stringtie.gtf

		$bin/gffcompare -o gffmul -r $gtf stringtie.gtf -M -N
		$bin/gffcompare -o gffall -r $gtf stringtie.gtf
		cd -
	done
done
