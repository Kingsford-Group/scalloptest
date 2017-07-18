#!/bin/bash

if [ "$#" -ne "1" ]
then
	echo "usage $0 .tex"
fi

dir=`dirname $0`
header=$dir/headers
tmp=./shao.tmp.tex

cat $header > $tmp
cat $1 >> $tmp
echo "\end{document}" >> $tmp

mv $tmp $1

cat $1 | sed 's/Sensitivity/Sensitivity~(\\%)/g' > $tmp; mv $tmp $1
cat $1 | sed 's/Precision/Precision~(\\%)/g' > $tmp; mv $tmp $1
cat $1 | sed 's/Correct/\\# Correct/g' > $tmp; mv $tmp $1
cat $1 | sed 's/AUC/AUC~($\\times 10^{4}$)/g' > $tmp; mv $tmp $1
cat $1 | sed 's/Aligned/\\# Aligned/g' > $tmp; mv $tmp $1
cat $1 | sed 's/Pairs/Pairs~($\\times 10^{-9}$)/g' > $tmp; mv $tmp $1
