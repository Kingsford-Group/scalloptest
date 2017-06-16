#!/bin/bash

list=../lists/sequin.list
summary=./sequin/accuracy

mkdir -p $summary

for x in `cat $list`
do
	id=`echo $x | cut -f 1 -d ":"`
	./collect.sequin.accuracy.sh -i $id > $summary/$id
done
