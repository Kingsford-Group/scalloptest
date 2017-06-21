#!/bin/bash

if [ "$#" != "5" ]; then
	echo "ID algo1 algo2 algo3 quant-level(1,2,3)"
	exit
fi

results=../results/encode10

id=$1
algo1=$2
algo2=$3
algo3=$4
level=$5

cc=""
for aa in `echo "tophat star hisat"`
do
	algos="$algo1 $algo2 $algo3"
	if [ "$aa" == "hisat" ]; then
		algos="$algo1 $algo2"
	fi

	for bb in `echo "$algos"`
	do
		x1=`cat $results/$id.$aa/$bb/gffmul.quant | head -n $level | tail -n 1 | cut -f 10 -d " "`
		x2=`cat $results/$id.$aa/$bb/gffmul.quant | head -n $level | tail -n 1 | cut -f 16 -d " "`
		cc="$cc$x1 $x2 "
	done
done

echo $id $cc
