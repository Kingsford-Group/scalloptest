#!/bin/bash

list=encode65.list
bam=/home/mingfus/data/repositories/scallop/bin/ENCODE/bam
data=../data/encode65
mkdir -p $data

for x in `cat $list`
do
	i=`echo $x | cut -f 1 -d ":"`	
	echo $i
	ln -sf $bam/$i.bam $data/$i.bam
done
