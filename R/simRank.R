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

### implement simrank similarity defined in
### Santis et al, Simrank: Rapid and sensitive general-purpose k-mer 
### search tool, BMC Ecology 2011, 11:11

### The similarity between sequences Q and S are the number of unique k-mers 
### shared, divided by the smallest total unique k-mer count in either Q or S. 

simRank <- function(x, k=7) {
    x <- DNAStringSet(x)
    
    x.kmer <- oligonucleotideFrequency(x, k) >0

    shared <- tcrossprod(x.kmer)
    sum.kmer <- rowSums(x.kmer)
    
    min <- outer(sum.kmer, sum.kmer, function(x, y) pmin(x,y)) 

    proxy::as.simil(shared/min)
}


  

