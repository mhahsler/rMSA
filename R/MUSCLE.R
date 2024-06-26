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

muscle <- function(x, param = "") {
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
        .findExecutable("muscle"),
        args = c(param, "-clwstrict",
        "-in", infile, "-out", outfile
    ))

    ### muscle is missing a blank line in the output!
    rows <- scan(outfile,
        what = "", sep = "\n", strip.white = FALSE,
        quiet = TRUE, blank.lines.skip = FALSE
    )
    if (rows[[3L]] != "") {
        rows <- c(rows[1:2], "", rows[3:length(rows)])
    }
    cat(rows, file = outfile, sep = "\n")


    ### FIXME: Sequences need to be reordered!
    reader(outfile, format = "clustal")
}

muscle_help <- function() {
    system2(.findExecutable("muscle"), args = c("-h"))
}
