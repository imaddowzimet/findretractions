
<!-- README.md is generated from README.Rmd. Please edit that file -->

# findretractions

<!-- badges: start -->

<!-- badges: end -->

## Installation

The `findretractions` package is a simple tool to help see if papers you
have cited have associated retraction notices, erratums or expressions
of concern. Currently, it can only find records on PubMed (using the
`RISmed` package by Stephanie Kovalchik); future versions may expand to
other databases as well.

You can install the released version of findretractions using:

``` r
devtools::install_github("imaddowzimet/findretractions")
```

\*\*How to use it

`check.bib()` is the main function in the package. It takes as an input
any .bib file; .bib files can be exported from almost every reference
manager software (like Zotero or Endnote). To export a .bib file from
Zotero, just select the library you want to export, and choose the
format “BibTex”:

![](Misc/zoteroexport.png)
