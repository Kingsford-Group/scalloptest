#!/bin/bash

list=../data/sequin.list
summary=./sequin/collect.B759
mkdir -p $summary

# collect results for ROC
for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	rm -rf $summary/$id
	./collect.sequin.roc.sh $id scallop.B759 stringtie transcomb > $summary/$id
done

# collect multi-exon results with default parameters
rm -rf $summary/spike.multi.default
rm -rf $summary/neat.multi.default
for x in `cat $list | head -n 4`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.sequin.multi.sh $id scallop.B759.1.0 stringtie.2.5 transcomb.0.01 >> $summary/spike.multi.default
done

for x in `cat $list | tail -n 4`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.sequin.multi.sh $id scallop.B759.1.0 stringtie.2.5 transcomb.0.01 >> $summary/neat.multi.default
done
