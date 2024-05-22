
# R package rMSA - Interface for Popular Multiple Sequence Alignment Tools

[![r-universe
status](https://mhahsler.r-universe.dev/badges/rMSA)](https://mhahsler.r-universe.dev/rMSA)

Seamlessly interfaces Multiple Sequence Alignment software packages
including ClustalW, MAFFT, MUSCLE and Kalign (downloaded separately)
with the Bioconductor infrastructure. A short guide with examples can be
found
[here](http://github.com/mhahsler/rMSA/raw/master/vignettes_real/rMSA.pdf).

## Installation

**Current development version:** Install from
[r-universe.](https://mhahsler.r-universe.dev/rMSA)

``` r
install.packages("rMSA",
    repos = c("https://mhahsler.r-universe.dev". "https://cloud.r-project.org/"))
```

Additional installation instructions can be found [here](INSTALL).

## Example

``` r
library("rMSA")

rna <- readRNAStringSet(system.file("examples/RNA_example.fasta", package="rMSA"))
rna
```

    ## RNAStringSet object of length 5:
    ##     width seq                                               names               
    ## [1]  1481 AGAGUUUGAUCCUGGCUCAGAAC...GGUGAAGUCGUAACAAGGUAACC 1675 AB015560.1 d...
    ## [2]  1404 GCUGGCGGCAGGCCUAACACAUG...CACGGUAAGGUCAGCGACUGGGG 4399 D14432.1 Rho...
    ## [3]  1426 GGAAUGCUNAACACAUGCAAGUC...AACAAGGUAGCCGUAGGGGAACC 4403 X72908.1 Ros...
    ## [4]  1362 GCUGGCGGAAUGCUUAACACAUG...UACCUUAGGUGUCUAGGCUAACC 4404 AF173825.1 A...
    ## [5]  1458 AGAGUUUGAUUAUGGCUCAGAGC...UGAAGUCGUAACAAGGUAACCGU 4411 Y07647.2 Dre...

``` r
al <- clustal(rna)
al
```

    ## RNAMultipleAlignment with 5 rows and 1500 columns
    ##      aln                                                    names               
    ## [1] --------------------------...GNAACAAGGUAGCCGUAGGGGAACC 4403
    ## [2] --------------------------...------------------------- 4404
    ## [3] AGAGUUUGAUUAUGGCUCAGAGCGAA...GUAACAAGGUAACCGU--------- 4411
    ## [4] --------------------------...------------------------- 4399
    ## [5] AGAGUUUGAUCCUGGCUCAGAACGAA...GUAACAAGGUAACC----------- 1675
