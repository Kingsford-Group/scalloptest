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
			quant=$datadir/$id/quant.sf
	
			if [ ! -s $bam ]; then
				echo "make sure $bam is available"
				exit
			fi
	
			cur=$results/$id.$aa/$algo.$suffix
	
			echo "./run.$algo.sh $cur $bam $gtf $coverage $ss $quant" >> $scripts
		done
	done
}

make.scripts cufflinks default 999

#make.scripts stringtie 0.01 0.01
#make.scripts transcomb 0.01 0.01

#make.scripts stringtie 0621.0.01 0.01
#make.scripts stringtie 0621.1 1
#make.scripts stringtie 0621.2.5 2.5
#make.scripts stringtie 0621.5 5
#make.scripts stringtie 0621.7.5 7.5
#make.scripts stringtie 0621.10 10
#make.scripts stringtie 0621.25 25
#make.scripts stringtie 0621.50 50
#make.scripts stringtie 0621.75 75
#make.scripts stringtie 0621.100 100

#make.scripts transcomb 0620.0.01 0.01
#make.scripts transcomb 0620.1 1
#make.scripts transcomb 0620.2.5 2.5
#make.scripts transcomb 0620.5 5
#make.scripts transcomb 0620.7.5 7.5
#make.scripts transcomb 0620.10 10
#make.scripts transcomb 0620.25 25
#make.scripts transcomb 0620.50 50
#make.scripts transcomb 0620.75 75
#make.scripts transcomb 0620.100 100

xarglist=`tempfile -d $dir`
rm -f $xarglist

cat $scripts | sort -R > $xarglist

nohup cat $xarglist | xargs -L 1 -I CMD -P 20 bash -c CMD > /tmp/null &
