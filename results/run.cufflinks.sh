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

if [ "$5" == "first" ]; then
	strand="fr-firststrand"
elif [ "$5" == "second" ]; then
	strand="fr-secondstrand"
else
	strand="fr-unstranded"
fi

mkdir -p $cur

cd $cur

{ /usr/bin/time -v $bin/cufflinks --library-type $strand $bam 2> /dev/null; } 2> time.log

cat transcripts.gtf | sed 's/^chr//g' > cufflinks.tmp.xxx.gtf
mv cufflinks.tmp.xxx.gtf cufflinks.gtf

$bin/gffcompare -o gffmul -r $gtf cufflinks.gtf -M -N
$bin/gffcompare -o gffall -r $gtf cufflinks.gtf
$bin/gtfcuff acc-single gffall.cufflinks.gtf.tmap > gffall.single
$bin/gtfcuff classify gffmul.cufflinks.gtf.tmap cufflinks.gtf > gffmul.class

if [ "$#" == "6" ]; then
	$bin/gtfcuff acc-quant gffmul.cufflinks.gtf.tmap $6 0.1 > gffmul.quant
fi

cd -
