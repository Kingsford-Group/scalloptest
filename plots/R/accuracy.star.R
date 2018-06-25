error.bar <- function(x, y, upper, lower=upper, length=0.025, ...)
{
	if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper)) stop("vectors must be same length")
	arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)
}

plot.bar <- function(xx, yy, file, ylabel)
{
	library("tikzDevice");
	#tikz(file, width = 2.7, height = 3.0);
	tikz(file, width = 1.5, height =3.2);
	q = c(6,5,4);
	cc = c(3,2,4);
	maxy=max(xx + yy);
	barx = barplot(xx[q], beside=TRUE, col=cc, ylim=c(0, maxy), space = c(0,0,0), yaxt = 'n', xaxt = 'n');

	#axis(1, at = c(1.5, 5.0, 8.0), tick = FALSE, labels = c("TH", "ST", ""), mgp = c(0,0.5,0));
	#axis(1, at = c(1.5, 5.0, 8.0), tick = FALSE, labels = c("", "", "HI"), mgp = c(0,0.5,0));

	axis(2, mgp = c(0, 0.275, 0), tck = -0.05);
	mtext(ylabel, 2, line = 1.3);
	#axis(1, at = c(1.5, 5.5, 9.0), tick = FALSE, labels = c("TopHat", "STAR", "HISAT"), line = -0.5);
	#axis(1, at = c(4.5), tick = FALSE, labels = c(xlabel), line = -0.5);
	#axis(2, seq(0, maxy, by=10))
	error.bar(barx, xx[q], yy[q]);
	#legend(10, maxy, c("StringTie(TopHat2, STAR, HISAT2)", "TransComb(TopHat2, STAR)","Scallop(TopHat2, STAR, HISAT2)"), fill=c(2,3,4));
	dev.off();
}

plot.bar2 <- function(xx, yy, file, ylabel)
{
	library("tikzDevice");
	tikz(file, width = 1.8, height = 3.0);
	q = c(2,1, 5,4, 8,7);
	cc = c(6,4,  6,4,  6,4);
	maxy=max(xx + yy);
	barx = barplot(xx[q], beside=TRUE, col=cc, ylim=c(0, maxy), space = c(0,0,0.5,0,0.5,0), yaxt = 'n', xaxt = 'n');

	axis(1, at = c(1.0, 3.5, 6.0), tick = FALSE, labels = c("TH", "", ""), mgp = c(0,0.5,0));
	axis(1, at = c(1.0, 3.5, 6.0), tick = FALSE, labels = c("", "ST", ""), mgp = c(0,0.5,0));
	axis(1, at = c(1.0, 3.5, 6.0), tick = FALSE, labels = c("", "", "HI"), mgp = c(0,0.5,0));

	axis(2, mgp = c(0, 0.275, 0), tck = -0.05);
	mtext(ylabel, 2, line = 1.3);
	error.bar(barx, xx[q], yy[q]);
	dev.off();
}

plot.accuracy <- function(datafile, texfile1, texfile2)
{
	data = read.table(datafile);
	
	xx = c();
	yy = c();
	
	for (k in seq(1, 8))
	{
		xx[k] = mean(data[, k * 2 + 0] / 1000);
		yy[k] = sd(data[, k * 2 + 0] / 1000);
	}
	plot.bar(xx, yy, texfile1, "Correct");

	for (k in seq(1, 8))
	{
		xx[k] = mean(data[, k * 2 + 1]);
		yy[k] = sd(data[, k * 2 + 1]);
	}
	plot.bar(xx, yy, texfile2, "Precision");
}


plot.accuracy2 <- function(datafile, texfile1, texfile2)
{
	data = read.table(datafile);
	
	xx = c();
	yy = c();
	
	for (k in seq(1, 8))
	{
		xx[k] = mean(data[, k * 2 + 0]);
		yy[k] = sd(data[, k * 2 + 0]);
	}
	plot.bar2(xx, yy, texfile1, "Correct Transcripts");

	for (k in seq(1, 8))
	{
		xx[k] = mean(data[, k * 2 + 1]);
		yy[k] = sd(data[, k * 2 + 1]);
	}
	plot.bar2(xx, yy, texfile2, "Precision");
}
