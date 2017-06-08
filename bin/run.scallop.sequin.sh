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

if [ ! -x $bin/scallop ]; then
	echo "please make sure $bin/scallop is available/executable"
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

	for aa in `echo "star hisat"`
	do
		bb="$aa"."$gm"
		bam=$datadir/$id/$bb/$aa.sort."$sample".bam

		if [ ! -s $bam ]; then
			echo "make sure $bam is available"
			exit
		fi

		cur=$results/$id.$bb/scallop.$coverage.$sample
		mkdir -p $cur

		cd $cur

		if [ "$coverage" == "default" ]
		then
			{ /usr/bin/time -v $bin/scallop -i $bam -o scallop.gtf --library_type $ss > scallop.log; } 2> time.log
		else
			{ /usr/bin/time -v $bin/scallop -i $bam -o scallop.gtf --library_type $ss --min_transcript_coverage $coverage > scallop.log; } 2> time.log
		fi

		cat scallop.gtf | sed 's/^chr//g' > scallop.tmp.xxx.gtf
		mv scallop.tmp.xxx.gtf scallop.gtf

		$bin/gffcompare -o gffmul -r $gtf scallop.gtf -M -N
		$bin/gffcompare -o gffall -r $gtf scallop.gtf
		cd -
	done
done
