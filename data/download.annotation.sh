#!/bin/bash

dir=./ensembl
mkdir -p $dir

wget ftp://ftp.ensembl.org/pub/release-84/gtf/homo_sapiens/Homo_sapiens.GRCh38.84.gtf.gz -O $dir/GRCh38.gtf.gz
wget ftp://ftp.ensembl.org/pub/grch37/release-87/gtf/homo_sapiens/Homo_sapiens.GRCh37.87.gtf.gz -O $dir/GRCh37.gtf.gz

gzip -d $dir/GRCh38.gtf.gz
gzip -d $dir/GRCh37.gtf.gz
