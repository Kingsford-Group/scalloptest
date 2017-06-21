#!/bin/bash

if [ "$#" != "4" ]; then
	echo "ID algo1 algo2 algo3"
	exit
fi

results=../results/encode10

id=$1
algo1=$2
algo2=$3
algo3=$4

for exon in `seq 2 20`
do
	cc=""
	for aa in `echo "tophat star hisat"`
	do
		algos="$algo1 $algo2 $algo3"
		if [ "$aa" == "hisat" ]; then
			algos="$algo1 $algo2"
		fi

		for bb in `echo "$algos"`
		do
			x1=`cat $results/$id.$aa/$bb/gffmul.class | head -n $exon | tail -n 1 | cut -f 6 -d " "`
			x2=`cat $results/$id.$aa/$bb/gffmul.class | head -n $exon | tail -n 1 | cut -f 9 -d " "`
			cc="$cc$x1 $x2 "
		done
	done

	echo $exon $id $cc
done
