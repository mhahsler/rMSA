\name{dist}
\alias{distNSV}
\alias{distSimRank}
\alias{distApe}
\alias{distKMer}
\alias{distCV}
\alias{distFFP}
\alias{distEdit}
\alias{distAlignment}
\title{
Calculate Distances between Sets of Sequences
}
\description{
Implements different methods to calculate distance between sets of sequences
based on k-mer distribution, edit distance/alignment or evolutionary distance.

}
\usage{
# k-mer-based methods
distFFP(x, k=3, method="JSD", normalize=TRUE)
distCV(x, k=3)
distNSV(x, k=3, method="Manhattan", normalize=FALSE)
distKMer(x, k=3)
distSimRank(x, k=7)

# edit distance/alignment
distEdit(x)
distAlignment(x, substitutionMatrix=NULL, ...)

# evolutionary distance
distApe(x, model="K80" ,...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{an object of class XStringSet containing the sequences. For
    \code{distApe}, \code{x} needs to be a multiple sequence alignment.}
  \item{k}{size of used k-mers.}
  \item{method}{metric used to calculate the dissimilarity between two
  k-mer frequency distributions. }
  \item{substitutionMatrix}{matrix with substitution scores
  (defaults to a matrix with match=1, mismatch=0)}
  \item{normalize}{normalize the k-mer frequencies by the total number of
                   k-mers in the sequence.}
  \item{model}{evolutionary model used.}
  \item{...}{further arguments passed on.}

}
\details{
\itemize{
\item{\emph{Feature frequency profile} (\code{distFFP}): A FFP is the
normalized (by the number of k-mers in the sequence) count of each possible
k-mer in a sequence. The distance is defined
as the Jensen-Shannon divergence (JSD) between FFPs (Sims and Kim, 2011).}

\item{\emph{Composition Vector} (\code{distCV}): A CV is a vector with the
frequencies of each k-mer in the sequency minus the expected frequency
of random background of neutral mutations obtained from a Markov Model.
The cosine distance is used between CVs. (Qi et al, 2007).}

\item{\emph{Numerical Summarization Vector} (\code{distNSV}): An NSV is
frequency distribution of all possible k-mers in a sequence.
The Manhattan distance is used between NSVs (Nagar and Hahsler, 2013).}

\item{\emph{Distance between sets of k-mers} (\code{distkMer}): Each
sequence is represented as a set of k-mers. The Jaccard (binary) distance is
used between sets (number of unique shared k-mers over the total number of
unique k-mers in both sequences).}

\item{\emph{Distance based on SimRank} (\code{distSimRank}): 1-simRank
(see \code{simRank}).}

\item{\emph{Edit (Levenshtein) Distance} (\code{distEdit}): Edit distance
between sequences.}

\item{\emph{Distance based on alignment score} (\code{distAlignment}):
see \code{\link[Biostrings]{stringDist}} in \pkg{Biostrings}.}

\item{\emph{Evolutionary distances} (\code{distApe}):
see \code{\link[ape]{dist.dna}} in \pkg{ape}.}
}
}
\value{
A dist object.
}
\references{
Sims, GE; Kim, SH (2011 May 17). "Whole-genome phylogeny of Escherichia coli/Shigella group by feature frequency profiles (FFPs).". Proceedings of the National Academy of Sciences of the United States of America 108 (20): 8329-34. PMID 21536867.

Gao, L; Qi, J (2007 Mar 15). "Whole genome molecular phylogeny of large dsDNA viruses using composition vector method.". BMC evolutionary biology 7: 41. PMID 17359548.

Qi J, Wang B, Hao B: Whole Proteome Prokaryote Phylogeny
without Sequence Alignment: A K-String Composition
Approach. Journal of Molecular Evolution 2004, 58:1-11.

Anurag Nagar; Michael Hahsler (2013). "Fast discovery and visualization of conserved regions in DNA sequences using quasi-alignment." BMC Bioinformatics, 14(Suppl. 11), 2013
}
\examples{
s <- mutations(random_sequences(100), 100)
s

### calculate NSV distance
dNSV <- distNSV(s)

### relationship with edit distance
dEdit <- distEdit(s)

df <- data.frame(dNSV=as.vector(dNSV), dEdit=as.vector(dEdit))
plot(sapply(df, jitter), cex=.1)
### add lower bound (2*k, for Manhattan distance)
abline(0,1/(2*3), col="red", lwd=2)
### add regression line
abline(lm(dEdit~dNSV, data=df), col="blue", lwd=2)

### check correlation
cor(dNSV,dEdit)
}
\keyword{model}
