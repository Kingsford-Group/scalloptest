error.bar <- function(x, y, upper, lower=upper, length=0.022, ...)
{
	if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper)) stop("vectors must be same length")
	arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)
}

plot.time = function(datafile, texfile)
{
	data = read.table(datafile)
	cx = c();
	cy = c();
	for(k in 1:80)
	{
		a = t(data[k, 4:12]) / 60;
		cx[k] = mean(a);
		cy[k] = sd(a);
	}
	xx = matrix(cx, nrow = 8, ncol = 10);
	yy = matrix(cy, nrow = 8, ncol = 10);
	tt = c("ST1", "ST2", "ST3", "TC1", "TC2", "SC1", "SC2", "SC3", "SC4", "SC5");
	
	pp = c(4,7,1,  5,8,2,  6,3);
	cc = c(2,3,4,  2,3,4,  2,4);
	ss = matrix(nrow = 8, ncol = 10);
	for(k in 1:10)
	{
		ss[,k] = c(1.0,0,0,0.5,0,0,0.5,0);
	}
	
	library("tikzDevice");
	tikz(texfile, width = 9, height = 5.0);
	
	barx <- barplot(xx[pp,], beside=TRUE, col=cc, ylim=c(0, max(xx + yy)), names.arg = tt, ylab="CPU Time (Minutes)", space = ss);
	error.bar(barx, xx[pp,], yy[pp,])
	legend(40, max(xx), c("StringTie", "TransComb","Scallop"), fill=c(2,3,4), bty = 'n');
	
	dev.off();
}
