% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check.pubmed.R
\name{check.pubmed}
\alias{check.pubmed}
\title{Check Pubmed}
\usage{
check.pubmed(articlename)
}
\arguments{
\item{articlename}{Title of article (in quotes)}
}
\value{
Returns a list of warnings, if article has any associated retractions, erratums or expressions of concern. If it does not, returns an empty list.
}
\description{
\code{check.pubmed} searches for a single article on Pubmed, and returns any associated retractions, erratums or expressions of concern.
}
\examples{

check.pubmed("Ileal-lymphoid-nodular hyperplasia, non-specific colitis, and pervasive developmental disorder in children")
# (returns warning that article may have been retracted)
}
