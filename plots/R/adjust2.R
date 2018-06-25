plot.correct2 = function(datafile, texfile, maxvalue, pl)
{
	data = read.table(datafile);
	tt = data[,1];
	n = length(tt);
	library(tikzDevice);
	tikz(texfile, width = 3.5, height = 1.25 + 0.33 * n);
	xx = matrix(nrow = 2, ncol = n);
	xx[1,] = t(data[,4]);
	xx[2,] = t(data[,2]);
	par(mar=c(1.1,9.1,3.1,1.1));
	barplot(xx, beside=TRUE, horiz=TRUE, col=c(2,4), xaxt = 'n', yaxt = 'n', ylim = c(-21, 45), xlim = c(0, maxvalue), xlab = "Correct");
	axis(3, tck = -0.025, mgp = c(0, 0.6, 0));
	axis(2, at = seq(1,n) * 3 - 1.0, labels = tt, tick = FALSE, las = 1, mgp = c(0, 0.4, 0));
	mtext("Correct", side = 3, line =2.20);

	dev.off();
}

plot.correct3 = function(datafile, texfile, maxvalue, pl)
{
	data = read.table(datafile);
	tt = data[,1];
	n = length(tt);
	library(tikzDevice);
	tikz(texfile, width = 3.5, height = 1.25 + 0.30 * n);
	xx = matrix(nrow = 3, ncol = n);
	xx[1,] = t(data[,4]);
	xx[2,] = t(data[,6]);
	xx[3,] = t(data[,2]);
	
	par(mar=c(1.1,9.1,3.1,1.1));
	barplot(xx, beside=TRUE, horiz=TRUE, col=c(2,3,4), xaxt = 'n', yaxt = 'n', xlim = c(0, maxvalue), xlab = "Correct");
	axis(3, tck = -0.025, mgp = c(0, 0.6, 0));
	axis(2, at = seq(1,n) * 4 - 1.5, labels = tt, tick = FALSE, las = 1, mgp = c(0, 0.4, 0));
	mtext("Correct", side = 3, line =2.20);


	dev.off();
}

plot.precision2 = function(datafile, texfile, maxvalue, pl)
{
	data = read.table(datafile);
	tt = data[,1];
	n = length(tt);
	library(tikzDevice);
	tikz(texfile, width = 3.5, height = 1.25 + 0.33 * n);
	xx = matrix(nrow = 2, ncol = n);
	xx[1,] = t(data[,5]);
	xx[2,] = t(data[,3]);
	par(mar=c(1.1,9.1,3.1,1.1));
	barplot(xx, beside=TRUE, horiz=TRUE, col=c(2,4), xaxt = 'n', yaxt = 'n', ylim = c(-21, 45), xlim = c(0, maxvalue), xlab = "Adjusted Precision");
	axis(3, tck = -0.025, mgp = c(0, 0.6, 0));
	axis(2, at = seq(1,n) * 3 - 1.0, labels = tt, tick = FALSE, las = 1, mgp = c(0, 0.4, 0));
	mtext("Adjusted Precision", side = 3, line =2.20);


	dev.off();
}

plot.precision3 = function(datafile, texfile, maxvalue, pl)
{
	data = read.table(datafile);
	tt = data[,1];
	n = length(tt);
	library(tikzDevice);
	tikz(texfile, width = 3.5, height = 1.25 + 0.30 * n);
	xx = matrix(nrow = 3, ncol = n);
	xx[1,] = t(data[,5]);
	xx[2,] = t(data[,7]);
	xx[3,] = t(data[,3]);
	
	par(mar=c(1.1,9.1,3.1,1.1));
	barplot(xx, beside=TRUE, horiz=TRUE, col=c(2,3,4), xaxt = 'n', yaxt = 'n', xlim = c(0, maxvalue), xlab = "Adjusted Precision");
	axis(3, tck = -0.025, mgp = c(0, 0.6, 0));
	axis(2, at = seq(1,n) * 4 - 1.5, labels = tt, tick = FALSE, las = 1, mgp = c(0, 0.4, 0));
	mtext("Adjusted Precision", side = 3, line =2.20);


	dev.off();
}

error.bar <- function(x, y, upper, lower=upper, length=0.025, ...)
{
	if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper)) stop("vectors must be same length")
	arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)
}

