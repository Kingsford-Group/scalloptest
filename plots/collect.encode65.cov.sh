#!/bin/bash

dir=/home/mingfus/data/repositories/scalloptest/
bin=$dir/programs
datadir=$dir/data/encode65
list=$dir/data/encode65.list
result=$dir/plots/encode65/collect.B759/cov
scripts=./scripts

mkdir -p $result
rm -rf $scripts

for k in `cat $list | cut -f 1 -d ":"`
do
	echo $k
	nohup $bin/bamkit $datadir/$k.bam > $result/$k &
	#echo "$bin/bamkit $datadir/$k.bam > $result/$k" >> $scripts
done

#cat $scripts | xargs -L 1 -I CMD -P 30 bash -c CMD
