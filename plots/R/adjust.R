plot.correct2 = function(datafile, texfile, maxvalue)
{
	library(tikzDevice);
	tikz(texfile, width = 3.5, height = 7);
	data = read.table(datafile);
	tt = data[,1];
	n = length(tt);
	xx = matrix(nrow = 2, ncol = n);
	xx[1,] = t(data[,4]);
	xx[2,] = t(data[,2]);
	par(mar=c(1.1,9.1,3.1,1.1));
	barplot(xx, beside=TRUE, horiz=TRUE, col=c(2,4), xaxt = 'n', yaxt = 'n', ylim = c(-21, 45), xlim = c(0, maxvalue), xlab = "Correct Transcripts");
	axis(3, tck = -0.025, mgp = c(0, 0.6, 0));
	axis(2, at = seq(1,n) * 3 - 1.0, labels = tt, tick = FALSE, las = 1, mgp = c(0, 0.4, 0));
	mtext("Correct Transcripts", side = 3, line =2.20);
	legend(0, -5, c("StringTie", "TransComb", "Scallop"), fill = c(2,3,4));
	dev.off();
}

plot.correct3 = function(datafile, texfile, maxvalue)
{
	library(tikzDevice);
	tikz(texfile, width = 3.5, height = 7);
	data = read.table(datafile);
	tt = data[,1];
	n = length(tt);
	xx = matrix(nrow = 3, ncol = n);
	xx[1,] = t(data[,4]);
	xx[2,] = t(data[,6]);
	xx[3,] = t(data[,2]);
	
	par(mar=c(1.1,9.1,3.1,1.1));
	barplot(xx, beside=TRUE, horiz=TRUE, col=c(2,3,4), xaxt = 'n', yaxt = 'n', xlim = c(0, maxvalue), xlab = "Correct Transcripts");
	axis(3, tck = -0.025, mgp = c(0, 0.6, 0));
	axis(2, at = seq(1,n) * 4 - 1.5, labels = tt, tick = FALSE, las = 1, mgp = c(0, 0.4, 0));
	mtext("Correct Transcripts", side = 3, line =2.20);
	dev.off();
}

plot.precision2 = function(datafile, texfile, maxvalue)
{
	library(tikzDevice);
	tikz(texfile, width = 3.5, height = 7);
	data = read.table(datafile);
	tt = data[,1];
	n = length(tt);
	xx = matrix(nrow = 2, ncol = n);
	xx[1,] = t(data[,5]);
	xx[2,] = t(data[,3]);
	par(mar=c(1.1,9.1,3.1,1.1));
	barplot(xx, beside=TRUE, horiz=TRUE, col=c(2,4), xaxt = 'n', yaxt = 'n', ylim = c(-21, 45), xlim = c(0, maxvalue), xlab = "Adjusted Precision");
	axis(3, tck = -0.025, mgp = c(0, 0.6, 0));
	axis(2, at = seq(1,n) * 3 - 1.0, labels = tt, tick = FALSE, las = 1, mgp = c(0, 0.4, 0));
	mtext("Adjusted Precision", side = 3, line =2.20);
	legend(0, -5, c("StringTie", "TransComb", "Scallop"), fill = c(2,3,4));
	dev.off();
}

plot.precision3 = function(datafile, texfile, maxvalue)
{
	library(tikzDevice);
	tikz(texfile, width = 3.5, height = 7);
	data = read.table(datafile);
	tt = data[,1];
	n = length(tt);
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
