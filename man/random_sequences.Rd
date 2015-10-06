\name{random_sequences}
\alias{random_sequences}
\title{
Create a Set of Random Sequences
}
\description{
Creates a set of random DNA, RNA or AA sequences.
}
\usage{
random_sequences(len, number=1, prob=NULL, type=c("DNA", "RNA", "AA"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{len}{sequence length}
  \item{number}{number of sequences in the set}
  \item{prob}{a named vector with letter probabilities or a transition
              probability matrix (as produced by
              \code{\link{oligonucleotideTransitions}}).
              4 letters for DNA and RNA and 20
              for AA (see \code{DNA_BASES}, \code{RNA_BASES} and the first 20
              letters in \code{AA_ALPHABET}). }
  \item{type}{sequence type}
}
%\details{
%}
\value{
A XStringSet.
}
\examples{
### create random sequences (using given letter frequencies)
seqs <- random_sequences(100, number=10, prob=c(a=.5, c=.3, g=.1, t=.1))
seqs

### check letter frequencies
summary(oligonucleotideFrequency(seqs, width=1, as.prob=TRUE))

### creating random sequences using a random dinocleodite transition matrix
prob <-  matrix(runif(16), nrow=4, ncol=4, dimnames=list(DNA_BASES, DNA_BASES))
prob <- prob/rowSums(prob)

seqs <- random_sequences(100, number=10, prob=prob)
seqs

### check dinocleodite transition probabilities
prob
oligonucleotideTransitions(seqs, as.prob=TRUE)
}
\keyword{model}
