#' Check CrossRef
#'
#' `check.crossref` searches for a single article on Pubmed, and returns any associated retractions, erratums or expressions of concern.
#'
#' @param articlename Title of article (in quotes)
#' @return Returns a list of warnings, if article has any associated retractions.
#' @examples
#'
#' check.crossref("Ileal-lymphoid-nodular hyperplasia, non-specific colitis, and pervasive developmental disorder in children")
#' # (returns warning that article may have been retracted)
#'
#' @export


check.crossref <- function(articlename) {

  records <- rcrossref::cr_works(flq = c(`query.title` = articlename), select=c("title"))$data
  matches  <- grep(articlename, dplyr::pull(records))
  retracted    <- grepl("Retracted|Retraction", records[matches,])
  issues       <- list()
  num          <- 1
  if (sum(retracted) >= 1) {
    issues[num] <- paste("Check: ", articlename, ". It may have been retracted", sep="")
    num <- num + 1
  }
  return(issues)
}


