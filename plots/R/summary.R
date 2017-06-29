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