plot.correct2.summary <- function(datafile, texfile)
{
	data = read.table(datafile);
	
	xx = c();
	yy = c();

	xx[1] = mean(data[, 2]);
	xx[2] = mean(data[, 4]);
	yy[1] = sd(data[, 2]);
	yy[2] = sd(data[, 4]);

	library("tikzDevice");
	tikz(texfile, width = 1.25, height = 3.0);
	q = c(2,1);
	cc = c(2,4);
	maxy=max(xx + yy);
	barx = barplot(xx[q], beside=TRUE, col=cc, ylim=c(0, maxy), space = c(0,0), yaxt = 'n', xaxt = 'n');

#axis(1, at = c(1.0), tick = FALSE, labels = c("unstranded"), mgp = c(0,0.5,0));
	axis(2, mgp = c(0, 0.375, 0.2), tck = -0.05);
	mtext("Correct", 2, line = 1.6);
	error.bar(barx, xx[q], yy[q]);

	dev.off();
}

plot.precision2.summary <- function(datafile, texfile)
{
	data = read.table(datafile);
	
	xx = c();
	yy = c();

	xx[1] = mean(data[, 3]);
	xx[2] = mean(data[, 5]);
	yy[1] = sd(data[, 3]);
	yy[2] = sd(data[, 5]);

	library("tikzDevice");
	tikz(texfile, width = 1.25, height = 3.0);
	q = c(2,1);
	cc = c(2,4);
	maxy=max(xx + yy);
	barx = barplot(xx[q], beside=TRUE, col=cc, ylim=c(0, maxy), space = c(0,0), yaxt = 'n', xaxt = 'n');

#axis(1, at = c(1.0), tick = FALSE, labels = c("unstranded"), mgp = c(0,0.5,0));
	axis(2, mgp = c(0, 0.375, 0.2), tck = -0.05);
	mtext("Adjusted Precision", 2, line = 1.6);
	error.bar(barx, xx[q], yy[q]);
	dev.off();
}

plot.correct3.summary <- function(datafile, texfile)
{
	data = read.table(datafile);
	
	xx = c();
	yy = c();

	xx[1] = mean(data[, 2]);
	xx[2] = mean(data[, 4]);
	xx[3] = mean(data[, 6]);
	yy[1] = sd(data[, 2]);
	yy[2] = sd(data[, 4]);
	yy[3] = sd(data[, 6]);

	library("tikzDevice");
	tikz(texfile, width = 1.36, height = 3.0);
	q = c(2,3,1);
	cc = c(2,3,4);
	maxy=max(xx + yy);
	barx = barplot(xx[q], beside=TRUE, col=cc, ylim=c(0, maxy), space = c(0,0), yaxt = 'n', xaxt = 'n');

#axis(1, at = c(1.0), tick = FALSE, labels = c("stranded"), mgp = c(0,0.5,0));
	axis(2, mgp = c(0, 0.375, 0.2), tck = -0.05);
	mtext("Correct", 2, line = 1.6);
	error.bar(barx, xx[q], yy[q]);

	dev.off();
}

plot.precision3.summary <- function(datafile, texfile)
{
	data = read.table(datafile);
	
	xx = c();
	yy = c();

	xx[1] = mean(data[, 3]);
	xx[2] = mean(data[, 5]);
	xx[3] = mean(data[, 7]);
	yy[1] = sd(data[, 3]);
	yy[2] = sd(data[, 5]);
	yy[3] = sd(data[, 7]);

	library("tikzDevice");
	tikz(texfile, width = 1.36, height = 3.0);
	q = c(2,3,1);
	cc = c(2,3,4);
	maxy=max(xx + yy);
	barx = barplot(xx[q], beside=TRUE, col=cc, ylim=c(0, maxy), space = c(0,0), yaxt = 'n', xaxt = 'n');

#axis(1, at = c(1.0), tick = FALSE, labels = c("stranded"), mgp = c(0,0.5,0));
	axis(2, mgp = c(0, 0.375, 0.2), tck = -0.05);
	mtext("Adjusted Precision", 2, line = 1.6);
	error.bar(barx, xx[q], yy[q]);

	dev.off();
}
