plot.cov = function(accfile1, accfile2, covfile1, covfile2, texfile)
{
	library("tikzDevice");
	tikz(texfile, width = 8, height = 5);
	acc1 = read.table(accfile1);
	acc2 = read.table(accfile2);
	cov1 = read.table(covfile1);
	cov2 = read.table(covfile2);
	
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
	
	xmax = max(cov.th, cov.st, cov.hi);
	xmin = min(cov.th, cov.st, cov.hi);
	
	ymax = max(sc.th, sc.st, sc.hi, st.th, st.st, st.hi, tc.th, tc.st);
	ymin = min(sc.th, sc.st, sc.hi, st.th, st.st, st.hi, tc.th, tc.st);
	
	plot(-1, -1, xlim = c(xmin, xmax), ylim = c(ymin, ymax), xlab = "Aligned Base Pairs", ylab = "Correct Transcripts");
	
	points(cov.th, sc.th, col = 4, pch = 15, cex = 0.95);
	points(cov.th, st.th, col = 2, pch = 15, cex = 0.95);
	points(cov.th, tc.th, col = 3, pch = 15, cex = 0.95);
	
	points(cov.st, sc.st, col = 4, pch = 16, cex = 1.05);
	points(cov.st, st.st, col = 2, pch = 16, cex = 1.05);
	points(cov.st, tc.st, col = 3, pch = 16, cex = 1.05);
	
	points(cov.hi, sc.hi, col = 4, pch = 17, cex = 0.95);
	points(cov.hi, st.hi, col = 2, pch = 17, cex = 0.95);

	legend(5, ymax, c("StringTie", "TransComb", "Scallop"), fill=c(2,3,4), bty = 'n');
	legend(12, ymax, c("TopHat2", "STAR", "HISAT2"), pch = c(0,1,2), bty = 'n');

	dev.off();
}
