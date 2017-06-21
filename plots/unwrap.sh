#!/bin/bash

if [ "$#" -ne "1" ]
then
	echo "usage $0 .tex"
fi

tmp=./shao.tmp.tex

l=`cat $1 | wc -l | sed 's/ //g'`
let a=$l-3
let b=$a-1
cat $1 | tail -n $a | head -n $b > $tmp

mv $tmp $1
