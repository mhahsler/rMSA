
# R package rMSA - Interface for Popular Multiple Sequence Alignment Tools

[![r-universe
status](https://mhahsler.r-universe.dev/badges/rMSA)](https://mhahsler.r-universe.dev/rMSA)

Seamlessly interfaces Multiple Sequence Alignment software packages
including

- ClustalW
- MAFFT
- MUSCLE
- Kalign
- Boxshade

with the Bioconductor infrastructure. The tools have to be installed
separately.

In addition, distances between sets of sequences can be calculated
providing

- Numerical summarization vector distance (Nagar and Hahsler, 2013)
- Jensen-Shannon divergence (JSD) between FFPs (Sims and Kim, 2011)
- Cosine distance is used between Composition Vectors (Qi et al, 2007)
- Jaccard distance between sets of k-mers.
- Distance based on SimRank (Santis et al, 2011)
- Edit (Levenshtein) Distance (package pwalign)
- Distance based on alignment scores (package pwalign)
- Evolutionary distances (package ape)

A short guide with examples can be found
[here](http://github.com/mhahsler/rMSA/raw/master/vignettes_real/rMSA.pdf).

## Installation

**Current development version:** Install from
[r-universe.](https://mhahsler.r-universe.dev/rMSA)

``` r
install.packages("rMSA",
    repos = c("https://mhahsler.r-universe.dev". "https://cloud.r-project.org/"))
```

Additional installation instructions can be found [here](INSTALL).

## Examples

Align sequences using clustalW.

``` r
library("rMSA")

rna <- readRNAStringSet(system.file("examples/RNA_example.fasta", package = "rMSA"))
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

Cluster mutations of a sequence using SimRank

``` r
s <- random_sequences(len = 100, number = 1)
ms <- mutations(s, number = 20)
dSimRank <- distSimRank(ms)
plot(as.dendrogram(hclust(dSimRank)), horiz=TRUE, type="triangle")
```

![](inst/README_files/unnamed-chunk-4-1.png)<!-- -->

# How to Cite the Use of this Package

To cite package ‘rMSA’ in publications use:

> Hahsler M, Nagar A (2024). *rMSA: Interface for Popular Multiple
> Sequence Alignment Tools*. R package version 0.99.1.

    @Manual{,
      title = {rMSA: Interface for Popular Multiple Sequence Alignment Tools},
      author = {Michael Hahsler and Anurag Nagar},
      year = {2024},
      note = {R package version 0.99.1},
    }

# References

Gao, L; Qi, J (2007 Mar 15). “Whole genome molecular phylogeny of large
dsDNA viruses using composition vector method.”. BMC evolutionary
biology 7: 41. PMID 17359548.

Hahsler M, Nagar A (2024). *rMSA: Interface for Popular Multiple
Sequence Alignment Tools*. R package version 0.99.1.

Anurag Nagar; Michael Hahsler (2013). “Fast discovery and visualization
of conserved regions in DNA sequences using quasi-alignment.” BMC
Bioinformatics, 14(Suppl. 11), 2013

Santis et al, Simrank: Rapid and sensitive general-purpose k-mer search
tool, BMC Ecology 2011, 11:11

Sims, GE; Kim, SH (2011 May 17). “Whole-genome phylogeny of Escherichia
coli/Shigella group by feature frequency profiles (FFPs).”. Proceedings
of the National Academy of Sciences of the United States of America 108
(20): 8329-34. PMID 21536867.

Qi J, Wang B, Hao B: Whole Proteome Prokaryote Phylogeny without
Sequence Alignment: A K-String Composition Approach. Journal of
Molecular Evolution 2004, 58:1-11.
