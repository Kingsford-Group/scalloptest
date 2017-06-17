#!/bin/bash

dir=`pwd`
bin=$dir/../programs
list=$dir/../data/sequin.list
datadir=$dir/../data/sequin
results=$dir/../results/sequin
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

	if [ "$1" == "transcomb" ]; then
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
			bb="$aa"."$gm"
			bam=$datadir/$id/$bb/$aa.sort.bam
	
			if [ ! -s $bam ]; then
				echo "make sure $bam is available"
				exit
			fi
	
			cur=$results/$id.$bb/$algo.$suffix
	
			echo "./run.$algo.single.sh $cur $bam $gtf $coverage $ss" >> $scripts
		done
	done
}

make.scripts scallop test1.10 10 
make.scripts stringtie test2.10 10 
make.scripts transcomb test3.10 10 

xarglist=`tempfile -d $dir`
rm -f $xarglist

cat $scripts | sort -R > $xarglist

#nohup cat $xarglist | xargs -L 1 -I CMD -P 30 bash -c CMD > /tmp/null &
