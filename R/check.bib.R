#' Check Bibliography
#'
#' `check.bib` searches for all articles from a .bib file on Pubmed, and returns any associated retractions, erratums or expressions of concern.
#'
#' @param bibfile File path to .bib file
#' @param checkwith Source to check against. Options are "crossref", "pubmed" or "both"
#' @return Returns a list of warnings, if any articles in .bib file have any associated retractions, erratums or expressions of concern. If it does not, returns an empty list.
#' @export
#'
#' @importFrom utils txtProgressBar



check.bib <- function(bibfile, checkwith = "both") {

  # Check for valid inputs
  if (!(checkwith %in% c("both", "pubmed", "crossref"))) {
    stop("Invalid input for checkwith: possible arguments are 'both', 'pubmed' or 'crossref'")
  }

  # Read BibTex file, extract titles, and loop over them
  bibdata <- RefManageR::ReadBib(bibfile, check = F)
  bibdataclean <- gsub("[{}]", "",bibdata$title)
  timing <- length(bibdataclean)*1.5
  print(paste("Warning: checking references now; expect a wait time of approximately", timing, "seconds"))
  pg <- txtProgressBar(min = 0, max = length(bibdataclean), style = 3)
  issues <- list()
  num    <- 1
  for(i in 1:length(bibdataclean)) {
    article <- bibdataclean[i]

    # PubMed only
    if (checkwith == "pubmed") {
      anynotice <- tryCatch(check.pubmed(article),
                            warning = function(e) {
                              closeAllConnections()
                              Sys.sleep(1)
                              check.pubmed(article)
                            },
                            error = function(e) {
                              closeAllConnections()
                              Sys.sleep(1)
                              check.pubmed(article)
                            }
                            )
    }

    # CrossRef only
    if (checkwith == "crossref") {
      anynotice <- check.crossref(article)
    }

    # Both
    if (checkwith == "both") {
      anynoticecrossref <- check.crossref(article)
      anynoticepubmed   <- tryCatch(check.pubmed(article),
                            warning = function(e) {
                              closeAllConnections()
                              Sys.sleep(1)
                              check.pubmed(article)
                            },
                            error = function(e) {
                              closeAllConnections()
                              Sys.sleep(1)
                              check.pubmed(article)
                            }
      )
      if (length(anynoticecrossref) > 0) {anynotice <- anynoticecrossref}
      if (length(anynoticepubmed) > 0)   {anynotice <- anynoticepubmed}
      if (length(anynoticepubmed) == 0 & length(anynoticecrossref) == 0)   {anynotice <- list()}
    }

    # Store relevant results
    if (length(anynotice) > 0) {

      issues[num] <- anynotice
      num <- num + 1
    }
    Sys.sleep(.5)
    utils::setTxtProgressBar(pg, i)

  }
  return(issues)
}
