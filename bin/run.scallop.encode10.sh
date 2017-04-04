#!/bin/bash

coverage="default"
platform="linux_x86_64"

while getopts "c:p:h:" arg
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

	for aa in `echo "tophat star hisat"`
	do
		bam=$datadir/$id/$aa.sort.bam
		cur=$results/$id.$aa/scallop.$coverage
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
