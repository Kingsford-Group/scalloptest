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

results=../results/encode10
list=./encode10.list

echo "#summary of multi-exon accuracy"
echo "#id aligner scallop-correct scallop-precision stringtie-correct stringtie-precision transcomb-correct transcomb-precision"
for x in `cat $list`
do
	for aa in `echo "tophat star hisat"`
	do
		id=`echo $x | cut -f 1 -d ":"`
		ss=`echo $x | cut -f 2 -d ":"`
		gm=`echo $x | cut -f 3 -d ":"`

		x1=`cat $results/$id.$aa/scallop.$coverage/gffall.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
		y1=`cat $results/$id.$aa/stringtie.$coverage/gffall.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
		x2=`cat $results/$id.$aa/scallop.$coverage/gffall.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`
		y2=`cat $results/$id.$aa/stringtie.$coverage/gffall.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`
		z1=`cat $results/$id.$aa/transcomb.$coverage/gffall.stats | grep Matching | grep intron | grep chain | head -n 1 | awk '{print $4}'`
		z2=`cat $results/$id.$aa/transcomb.$coverage/gffall.stats | grep Intron | grep chain | head -n 1 | awk '{print $6}'`
		echo "$id $aa $x1 $x2 $y1 $y2 $z1 $z2"
	done
done


echo "#summary of single-exon accuracy"
echo "#id aligner scallop-correct scallop-prediction stringtie-correct stringtie-prediction transcomb-correct transcomb-prediction"
for x in `cat $list`
do
	for aa in `echo "tophat star hisat"`
	do
		id=`echo $x | cut -f 1 -d ":"`
		ss=`echo $x | cut -f 2 -d ":"`
		gm=`echo $x | cut -f 3 -d ":"`

		x1=`cat $results/$id.$aa/scallop.$coverage/gffall.scallop.gtf.tmap | awk '$6 == 1' | awk '$3 == "="' | wc -l`
		x2=`cat $results/$id.$aa/scallop.$coverage/gffall.scallop.gtf.tmap | awk '$6 == 1' | wc -l`
		y1=`cat $results/$id.$aa/stringtie.$coverage/gffall.stringtie.gtf.tmap | awk '$6 == 1' | awk '$3 == "="' | wc -l`
		y2=`cat $results/$id.$aa/stringtie.$coverage/gffall.stringtie.gtf.tmap | awk '$6 == 1' | wc -l`
		z1=`cat $results/$id.$aa/transcomb.$coverage/gffall.transcomb.gtf.tmap | awk '$6 == 1' | awk '$3 == "="' | wc -l`
		z2=`cat $results/$id.$aa/transcomb.$coverage/gffall.transcomb.gtf.tmap | awk '$6 == 1' | wc -l`

		echo "$id $aa $x1 $x2 $y1 $y2 $z1 $z2"
	done
done

