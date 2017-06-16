#!/bin/bash

suffix="default"
algo="scallop"

while getopts "x:a:" arg
do
	case $arg in 
	x) 
		suffix=$OPTARG
		;;
	a) 
		algo=$OPTARG
		;;
	esac
done

list=./encode10.list
results=../results/encode10

#echo "#summary of multi-exon accuracy"

echo "#accession aligner #total #correct sensitivity(%) precision(%)"

for x in `cat $list`
do
	for aa in `echo "tophat star hisat"`
	do
		id=`echo $x | cut -f 1 -d ":"`
		ss=`echo $x | cut -f 2 -d ":"`
		gm=`echo $x | cut -f 3 -d ":"`

		x0=`cat $results/$id.$aa/$algo.$suffix/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
		x1=`cat $results/$id.$aa/$algo.$suffix/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
		x2=`cat $results/$id.$aa/$algo.$suffix/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $4}'`
		x3=`cat $results/$id.$aa/$algo.$suffix/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`

		if [ "$x0" == "" ]; then x0="0"; fi
		if [ "$x1" == "" ]; then x1="0"; fi
		if [ "$x2" == "" ]; then x2="0"; fi
		if [ "$x3" == "" ]; then x3="0"; fi

		echo "$id $aa $x0 $x1 $x2 $x3"
	done
done

exit

echo "#summary of single-exon accuracy"
echo "#id aligner $algo-correct $algo-prediction"
for x in `cat $list`
do
	for aa in `echo "tophat star hisat"`
	do
		id=`echo $x | cut -f 1 -d ":"`
		ss=`echo $x | cut -f 2 -d ":"`
		gm=`echo $x | cut -f 3 -d ":"`

		x1=`cat $results/$id.$aa/$algo.$suffix/gffall.$algo.gtf.tmap | awk '$6 == 1' | awk '$3 == "="' | wc -l`
		x2=`cat $results/$id.$aa/$algo.$suffix/gffall.$algo.gtf.tmap | awk '$6 == 1' | wc -l`

		if [ "$x1" == "" ]; then x1="0"; fi
		if [ "$x2" == "" ]; then x2="0"; fi
	
		echo "$id $aa $x1 $x2"
	done
done
