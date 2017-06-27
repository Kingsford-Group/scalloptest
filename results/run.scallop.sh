#!/bin/bash

if [ "$#" != "6" ] && [ "$#" != "5" ]; then
	echo "usage $0 cur-dir bam-file gtf-file coverage strand [quantfile]"
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

if [ -s scallop.gtf ]; then
	exit
fi

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
$bin/gtfcuff acc-single gffall.scallop.gtf.tmap > gffall.single
$bin/gtfcuff classify gffmul.scallop.gtf.tmap scallop.gtf > gffmul.class

if [ "$#" == "6" ]; then
	$bin/gtfcuff acc-quant gffmul.scallop.gtf.tmap $6 0.1 > gffmul.quant
fi

cd -
