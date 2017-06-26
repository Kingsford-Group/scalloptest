#!/bin/bash

list=../data/encode65.list
summary=./encode65/collect.B759
mkdir -p $summary

# collect multi-exon results with default parameters
rm -rf $summary/multi.default.precision2
for x in `cat $list | grep unstranded`
do
	id=`echo $x | cut -f 1 -d ":"`
	./adjust.precision2.sh $id scallop.B759.default stringtie.default >> $summary/multi.default.precision2
done

rm -rf $summary/multi.default.precision3
for x in `cat $list | grep -v unstranded`
do
	id=`echo $x | cut -f 1 -d ":"`
	./adjust.precision3.sh $id scallop.B759.default stringtie.default transcomb.default >> $summary/multi.default.precision3
done

rm -rf $summary/multi.default.correct2
for x in `cat $list | grep unstranded`
do
	id=`echo $x | cut -f 1 -d ":"`
	./adjust.correct2.sh $id scallop.B759.default stringtie.default >> $summary/multi.default.correct2
done

rm -rf $summary/multi.default.correct3
for x in `cat $list | grep -v unstranded`
do
	id=`echo $x | cut -f 1 -d ":"`
	./adjust.correct3.sh $id scallop.B759.default stringtie.default transcomb.default >> $summary/multi.default.correct3
done

cat $summary/multi.default.correct2 | sort -k2,2n > tmpfile; mv tmpfile $summary/multi.default.correct2
cat $summary/multi.default.precision2 | sort -k3,3n > tmpfile; mv tmpfile $summary/multi.default.precision2

cat $summary/multi.default.correct3 | sort -k2,2nr > tmpfile; mv tmpfile $summary/multi.default.correct3
cat $summary/multi.default.precision3 | sort -k3,3nr > tmpfile; mv tmpfile $summary/multi.default.precision3

cat $summary/multi.default.correct3 | head -n 17 | tail -n 17 | sort -k2,2n > $summary/multi.default.correct3A
cat $summary/multi.default.correct3 | head -n 34 | tail -n 17 | sort -k2,2n > $summary/multi.default.correct3B
cat $summary/multi.default.correct3 | head -n 50 | tail -n 17 | sort -k2,2n > $summary/multi.default.correct3C

cat $summary/multi.default.precision3 | head -n 17 | tail -n 17 | sort -k3,3n > $summary/multi.default.precision3A
cat $summary/multi.default.precision3 | head -n 34 | tail -n 17 | sort -k3,3n > $summary/multi.default.precision3B
cat $summary/multi.default.precision3 | head -n 50 | tail -n 17 | sort -k3,3n > $summary/multi.default.precision3C
