#######################################################################
# BiostringsTools - Interfaces to several sequence alignment and
# classification tools
# Copyright (C) 2012 Michael Hahsler and Anurag Nagar
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

### Feature Frequency Profile
distFFP <- function(x, k=3, method="JSD", normalize=TRUE) {

  ## Jensen–Shannon divergence between rows
  JSdiv <- function(x) {
    n <- nrow(x)
    s <- matrix(NA_real_, nrow=n, ncol=n)

    for(i in 1:(n-1)) {
      for(j in (i+1):n) {
        s[j,i] <- s[i,j] <- JSDivergence(x[i,], x[j,])
      }
    }

    as.dist(s)
  }

  ### from: Bioconductor: cn.farms
  ## Kullback-Leibler divergences
  KLDivergence <- function(p, q){
    sum(p * log(p / q))
  }

  KLInformation <- function(p, q){
    sum((p - q) * log(p / q))
  }

  ## Jensen-Shannon divergence
  JSDivergence <- function(p, q){
    m <- 0.5 * (p + q)
    0.5 * (KLDivergence(p, m) +  KLDivergence(q, m))
  }
  ### end

  x <- DNAStringSet(x)
  x.kmer <- oligonucleotideFrequency(x, k)

  if(normalize) x.kmer <- sweep(x.kmer, 1, rowSums(x.kmer), "/")

  ### JSD: Jensen–Shannon divergence
  if(pmatch(tolower(method), "jsd", nomatch=0)) {
    x.kmer <- x.kmer+1
    return(JSdiv(x.kmer))
  }

  if(pmatch(tolower(method), "kullback", nomatch=0)) x.kmer <- x.kmer+1

  proxy::dist(x.kmer, method=method)
}

### Composition Vector
###
distCV <- function(x, k=3) {
  x <- DNAStringSet(x)
  x.kmer <- oligonucleotideFrequency(x, k)
  x.kmer <- sweep(x.kmer, 1, rowSums(x.kmer), "/") ### normalize

  ### k-1 and k-2 mers
  x.kmer1 <- oligonucleotideFrequency(x, k-1)
  x.kmer1 <- sweep(x.kmer1, 1, rowSums(x.kmer1), "/") ### normalize
  x.kmer2 <- oligonucleotideFrequency(x, k-2)
  x.kmer2 <- sweep(x.kmer2, 1, rowSums(x.kmer2), "/") ### normalize


  x.kmer <- x.kmer - sapply(colnames(x.kmer), FUN=function(n) {
    p0 <- x.kmer1[,substr(n, 1L,k-1L), drop=FALSE] *
      x.kmer1[,substr(n, 2L,k), drop=FALSE] /
      x.kmer2[,substr(n, 2L,k-1L), drop=FALSE]

    p0[is.nan(p0)] <- 0
  })

  proxy::dist(x.kmer, method="Cosine")

}

### NSV-based distance
distNSV <- function(x, k=3, method="Manhattan", normalize=FALSE) {
  distFFP(x, k, method=method, normalize=normalize)
}

distKMer <- function(x, k=3) {
  x.kmer <- oligonucleotideFrequency(x, k) >0
  dist(x.kmer, method="binary")
}

### dist based on simRank
### FIXME: proxy::as.dist does not work...
distSimRank <- function(x, k=7) proxy::as.dist(simRank(x, k))


### distances based on package ape
distApe <- function(x, model="K80" ,...) {
  if(!is(x, "MultipleAlignment")) stop("x needs to be a Multiple Alignment.")

  dist.dna(as.DNAbin(lapply(tolower(as.character(x)), s2c)),
    model, ...)
}

# alignScore <- function(x, ...) {
#   n <- length(x)
#   s <- matrix(NA_real_, nrow=n, ncol=n)
#
#   for(i in 1:(n-1)) {
#     for(j in (i+1):n) {
#       s[j,i] <- s[i,j] <- pairwiseAlignment(x[[i]], x[[j]], ..., scoreOnly=TRUE)
#     }
#   }
#
#   as.simil(s)
# }
#
#distAlignment <- function(x, ...) structure(
#  1/(alignScore(x, ...)+1),
#  class="dist")


### dist based on Biostrings
distEdit <- function(x) stringDist(x, method="levenshtein")


distAlignment <- function(x, substitutionMatrix=NULL, ...) {
  if(is.null(substitutionMatrix))
    substitutionMatrix <- nucleotideSubstitutionMatrix(match = 1,
      mismatch = 0,
      baseOnly = TRUE,
      type = "DNA")

  stringDist(x, substitutionMatrix=substitutionMatrix, ...)
}



