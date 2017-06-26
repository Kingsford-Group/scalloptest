error.bar <- function(x, y, upper, lower=upper, length=0.02, ...)
{
	if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper)) stop("vectors must be same length")
	arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)
}

plot.class <- function(datafile, texfile)
{
	data = read.table(datafile);
	
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

	ymin = min(xx - yy);
	ymax = max(xx + yy);
	
	#cc = c(2,2,2,3,3,4,4,4);
	#pp = c(4,5,6,7,8,1,2,3);
	
	tt = c("2-3", "4-5", "6-7", "8-9", "10-11", "12-13", "14-15", "16-17", "18-19", "20");
#pp = c(4,7,1,  5,8,2,  6,3);
	pp = c(2,3,1,  5,6,4,  8,7); 
	cc = c(2,3,4,  2,3,4,  2,4);
	ss = matrix(nrow = 8, ncol = 10);
	for(k in 1:10)
	{
		ss[,k] = c(1.0,0,0,0.5,0,0,0.5,0);
	}
	
	#pdf("class0.pdf", width = 10.0, height = 6.0);
	library("tikzDevice");
	tikz(texfile, width = 10.36, height = 2.9);
	
	#par(mar=c(2.5,4.1,0.4,1.0));
	#barx <- barplot(xx[pp,], beside=TRUE, col=cc, ylim=c(0, ymax), names.arg = tt, ylab="Correct Transcripts", space = c(0,0,0,0.5,0,0.5,0,0));
	barx <- barplot(xx[pp,], beside=TRUE, col=cc, ylim=c(0, ymax), names.arg = tt, space = ss, mgp = c(0, 0.5, 0), yaxt = 'n');
	axis(2, mgp = c(0, -0.7, -1.7), tck = -0.03);
	mtext("Correct Transcripts", 2, line =-0.20);
	error.bar(barx, xx[pp,], yy[pp,])
	legend(60, max(xx + yy), c("StringTie", "TransComb","Scallop"), pch = c(19,19,19), col = c(2,3,4),bty='n');
#legend(60, max(xx + yy), c("TopHat2", "STAR", "HISAT2"), pch = c(0,1,2), col = c(1,1,1),bty='n');
	
	dev.off();
}
