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

### plot as a Sequence Logo

### DNA
plot.DNAMultipleAlignment <- function(x, start=1, end=NULL, ic.scale=FALSE, ...) plot(as(x, "DNAStringSet"), start, end, ic.scale, ...)


plot.DNAStringSet <- function(x, start=1, end=NULL, ic.scale=FALSE, ...)
{
    cm <- consensusMatrix(x,baseOnly=TRUE)
    if (is.null(end))
	end <- ncol(cm)
    cm <- cm[1:4,start:end]
    for(i in 1:ncol(cm))
	cm[,i] <- cm[,i]/colSums(cm)[i]
    pwm <- seqLogo::makePWM(cm)
    seqLogo::seqLogo(pwm, ic.scale,  ...)
}

### RNA
### FIXME: SeqLogo only supports DNA
plot.RNAMultipleAlignment <- function(x, start=1, end=NULL, ic.scale=FALSE, ...) plot(as(x, "RNAStringSet"), start, end, ic.scale, ...)


plot.RNAStringSet <- function(x, start=1, end=NULL, ic.scale=FALSE, ...)
{
    warning("Sequence logo only supports DNA. All U's are plotted as T's!")
    cm <- consensusMatrix(x,baseOnly=TRUE)
    if (is.null(end))
	end <- ncol(cm)
    cm <- cm[1:4,start:end]
    for(i in 1:ncol(cm))
	cm[,i] <- cm[,i]/colSums(cm)[i]
    pwm <- seqLogo::makePWM(cm)
    seqLogo::seqLogo(pwm, ic.scale,  ...)
}

