# Overview

This repository tests and compares the performance of our released transcript assembly method
[**Scallop**](https://github.com/Kingsford-Group/scallop) with other two leading transcript assemblers,
[StringTie](https://ccb.jhu.edu/software/stringtie/) and
[TransComb](https://sourceforge.net/projects/transcriptomeassembly/files/).
Please refer to our paper published at 
[**Nature Biotechnology**](https://www.nature.com/articles/nbt.4020).
A **podcast** about Scallop (thanks to [Roman Cheplyaka](https://ro-che.info/)) 
is available at [bioinformatics.chat](https://bioinformatics.chat/scallop)
and [iTunes](https://itunes.apple.com/us/podcast/the-bioinformatics-chat/id1227281398). 
Here we provide scripts to download datasets, run the three methods, evaluated the
predicted transcripts, and reproduce the results and figures in the paper.

The pipeline involves in the followint four steps:

1. Download necessary datasets (`data` directory).
2. Download and/or compile necessary programs (`programs` directory).
3. Run the methods to produce results (`results` directory).
4. Summarize results and produce figures (`plots` directory).

# Datasets
We compare the three methods on three datasets, namely **encode10**, **encode65**, and **sequin**. 
Besides, we also need the annotation files for evaluation purposes.
In directory `data`, we provide metadata for these datasets, and also provide scripts to download them.

## **encode10**
The first dataset, namely **encode10**,
contains 10 human RNA-seq samples downloaded from [ENCODE project (2003--2012)](https://genome.ucsc.edu/ENCODE/).
All these samples are sequenced with strand-specific and paired-end protocols.
For each of these 10 samples, we align it with three RNA-seq aligners,
[TopHat2](https://ccb.jhu.edu/software/tophat/index.shtml),
[STAR](https://github.com/alexdobin/STAR), and
[HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml).
Among them the STAR and HISAT2 alignments are
available at [doi:10.26208/8c06-w247](https://doi.org/10.26208/8c06-w247).

## **encode65**
The second dataset, namely **encode65**,
contains 65 human RNA-seq samples downloaded from [ENCODE project (2013--present)](https://www.encodeproject.org/).
This dataset includes 50 strand-specific samples and 15 non-strand samples.
These samples have pre-computed reads alignments, and can be downloaded by the script in `data` directory.
```
./download.encode65.sh
```
The downloaded files will appear under `data/encode65`.
**NOTE:** The total 65 reads alignments files take about 390GB storage space.


## **sequin**
The third dataset, namely **sequin**,
contains 8 spike-in RNA-seq samples (see [paper](http://www.nature.com/nmeth/journal/v13/n9/full/nmeth.3958.html)).
Again, for each of these 8 samples, we align it with three RNA-seq aligners,
[TopHat2](https://ccb.jhu.edu/software/tophat/index.shtml),
[STAR](https://github.com/alexdobin/STAR), and
[HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml).
We have uploaded all these reads alignments to CMU box.
Use this [link](https://cmu.box.com/s/1h6z11ee7ks2ij5xvnc8n9z9gdjeet52) to download these files.
Please keep the identical directory structure and files names
(i.e., `data/sequin/ACCESSION/ALIGNER.sort.bam`) as we used there.


## Annotations
For **encode10** and **encode65** datasets, we use human annotation database as reference;
for **sequin**, we use the known synthetic annotation as reference.
Use the following script in `data` to download annotations:
```
./download.annotation.sh
```
The downloaded files will appear under `data/ensembl`.


# Programs

Our experiments involve the following four programs:

Program | Version | Description
------------ | ------------ | ------------ 
[Scallop](https://github.com/Kingsford-Group/scallop) | v0.9.8 | Transcript assembler
[StringTie](https://ccb.jhu.edu/software/stringtie/) | v1.3.2d | Transcript assembler
[TransComb](https://sourceforge.net/projects/transcriptomeassembly/files/) | v.1.0 | Transcript assembler
[Cufflinks](http://cole-trapnell-lab.github.io/cufflinks/) | v2.2.1 | Transcript assembler
[gffcompare](http://ccb.jhu.edu/software/stringtie/gff.shtml) | v0.9.9c | Evaluate assembled transcripts
[gtfcuff](https://github.com/Kingsford-Group/rnaseqtools) |  | RNA-seq tool
[gtfformat](https://github.com/Kingsford-Group/rnaseqtools) |  | RNA-seq tool
[gtfmerge](https://github.com/Kingsford-Group/rnaseqtools) |  | RNA-seq tool

You need to download and/or complile them,
and then link them to `programs` directory.
Make sure that the program names are in lower cases (i.e., `scallop`, `stringtie`, `transcomb`, and `gffcompare`)
in `programs` directory.


# Run the Methods

Once the datasets and programs are all available, use the following scripts in `results`
to run the methods assemblers on the datasets:
```
./run.encode10.sh
./run.encode65.sh
./run.sequin.sh
```
In each of these three scripts, you can modify it to run different
methods (Scallop, StringTie, TransComb, and Cufflinks), and to run
with different minimum coverage threshold. For each run,
you need to specify a `run-id`, which will be used later on when 
collecting the results. You can also modify the scripts to specify
how many CPU cores you want to use to run the jobs in parallel.


# Analysis Results and Reproduce Figures

Once the results have been generated, one can use the following scripts in `plots` to reproduce the figures:
```
./build.figures.sh
```
You may need to install R packages `VennDiagram` and `tikzDevice`.
You may also need to modify these scripts to match the `run-id(s)` you
specified when you run these assemblers.


