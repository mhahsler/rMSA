\name{MUSCLE}
\alias{muscle}
\alias{muscle_help}
\title{
Run Multiple Sequence Alignment (MUSCLE) on a Set of Sequences
}
\description{
Executes MUSLCE on a set of sequences to obtain a multiple sequence
alignment.
}
\usage{
muscle(x, param="")
muscle_help()
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{an object of class XStringSet (e.g., DNAStringSet) with the sequences to be aligned.}
  \item{param}{character string with the command line parameters (see output of \code{musce_help()}).}

}
\details{
The MUSCLE software has to be installed (see \link{rMSA_INSTALL}).
}
\value{
An object of class DNAMultipleAlignment (see \pkg{BioStrings}).
}
\references{
Edgar, R.C. (2004) MUSCLE: multiple sequence alignment with high accuracy and high throughput, Nucleic Acids Res. 32(5):1792-1797

Edgar, R.C. (2004) MUSCLE: a multiple sequence alignment method with reduced time and space complexity, BMC Bioinformatics, (5) 113
}
\examples{
\dontrun{
### DNA
dna <- readDNAStringSet(system.file("examples/DNA_example.fasta",
	package="rMSA"))
dna

al <- muscle(dna)
al

### inspect alignment
detail(al)

### plot a sequence logo for the first 20 positions
plot(al, 1, 20)

### RNA
rna <- readRNAStringSet(system.file("examples/RNA_example.fasta",
	package="rMSA"))
rna

al <- MUSCLE(rna)
al

### Proteins
aa <- readAAStringSet(system.file("examples/Protein_example.fasta",
	package="rMSA"))
aa

al <- MUSCLE(aa)
al
}
}
\keyword{model}
