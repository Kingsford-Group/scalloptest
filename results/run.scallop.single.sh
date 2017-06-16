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
	{ /usr/bin/time -v $bin/scallop -i $bam -o scallop.gtf --library_type $strand > scallop.log; } 2> time.log
else
	{ /usr/bin/time -v $bin/scallop -i $bam -o scallop.gtf --library_type $strand --min_transcript_coverage $coverage > scallop.log; } 2> time.log
fi

cat scallop.gtf | sed 's/^chr//g' > scallop.tmp.xxx.gtf
mv scallop.tmp.xxx.gtf scallop.gtf

$bin/gffcompare -o gffmul -r $gtf scallop.gtf -M -N
$bin/gffcompare -o gffall -r $gtf scallop.gtf
cd -
