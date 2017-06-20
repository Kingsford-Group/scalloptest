#!/bin/bash

dir=`pwd`
bin=$dir/../programs
list=$dir/../data/encode10.list
datadir=$dir/../data/encode10
results=$dir/../results/encode10
mkdir -p $results

scripts=`tempfile -d $dir`
rm -f $scripts

function make.scripts
{
	algo=$1;
	suffix=$2;
	coverage=$3;

	if [ ! -x $bin/$1 ]; then
		echo "please make sure $bin/scallop is available/executable"
		exit
	fi
	
	if [ ! -x $bin/gffcompare ]; then
		echo "please make sure $bin/gffcompare is available/executable"
		exit
	fi

	aligns="tophat star hisat"

	if [ "$algo" == "transcomb" ]; then
		aligns="tophat star"
	fi

	for x in `cat $list`
	do
		id=`echo $x | cut -f 1 -d ":"`
		ss=`echo $x | cut -f 2 -d ":"`
		gm=`echo $x | cut -f 3 -d ":"`
		gtf=$dir/../data/ensembl/$gm.gtf
	
		if [ ! -s $gtf ]; then
			echo "make sure $gtf is available"
			exit
		fi
	
		for aa in `echo $aligns`
		do
			bam=$datadir/$id/$aa.sort.bam
	
			if [ ! -s $bam ]; then
				echo "make sure $bam is available"
				exit
			fi
	
			cur=$results/$id.$aa/$algo.$suffix
	
			echo "./run.$algo.sh $cur $bam $gtf $coverage $ss" >> $scripts
		done
	done
}

make.scripts scallop B759.25 25
#make.scripts scallop B759.0.01 0.01
#make.scripts scallop B759.1 1
#make.scripts scallop B759.2.5 2.5
#make.scripts scallop B759.5 5
#make.scripts scallop B759.7.5 7.5
#make.scripts scallop B759.10 10
#make.scripts scallop B759.50 50
#make.scripts scallop B759.75 75
#make.scripts scallop B759.100 100

xarglist=`tempfile -d $dir`
rm -f $xarglist

cat $scripts | sort -R > $xarglist

nohup cat $xarglist | xargs -L 1 -I CMD -P 40 bash -c CMD > /tmp/null &
