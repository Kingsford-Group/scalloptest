#!/bin/bash

if [ "$#" != "5" ]; then
	echo "usage $0 cur-dir bam-file gtf-file coverage strand"
	exit
fi


bin=`pwd`/../programs

cur=$1
bam=$2
gtf=$3
coverage=$4
strand=$5

mkdir -p $cur

cd $cur

if [ "$coverage" == "default" ]
then
	{ /usr/bin/time -v $bin/stringtie $bam -o stringtie.gtf $strand > stringtie.log; } 2> time.log
else
	{ /usr/bin/time -v $bin/stringtie $bam -o stringtie.gtf $strand -c $coverage > stringtie.log; } 2> time.log
fi

cat stringtie.gtf | sed 's/^chr//g' > stringtie.tmp.xxx.gtf
mv stringtie.tmp.xxx.gtf stringtie.gtf

$bin/gffcompare -o gffmul -r $gtf stringtie.gtf -M -N
$bin/gffcompare -o gffall -r $gtf stringtie.gtf
cd -
