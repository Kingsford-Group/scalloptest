#!/bin/bash

list=encode10.list
sra=/home/mingfus/data/transcriptomics/SRA
data=../data/encode10

for i in `cat $list`
do
	echo $i
	cur=$data/$i
	mkdir -p $cur
	ln -sf $sra/$i/tophat/tophat.sort.bam $cur/tophat.sort.bam
	ln -sf $sra/$i/star/star.sort.bam $cur/star.sort.bam
	ln -sf $sra/$i/hisat/hisat.sort.bam $cur/hisat.sort.bam
done
