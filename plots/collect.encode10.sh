#!/bin/bash

list=../data/encode10.list

# collect quant-results with zero parameters
summary=./encode10/collect.B759
mkdir -p $summary

for ll in `echo "1 2 3"`
do
	outfile=$summary/train.quant$ll.zero
	rm -rf $outfile
	for x in `cat $list | head -n 5`
	do
		id=`echo $x | cut -f 1 -d ":"`
		./collect.encode10.quant.sh $id scallop.B759.0.01 stringtie.0.01 transcomb.0.01 $ll >> $outfile
	done
done

for ll in `echo "1 2 3"`
do
	outfile=$summary/test.quant$ll.zero
	rm -rf $outfile
	for x in `cat $list | tail -n 5`
	do
		id=`echo $x | cut -f 1 -d ":"`
		./collect.encode10.quant.sh $id scallop.B759.0.01 stringtie.0.01 transcomb.0.01 $ll >> $outfile
	done
done

exit


# collect class results with zero
summary=./encode10/class.B759
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

cat $summary/train.class.zero | sort -k1,1n -k2,2 > xxx; mv xxx $summary/train.class.zero
cat $summary/test.class.zero | sort -k1,1n -k2,2 > xxx; mv xxx $summary/test.class.zero

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
