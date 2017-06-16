#!/bin/bash

suffix=""
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

list=./sequin.list
results=../results/sequin

if [ "$suffix" != "" ];
then
	suffix="$suffix".
fi

#echo "#summary of multi-exon accuracy"

echo "#accession aligner coverage #total #correct sensitivity(%) precision(%)"

for x in `cat $list`
do
	for aa in `echo "tophat star hisat"`
	do
		id=`echo $x | cut -f 1 -d ":"`
		ss=`echo $x | cut -f 2 -d ":"`
		gm=`echo $x | cut -f 3 -d ":"`

		for bb in `echo "1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0 6.5 7.0 7.5 8.0 8.5 9.0 9.5"`
		do
			x0=`cat $results/$id.$aa.$gm/$algo.$suffix$bb.1.00/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
			x1=`cat $results/$id.$aa.$gm/$algo.$suffix$bb.1.00/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
			x2=`cat $results/$id.$aa.$gm/$algo.$suffix$bb.1.00/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $4}'`
			x3=`cat $results/$id.$aa.$gm/$algo.$suffix$bb.1.00/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`

			if [ "$x0" == "" ]; then x0="0"; fi
			if [ "$x1" == "" ]; then x1="0"; fi
			if [ "$x2" == "" ]; then x2="0"; fi
			if [ "$x3" == "" ]; then x3="0"; fi

			echo "$id $aa $bb $x0 $x1 $x2 $x3"
		done
	done
done
