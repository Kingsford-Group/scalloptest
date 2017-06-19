#!/bin/bash

if [ "$#" != "1" ]; then
	echo "usage $0 suffix"
	exit
fi

dir=`pwd`/..
cur=`pwd`/SRR3743149.star.is/$1
bam=$dir/data/sequin/SRR3743149/star.is/star.sort.1.00.bam
gtf=$dir/data/ensembl/is2.gtf

mkdir -p $cur

cd $cur

$dir/programs/scallop -i $bam -o scallop.gtf --library_type first --min_transcript_coverage 5.0 --verbose 2 > scallop.log
#$dir/programs/scallop -i $bam -o scallop.gtf --library_type first --min_transcript_coverage 5.0 --verbose 2 -t -g bundle.1.251 > scallop.log

cat scallop.gtf | sed 's/chrIS/IS/g' > tmpfile
mv tmpfile scallop.gtf

gffcompare -M -N -r ~/data/repositories/scalloptest/data//ensembl/is2.gtf ./scallop.gtf -o gffmul

gtfcuff split gffmul.scallop.gtf.tmap scallop.gtf scallop.true.gtf scallop.false.gtf

cd -
