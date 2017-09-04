#!/bin/bash

list=../data/encode10.list
results=../results/encode10
bb="B771"

for id in `cat $list | cut -f 1 -d ":"`
do
	for algo in `echo "scallop"`
	do
		xx="$id"
		for aa in `echo "tophat star hisat"`
		do
			if [ "$algo" == "transcomb" ] && [ "$aa" == "hisat" ]; then
				continue;
			fi
	
			file="$results/$id.$aa/$algo.$bb/salmon.quant/quant.sf"
			x1=`cat $file | awk '$4 >= 10' | wc -l`
			x2=`cat $file | awk '$4 >= 10' | grep gene | wc -l`
			xx="$xx $x1 $x2"
		done
		echo $xx
	done
done
