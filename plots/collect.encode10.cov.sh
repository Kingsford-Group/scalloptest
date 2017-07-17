#!/bin/bash

bin=../programs
datadir=../data/encode10
list=../data/encode10.list
result=./encode10/collect.B759/cov
mkdir -p $result

for k in `cat $list | cut -f 1 -d ":"`
do
	echo $k
	for aa in `echo "tophat star hisat"`
	do	
		nohup $bin/bamkit $datadir/$k/$aa.sort.bam > $result/$k.$aa.cov2 &
	done
done
