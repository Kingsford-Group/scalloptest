#!/bin/bash

if [ "$#" != "4" ]; then
	echo "ID algo1 algo2 algo3"
	exit
fi

id=$1
algo1=$2
algo2=$3
algo3=$4

list=../data/encode10.list
results=../results/encode10

abd="0.01 1 2.5 5 7.5 10 25 50 75 100"

#echo "#accession algorithm aligner sensitivity(%) precision(%)"

for algo in `echo "$algo1 $algo2 $algo3"`
do
	for aa in `echo "tophat star hisat"`
	do
		if [ "$algo" == "transcomb" ] && [ "$aa" == "hisat" ]; then
			continue;
		fi

		cc=""
		for bb in `echo $abd`
		do

			file="$results/$id.$aa/$algo.$bb/time.log"
			ll=`cat $file | grep User | wc -l`

			if [ "$ll" == "1" ]; then
				t1=`cat $file | grep "User time" | awk '{print $4}'`
				t2=`cat $file | grep "System time" | awk '{print $4}'`
				tt=`echo "$t1 $t2" | awk '{print $1 + $2}'`
				cc="$cc$tt "
			else
				t1=`cat $file | grep "user" | awk '{print $2}'`
				x1=`echo $t1 | cut -f 1 -d "m"`
				y1=`echo $t1 | cut -f 2 -d "m" | cut -f 1 -d "s"`

				t2=`cat $file | grep "sys" | awk '{print $2}'`
				x2=`echo $t2 | cut -f 1 -d "m"`
				y2=`echo $t2 | cut -f 2 -d "m" | cut -f 1 -d "s"`

				tt=`echo "$x1 $x2 $y1 $y2" | awk '{print $1 * 60 + $2 * 60 + $3 + $4}'`
				cc="$cc$tt "
			fi
		done
		echo "$id $algo $aa $cc"
	done
done
