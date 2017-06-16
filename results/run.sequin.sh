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
	echo "please provide -x for suffix"
	exit
fi

scripts=./scripts.sequin6
rm -f $scripts

#./run.scallop.sequin.sh -x $suffix.7.0 -c 7.0 -s 1.00 -t $scripts
#nohup cat $scripts | xargs -L 1 -I CMD -P 1 bash -c CMD > log & 
#exit

./run.scallop.sequin.sh -x $suffix.1.0 -c 1.0 -s 1.00 -t $scripts 
./run.scallop.sequin.sh -x $suffix.2.0 -c 2.0 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.3.0 -c 3.0 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.4.0 -c 4.0 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.5.0 -c 5.0 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.6.0 -c 6.0 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.7.0 -c 7.0 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.8.0 -c 8.0 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.9.0 -c 9.0 -s 1.00 -t $scripts

./run.scallop.sequin.sh -x $suffix.1.5 -c 1.5 -s 1.00 -t $scripts 
./run.scallop.sequin.sh -x $suffix.2.5 -c 2.5 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.3.5 -c 3.5 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.4.5 -c 4.5 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.5.5 -c 5.5 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.6.5 -c 6.5 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.7.5 -c 7.5 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.8.5 -c 8.5 -s 1.00 -t $scripts
./run.scallop.sequin.sh -x $suffix.9.5 -c 9.5 -s 1.00 -t $scripts

nohup cat $scripts | xargs -L 1 -I CMD -P 20 bash -c CMD > log & 
exit

./run.stringtie.sequin.sh -c 1.5 -s 1.00 -t $scripts
./run.stringtie.sequin.sh -c 2.5 -s 1.00 -t $scripts
./run.stringtie.sequin.sh -c 3.5 -s 1.00 -t $scripts
./run.stringtie.sequin.sh -c 4.5 -s 1.00 -t $scripts
./run.stringtie.sequin.sh -c 5.5 -s 1.00 -t $scripts
./run.stringtie.sequin.sh -c 6.5 -s 1.00 -t $scripts
./run.stringtie.sequin.sh -c 7.5 -s 1.00 -t $scripts
./run.stringtie.sequin.sh -c 8.5 -s 1.00 -t $scripts
./run.stringtie.sequin.sh -c 9.5 -s 1.00 -t $scripts

nohup cat $scripts | xargs -L 1 -I CMD -P 10 bash -c CMD > log & 
exit

./run.transcomb.sequin.sh -c 1.0 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 2.0 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 3.0 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 4.0 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 5.0 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 6.0 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 7.0 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 8.0 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 9.0 -s 1.00 -t $scripts

./run.transcomb.sequin.sh -c 1.5 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 2.5 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 3.5 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 4.5 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 5.5 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 6.5 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 7.5 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 8.5 -s 1.00 -t $scripts
./run.transcomb.sequin.sh -c 9.5 -s 1.00 -t $scripts

nohup cat $scripts | xargs -L 1 -I CMD -P 5 bash -c CMD > log &
