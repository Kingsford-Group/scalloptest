# Overview

This repository tests and compares the performance of our released transcript assembly method
[**Scallop**](https://github.com/Kingsford-Group/scallop) with other two leading transcript assemblers,
[StringTie](https://ccb.jhu.edu/software/stringtie/) and
[TransComb](https://sourceforge.net/projects/transcriptomeassembly/files/).
The datasets, methods, and results are described in our paper
(http://biorxiv.org/content/early/2017/04/03/123612).
Here we provides scripts to download datasets, run the three methods, evaluated the
predicted transcripts, and report the results.

# Datasets
We compare the three methods on two datasets. The first dataset, namely **ENCODE10**,
contains 10 human RNA-seq samples downloaded from [ENCODE project (2003--2012)](https://genome.ucsc.edu/ENCODE/).
All these samples are sequenced with strand-specific and paired-end protocols.
For each of these 10 samples, we align it with three RNA-seq aligners,
[TopHat2](https://ccb.jhu.edu/software/tophat/index.shtml),
[STAR](https://github.com/alexdobin/STAR), and
[HISAT2](https://ccb.jhu.edu/software/hisat2/index.shtml).
We have uploaded all these reads alignments to CMU box.
Use this link [**DOWNLOAD ENCODE10**](https://cmu.box.com/s/zeaxc7iwiis466g1idphtojtarcb6hf4) to download these files.
**NOTE:** The total 30 reads alignments files take about 270GB storage space.
Please keep the identical directory structure and files names
(i.e., `data/encode10/ACCESSION/ALIGNER.sort.bam`) as we used here.

The second dataset, namely **ENCODE65**,
contains 65 human RNA-seq samples downloaded from [ENCODE project (2013--present)](https://www.encodeproject.org/).
This dataset includes 50 strand-specific samples, and 15 non-strand samples, all of which use paired-end protocols.
These samples have pre-computed reads alignments, and can be downloaded by the script in `bin` directory.
```
./download.encode65.sh
```
The downloaded files will appear under `data/encode65`.
**NOTE:** The total 65 reads alignments files take about 390GB storage space.


To evaluate to predicted transcripts, we use human annotation database as reference. 
We align all samples in **ENCODE10** to GRCh38. For samples in **ENCODE65**, some of
them are aligned to GRCh38, and some of them are aligned to GRCh37
(see `bin/encode15.list` and `bin/encode65.list` for details).
Use the following script to download annotations for GRCh38 and GRCh37:
```
./download.annotation.sh
```
The downloaded files will appear under `data/ensembl`.


# Programs

The experiments involves the following four programs:

Program | Version | Description | URL
------------ | ------------ | ------------ | ------------
Scallop | v0.9.8 | Transcript Assembler | (https://github.com/Kingsford-Group/scallop) 
StringTie | v1.3.2d | Transcript Assembler | (https://ccb.jhu.edu/software/stringtie/) 
TransComb | v.1.0 | Transcript Assembler | (https://sourceforge.net/projects/transcriptomeassembly/files/)
gffcompare | v0.9.9c | Evaluate predicted transcripts | (http://ccb.jhu.edu/software/stringtie/gff.shtml)

We include in `programs/linux_x86_64` and `programs/macOS` the binary executables of these four programs for linux and macOS platforms.
If these binary versions cannot execute on your machine, you need to download and compile the source code.
After that, link them to `programs/linux_x86_64` or `programs/macOS`.

# Run the Methods

Once the datasets are programs are all available, use the following scripts in `bin`
to run the three assemblers on the corresponding datasets:
```
./run.encode10.sh [-c coverage] [-p platform]
./run.encode65.sh [-c coverage] [-p platform]
```
Both scripts take two parameters. `-c` specifies the *minimum coverage threshold*,
which filters the predicted transcripts with coverage less than this value. 
This parameter can be set as `default`, or any float value that is larger than 0 (cannot be exactly 0).
`-p` parameter specifies the platform, chosen from `linux_x86_64`, or `macOS`.
These two scripts shall choose the corresponding programs locating in either `programs/linux_x86_64` or `programs/macOS`.

These two scripts shall also call `gffcompare` to evaluate the predicted transcripts. 
All results shall appear under directory `results`.

# Report Accuracy

Once the results have been generated, one can use the following scripts in `bin` to summarize the accuracy of the three assemblers:
```
./collect.encode10.sh [-c coverage]
./collect.encode65.sh [-c coverage]
```
The `-c` parameter should match the one used to run the three methods. 
The summarized accuracy, including `# correct transcritps` and `precision` for both multi-exon transcripts
and single-exon transcritps, shall be pushed to standard output.
