\name{mafft}
\alias{mafft}
\alias{mafft_help}
\title{
Run Multiple Sequence Alignment (MAFFT) on a Set of Sequences
}
\description{
Executes mafft on a set of sequences to obtain a multiple sequence
alignment.
}
\usage{
mafft(x, param="--auto")
mafft_help()
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{an object of class XStringSet (e.g., DNAStringSet) with the sequences to be aligned.}
  \item{param}{character string with the command line parameters (see output of \code{mafft_help()}).}

}
\details{
The MAFFT software has to be installed (see \link{rMSA_INSTALL}).
}
\value{
An object of class DNAMultipleAlignment (see \pkg{BioStrings}).
}
\references{
Katoh, Standley 2013 (Molecular Biology and Evolution 30:772-780)
MAFFT multiple sequence alignment software version 7: improvements in performance and usability.
}
\examples{
\dontrun{
### DNA
dna <- readDNAStringSet(system.file("examples/DNA_example.fasta",
	package="rMSA"))
dna

al <- mafft(dna)
al

### inspect alignment
detail(al)

### plot a sequence logo for the first 20 positions
plot(al, 1, 20)

### RNA
rna <- readRNAStringSet(system.file("examples/RNA_example.fasta",
	package="rMSA"))
rna

al <- mafft(rna)
al

### Proteins
aa <- readAAStringSet(system.file("examples/Protein_example.fasta",
	package="rMSA"))
aa

al <- mafft(aa)
al
}
}
\keyword{model}
