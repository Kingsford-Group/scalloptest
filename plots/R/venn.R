plot.venn = function(datafile)
{
	library("tikzDevice");
	library("VennDiagram");
	
	x = read.table(datafile)
	
	len = length(x[,1]);
	for (k in seq(1, len))
	{
		ff = paste("venn-tophat-", k, ".tex", sep="");
		tikz(ff, width = 1.0, height = 1.0);
		xx = x[k, seq(2,8)];
		xx = xx[1, c(2,3,1,6,4,5,7)];
	
		sum = xx[1,1] + xx[1,2] + xx[1,3] - xx[1,4] - xx[1,5] - xx[1,6] + xx[1,7];
		print(paste(ff, sum));
	
		xx = floor(xx / sum * 100);
		#cc = c("skyblue", "pink1", "mediumorchid");
		cc = c(2,3,4);
		draw.triple.venn(area1 = xx[1,1], area2 = xx[1,2], area3 = xx[1,3], n12 = xx[1,4], n13 = xx[1,5], n23 = xx[1,6], n123 = xx[1,7], fill = cc, lty = "blank", scaled = TRUE);
		dev.off();
	
	
		ff = paste("venn-star-", k, ".tex", sep="");
		tikz(ff, width = 1.0, height = 1.0);
		xx = x[k, seq(9,15)];
		xx = xx[1, c(2,3,1,6,4,5,7)];
	
		sum = xx[1,1] + xx[1,2] + xx[1,3] - xx[1,4] - xx[1,5] - xx[1,6] + xx[1,7];
		print(paste(ff, sum));
	
		xx = floor(xx / sum * 100);
		#cc = c("skyblue", "pink1", "mediumorchid");
		cc = c(2,3,4);
		draw.triple.venn(area1 = xx[1,1], area2 = xx[1,2], area3 = xx[1,3], n12 = xx[1,4], n13 = xx[1,5], n23 = xx[1,6], n123 = xx[1,7], fill = cc, lty = "blank");
		dev.off();
	
	
		ff = paste("venn-hisat-", k, ".tex", sep="");
		tikz(ff, width = 0.9, height = 0.9);
		xx = x[k, seq(16,18)];
		xx = xx[1, c(2,1,3)];
	
		sum = xx[1,1] + xx[1,2] - xx[1,3];
		print(paste(ff, sum));
	
		xx = floor(xx / sum * 100);
		#cc = c("skyblue", "pink1", "mediumorchid");
		cc = c(2,4);
		draw.pairwise.venn(area1 = xx[1,1], area2 = xx[1,2], cross.area = xx[1,3], fill = cc, lty = "blank");
		dev.off();
	}
}
