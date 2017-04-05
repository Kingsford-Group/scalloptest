# Overview

This repository tests and compares the performance of our released transcript assembly method
[**Scallop**](https://github.com/Kingsford-Group/scallop) with other two leading transcript assemblers,
[StringTie](https://ccb.jhu.edu/software/stringtie/) and
[TransComb](https://sourceforge.net/projects/transcriptomeassembly/files/).
The datasets, methods, and results are described in our paper
(http://biorxiv.org/content/early/2017/04/03/123612).
Here we provides scripts to download datasets, run the three methods, and report the results.

# Datasets
We compare the three methods on two datasets. The first dataset, namely **ENCODE10**,
contains 10 human RNA-seq samples downloaded from [ENCODE project (2003--2012)](https://genome.ucsc.edu/ENCODE/).
All these samples are sequenced with strand-specific and paired-end protocols.
For each of these 10 samples, we align it with three RNA-seq aligners,
[TopHat2](https://ccb.jhu.edu/software/tophat/index.shtml),
[STAR](https://github.com/alexdobin/STAR), and
[HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml).
To download these alignments, run the following script in `bin` directory:
```
./download.encode10.sh
```
**NOTE:** The total 30 reads alignments files (in `bam` format) take about 270GB storage space.

The second dataset, namely **ENCODE65**,
contains 65 human RNA-seq samples downloaded from [ENCODE project (2013--present)](https://www.encodeproject.org/).
This dataset includes 50 strand-specific samples, and 15 non-strand samples, all of which use paired-end protocols.
These samples have pre-computed reads alignments, and can be downloaded through
```
./download.encode65.sh
```
