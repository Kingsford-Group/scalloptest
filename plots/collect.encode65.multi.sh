#!/bin/bash

if [ "$#" != "4" ]; then
	echo "ID algo1 algo2 algo3"
	exit
fi

results=../results/encode65

id=$1
algo1=$2
algo2=$3
algo3=$4

cc=""
for bb in `echo $algos`
do
	x1=`cat $results/$id/$bb/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
	x3=`cat $results/$id/$bb/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`

	if [ "$x1" == "" ]; then x1="0"; fi
	if [ "$x3" == "" ]; then x3="0"; fi

	cc="$cc$x1 $x3 "
done

echo $id $cc
