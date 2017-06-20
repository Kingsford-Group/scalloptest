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

cc=""
for aa in `echo "tophat star hisat"`
do
	algos="$algo1 $algo2 $algo3"
	if [ "$aa" == "hisat" ]; then
		algos="$algo1 $algo2"
	fi

	for bb in `echo $algos`
	do
		x1=`cat $results/$id.$aa/$bb/gffall.single | cut -f 10 -d " "`
		x2=`cat $results/$id.$aa/$bb/gffall.single | cut -f 16 -d " "`

		if [ "$x1" == "" ]; then x1="0"; fi
		if [ "$x2" == "" ]; then x2="0"; fi

		cc="$cc$x1 $x2 "
	done
done

echo $id $cc
