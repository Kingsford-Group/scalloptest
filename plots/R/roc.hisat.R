plot.roc = function(file, tt, texfile, flag, legendx, legendy)
{
	x = read.table(file);

	m = length(x[,1]);
	n = length(x[1,]);
	cols = c(4,4,4,2,2,2,3,3);
	cexs = c(0.8,0.8,0.75,0.8,0.8,0.75,0.8,0.8);
#pchs = c(22,21,24,22,21,24,22,21);
#pchs = c(0,1,2,0,1,2,0,1);
#pchs = c(15,16,17,15,16,17,15,16);
	pchs = c(16,16,16,16,16,16,16,16);
	fcol = c(2,3,4,5,6,7,8,9);
	p = seq(1, n / 2) * 2 - 0;
	q = seq(1, n / 2) * 2 - 1;

	xmin = min(x[,p]);
	xmax = max(x[,p]);
	ymin = min(x[,q]);
	ymax = max(x[,q]) - 0.05;

	library("tikzDevice");
	tikz(texfile, width = 2.4, height = 2.4);
	
#pdf("test.pdf");

	par(las=1);
	par(mar=c(3.1,3.1,1,1));
#plot(-1, -1, xlim = c(xmin, xmax), ylim = c(ymin, ymax), xlab = "Precision", ylab = "Sensitivity", main = tt);
	plot(-1, -1, xlim = c(xmin, xmax), xaxt="n",yaxt="n", ylim = c(ymin, ymax));
	axis(2, mgp=c(3, 0.3, 0.0), tck = -0.015);
	axis(1, mgp=c(3, 0.2, 0.0), tck = -0.015);
	mtext("Precision", 1, line =1.20);

	if(flag == 1)
	{
		mtext("Sensitivity", las = 3, side = 2, line =1.20, outer = FALSE);
	}

	for (k in c(3,6))
	{
		a = x[k, p];
		b = x[k, q];
		lines(t(a), t(b), col = cols[k]);
		points(t(a), t(b), col = cols[k], pch = pchs[k], cex = cexs[k]);
	}

# circle default parameters

	a = x[2, 4];
	b = x[2, 3];
#points(t(a), t(b), col = 4, pch = c(1,1,1), cex = c(1.2,1.2,1.2));

	a = x[5, 6];
	b = x[5, 5];
#points(t(a), t(b), col = 2, pch = c(1,1,1), cex = c(1.2,1.2,1.2));

	a = x[8, 2];
	b = x[8, 1];
#points(t(a), t(b), col = 3, pch = c(1,1), cex = c(1.2,1.2));

#legend((xmax - xmin) * legendx + xmin, (ymax - ymin) * legendy + ymin, tt, bty = 'n');
	dev.off();
}
