#!/bin/bash

coverage="default"

while getopts "c:" arg
do
	case $arg in 
	c) 
		coverage=$OPTARG
		;;
	esac
done

results=../results/encode65
list=./encode65.list

echo "#summary of multi-exon accuracy"
echo "#id aligner scallop-correct scallop-precision stringtie-correct stringtie-precision transcomb-correct transcomb-precision"
for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	ss=`echo $x | cut -f 2 -d ":"`
	gm=`echo $x | cut -f 3 -d ":"`

	x1=`cat $results/$id/scallop.$coverage/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
	y1=`cat $results/$id/stringtie.$coverage/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
	x2=`cat $results/$id/scallop.$coverage/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`
	y2=`cat $results/$id/stringtie.$coverage/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`
	z1=`cat $results/$id/transcomb.$coverage/gffmul.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
	z2=`cat $results/$id/transcomb.$coverage/gffmul.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`

	if [ "$x1" == "" ]; then x1="0"; fi
	if [ "$x2" == "" ]; then x2="0"; fi
	if [ "$y1" == "" ]; then y1="0"; fi
	if [ "$y2" == "" ]; then y2="0"; fi
	if [ "$z1" == "" ]; then z1="0"; fi
	if [ "$z2" == "" ]; then z2="0"; fi

	echo "$id $x1 $x2 $y1 $y2 $z1 $z2"
done


echo "#summary of single-exon accuracy"
echo "#id aligner scallop-correct scallop-precision stringtie-correct stringtie-precision transcomb-correct transcomb-precision"
for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	ss=`echo $x | cut -f 2 -d ":"`
	gm=`echo $x | cut -f 3 -d ":"`

	x1=`cat $results/$id/scallop.$coverage/gffall.scallop.gtf.tmap | awk '$6 == 1' | awk '$3 == "="' | wc -l`
	x2=`cat $results/$id/scallop.$coverage/gffall.scallop.gtf.tmap | awk '$6 == 1' | wc -l`
	y1=`cat $results/$id/stringtie.$coverage/gffall.stringtie.gtf.tmap | awk '$6 == 1' | awk '$3 == "="' | wc -l`
	y2=`cat $results/$id/stringtie.$coverage/gffall.stringtie.gtf.tmap | awk '$6 == 1' | wc -l`
	z1=`cat $results/$id/transcomb.$coverage/gffall.transcomb.gtf.tmap | awk '$6 == 1' | awk '$3 == "="' | wc -l`
	z2=`cat $results/$id/transcomb.$coverage/gffall.transcomb.gtf.tmap | awk '$6 == 1' | wc -l`

	if [ "$x1" == "" ]; then x1="0"; fi
	if [ "$x2" == "" ]; then x2="0"; fi
	if [ "$y1" == "" ]; then y1="0"; fi
	if [ "$y2" == "" ]; then y2="0"; fi
	if [ "$z1" == "" ]; then z1="0"; fi
	if [ "$z2" == "" ]; then z2="0"; fi


	echo "$id $x1 $x2 $y1 $y2 $z1 $z2"
done
