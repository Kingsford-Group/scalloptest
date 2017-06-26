#!/bin/bash

if [ "$#" != "3" ]; then
	echo "usage $0 algo1 algo2"
	exit
fi

results=../results/encode65
bin=../programs

id=$1
algo1=$2
algo2=$3

fx="$results/$id/$algo1/gffmul.stats"
fy="$results/$id/$algo2/gffmul.stats"

tx="$results/$id/$algo1/gffmul.scallop.gtf.tmap"
ty="$results/$id/$algo2/gffmul.stringtie.gtf.tmap"

sx=`cat $fx | grep Reference | grep mRNA | awk '{print $9}' | sed 's/(//g'`
sy=`cat $fy | grep Reference | grep mRNA | awk '{print $9}' | sed 's/(//g'`

x1=`cat $fx | grep Matching | grep intron | grep chain | awk '{print $4}'`
y1=`cat $fy | grep Matching | grep intron | grep chain | awk '{print $4}'`

x2=`cat $fx | grep Intron | grep chain | awk '{print $6}'`
y2=`cat $fy | grep Intron | grep chain | awk '{print $6}'`

xx1=$x1
xx2=$x2
yy1=$y1
yy2=$y2

if (( $(echo "$x1 <= $y1" | bc -l) )); then
	yy1=`gtfcuff match-correct $ty $sy $x1 | cut -f 10 -d " "`
	yy2=`gtfcuff match-correct $ty $sy $x1 | cut -f 16 -d " "`
else
	xx1=`gtfcuff match-correct $tx $sx $y1 | cut -f 10 -d " "`
	xx2=`gtfcuff match-correct $tx $sx $y1 | cut -f 16 -d " "`
fi

echo $id $xx1 $xx2 $yy1 $yy2
