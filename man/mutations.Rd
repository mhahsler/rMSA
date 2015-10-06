\name{mutations}
\alias{mutations}
\title{
Creates Random Mutations of a Sequence
}
\description{
Creates a set of sequences which are random mutations (with base changes,
insertions and deletions) for a given DNA, RNA or AA sequence.
}
\usage{
mutations(x, number=1, change=0.01, insertion=0.01, deletion=0.01, prob=NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{A XString or an XStringSet of length 1.}
  \item{number}{number of sequences to create.}
  \item{change, insertion, deletion}{probability of this operation.}
  \item{prob}{a named vector with letter probabilities. 4 for DNA and RNA and 20
  for AA (see \code{DNA_BASES}, \code{RNA_BASES} and the first 20
          letters in \code{AA_ALPHABET}).
  The default is to estimate the probabilities from the sequence in x. }
}
%\details{
%}
\value{
A XStringSet.
}
\examples{
### create random sequences
s <- random_sequences(100, number=1)
s

### create 10 sequences with 1 percent base changes, insertions and deletions
m <- mutations(s, 10, change=0.01, insertion=0.01, deletion=0.01)
m

### calculate edit distance between the original sequence and the mutated
### sequences
stringDist(c(s,m))

### multiple sequence alignment
\dontrun{
al <- clustal(c(s,m))
detail(al)
}
}
\keyword{model}
