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

boxshade <- function(x, file, dev="pdf", param="-thr=0.5 -cons -def",
  pdfCrop=TRUE) {
  devs <- c(ps=1, eps=2, hpgl=3, rtf=4, crt=5, ansi=6, vt=7,
    ascii="b", fig="c", pict="d", html="e")
  
  dev <- tolower(dev)
  
  ## pdf?
  if(dev == "pdf") {
    pdf <- TRUE
    if(pdfCrop) dev <- "eps"
    else dev <- "ps"
  } else pdf <- FALSE
  
  if(dev %in% names(devs)) dev <- devs[[dev]]
  
  ## get temp files and change working directory
  wd <- tempdir()
  temp_file <- tempfile(tmpdir = wd)
  on.exit({
    file.remove(Sys.glob(paste(temp_file, ".*", sep=""))) 
  })
  
  infile <- paste(temp_file, ".PHY", sep="")
  write.phylip(x, filepath=infile)
  
  ## call boxshade (needs to be installed and in the path!)
  system(paste(.findExecutable(c("boxshade", "box")), 
    " -in=", infile, " -type=5",
    " -out=", file, " -dev=", dev, 
    param, sep=""))
  
  if(pdf) {
    temp_file <- paste(file, ".tmp", sep='') 
    file.rename(file, temp_file)
    system(paste(.findExecutable(c("ps2pdf")), 
      if(pdfCrop) "-dEPSCrop" else "", 
      temp_file, file))  
    unlink(temp_file)
  }
  
}

boxshade_help <- function() {
  system(paste(.findExecutable(c("boxshade", "box")), 
    "-help"))
}


