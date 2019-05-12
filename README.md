
<!-- README.md is generated from README.Rmd. Please edit that file -->

# findretractions

<!-- badges: start -->

<!-- badges: end -->

## Installation

The `findretractions` package is a simple tool to help see if papers you
have cited have associated retraction notices, erratums or expressions
of concern. Currently, it can only find records on PubMed and CrossRef
(using the `RISmed` and `rcrossref` packages); future versions may
expand to other databases as well.

You can install the released version of findretractions using:

``` r
devtools::install_github("imaddowzimet/findretractions")
```

## How to use it

`check.bib()` is the main function in the package. It takes as an input
any BibTex file (.bib); .bib files can be exported from almost every
reference manager software (like Zotero or Endnote). To export a BibTex
file from Zotero, just select the library or collection you want to
export, select File\>Export Library…(or if it’s a collection, right
click, and select Export Collection…), and choose the format “BibTex” in
the pop-up window that appears:

![](Misc/zoteroexport.png)

Then just run `check.bib` with the link to the relevant file:

``` r
library(findretractions)
check.bib("Misc/My_Library.bib")
#> [1] "Warning: checking references now; expect a wait time of approximately 7.5 seconds"
#> 
  |                                                                       
  |                                                                 |   0%
  |                                                                       
  |=============                                                    |  20%
  |                                                                       
  |==========================                                       |  40%
  |                                                                       
  |=======================================                          |  60%
  |                                                                       
  |====================================================             |  80%
  |                                                                       
  |=================================================================| 100%
#> [[1]]
#> [1] "Check: Ileal-lymphoid-nodular hyperplasia, non-specific colitis, and pervasive developmental disorder in children. It may have been retracted"
#> 
#> [[2]]
#> [1] "Check: Genetic signatures of exceptional longevity in humans. It may have been retracted"
#> 
#> [[3]]
#> [1] "Check: Biological fabrication of cellulose fibers with tailored properties. There may be an associated erratum"
```

The function checks the references one by one, and is careful to not
overload PubMed or Crossref with too many requests, so it may take some
time to run. It returns a list of any flagged articles, or an empty list
if it hasn’t found anything.

**IMPORTANT**: This function is mean to flag *possible* retractions,
erratums or expressions of concern. Any articles it flags should be
checked on PubMed, CrossRef and the publisher’s website directly, so
that you can find the content of the notice, and be aware that it will
not flag any notice not indexed on PubMed (and there are documented lags
in when retraction notices get posted to PubMed; see [Decullier E et
al., 2014](https://www.ncbi.nlm.nih.gov/pubmed/?term=What+time-lag+for+a+retraction+search+on+PubMed%3F);
there are similar issues for CrossRef). Right now, the [Retraction Watch
Database](https://retractionwatch.com/2018/10/25/were-officially-launching-our-database-today-heres-what-you-need-to-know/)
has the most up to date listings of retracted articles; unfortunately,
as it doesn’t yet have an API, articles need to be searched for manually
on their site.
