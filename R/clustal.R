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

clustal <- function(x, param = NULL) {
    ## get temp files and change working directory
    wd <- tempdir()
    dir <- getwd()
    temp_file <- basename(tempfile(tmpdir = wd))
    on.exit({
        file.remove(Sys.glob(paste(temp_file, ".*", sep = "")))
        setwd(dir)
    })
    setwd(wd)

    infile <- paste(temp_file, ".in", sep = "")
    outfile <- paste(temp_file, ".aln", sep = "")
    reader <- if (inherits(x, "RNAStringSet")) {
        readRNAMultipleAlignment
    } else if (inherits(x, "DNAStringSet")) {
        readDNAMultipleAlignment
    } else if (inherits(x, "AAStringSet")) {
        readAAMultipleAlignment
    } else {
        stop("Unknown sequence type!")
    }


    writeXStringSet(x, infile, append = FALSE, format = "fasta")

    ## call clustalw (needs to be installed and in the path!)
    system2(
        .findExecutable(c("clustalw", "clustalw2")),
        args = c(infile, param)
    )

    reader(outfile, format = "clustal")
}

clustal_help <- function() {
    system2(
        .findExecutable(c("clustalw", "clustalw2")),
        args = c("-help")
    )
}


clustal_profile <- function(x, y, param = NULL) {
    if (inherits(y, "DNAMultipleAlignment")) {
        profileprofile <- TRUE
        param2 <- "-profile"
    } else {
        profileprofile <- FALSE
        param2 <- "-sequence"
    }

    ## get temp files and change working directory
    wd <- tempdir()
    dir <- getwd()
    temp_file <- basename(tempfile(tmpdir = wd))
    on.exit({
        file.remove(Sys.glob(paste(temp_file, ".*", sep = "")))
        setwd(dir)
    })
    setwd(wd)

    prof1 <- paste(temp_file, ".in1", sep = "")
    prof2 <- paste(temp_file, ".in2", sep = "")
    outfile <- paste(temp_file, ".aln", sep = "")

    write.phylip(x, prof1)
    if (profileprofile) {
        write.phylip(y, prof2)
    } else {
        writeXStringSet(y, prof2, append = FALSE, format = "fasta")
    }

    ## call clustalw (needs to be installed and in the path!)
    system(paste(.findExecutable(c("clustalw", "clustalw2")),
        " -profile1=", prof1,
        " -profile2=", prof2,
        " ", param2, " ", param,
        sep = ""
    ))

    readDNAMultipleAlignment(paste(temp_file, ".aln", sep = ""),
        format = "clustal"
    )
}
