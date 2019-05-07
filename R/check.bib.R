#' Check Bibliography
#'
#' `check.bib` searches for all articles from a .bib file on Pubmed, and returns any associated retractions, erratums or expressions of concern.
#'
#' @param bibfile File path to .bib file
#' @return Returns a list of warnings, if any articles in .bib file have any associated retractions, erratums or expressions of concern. If it does not, returns an empty list.
#' @export
#'
#' @importFrom utils txtProgressBar



check.bib <- function(bibfile) {
  bibdata <- RefManageR::ReadBib(bibfile, check=F)
  bibdataclean <- gsub("[{}]", "",bibdata$title)
  timing <- length(bibdataclean)*1.5
  print(paste("Warning: checking references now; expect a wait time of approximately", timing, "seconds"))
  pg <- txtProgressBar(min = 0, max = length(bibdataclean), style = 3)
  issues <- list()
  num    <- 1
  for(i in 1:length(bibdataclean)) {

    article <- bibdataclean[i]
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
    if (length(anynotice)>0) {

      issues[num] <- anynotice
      num <- num + 1
    }
    Sys.sleep(.5)
    utils::setTxtProgressBar(pg, i)
  }
  return(issues)
}
