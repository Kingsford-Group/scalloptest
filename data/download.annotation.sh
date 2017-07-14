#!/bin/bash

dir=./ensembl
mkdir -p $dir

wget ftp://ftp.ensembl.org/pub/release-84/gtf/homo_sapiens/Homo_sapiens.GRCh38.84.gtf.gz -O $dir/GRCh38.gtf.gz
wget ftp://ftp.ensembl.org/pub/grch37/release-87/gtf/homo_sapiens/Homo_sapiens.GRCh37.87.gtf.gz -O $dir/GRCh37.gtf.gz

gzip -d $dir/GRCh38.gtf.gz
gzip -d $dir/GRCh37.gtf.gz

wget https://s3.amazonaws.com/sequins/annotations/A.R.1.2.gtf -O $dir/chrIS.gtf
cat $dir/chrIS.gtf | sed 's/chrIS/IS/g' > $dir/is.gtf
