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
	{ /usr/bin/time -v $bin/transcomb -b $bam -s $strand > transcomb.log; } 2> time.log
else
	{ /usr/bin/time -v $bin/transcomb -b $bam -s $strand -f $coverage > transcomb.log; } 2> time.log
fi

cat TransComb.gtf | sed 's/^chr//g' > transcomb.tmp.xxx.gtf
mv transcomb.tmp.xxx.gtf transcomb.gtf

$bin/gffcompare -o gffmul -r $gtf transcomb.gtf -M -N
$bin/gffcompare -o gffall -r $gtf transcomb.gtf
cd -
