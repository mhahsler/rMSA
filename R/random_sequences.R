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


### create random sequences

random_sequences <- function(len, number=1, prob=NULL,
                            type = c("DNA", "RNA", "AA")) {
  type <- match.arg(type)
  alpha <- switch(type,
              DNA = Biostrings::DNA_BASES,
              RNA = Biostrings::RNA_BASES,
              AA = AA_ALPHABET[1:20]
  )
  
  #.rand_string <- function(...) stop("No sequence creator selected.")
  
  if(is.null(prob)){
    .rand_string <- function(len, prob, alpha) c2s(sample(alpha, len, 
                                                          replace=TRUE, 
                                                          prob=prob)) 
  }else{ ### with specified probabilities
    if(is.matrix(prob)) { ### transition matrix
      # prob <- oligonucleotideTransitions(seqs, as.prob=TRUE)
      
      if(!all(sort((rownames(prob)))==sort(alpha)) 
         || !all(sort((colnames(prob)))==sort(alpha))) 
        stop(paste("Illegal or missing names in transition matrix.\n",
             "Expecting values for", paste(alpha, collapse=", ")))
      
      prob <- prob[alpha, alpha]  
      
      .rand_string <- function(len, prob, alpha) {
        s <- character(len)
        s[1L] <- sample(alpha, 1L, prob=colMeans(prob))
  
        for(i in 2:len) s[i] <- sample(alpha, 1L, prob=prob[s[i-1L],])
        
        c2s(s)
      }
      
    }else{ ### vector with letter frequencies
      names(prob) <- toupper(names(prob))
      prob <- prob[alpha]
      if(any(is.na(prob))) 
        stop(paste("Illegal or missing names in probability vector.\n",
                 "Expecting values for", paste(alpha, collapse=", ")))
      
      .rand_string <- function(len, prob, alpha) c2s(sample(alpha, len, 
                                                            replace=TRUE, 
                                                            prob=prob)) 
    }
  }
  
 

  s <- switch(type,
              DNA = DNAStringSet(replicate(number, .rand_string(len, prob, Biostrings::DNA_BASES))),
              RNA = RNAStringSet(replicate(number, .rand_string(len, prob, Biostrings::RNA_BASES))),
              AA = AAStringSet(replicate(number, .rand_string(len, prob, Biostrings::AA_ALPHABET[1:20])))
  )
  
  names(s) <- 1:length(s)
  s
}



mutations <- function(x, number=1, change=0.01, insertion=0.01, 
                      deletion=0.01, prob=NULL) {
  
  if(is(x, "XStringSet") && length(x)!=1) stop("x has to be a single sequence!")
  if(is(x, "XStringSet")) {
    name <- paste(names(x[1]), '_', sep='')
    x <- x[[1]]
  }else name <- ""
  
  alpha <- alphabet(x, baseOnly=TRUE)
  xs <- s2c(as.character(x))
  n <- length(xs)
  
  ### estimate letter frequencies or use given probabilities
  if(is.null(prob)) {
    prob <- letterFrequency(x, letters=alphabet(x, baseOnly=TRUE), as.prob=TRUE)
  }else{
    names(prob) <- toupper(names(prob))
    prob <- prob[alpha]
    if(any(is.na(prob))) stop("illegal or missing names in prob.")
  }
     
  .mut <- function(xs, change, insertion, deletion, prob) {
    ### change
    if(change>0) {
      m <- which(runif(n) < change)
      #xs[m] <- sample(alpha, sum(m), replace=TRUE, prob=prob)
      ### this correctd for equal base exchange
      while(length(m)>0) {
        newLetters <- sample(alpha, length(m), replace=TRUE, prob=prob)
        oldM <- m
        m <- m[xs[m] == newLetters]
        xs[oldM] <- newLetters
      }
    }
    
    ### deletion
    if(deletion>0) {
      keep <- which(runif(n) > deletion)
      xs <- xs[keep]
    }
    
    ### insertion
    if(insertion>0) {
      ni <- rbinom(1, n, insertion)
      for(i in 1:ni) {
        pos <- sample(0:length(xs),1)
        if(pos==0) xs <- c(sample(alpha, 1, prob=prob), xs)
        else if(pos==length(xs)) xs <- c(xs, sample(alpha, 1, prob=prob))
        else xs <- c(xs[1:pos], sample(alpha, 1, prob=prob), 
                     xs[(pos+1L):length(xs)])
      }
    }
    c2s(xs)
  }
  
  xs <- replicate(number, .mut(xs, change, insertion, deletion, prob), 
                  simplify=FALSE)
  
  r <- (switch(class(x),
         DNAString = DNAStringSet(lapply(xs, DNAString)), 
         RNAString = RNAStringSet(lapply(xs, RNAString)),
         AAString = AAStringSet(lapply(xs, AAString)) 
         ))


  names(r) <- paste(name, 1:length(r), sep="mutation_")
  r
}
