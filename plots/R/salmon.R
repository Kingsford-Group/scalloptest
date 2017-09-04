plot.salmon = function(datafile, texfile)
{
	data = read.table(datafile)
	xx = matrix(nrow = 3, ncol = 10);
	xx[1,] = t(data[,3] / data[,2] * 100);
	xx[2,] = t(data[,5] / data[,4] * 100);
	xx[3,] = t(data[,7] / data[,6] * 100);

	tt = c("ST1", "ST2", "ST3", "TC1", "TC2", "SC1", "SC2", "SC3", "SC4", "SC5");
	cc = c(2,3,4);
	
	library("tikzDevice");
	tikz(texfile, width = 6, height = 4.0);
	
	barx <- barplot(xx, beside=TRUE, col=cc, ylim=c(0, max(xx) * 1.1), names.arg = tt, ylab="Ratio of Predicted Transcripts");
	legend(8, max(xx) * 1.1, c("TopHat2", "STAR","HISAT2"), fill=c(2,3,4), bty = 'n');
	
	dev.off();
}
