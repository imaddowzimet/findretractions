context("check.crossref")

testthat::test_that("flags retraction", {
  testthat::expect_equal(
    check.crossref("Ileal-lymphoid-nodular hyperplasia, non-specific colitis, and pervasive developmental disorder in children"),
    list("Check: Ileal-lymphoid-nodular hyperplasia, non-specific colitis, and pervasive developmental disorder in children. It may have been retracted")
  )
})

testthat::test_that("does not flag retraction", {
  testthat::expect_equal(
    check.crossref("Changes in Adolescents' Receipt of Sex Education, 2006–2013"),
    list()
  )
})

context("check.pubmed")

testthat::test_that("flags retraction", {
  testthat::expect_equal(
    check.pubmed("Ileal-lymphoid-nodular hyperplasia, non-specific colitis, and pervasive developmental disorder in children"),
    list("Check: Ileal-lymphoid-nodular hyperplasia, non-specific colitis, and pervasive developmental disorder in children. It may have been retracted")
  )
})

testthat::test_that("does not flag retraction", {
  testthat::expect_equal(
    check.pubmed("Effect of Changes in Response Options on Reported Pregnancy Intentions: A Natural Experiment in the United States"),
    list()
  )
})



context("check.bib")
file.name <- system.file("Bib", "My_Library.bib", package="findretractions")

result <- list()
result[[1]] <- "Check: Ileal-lymphoid-nodular hyperplasia, non-specific colitis, and pervasive developmental disorder in children. It may have been retracted"
result[[2]] <- "Check: Genetic signatures of exceptional longevity in humans. It may have been retracted"
result[[3]] <- "Check: Biological fabrication of cellulose fibers with tailored properties. There may be an associated erratum"
result[[4]] <- "Check: Structural Stigma and All-Cause Mortality in Sexual Minority Populations. It may have been retracted"
testthat::test_that("my_library test", {
  testthat::expect_equal(
    check.bib(file.name),
    result
  )
})
