#!/bin/sh
if [ $# -eq 0 ] 
then
   echo ""
   echo ""
   echo "Usage: myepstool.sh TexFileName_WithoutExtension"
   echo "by Le CHEN, (chenle02@gmail.com)"
   echo "2010-Dec-17"
   echo ""
   echo ""
   exit 1
fi

latex --shell-escape --enable-write18 $1.tex		# run latex (file without extension)
dvips -j -E $1.dvi -o $1.eps		# run dvips
epstool --copy --bbox $1.eps $1.tmp.eps # run epstool
mv $1.tmp.eps $1.eps			# rename output
epstopdf $1.eps		#generate corresponding pdf files
