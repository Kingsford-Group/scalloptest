#!/bin/bash

list=../data/encode10.list

# collect class results with zero
summary=./encode10/accuracy.B759
mkdir -p $summary

rm -rf $summary/train.class.zero
rm -rf $summary/test.class.zero

for x in `cat $list | head -n 5`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.class.sh $id scallop.B759.0.01 stringtie.0.01 transcomb.0.01 >> $summary/train.class.zero
done

for x in `cat $list | tail -n 5`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.class.sh $id scallop.B759.0.01 stringtie.0.01 transcomb.0.01 >> $summary/test.class.zero
done

cat $summary/train.class.zero | sort -k1,1n > xxx; mv xxx $summary/train.class.zero
cat $summary/test.class.zero | sort -k1,1n > xxx; mv xxx $summary/test.class.zero

exit

# collect single-exon results with default parameters
summary=./encode10/accuracy.B759
mkdir -p $summary

rm -rf $summary/single.default

for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.single.sh $id scallop.B759.1 stringtie.2.5 transcomb.0.01 >> $summary/single.default
done

exit

# collect multi-exon results with default parameters
summary=./encode10/accuracy.B759
mkdir -p $summary

rm -rf $summary/multi.default
rm -rf $summary/multi.zero

for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.multi.sh $id scallop.B759.1 stringtie.2.5 transcomb.0.01 >> $summary/multi.default
	./collect.encode10.multi.sh $id scallop.B759.0.01 stringtie.0.01 transcomb.0.01 >> $summary/multi.zero
done

exit

# collect results for ROC
summary=./encode10/roc.B759.10
mkdir -p $summary

for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.encode10.roc.sh -i $id > $summary/$id
done
