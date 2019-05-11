#' Check Pubmed
#'
#' `check.pubmed` searches for a single article on Pubmed, and returns any associated retractions, erratums or expressions of concern.
#'
#' @param articlename Title of article (in quotes)
#' @return Returns a list of warnings, if article has any associated retractions, erratums or expressions of concern. If it does not, returns an empty list.
#' @examples
#'
#' check.pubmed("Ileal-lymphoid-nodular hyperplasia, non-specific colitis, and pervasive developmental disorder in children")
#' # (returns warning that article may have been retracted)
#'
#' @export


check.pubmed <- function(articlename) {

  search_topic <- articlename
  search_query <- RISmed::EUtilsSummary(search_topic, retmax=20)
  records      <- RISmed::EUtilsGet(search_query)
  if (length(records@PMID)==0){
    warning(paste("No record found for", articlename, "in PubMed", sep=" "))
  }
  pubmed_data  <- as.vector(RISmed::PublicationType(records))
  retracted    <- grepl("Retraction of Publication|Retracted Publication", pubmed_data)
  erratum      <- grepl("Published Erratum", pubmed_data)
  concern      <- grepl("Expression of Concern", pubmed_data)
  issues       <- list()
  num          <- 1
  if (sum(retracted) >= 1) {
    issues[num] <- paste("Check: ", search_topic, ". It may have been retracted", sep="")
    num <- num + 1
  }
  if (sum(concern) >= 1) {
    issues[num] <- paste("Check: ", search_topic, ". There may be an associated expression of concern", sep="")
    num <- num + 1
  }
  if (sum(erratum) >= 1) {
    issues[num] <- paste("Check: ", search_topic, ". There may be an associated erratum", sep="")
    num <- num + 1
  }
  return(issues)
}
