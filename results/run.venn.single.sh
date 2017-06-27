#!/bin/bash

if [ "$#" -ne 1 ]
then
	echo "usage $0 dataset"
	exit
fi

sc="scallop.B759.0.01"
st="stringtie.0.01"
tc="transcomb.0.01"

dir=`pwd`/encode10
bin=`pwd`/../programs
data=`pwd`/../data/

cur=$dir/$1.venn
mkdir -p $cur

gtf=$data/ensembl/GRCh38.gtf
roc=$bin/gtfcuff
gtfmerge=$bin/gtfmerge

function commgtf()
{
	tmp=./list.xxx.tmp;
	echo $1 > $tmp;
	echo $2 >> $tmp;
	$gtfmerge intersection $tmp $3;
	rm -rf $tmp;
}

ln -sf $dir/$1.tophat/$sc/scallop.gtf $cur/scallop.1.gtf
ln -sf $dir/$1.star/$sc/scallop.gtf $cur/scallop.2.gtf
ln -sf $dir/$1.hisat/$sc/scallop.gtf $cur/scallop.3.gtf

ln -sf $dir/$1.tophat/$st/stringtie.gtf $cur/stringtie.1.gtf
ln -sf $dir/$1.star/$st/stringtie.gtf $cur/stringtie.2.gtf
ln -sf $dir/$1.hisat/$st/stringtie.gtf $cur/stringtie.3.gtf

ln -sf $dir/$1.tophat/$tc/transcomb.gtf $cur/transcomb.1.gtf
ln -sf $dir/$1.star/$tc/transcomb.gtf $cur/transcomb.2.gtf

cd $cur

for k in `echo "1 2 3"`
do
	gffcompare -r $gtf scallop.$k.gtf -M -N
	refsize=`cat $cur/gffcmp.stats | grep Reference | grep mRNA | awk '{print $5}'`
	$roc split gffcmp.scallop.$k.gtf.tmap scallop.$k.gtf scallop.$k.true.gtf false.gtf
	rm gffcmp.* false.gtf
done

for k in `echo "1 2 3"`
do
	gffcompare -r $gtf stringtie.$k.gtf -M -N
	refsize=`cat $cur/gffcmp.stats | grep Reference | grep mRNA | awk '{print $5}'`
	$roc split gffcmp.stringtie.$k.gtf.tmap stringtie.$k.gtf stringtie.$k.true.gtf false.gtf
	rm gffcmp.* false.gtf
done

for k in `echo "1 2"`
do
	gffcompare -r $gtf transcomb.$k.gtf -M -N
	refsize=`cat $cur/gffcmp.stats | grep Reference | grep mRNA | awk '{print $5}'`
	$roc split gffcmp.transcomb.$k.gtf.tmap transcomb.$k.gtf transcomb.$k.true.gtf false.gtf
	rm gffcmp.* false.gtf
done

a1="scallop"
a2="stringtie"
a3="transcomb"

# different algorithm
xx=$1
for k in `echo "1 2"`
do
	commgtf $cur/$a1.$k.true.gtf $cur/$a2.$k.true.gtf  $cur/$a1.$a2.$k.true.gtf
	commgtf $cur/$a1.$k.true.gtf $cur/$a3.$k.true.gtf  $cur/$a1.$a3.$k.true.gtf
	commgtf $cur/$a2.$k.true.gtf $cur/$a3.$k.true.gtf  $cur/$a2.$a3.$k.true.gtf
	commgtf $cur/$a1.$a2.$k.true.gtf $cur/$a3.$k.true.gtf  $cur/$a1.$a2.$a3.$k.true.gtf

	xa=`cat $cur/$a1.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	xb=`cat $cur/$a2.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	xc=`cat $cur/$a3.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	x1=`cat $cur/$a1.$a2.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	x2=`cat $cur/$a1.$a3.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	x3=`cat $cur/$a2.$a3.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	x4=`cat $cur/$a1.$a2.$a3.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	xx="$xx $xa $xb $xc $x1 $x2 $x3 $x4"
done

for k in `echo "3"`
do
	commgtf $cur/$a1.$k.true.gtf $cur/$a2.$k.true.gtf  $cur/$a1.$a2.$k.true.gtf
	xa=`cat $cur/$a1.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	xb=`cat $cur/$a2.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	x1=`cat $cur/$a1.$a2.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	xx="$xx $xa $xb $x1"
done

echo $xx > $cur/algo.summary

# different aligner
cd $cur
commgtf $cur/scallop.1.true.gtf $cur/scallop.2.true.gtf  $cur/scallop.12.true.gtf
commgtf $cur/scallop.1.true.gtf $cur/scallop.3.true.gtf $cur/scallop.13.true.gtf
commgtf $cur/scallop.2.true.gtf $cur/scallop.3.true.gtf $cur/scallop.23.true.gtf
commgtf $cur/scallop.1.true.gtf $cur/scallop.23.true.gtf $cur/scallop.123.true.gtf

commgtf $cur/stringtie.1.true.gtf $cur/stringtie.2.true.gtf $cur/stringtie.12.true.gtf
commgtf $cur/stringtie.1.true.gtf $cur/stringtie.3.true.gtf $cur/stringtie.13.true.gtf
commgtf $cur/stringtie.2.true.gtf $cur/stringtie.3.true.gtf $cur/stringtie.23.true.gtf
commgtf $cur/stringtie.1.true.gtf $cur/stringtie.23.true.gtf $cur/stringtie.123.true.gtf

commgtf $cur/transcomb.1.true.gtf $cur/transcomb.2.true.gtf $cur/transcomb.12.true.gtf

xx=$1
for k in `echo "1 2 3 12 13 23 123"`
do
	x=`cat scallop.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	xx="$xx $x"
done

for k in `echo "1 2 3 12 13 23 123"`
do
	x=`cat stringtie.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	xx="$xx $x"
done

for k in `echo "1 2 12"`
do
	x=`cat transcomb.$k.true.gtf | awk '$3 == "transcript"' | wc -l`
	xx="$xx $x"
done

echo $xx > $cur/aligner.summary
