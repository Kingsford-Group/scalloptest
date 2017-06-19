#!/bin/bash

id=""

while getopts "i:" arg
do
	case $arg in 
	i) 
		id=$OPTARG
		;;
	esac
done

results=../results/sequin
gm="is"

algo1="scallop.B759.1.0"
algo2="stringtie.2.5"
algo3="transcomb.0.01"

if [ "$id" == "" ];
then
	echo "please provide id through -i"
	exit
fi

cc=""
for aa in `echo "tophat star hisat"`
do
	algos="$algo1 $algo2 $algo3"
	if [ "$aa" == "hisat" ]; then
		algos="$algo1 $algo2"
	fi

	for bb in `echo $algos`
	do
		x0=`cat $results/$id.$aa.$gm/$bb/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
		x1=`cat $results/$id.$aa.$gm/$bb/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
		x2=`cat $results/$id.$aa.$gm/$bb/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $4}'`
		x3=`cat $results/$id.$aa.$gm/$bb/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`

		if [ "$x0" == "" ]; then x0="0"; fi
		if [ "$x1" == "" ]; then x1="0"; fi
		if [ "$x2" == "" ]; then x2="0"; fi
		if [ "$x3" == "" ]; then x3="0"; fi

		cc="$cc$x1 $x3 "
	done
done

echo $id $cc
