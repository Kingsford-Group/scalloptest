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

auc_file = function(file, outfile)
{
	data = as.matrix(read.table(file));
	m = length(data[,1]);

	auc = c();
	for(k in 1:m)
	{
		auc[k] = auc_vector(data[k,]);
	}
	write(auc, outfile, append = TRUE, ncolumns = 100);
	return(auc);
}

error.bar <- function(x, y, upper, lower=upper, length=0.025, ...)
{
	if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper)) stop("vectors must be same length")
	arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)
}

draw.plot <- function(file, ylabel, xx, yy)
{
	library("tikzDevice");
	tikz(file, width = 1.4, height = 3.6);
	q = c(6,3);
	cc = c(2,4);
	maxy=max(xx + yy);
	#mgp = c(1.7,0.6,0), 
	barx = barplot(xx[q], beside=TRUE, col=cc, ylim=c(0, maxy), space = c(0.0,0), xaxt = 'n', yaxt = 'n');
#axis(1, at = c(1.5, 5.0, 8.0), tick = FALSE, labels = c("TH", "ST", ""), mgp = c(0, 0.5, 0));
#axis(1, at = c(1.5, 5.0, 8.0), tick = FALSE, labels = c("", "", "HI"), mgp = c(0, 0.5, 0));
	axis(2, tck = -0.05, mgp = c(0, 0.275, 0));
	mtext(ylabel, 2, line = 1.3);
	error.bar(barx, xx[q], yy[q]);
	legend(10, maxy, c("StringTie(TopHat2, STAR, HISAT2)", "TransComb(TopHat2, STAR)","Scallop(TopHat2, STAR, HISAT2)"), fill=c(2,3,4));
	dev.off();
}

plot.auc = function(aucfile, texfile)
{
	auc = t(as.matrix(read.table(aucfile)));
	m = length(auc[,1]);
	n = length(auc[1,]);

	# for training set
	xx = c();
	yy = c();
	for (k in seq(1, m))
	{
		xx[k] = mean(auc[k,]);
		yy[k] = sd(auc[k,]);
	}
	draw.plot(texfile, "AUC", xx, yy);
}
