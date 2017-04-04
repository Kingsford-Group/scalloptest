#!/bin/bash

wget ftp://ftp.ensembl.org/pub/release-84/gtf/homo_sapiens/Homo_sapiens.GRCh38.84.gtf.gz -O ../data/ensembl/GRCh38.gtf.gz
wget ftp://ftp.ensembl.org/pub/grch37/release-87/gtf/homo_sapiens/Homo_sapiens.GRCh37.87.gtf.gz -O ../data/ensembl/GRCh37.gtf.gz

gzip -d ../data/ensembl/GRCh38.gtf.gz
gzip -d ../data/ensembl/GRCh37.gtf.gz
