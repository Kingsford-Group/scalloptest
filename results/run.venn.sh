#!/bin/bash

dir=`pwd`/
list=../data/encode10.list
scripts=`tempfile -d $dir`
rm -f $scripts

for i in `cat $list`
do
	id=`echo $i | cut -f 1 -d ":"`
	echo "./run.venn.single.sh $id" >> $scripts
done

nohup cat $scripts | xargs -L 1 -I CMD -P 10 bash -c CMD > /tmp/null &
