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

#echo "$id $ss $gm $x1 $x2 $y1 $y2 $z1 $z2"

if (( $(echo "$x1 <= $y1" | bc -l) )) && (( $(echo "$x1 <= $z1" | bc -l) )); then
	yy1=`$bin/gtfcuff match-correct $ty $sy $x1 | cut -f 10 -d " "`
	zz1=`$bin/gtfcuff match-correct $tz $sz $x1 | cut -f 10 -d " "`
	yy2=`$bin/gtfcuff match-correct $ty $sy $x1 | cut -f 16 -d " "`
	zz2=`$bin/gtfcuff match-correct $tz $sz $x1 | cut -f 16 -d " "`
elif (( $(echo "$y1 <= $x1" | bc -l) )) && (( $(echo "$y1 <= $z1" | bc -l) )); then
	xx1=`$bin/gtfcuff match-correct $tx $sx $y1 | cut -f 10 -d " "`
	zz1=`$bin/gtfcuff match-correct $tz $sz $y1 | cut -f 10 -d " "`
	xx2=`$bin/gtfcuff match-correct $tx $sx $y1 | cut -f 16 -d " "`
	zz2=`$bin/gtfcuff match-correct $tz $sz $y1 | cut -f 16 -d " "`
elif (( $(echo "$z1 <= $x1" | bc -l) )) && (( $(echo "$z1 <= $y1" | bc -l) )); then
	xx1=`$bin/gtfcuff match-correct $tx $sx $z1 | cut -f 10 -d " "`
	yy1=`$bin/gtfcuff match-correct $ty $sy $z1 | cut -f 10 -d " "`
	xx2=`$bin/gtfcuff match-correct $tx $sx $z1 | cut -f 16 -d " "`
	yy2=`$bin/gtfcuff match-correct $ty $sy $z1 | cut -f 16 -d " "`
fi

#echo $id $ss $gm $x1 $xx1 $x2 $xx2 $y1 $yy1 $y2 $yy2 $z1 $zz1 $z2 $zz2
echo $id $xx1 $xx2 $yy1 $yy2 $zz1 $zz2
