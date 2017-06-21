#!/bin/bash

list=../data/sequin.list

# collect results for ROC
summary=./sequin/roc.B759.6
mkdir -p $summary

for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.sequin.roc.sh -i $id > $summary/$id
done

# collect multi-exon results with default parameters
summary=./sequin/accuracy.B759
mkdir -p $summary

rm -rf $summary/multi.default
for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.sequin.multi.sh -i $id >> $summary/multi.default
done
