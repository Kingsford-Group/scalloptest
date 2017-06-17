#!/bin/bash

suffix=""

while getopts "x:" arg
do
	case $arg in 
	x) 
		suffix=$OPTARG
		;;
	esac
done

if [ "$suffix" == "" ]; then
	echo "please provide -x for suffix (used for scallop)"
	exit
fi

dir=`pwd`
scripts=`tempfile -d $dir`
rm -f $scripts

bin=$dir/../programs
list=$dir/../data/sequin.list
datadir=$dir/../data/sequin
results=$dir/../results/sequin

mkdir -p $results

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

./run.scallop.sequin.sh -x $suffix.10 -c 10 -t $scripts 
./run.scallop.sequin.sh -x $suffix.25 -c 25 -t $scripts
./run.scallop.sequin.sh -x $suffix.50 -c 50 -t $scripts
./run.scallop.sequin.sh -x $suffix.75 -c 75 -t $scripts
./run.scallop.sequin.sh -x $suffix.100 -c 100 -t $scripts

#./run.stringtie.sequin.sh -c 10 -t $scripts
#./run.stringtie.sequin.sh -c 25 -t $scripts
#./run.stringtie.sequin.sh -c 50 -t $scripts
#./run.stringtie.sequin.sh -c 75 -t $scripts
#./run.stringtie.sequin.sh -c 100 -t $scripts

#./run.transcomb.sequin.sh -c 10 -t $scripts
#./run.transcomb.sequin.sh -c 25 -t $scripts
#./run.transcomb.sequin.sh -c 50 -t $scripts
#./run.transcomb.sequin.sh -c 75 -t $scripts
#./run.transcomb.sequin.sh -c 100 -t $scripts

xarglist=`tempfile -d $dir`
rm -f $xarglist

cat $scripts | sort -R > $xarglist

#nohup cat $xarglist | xargs -L 1 -I CMD -P 30 bash -c CMD > /tmp/null &
