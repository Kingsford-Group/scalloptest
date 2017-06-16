#!/bin/bash

coverage="default"

while getopts "c:p:" arg
do
	case $arg in 
	c) 
		coverage=$OPTARG
		;;
	esac
done


bin=`pwd`/../programs
gtf=`pwd`/../data/ensembl

if [ ! -x $bin/scallop ]; then
	echo "please make sure $bin/scallop is available/executable"
	exit
fi

if [ ! -x $bin/stringtie ]; then
	echo "please make sure $bin/stringtie is available/executable"
	exit
fi

if [ ! -x $bin/transcomb ]; then
	echo "please make sure $bin/transcomb is available/executable"
	exit
fi

if [ ! -x $bin/gffcompare ]; then
	echo "please make sure $bin/gffcompare is available/executable"
	exit
fi

if [ ! -s $gtf/GRCh38.gtf ]; then
	echo "please make sure $gtf/GRCh38.gtf is available (you may run ./download.annotation.sh)"
	exit
fi

if [ ! -s $gtf/GRCh37.gtf ]; then
	echo "please make sure $gtf/GRCh37.gtf is available (you may run ./download.annotation.sh)"
	exit
fi


nohup ./run.scallop.encode10.sh -c $coverage &
nohup ./run.stringtie.encode10.sh -c $coverage &
nohup ./run.transcomb.encode10.sh -c $coverage &
