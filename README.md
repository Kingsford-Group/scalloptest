# Overview

This repository tests and compares the performance of our released transcript assembly method
[**Scallop**](https://github.com/Kingsford-Group/scallop) with other two leading transcript assemblers,
[StringTie](https://ccb.jhu.edu/software/stringtie/) and
[TransComb](https://sourceforge.net/projects/transcriptomeassembly/files/).
Please refer to our pre-print
at [bioRxiv](http://biorxiv.org/content/early/2017/04/03/123612).
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
We have uploaded all these reads alignments to CMU box.
Use this [link](https://cmu.box.com/s/1h6z11ee7ks2ij5xvnc8n9z9gdjeet52) to download these files.
Four reads alignment files are splitted and then uploaded due to single file size limit of CMU box:
all the three alignments of SRR387661 and the tophat alignment of SRR534307.
You need to merge them after downloading, for example:
```
cat tophat.sort.part1.bam tophat.sort.part2.bam > tophat.sort.bam
```
After that you can (optionally) remove `tophat.sort.part*.bam`.
**NOTE:** The total 30 reads alignments files take about 270GB storage space.
Please keep the identical directory structure and files names
(i.e., `data/encode10/ACCESSION/ALIGNER.sort.bam`) as we used there.


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


# Quantification by Combining Scallop and Salmon

We recommend users to perform RNA-seq quantification using the combination of Scallop and Salmon.
This pipeline involves the following steps:

**Step 1:** Align the reads to a reference genome (for example, with
[TopHat2](https://ccb.jhu.edu/software/tophat/index.shtml),
[STAR](https://github.com/alexdobin/STAR), or
[HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml))
to obtain the reads alignment.

**Step 2:** Assemble the expressed transcripts with [Scallop](https://github.com/Kingsford-Group/scallop)
```
scallop -i sort.bam -o scallop.gtf
```
The assembled transcripts will be written to `scallop.gtf`.

**Step 3:** Use [gffcompare](http://ccb.jhu.edu/software/stringtie/gff.shtml) to
evaluate the assembled transcripts with respect to a reference annotation:
```
gffcompare -o gffall -r ensembl.gtf scallop.gtf
```
where `ensembl.gtf` is the 
[ensembl annotation](goo.gl/cifLXecontent_copyCopy short URL)
This command will generate a file `gffall.scallop.gtf.map` defining which transcripts in `scallop.gtf`
can be found in the `ensembl.gtf`.

4. Union the assembled transcripts with the reference transcriptome. Specifically,
..1. Use our tool
[gtfcuff](https://github.com/Kingsford-Group/rnaseqtools) to fetch the transcripts that
are only in `scallop.gtf`:
```
gtfcuff puniq gffall.scallop.gtf.tmap scallop.gtf unique.gtf
```
The uniquely expressed transcripts will be written to `unique.gtf`.
..2. Extract the cDNAs of these transcripts in `unique.gtf` using tool
[gffread](http://ccb.jhu.edu/software/stringtie/gff.shtml):
```
gffread unique.gtf -g genome -w unique.fa
```
where `genome` is the reference genome sequences, for example 
[ensembl](ftp://ftp.ensembl.org/pub/release-90/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.alt.fa.gz).
The cDNA sequences of the uniquely assembled transcripts will be written to `unique.fa`.
..3. Merge `unique.fa` and the reference transcriptome: 
```
cat unique.fa reference.fa > union.fa
```
where reference.fa is the reference transcriptome, for example,
[ensembl cDNA](ftp://ftp.ensembl.org/pub/release-90/fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz)).
The unioned transcriptome will be written to `union.fa`.


4. Run Salmon to quantify with respect to the above extended transcriptome.
First, create Salmon index:
```
salmon index -t union.fa -i salmon.index -p 4
```
After that we can quantify:
```
salmon quant -i salmon.index -1 fastq-file1 -2 fastq-file2 -p 4
````
