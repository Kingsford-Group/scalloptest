encode10 = "encode10/collect.B759/";
encode65 = "encode65/collect.B759/";
sequin = "sequin/collect.B759/";

xx = c();
xx1 = c();
xx2 = c();


### analysis encode10

## analysis sensitivity and precision

# single-exon default
print("single-exon default sensitivity:");

data = read.table(paste(encode10, "train.single.default", sep=""));
for (k in seq(1, 8))
{
	xx1[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TRAINING TopHat2: scallop / stringtie = %f", xx1[1] / xx1[2]));
print(sprintf("TRAINING TopHat2: scallop / transcomb = %f", xx1[1] / xx1[3]));
print(sprintf("TRAINING STAR: scallop / stringtie = %f", xx1[4] / xx1[5]));
print(sprintf("TRAINING STAR: scallop / transcomb = %f", xx1[4] / xx1[6]));
print(sprintf("TRAINING HISAT: scallop / stringtie = %f", xx1[7] / xx1[8]));

data = read.table(paste(encode10, "test.single.default", sep=""));
for (k in seq(1, 8))
{
	xx2[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TESTING TopHat2: scallop / stringtie = %f", xx2[1] / xx2[2]));
print(sprintf("TESTING TopHat2: scallop / transcomb = %f", xx2[1] / xx2[3]));
print(sprintf("TESTING STAR: scallop / stringtie = %f", xx2[4] / xx2[5]));
print(sprintf("TESTING STAR: scallop / transcomb = %f", xx2[4] / xx2[6]));
print(sprintf("TESTING HISAT: scallop / stringtie = %f", xx2[7] / xx2[8]));

xx = xx1 * 0.5 + xx2 * 0.5;
print(sprintf("ALL TopHat2: scallop / stringtie = %f", xx[1] / xx[2]));
print(sprintf("ALL TopHat2: scallop / transcomb = %f", xx[1] / xx[3]));
print(sprintf("ALL STAR: scallop / stringtie = %f", xx[4] / xx[5]));
print(sprintf("ALL STAR: scallop / transcomb = %f", xx[4] / xx[6]));
print(sprintf("ALL HISAT: scallop / stringtie = %f", xx[7] / xx[8]));
print("\n");

# multi-exon default
print("multi-exon default sensitivity:");

data = read.table(paste(encode10, "train.multi.default", sep=""));
for (k in seq(1, 8))
{
	xx1[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TRAINING TopHat2: scallop / stringtie = %f", xx1[1] / xx1[2]));
print(sprintf("TRAINING TopHat2: scallop / transcomb = %f", xx1[1] / xx1[3]));
print(sprintf("TRAINING STAR: scallop / stringtie = %f", xx1[4] / xx1[5]));
print(sprintf("TRAINING STAR: scallop / transcomb = %f", xx1[4] / xx1[6]));
print(sprintf("TRAINING HISAT: scallop / stringtie = %f", xx1[7] / xx1[8]));

data = read.table(paste(encode10, "test.multi.default", sep=""));
for (k in seq(1, 8))
{
	xx2[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TESTING TopHat2: scallop / stringtie = %f", xx2[1] / xx2[2]));
print(sprintf("TESTING TopHat2: scallop / transcomb = %f", xx2[1] / xx2[3]));
print(sprintf("TESTING STAR: scallop / stringtie = %f", xx2[4] / xx2[5]));
print(sprintf("TESTING STAR: scallop / transcomb = %f", xx2[4] / xx2[6]));
print(sprintf("TESTING HISAT: scallop / stringtie = %f", xx2[7] / xx2[8]));

xx = xx1 * 0.5 + xx2 * 0.5;
print(sprintf("ALL TopHat2: scallop / stringtie = %f", xx[1] / xx[2]));
print(sprintf("ALL TopHat2: scallop / transcomb = %f", xx[1] / xx[3]));
print(sprintf("ALL STAR: scallop / stringtie = %f", xx[4] / xx[5]));
print(sprintf("ALL STAR: scallop / transcomb = %f", xx[4] / xx[6]));
print(sprintf("ALL HISAT: scallop / stringtie = %f", xx[7] / xx[8]));
print("\n");

# multi-exon zero
print("multi-exon zero sensitivity:");

data = read.table(paste(encode10, "train.multi.zero", sep=""));
for (k in seq(1, 8))
{
	xx1[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TRAINING TopHat2: scallop / stringtie = %f", xx1[1] / xx1[2]));
print(sprintf("TRAINING TopHat2: scallop / transcomb = %f", xx1[1] / xx1[3]));
print(sprintf("TRAINING STAR: scallop / stringtie = %f", xx1[4] / xx1[5]));
print(sprintf("TRAINING STAR: scallop / transcomb = %f", xx1[4] / xx1[6]));
print(sprintf("TRAINING HISAT: scallop / stringtie = %f", xx1[7] / xx1[8]));

data = read.table(paste(encode10, "test.multi.zero", sep=""));
for (k in seq(1, 8))
{
	xx2[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TESTING TopHat2: scallop / stringtie = %f", xx2[1] / xx2[2]));
print(sprintf("TESTING TopHat2: scallop / transcomb = %f", xx2[1] / xx2[3]));
print(sprintf("TESTING STAR: scallop / stringtie = %f", xx2[4] / xx2[5]));
print(sprintf("TESTING STAR: scallop / transcomb = %f", xx2[4] / xx2[6]));
print(sprintf("TESTING HISAT: scallop / stringtie = %f", xx2[7] / xx2[8]));

xx = xx1 * 0.5 + xx2 * 0.5;
print(sprintf("ALL TopHat2: scallop / stringtie = %f", xx[1] / xx[2]));
print(sprintf("ALL TopHat2: scallop / transcomb = %f", xx[1] / xx[3]));
print(sprintf("ALL STAR: scallop / stringtie = %f", xx[4] / xx[5]));
print(sprintf("ALL STAR: scallop / transcomb = %f", xx[4] / xx[6]));
print(sprintf("ALL HISAT: scallop / stringtie = %f", xx[7] / xx[8]));
print("\n");

## analysis quant (1/3)

print("sensitivity on lower (1/3) expressed transcripts:");
data = read.table(paste(encode10, "train.quant1.zero", sep=""));
for (k in seq(1, 8))
{
	xx1[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TRAINING TopHat2: scallop / stringtie = %f", xx1[1] / xx1[2]));
print(sprintf("TRAINING TopHat2: scallop / transcomb = %f", xx1[1] / xx1[3]));
print(sprintf("TRAINING STAR: scallop / stringtie = %f", xx1[4] / xx1[5]));
print(sprintf("TRAINING STAR: scallop / transcomb = %f", xx1[4] / xx1[6]));
print(sprintf("TRAINING HISAT: scallop / stringtie = %f", xx1[7] / xx1[8]));

data = read.table(paste(encode10, "test.quant1.zero", sep=""));
for (k in seq(1, 8))
{
	xx2[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TESTING TopHat2: scallop / stringtie = %f", xx2[1] / xx2[2]));
print(sprintf("TESTING TopHat2: scallop / transcomb = %f", xx2[1] / xx2[3]));
print(sprintf("TESTING STAR: scallop / stringtie = %f", xx2[4] / xx2[5]));
print(sprintf("TESTING STAR: scallop / transcomb = %f", xx2[4] / xx2[6]));
print(sprintf("TESTING HISAT: scallop / stringtie = %f", xx2[7] / xx2[8]));

xx = xx1 * 0.5 + xx2 * 0.5;
print(sprintf("ALL TopHat2: scallop / stringtie = %f", xx[1] / xx[2]));
print(sprintf("ALL TopHat2: scallop / transcomb = %f", xx[1] / xx[3]));
print(sprintf("ALL STAR: scallop / stringtie = %f", xx[4] / xx[5]));
print(sprintf("ALL STAR: scallop / transcomb = %f", xx[4] / xx[6]));
print(sprintf("ALL HISAT: scallop / stringtie = %f", xx[7] / xx[8]));
print("\n");

## analysis quant (2/3)

print("sensitivity on lower (2/3) expressed transcripts:");
data = read.table(paste(encode10, "train.quant2.zero", sep=""));
for (k in seq(1, 8))
{
	xx1[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TRAINING TopHat2: scallop / stringtie = %f", xx1[1] / xx1[2]));
print(sprintf("TRAINING TopHat2: scallop / transcomb = %f", xx1[1] / xx1[3]));
print(sprintf("TRAINING STAR: scallop / stringtie = %f", xx1[4] / xx1[5]));
print(sprintf("TRAINING STAR: scallop / transcomb = %f", xx1[4] / xx1[6]));
print(sprintf("TRAINING HISAT: scallop / stringtie = %f", xx1[7] / xx1[8]));

data = read.table(paste(encode10, "test.quant2.zero", sep=""));
for (k in seq(1, 8))
{
	xx2[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TESTING TopHat2: scallop / stringtie = %f", xx2[1] / xx2[2]));
print(sprintf("TESTING TopHat2: scallop / transcomb = %f", xx2[1] / xx2[3]));
print(sprintf("TESTING STAR: scallop / stringtie = %f", xx2[4] / xx2[5]));
print(sprintf("TESTING STAR: scallop / transcomb = %f", xx2[4] / xx2[6]));
print(sprintf("TESTING HISAT: scallop / stringtie = %f", xx2[7] / xx2[8]));

xx = xx1 * 0.5 + xx2 * 0.5;
print(sprintf("ALL TopHat2: scallop / stringtie = %f", xx[1] / xx[2]));
print(sprintf("ALL TopHat2: scallop / transcomb = %f", xx[1] / xx[3]));
print(sprintf("ALL STAR: scallop / stringtie = %f", xx[4] / xx[5]));
print(sprintf("ALL STAR: scallop / transcomb = %f", xx[4] / xx[6]));
print(sprintf("ALL HISAT: scallop / stringtie = %f", xx[7] / xx[8]));
print("\n");

## analysis quant (3/3)

print("sensitivity on lower (3/3) expressed transcripts:");
data = read.table(paste(encode10, "train.quant3.zero", sep=""));
for (k in seq(1, 8))
{
	xx1[k] = mean(data[1:5, k * 2 + 0]);
}
print(sprintf("TRAINING TopHat2: scallop / stringtie = %f", xx1[1] / xx1[2]));
print(sprintf("TRAINING TopHat2: scallop / transcomb = %f", xx1[1] / xx1[3]));
print(sprintf("TRAINING STAR: scallop / stringtie = %f", xx1[4] / xx1[5]));
print(sprintf("TRAINING STAR: scallop / transcomb = %f", xx1[4] / xx1[6]));
print(sprintf("TRAINING HISAT: scallop / stringtie = %f", xx1[7] / xx1[8]));

data = read.table(paste(encode10, "test.quant3.zero", sep=""));
for (k in seq(1, 8))
{
	xx2[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TESTING TopHat2: scallop / stringtie = %f", xx2[1] / xx2[4]));
print(sprintf("TESTING TopHat2: scallop / transcomb = %f", xx2[1] / xx2[7]));
print(sprintf("TESTING STAR: scallop / stringtie = %f", xx2[4] / xx2[5]));
print(sprintf("TESTING STAR: scallop / transcomb = %f", xx2[4] / xx2[6]));
print(sprintf("TESTING HISAT: scallop / stringtie = %f", xx2[7] / xx2[8]));

xx = xx1 * 0.5 + xx2 * 0.5;
print(sprintf("ALL TopHat2: scallop / stringtie = %f", xx[1] / xx[2]));
print(sprintf("ALL TopHat2: scallop / transcomb = %f", xx[1] / xx[3]));
print(sprintf("ALL STAR: scallop / stringtie = %f", xx[4] / xx[5]));
print(sprintf("ALL STAR: scallop / transcomb = %f", xx[4] / xx[6]));
print(sprintf("ALL HISAT: scallop / stringtie = %f", xx[7] / xx[8]));
print("\n");


## analysis AUC

auc_vector = function(v)
{
	m = length(v) / 2;
	x1 = 0;
	y1 = v[1];
	auc = 0;
	for(k in 1:m)
	{
		x2 = v[k * 2 - 0];
		y2 = v[k * 2 - 1];
		auc = auc + (y1 + y2) * 0.5 * (x2 - x1);
		x1 = x2;
		y1 = y2;
	}
	return(auc);
}

auc_file = function(file)
{
	data = as.matrix(read.table(file));
	m = length(data[,1]);

	auc = c();
	for(k in 1:m)
	{
		auc[k] = auc_vector(data[k,]);
	}
	return(auc);
}

m = 8;
n = 10;
auc = matrix(nrow = m, ncol = n);
auc[,1]  = auc_file(paste(encode10, "SRR534319", sep=""));
auc[,2]  = auc_file(paste(encode10, "SRR534291", sep=""));
auc[,3]  = auc_file(paste(encode10, "SRR545695", sep=""));
auc[,4]  = auc_file(paste(encode10, "SRR387661", sep=""));
auc[,5]  = auc_file(paste(encode10, "SRR307911", sep=""));
auc[,6]  = auc_file(paste(encode10, "SRR545723", sep=""));
auc[,7]  = auc_file(paste(encode10, "SRR315323", sep=""));
auc[,8]  = auc_file(paste(encode10, "SRR307903", sep=""));
auc[,9]  = auc_file(paste(encode10, "SRR315334", sep=""));
auc[,10] = auc_file(paste(encode10, "SRR534307", sep=""));

print("AUC:");

for (k in seq(1, 8))
{
	xx[k] = sum(auc[k, 1:5]);
}
print(sprintf("TRAINING TopHat2: scallop / stringtie = %f", xx[1] / xx[4]));
print(sprintf("TRAINING TopHat2: scallop / transcomb = %f", xx[1] / xx[7]));
print(sprintf("TRAINING STAR: scallop / stringtie = %f", xx[2] / xx[5]));
print(sprintf("TRAINING STAR: scallop / transcomb = %f", xx[2] / xx[8]));
print(sprintf("TRAINING HISAT: scallop / stringtie = %f", xx[3] / xx[6]));

for (k in seq(1, 8))
{
	xx[k] = sum(auc[k, 6:10]);
}
print(sprintf("TESTING TopHat2: scallop / stringtie = %f", xx[1] / xx[4]));
print(sprintf("TESTING TopHat2: scallop / transcomb = %f", xx[1] / xx[7]));
print(sprintf("TESTING STAR: scallop / stringtie = %f", xx[2] / xx[5]));
print(sprintf("TESTING STAR: scallop / transcomb = %f", xx[2] / xx[8]));
print(sprintf("TESTING HISAT: scallop / stringtie = %f", xx[3] / xx[6]));

for(k in 1:8)
{
	xx[k] = sum(auc[k, 1:10]);
}
print(sprintf("ALL TopHat2: scallop / stringtie = %f", xx[1] / xx[4]));
print(sprintf("ALL TopHat2: scallop / transcomb = %f", xx[1] / xx[7]));
print(sprintf("ALL STAR: scallop / stringtie = %f", xx[2] / xx[5]));
print(sprintf("ALL STAR: scallop / transcomb = %f", xx[2] / xx[8]));
print(sprintf("ALL HISAT: scallop / stringtie = %f", xx[3] / xx[6]));
print("\n");

## summary classes for different number of exons
summary.class <- function(datafile)
{
	data = read.table(paste(encode10, datafile, sep=""));
	n = length(data[,1]) / 19;

	xx = matrix(nrow = 10, ncol = 8);
	yy = matrix(nrow = 10, ncol = 8);
	
	for (k in seq(1, 10))
	{
		for (i in seq(1, 8))
		{
			kk = c();
			for (j in seq(1, n))
			{
				if(k < 10) 
				{
					kk[j] = data[k * 2 * n - 2 * n + j, 1 + 2 * i] + data[k * 2 * n - n + j, 1 + 2 * i];
				}
				else
				{
					kk[j] = data[k * 2 * n - 2 * n + j, 1 + 2 * i];
				}
			}
			xx[k, i] = mean(kk);
			yy[k, i] = sd(kk);
		}
	}
	
	xx = t(xx);
	yy = t(yy);

	print(sprintf("TopHat2: scallop / stringtie = %f", xx[1] / xx[2]));
	print(sprintf("TopHat2: scallop / transcomb = %f", xx[1] / xx[3]));
	print(sprintf("STAR: scallop / stringtie = %f", xx[4] / xx[5]));
	print(sprintf("STAR: scallop / transcomb = %f", xx[4] / xx[6]));
	print(sprintf("HISAT: scallop / transcomb = %f", xx[7] / xx[8]));
}

print("EXON 2-3: TRAINING");
summary.class("train.class.zero");

print("EXON 2-3: TESTING");
summary.class("test.class.zero");
print("\n");


# multi.cuff-exon-cuff default
print("multi-exon-cuff default sensitivity:");

data = read.table(paste(encode10, "train.multi.cuff.default", sep=""));
for (k in seq(1, 8))
{
	xx1[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TRAINING TopHat2: scallop / cufflinks = %f", xx1[1] / xx1[2]));
print(sprintf("TRAINING TopHat2: scallop / stringtie = %f", xx1[1] / xx1[3]));
print(sprintf("TRAINING STAR: scallop / cufflinks = %f", xx1[4] / xx1[5]));
print(sprintf("TRAINING STAR: scallop / stringtie = %f", xx1[4] / xx1[6]));
print(sprintf("TRAINING HISAT: scallop / cufflinks = %f", xx1[7] / xx1[8]));

data = read.table(paste(encode10, "test.multi.cuff.default", sep=""));
for (k in seq(1, 8))
{
	xx2[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("TESTING TopHat2: scallop / cufflinks = %f", xx2[1] / xx2[2]));
print(sprintf("TESTING TopHat2: scallop / stringtie = %f", xx2[1] / xx2[3]));
print(sprintf("TESTING STAR: scallop / cufflinks = %f", xx2[4] / xx2[5]));
print(sprintf("TESTING STAR: scallop / stringtie = %f", xx2[4] / xx2[6]));
print(sprintf("TESTING HISAT: scallop / cufflinks = %f", xx2[7] / xx2[8]));

xx = xx1 * 0.5 + xx2 * 0.5;
print(sprintf("ALL TopHat2: scallop / cufflinks = %f", xx[1] / xx[2]));
print(sprintf("ALL TopHat2: scallop / stringtie = %f", xx[1] / xx[3]));
print(sprintf("ALL STAR: scallop / cufflinks = %f", xx[4] / xx[5]));
print(sprintf("ALL STAR: scallop / stringtie = %f", xx[4] / xx[6]));
print(sprintf("ALL HISAT: scallop / cufflinks = %f", xx[7] / xx[8]));
print("\n");


## analysis time
data = read.table(paste(encode10, "time", sep=""));
cx = c();
for(k in 1:80)
{
	a = t(data[k, 4:12]);
	cx[k] = mean(a);
}
z = matrix(cx, nrow = 8, ncol = 10);

xx = c();
for(k in 1:8)
{
	xx[k] = mean(z[k,]);
}

print("Time:");
print(sprintf("TopHat2: scallop / stringtie = %f", xx[1] / xx[4]));
print(sprintf("TopHat2: transcomb / stringtie = %f", xx[7] / xx[4]));
print(sprintf("STAR: scallop / stringtie = %f", xx[2] / xx[5]));
print(sprintf("STAR: transcomb / stringtie = %f", xx[8] / xx[5]));
print(sprintf("HISAT: scallop / stringtie = %f", xx[3] / xx[6]));
print("\n");

## analysis encode65 
print("encode65:");
data = read.table(paste(encode65, "multi.default.correct3", sep=""));
for (k in seq(1, 3))
{
	xx1[k] = mean(data[, k * 2]);
}
print(sprintf("default.correct3: scallop / stringtie = %f", xx1[1] / xx1[2]));
print(sprintf("default.correct3: scallop / transcomb = %f", xx1[1] / xx1[3]));

data = read.table(paste(encode65, "multi.default.correct2", sep=""));
for (k in seq(1, 2))
{
	xx1[k] = mean(data[, k * 2]);
}
print(sprintf("default.correct2: scallop / stringtie = %f", xx1[1] / xx1[2]));

data = read.table(paste(encode65, "multi.default.precision3", sep=""));
for (k in seq(1, 3))
{
	xx1[k] = mean(data[, k * 2 + 1]);
}
print(sprintf("default.precision3: scallop = %f", xx1[1]));
print(sprintf("default.precision3: stringtie = %f", xx1[2]));
print(sprintf("default.precision3: transcomb = %f", xx1[3]));

data = read.table(paste(encode65, "multi.default.precision2", sep=""));
for (k in seq(1, 2))
{
	xx1[k] = mean(data[, k * 2 + 1]);
}
print(sprintf("default.precision2: scallop = %f", xx1[1]));
print(sprintf("default.precision2: stringtie = %f", xx1[2]));


data = read.table(paste(encode65, "multi.zero.correct3", sep=""));
for (k in seq(1, 3))
{
	xx1[k] = mean(data[, k * 2]);
}
print(sprintf("zero.correct3: scallop / stringtie = %f", xx1[1] / xx1[2]));
print(sprintf("zero.correct3: scallop / transcomb = %f", xx1[1] / xx1[3]));

data = read.table(paste(encode65, "multi.zero.correct2", sep=""));
for (k in seq(1, 2))
{
	xx1[k] = mean(data[, k * 2]);
}
print(sprintf("zero.correct2: scallop / stringtie = %f", xx1[1] / xx1[2]));


data = read.table(paste(encode65, "multi.zero.precision3", sep=""));
for (k in seq(1, 3))
{
	xx1[k] = mean(data[, k * 2 + 1]);
}
print(sprintf("zero.precision3: scallop = %f", xx1[1]));
print(sprintf("zero.precision3: stringtie = %f", xx1[2]));
print(sprintf("zero.precision3: transcomb = %f", xx1[3]));

data = read.table(paste(encode65, "multi.zero.precision2", sep=""));
for (k in seq(1, 2))
{
	xx1[k] = mean(data[, k * 2 + 1]);
}
print(sprintf("zero.precision2: scallop = %f", xx1[1]));
print(sprintf("zero.precision2: stringtie = %f", xx1[2]));
print("\n");


## 4 spike datasets
print("spike-neat default sensitivity:");

data = read.table(paste(sequin, "spike.multi.default", sep=""));
for (k in seq(1, 8))
{
	xx1[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("spike4 TopHat2: scallop / stringtie = %f", xx1[1] / xx1[2]));
print(sprintf("spike4 TopHat2: scallop / transcomb = %f", xx1[1] / xx1[3]));
print(sprintf("spike4 STAR: scallop / stringtie = %f", xx1[4] / xx1[5]));
print(sprintf("spike4 STAR: scallop / transcomb = %f", xx1[4] / xx1[6]));
print(sprintf("spike4 HISAT: scallop / stringtie = %f", xx1[7] / xx1[8]));

data = read.table(paste(sequin, "neat.multi.default", sep=""));
for (k in seq(1, 8))
{
	xx2[k] = mean(data[, k * 2 + 0]);
}
print(sprintf("neat4 TopHat2: scallop / stringtie = %f", xx2[1] / xx2[2]));
print(sprintf("neat4 TopHat2: scallop / transcomb = %f", xx2[1] / xx2[3]));
print(sprintf("neat4 STAR: scallop / stringtie = %f", xx2[4] / xx2[5]));
print(sprintf("neat4 STAR: scallop / transcomb = %f", xx2[4] / xx2[6]));
print(sprintf("neat4 HISAT: scallop / stringtie = %f", xx2[7] / xx2[8]));

print("spike-neat default precision:");

data = read.table(paste(sequin, "spike.multi.default", sep=""));
for (k in seq(1, 8))
{
	xx1[k] = mean(data[, k * 2 + 1]);
}
print(sprintf("spike4 TopHat2:    scallop = %f", xx1[1]));
print(sprintf("spike4 TopHat2:  stringtie = %f", xx1[2]));
print(sprintf("spike4 TopHat2:  transcomb = %f", xx1[3]));
print(sprintf("spike4 STAR:    scallop = %f", xx1[4]));
print(sprintf("spike4 STAR:  stringtie = %f", xx1[5]));
print(sprintf("spike4 STAR:  transcomb = %f", xx1[6]));
print(sprintf("spike4 HISAT:    scallop = %f", xx1[7]));
print(sprintf("spike4 HISAT:  stringtie = %f", xx1[8]));

data = read.table(paste(sequin, "neat.multi.default", sep=""));
for (k in seq(1, 8))
{
	xx1[k] = mean(data[, k * 2 + 1]);
}
print(sprintf("neat4 TopHat2:    scallop = %f", xx1[1]));
print(sprintf("neat4 TopHat2:  stringtie = %f", xx1[2]));
print(sprintf("neat4 TopHat2:  transcomb = %f", xx1[3]));
print(sprintf("neat4 STAR:    scallop = %f", xx1[4]));
print(sprintf("neat4 STAR:  stringtie = %f", xx1[5]));
print(sprintf("neat4 STAR:  transcomb = %f", xx1[6]));
print(sprintf("neat4 HISAT:    scallop = %f", xx1[7]));
print(sprintf("neat4 HISAT:  stringtie = %f", xx1[8]));

# analysis venn.aliger
print("venn aligner:");
data = read.table(paste(encode10, "venn.algo", sep=""));
x = as.matrix(data[,2:18]);
x1 = x[,1] + x[,2] + x[,3] - x[,4] - x[,5] - x[,6] + x[,7];
x2 = x[,8] + x[,9] + x[,10] - x[,11] - x[,12] - x[,13] + x[,14];
x3 = x[,15] + x[,16] - x[,17]

for (k in seq(1, 10))
{
	print(sprintf("TopHat: dataset %d union = %d", k, x1[k]));
}
for (k in seq(1, 10))
{
	print(sprintf("STAR: dataset %d union = %d", k, x2[k]));
}
for (k in seq(1, 10))
{
	print(sprintf("HISAT: dataset %d union = %d", k, x3[k]));
}

print(sprintf("TopHat2: intersection / union = %f", mean(x[,7]) / mean(x1)));
print(sprintf("STAR: intersection / union = %f", mean(x[,14]) / mean(x2)));
print(sprintf("HISAT2: intersection / union = %f", mean(x[,17]) / mean(x3)));


# coverage correlation

acc1 = read.table(paste(encode10, "test.multi.default", sep = ""));
acc2 = read.table(paste(encode10, "train.multi.default", sep = ""));
cov1 = read.table(paste(encode10, "test.cov", sep = ""));
cov2 = read.table(paste(encode10, "train.cov", sep = ""));

cov.th = cov1[,3] / 1000000000;
cov.st = cov1[,7] / 1000000000;
cov.hi = cov1[,11] / 1000000000;
cov.th[6:10] = cov2[,3] / 1000000000;
cov.st[6:10] = cov2[,7] / 1000000000;
cov.hi[6:10] = cov2[,11] / 1000000000;

sc.th = acc1[,2];
st.th = acc1[,4];
tc.th = acc1[,6];
sc.st = acc1[,8];
st.st = acc1[,10];
tc.st = acc1[,12];
sc.hi = acc1[,14];
st.hi = acc1[,16];

sc.th[6:10] = acc2[,2];
st.th[6:10] = acc2[,4];
tc.th[6:10] = acc2[,6];
sc.st[6:10] = acc2[,8];
st.st[6:10] = acc2[,10];
tc.st[6:10] = acc2[,12];
sc.hi[6:10] = acc2[,14];
st.hi[6:10] = acc2[,16];

cov2 = c(cov.th, cov.st);
cov3 = c(cov.th, cov.st, cov.hi);
sc = c(sc.th, sc.st, sc.hi);
st = c(st.th, st.st, st.hi);
tc = c(tc.th, tc.st);

scx = cor(sc, cov3);
stx = cor(st, cov3);
tcx = cor(tc, cov2);


print(sprintf("correlation scallop tophat = %f", cor(sc.th, cov.th)));
print(sprintf("correlation scallop star = %f", cor(sc.st, cov.st)));
print(sprintf("correlation scallop hisat = %f", cor(sc.hi, cov.hi)));

print(sprintf("correlation stringtie tophat = %f", cor(st.th, cov.th)));
print(sprintf("correlation stringtie star = %f", cor(st.st, cov.st)));
print(sprintf("correlation stringtie hisat = %f", cor(st.hi, cov.hi)));

print(sprintf("correlation transcomb tophat = %f", cor(tc.th, cov.th)));
print(sprintf("correlation transcomb star = %f", cor(tc.st, cov.st)));

print(sprintf("coverage correlation with scallop = %f", scx));
print(sprintf("coverage correlation with stringtie = %f", stx));
print(sprintf("coverage correlation with transcomb = %f", tcx));

