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
Use this link [(**download encode10**)](https://cmu.box.com/s/1h6z11ee7ks2ij5xvnc8n9z9gdjeet52) to download these files.
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
Use this link [(**download sequin**)](https://cmu.box.com/s/w2qex8ht0obu2rsxpx2y08m47jed8t8i) to download these files.
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

Once the datasets and programs are all available, use the following scripts in `bin`
to run the three assemblers on the datasets:
```
./run.encode10.sh [-c coverage]
./run.encode65.sh [-c coverage]
```
Both scripts takes parameter `-c`, the *minimum coverage threshold*,
which filters the predicted transcripts with coverage less than this value. 
This parameter can be set as `default`, or any float value that is larger than 0 (cannot be exactly 0).
The default value of `-c` is `default`, which run the three methods with their default settings.
These two scripts shall also invoke `gffcompare` to evaluate the assembled transcripts. 
All results shall appear under directory `results`.

# Report Accuracy

Once the results have been generated, one can use the following scripts in `bin` to summarize the accuracy of the three assemblers:
```
./collect.encode10.sh [-c coverage]
./collect.encode65.sh [-c coverage]
```
The `-c` parameter should match the one used to run the three methods. 
The summarized accuracy, including `# correct transcritps` and `precision` for both multi-exon transcripts
and single-exon transcritps, shall be printed on standard output.
