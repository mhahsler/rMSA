\name{plot}
\alias{plot}
\alias{plot.DNAStringSet}
\alias{plot.DNAMultipleAlignment}
\alias{plot.RNAStringSet}
\alias{plot.RNAMultipleAlignment}
\title{Plot Genetic Sequences and Alignments}
\description{
Plots genetic sequences (RNA/DNA)
using sequence logos.
}
%\usage{
%}
%\arguments{
%    \item{x}{}
%    \item{start}{}
%    \item{end}{}
%    \item{ic.scale}{}
%}
%\value{
%}
\details{
	\code{plot} creates a sequence logo. Parameters are 
	\code{start} (position to start the logo),
	\code{end} (position to end the logo),
	\code{ic.scale} (if TRUE then each column are scaled proportional to its information content).
}
\seealso{
\code{\link[seqLogo]{seqLogo}} in \pkg{seqLogo}.
}
%\examples{
%}
%\keyword{database}
