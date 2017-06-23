plot.legend = function(texfile)
{
	library("tikzDevice");
	tikz(texfile);
	plot(-1, -1, xlim=c(0,1), ylim=c(0,1), xaxt='n',yaxt='n',bty='n',ylab="",xlab="");
	legend(0, 1, c("StringTie", "TransComb","Scallop", "", "TopHat2 (TH)", "STAR (ST)", "HISAT2 (HI)"), pch = c(19,19,19,0,0,1,2), col = c(2,3,4,"white",1,1,1), bty='n');
	dev.off();
}

plot.cuff.legend = function(texfile)
{
	library("tikzDevice");
	tikz(texfile);
	plot(-1, -1, xlim=c(0,1), ylim=c(0,1), xaxt='n',yaxt='n',bty='n',ylab="",xlab="");
	legend(0, 1, c("Cufflinks", "Scallop"), pch = c(19,19), col = c(6,4), bty='n');
	dev.off();
}
