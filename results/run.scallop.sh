#!/bin/bash

if [ "$#" != "6" ] && [ "$#" != "5" ] && [ "$#" != "7" ]; then
	echo "usage $0 cur-dir bam-file gtf-file coverage strand [quantfile] / [fq1] [fq2]"
	exit
fi

gtf0=/home/mingfus/data/repositories/scalloptest/data/ensembl/GRCh38.gtf
cDNA=/home/mingfus/data/transcriptomics/cDNA/human/Homo_sapiens.GRCh38.cdna.all.fa
index0=/home/mingfus/data/transcriptomics/cDNA/human/salmon.index.GRCh38/salmon.index
genome=/home/mingfus/data/transcriptomics/ensembl/human/GRCh38/GRCh38.fa

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
#{ /usr/bin/time -v $bin/scallop -i $bam -o scallop.gtf --library_type $strand > scallop.log; } 2> time.log
	{ /usr/bin/time -v $bin/scallop -i $bam -o scallop.gtf > scallop.log; } 2> time.log
else
#{ /usr/bin/time -v $bin/scallop -i $bam -o scallop.gtf --library_type $strand --min_transcript_coverage $coverage > scallop.log; } 2> time.log
	{ /usr/bin/time -v $bin/scallop -i $bam -o scallop.gtf --min_transcript_coverage $coverage > scallop.log; } 2> time.log
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

if [ "$#" == "7" ]; then
	cuff=gffall.scallop.gtf.tmap
	$bin/gtfcuff puniq $cuff scallop.gtf $gtf unique.gtf
	gffread unique.gtf -g $genome -w unique.fa
	cat unique.fa $cDNA > union.fa
	
	{ /usr/bin/time -v salmon index -t union.fa -i salmon.index -p 1 2> salmon.index.log ; } 2> salmon.index.time
	{ /usr/bin/time -v salmon quant -i salmon.index -l ISR -1 $6 -2 $7 -p 1 -o salmon.quant; } 2> salmon.quant.time
fi

cd -
