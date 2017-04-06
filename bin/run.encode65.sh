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

nohup ./run.scallop.encode65.sh -c $coverage &
nohup ./run.stringtie.encode65.sh -c $coverage &
nohup ./run.transcomb.encode65.sh -c $coverage &
