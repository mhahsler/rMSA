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

mafft <- function(x, param="--auto") {

    ## get temp files and change working directory
    wd <- tempdir()
    dir <- getwd()
    temp_file <- basename(tempfile(tmpdir = wd))
    on.exit({
		file.remove(Sys.glob(paste(temp_file, ".*", sep="")))
		setwd(dir)
	    })
    setwd(wd)

    infile <- paste(temp_file, ".in", sep="")
    outfile <- paste(temp_file, ".aln", sep="")
    reader <- if(is(x, "RNAStringSet")) readRNAMultipleAlignment
	else if(is(x, "DNAStringSet")) readDNAMultipleAlignment
	else if(is(x, "AAStringSet")) readAAMultipleAlignment
	else stop("Unknown sequence type!")


    writeXStringSet(x, infile, append=FALSE, format="fasta")

    ## call clustalw (needs to be installed and in the path!)
    system(paste(.findExecutable( "mafft"), param, "--clustalout",
		    infile,">", outfile))

    reader(outfile, format="clustal")
}

mafft_help <- function() {
    #system(paste(.findExecutable("mafft"),
		 #   "--help"))

    cat("No MAFFT manual page available!")

}

