#!/bin/bash

coverage="default"
platform="linux_x86_64"

while getopts "c:p:" arg
do
	case $arg in 
	c) 
		coverage=$OPTARG
		;;
	p) 
		platform=$OPTARG
		;;
	esac
done

dir=`pwd`
bin=$dir/../programs/$platform

list=$dir/encode10.list
datadir=$dir/../data/encode10
results=$dir/../results/encode10

mkdir -p $results

for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	ss=`echo $x | cut -f 2 -d ":"`
	gm=`echo $x | cut -f 3 -d ":"`
	gtf=$dir/../data/ensembl/$gm.gtf

	st="";
	if [ "$ss" == "first" ]; then
		st="--rf"
	elif [ "$ss" == "second" ]; then
		st="--fr"
	fi

	for aa in `echo "tophat star hisat"`
	do
		bam=$datadir/$id/$aa.sort.bam
		cur=$results/$id.$aa/stringtie.$coverage
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

		$bin/gffcompare -o gffall -r $gtf stringtie.gtf
		$bin/gffcompare -o gffmul -r $gtf stringtie.gtf -M -N
		cd -
	done
done
