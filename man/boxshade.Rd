\name{boxshade}
\alias{boxshade}
\alias{box}
\alias{boxshade_help}
\title{
Boxshade: Shading Multiple Aligned Sequences}
\description{
Executes boxshade on a multiple sequence alignment.
}
\usage{
boxshade(x, file, dev="pdf", param="-thr=0.5 -cons -def",
    pdfCrop=TRUE)
boxshade_help()
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{a multiple alignment as an object of class
  DNAMultipleAlignment, RNAMultipleAlignment or AAMultipleAlignment.}
  \item{file}{output file}
  \item{dev}{used output device. Available are: ps, eps, hpgl, rtf, crt, ansi,
    vt, ascii, fig, pict, html and pdf.}
  \item{param}{character string with the command line parameters for clustal (see output of \code{boxshade_help()}).}
  \item{pdfCrop}{crop the pdf file if it is smaller than a page. Use
  \code{FALSE} if you want the results on a page or the
  alignment covers multiple pages.}
}
\details{
The boxshade software has to be installed (see \link{rMSA_INSTALL}).
}
\value{
Only a file is created.
}
\references{
Boxshade has been written by Kay Hofmann and Michael D. Baron
}
\examples{
\dontrun{
rna <- readRNAStringSet(system.file("examples/RNA_example.fasta",
	package="rMSA"))
rna <- narrow(rna, start=1, end=50)

al <- clustal(rna)

boxshade(al, file="alignment.pdf", dev="pdf")
}
}
\keyword{model}
