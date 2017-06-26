#!/bin/bash

if [ "$#" != "4" ]; then
	echo "usage $0 algo1 algo2 algo3"
	exit
fi

results=../results/encode65
bin=../programs

id=$1
algo1=$2
algo2=$3
algo3=$4

fx="$results/$id/$algo1/gffmul.stats"
fy="$results/$id/$algo2/gffmul.stats"
fz="$results/$id/$algo3/gffmul.stats"

tx="$results/$id/$algo1/gffmul.scallop.gtf.tmap"
ty="$results/$id/$algo2/gffmul.stringtie.gtf.tmap"
tz="$results/$id/$algo3/gffmul.transcomb.gtf.tmap"

sx=`cat $fx | grep Reference | grep mRNA | awk '{print $9}' | sed 's/(//g'`
sy=`cat $fy | grep Reference | grep mRNA | awk '{print $9}' | sed 's/(//g'`
sz=`cat $fz | grep Reference | grep mRNA | awk '{print $9}' | sed 's/(//g'`

x1=`cat $fx | grep Matching | grep intron | grep chain | awk '{print $4}'`
y1=`cat $fy | grep Matching | grep intron | grep chain | awk '{print $4}'`
z1=`cat $fz | grep Matching | grep intron | grep chain | awk '{print $4}'`

x2=`cat $fx | grep Intron | grep chain | awk '{print $6}'`
y2=`cat $fy | grep Intron | grep chain | awk '{print $6}'`
z2=`cat $fz | grep Intron | grep chain | awk '{print $6}'`

xx1=$x1
xx2=$x2
yy1=$y1
yy2=$y2
zz1=$z1
zz2=$z2

if (( $(echo "$x2 >= $y2" | bc -l) )) && (( $(echo "$x2 >= $z2" | bc -l) )); then
	yy1=`gtfcuff match-precision $ty $sy $x2 | cut -f 10 -d " "`
	zz1=`gtfcuff match-precision $tz $sz $x2 | cut -f 10 -d " "`
	yy2=`gtfcuff match-precision $ty $sy $x2 | cut -f 16 -d " "`
	zz2=`gtfcuff match-precision $tz $sz $x2 | cut -f 16 -d " "`
elif (( $(echo "$y2 >= $x2" | bc -l) )) && (( $(echo "$y2 >= $z2" | bc -l) )); then
	xx1=`gtfcuff match-precision $tx $sx $y2 | cut -f 10 -d " "`
	zz1=`gtfcuff match-precision $tz $sz $y2 | cut -f 10 -d " "`
	xx2=`gtfcuff match-precision $tx $sx $y2 | cut -f 16 -d " "`
	zz2=`gtfcuff match-precision $tz $sz $y2 | cut -f 16 -d " "`
elif (( $(echo "$z2 >= $x2" | bc -l) )) && (( $(echo "$z2 >= $y2" | bc -l) )); then
	xx1=`gtfcuff match-precision $tx $sx $z2 | cut -f 10 -d " "`
	yy1=`gtfcuff match-precision $ty $sy $z2 | cut -f 10 -d " "`
	xx2=`gtfcuff match-precision $tx $sx $z2 | cut -f 16 -d " "`
	yy2=`gtfcuff match-precision $ty $sy $z2 | cut -f 16 -d " "`
fi

#echo $id $ss $gm $x1 $xx1 $x2 $xx2 $y1 $yy1 $y2 $yy2 $z1 $zz1 $z2 $zz2
echo $id $xx1 $xx2 $yy1 $yy2 $zz1 $zz2
