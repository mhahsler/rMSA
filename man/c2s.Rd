\name{string2character}
\alias{c2s}
\alias{s2c}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Convenience Functions to Convert Strings to Character Vectors
}
\description{
These convenience function can be used to convert character strings into
vectors of single characters and back.
}
\usage{
c2s(x)
s2c(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ for \code{c2s} a single character string and
  for \code{s2c} a vector of single characters.
%%     ~~Describe \code{x} here~~
}
}
%\details{
%}
\value{
Either a single character string or a vector of single characters.
}
\author{
    Michael Hahsler
}
\examples{
s <- sample(c("A", "C", "G", "T"), 10, replace = TRUE)
s

s2 <- c2s(s)
s2

s2c(s2)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ manip }
