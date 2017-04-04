#!/bin/bash

coverage="default"
platform="linux_x86_64"

while getopts "c:p:" arg
do
	case $arg in 
	c) 
		coverage=$OPTARG
		;;
	p) 
		platform=$OPTARG
		;;
	esac
done

nohup ./run.scallop.encode10.sh -c $coverage -p $platform &
nohup ./run.stringtie.encode10.sh -c $coverage -p $platform &
nohup ./run.transcomb.encode10.sh -c $coverage -p $platform &
