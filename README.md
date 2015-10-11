# rMSA - Interface for Popular Multiple Sequence Alignment Tools (R package)

[![Travis-CI Build Status](https://travis-ci.org/mhahsler/rMSA.svg?branch=master)](https://travis-ci.org/mhahsler/rMSA)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/mhahsler/rMSA?branch=master&svg=true)](https://ci.appveyor.com/project/mhahsler/rMSA)

Seamlessly interfaces Multiple Sequence Alignment software packages including ClustalW, MAFFT, MUSCLE and Kalign 
(downloaded separately) with the Bioconductor infrastructure. A short guide with examples can be found 
[here](http://github.com/mhahsler/rMSA/raw/master/vignettes_real/rMSA.pdf).

## Installation

* Install [Bioconductor](http://www.bioconductor.org/install/) and the Bioconductor packages
`Biostrings` and `seqLogo`.
*  Download and install the package from [AppVeyor](https://ci.appveyor.com/project/mhahsler/rMSA/build/artifacts) or install via `intall_github("mhahsler/rMSA")` (needs devtools) 
* To install individual MSA tools follow the instructions found in `? rMSA_INSTALL`

## Example
```R
R> library("rMSA")

R> rna <- readRNAStringSet(system.file("examples/RNA_example.fasta", package="rMSA"))
R> rna
  A RNAStringSet instance of length 5
    width seq                                                                    names               
[1]  1481 AGAGUUUGAUCCUGGCUCAGAACGAACGCUGGCG...UGGUGAUCGGGGUGAAGUCGUAACAAGGUAACC 1675 AB015560.1 d...
[2]  1404 GCUGGCGGCAGGCCUAACACAUGCAAGUCGAACG...GGCAGCCGACCACGGUAAGGUCAGCGACUGGGG 4399 D14432.1 Rho...
[3]  1426 GGAAUGCUNAACACAUGCAAGUCGCACGGGCAGC...GUGUAGUCGNAACAAGGUAGCCGUAGGGGAACC 4403 X72908.1 Ros...
[4]  1362 GCUGGCGGAAUGCUUAACACAUGCAAGUCGCACG...GAGUUGGUUUUACCUUAGGUGUCUAGGCUAACC 4404 AF173825.1 A...
[5]  1458 AGAGUUUGAUUAUGGCUCAGAGCGAACGCUGGCG...GCGACUGGGGUGAAGUCGUAACAAGGUAACCGU 4411 Y07647.2 Dre...
 
R> al <- clustal(rna)
Alignment Score 71657

R> al
RNAMultipleAlignment with 5 rows and 1500 columns
     aln                                                                         names               
[1] ---------------------------------GGA...GGGGUGUAGUCGNAACAAGGUAGCCGUAGGGGAACC 4403
[2] ---------------------------GCUGGCGGA...------------------------------------ 4404
[3] AGAGUUUGAUUAUGGCUCAGAGCGAACGCUGGCGGC...GGGGUGAAGUCGUAACAAGGUAACCGU--------- 4411
[4] ---------------------------GCUGGCGGC...GGGG-------------------------------- 4399
[5] AGAGUUUGAUCCUGGCUCAGAACGAACGCUGGCGGC...GGGGUGAAGUCGUAACAAGGUAACC----------- 1675
```
