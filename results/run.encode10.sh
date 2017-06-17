#!/bin/bash

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

dir=`pwd`
scripts1=`tempfile -d $dir`
scripts2=`tempfile -d $dir`
rm -f $scripts1 $scripts2

./run.scallop.encode10.sh -x $suffix.0.01 -c 0.01 -t $scripts1 
./run.scallop.encode10.sh -x $suffix.5 -c 5 -t $scripts1 
./run.scallop.encode10.sh -x $suffix.7.5 -c 7.5 -t $scripts1 
./run.scallop.encode10.sh -x $suffix.10 -c 10 -t $scripts1 
./run.scallop.encode10.sh -x $suffix.25 -c 25 -t $scripts1
./run.scallop.encode10.sh -x $suffix.50 -c 50 -t $scripts1
./run.scallop.encode10.sh -x $suffix.75 -c 75 -t $scripts1
./run.scallop.encode10.sh -x $suffix.100 -c 100 -t $scripts1

cat $scripts1 | sort -R > $scripts2

nohup cat $scripts2 | xargs -L 1 -I CMD -P 32 bash -c CMD > /tmp/null &
