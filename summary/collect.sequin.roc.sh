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

algo1="scallop.B759"
algo2="stringtie"
algo3="transcomb"

#abd="1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10"
#abd="0.01 1.0 2.5 5.0 7.5 10 25 50 75 100"
abd="0.01 1.0 2.5 5.0 7.5 10"

if [ "$id" == "" ];
then
	echo "please provide id through -i"
	exit
fi

#echo "#accession algorithm aligner sensitivity(%) precision(%)"

for aa in `echo "tophat star hisat"`
do
	cc=""
#for bb in `echo "1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0 6.5 7.0 7.5 8.0 8.5 9.0 9.5"`
	for bb in `echo $abd`
	do
		x0=`cat $results/$id.$aa.$gm/$algo1.$bb/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
		x1=`cat $results/$id.$aa.$gm/$algo1.$bb/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
		x2=`cat $results/$id.$aa.$gm/$algo1.$bb/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $4}'`
		x3=`cat $results/$id.$aa.$gm/$algo1.$bb/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`

		if [ "$x0" == "" ]; then x0="0"; fi
		if [ "$x1" == "" ]; then x1="0"; fi
		if [ "$x2" == "" ]; then x2="0"; fi
		if [ "$x3" == "" ]; then x3="0"; fi

		cc="$cc$x2 $x3 "
	done
	echo "$cc"
done

for aa in `echo "tophat star hisat"`
do
	cc=""
	for bb in `echo $abd`
	do
		x0=`cat $results/$id.$aa.$gm/$algo2.$bb/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
		x1=`cat $results/$id.$aa.$gm/$algo2.$bb/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
		x2=`cat $results/$id.$aa.$gm/$algo2.$bb/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $4}'`
		x3=`cat $results/$id.$aa.$gm/$algo2.$bb/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`

		if [ "$x0" == "" ]; then x0="0"; fi
		if [ "$x1" == "" ]; then x1="0"; fi
		if [ "$x2" == "" ]; then x2="0"; fi
		if [ "$x3" == "" ]; then x3="0"; fi

		cc="$cc$x2 $x3 "
	done
	echo "$cc"
done

for aa in `echo "tophat star"`
do
	cc=""
	for bb in `echo $abd`
	do
		x0=`cat $results/$id.$aa.$gm/$algo3.$bb/gffmul.stats | grep Query | grep mRNAs | head -n 1 | awk '{print $5}'`
		x1=`cat $results/$id.$aa.$gm/$algo3.$bb/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
		x2=`cat $results/$id.$aa.$gm/$algo3.$bb/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $4}'`
		x3=`cat $results/$id.$aa.$gm/$algo3.$bb/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`

		if [ "$x0" == "" ]; then x0="0"; fi
		if [ "$x1" == "" ]; then x1="0"; fi
		if [ "$x2" == "" ]; then x2="0"; fi
		if [ "$x3" == "" ]; then x3="0"; fi

		cc="$cc$x2 $x3 "
	done
	echo "$cc"
done
