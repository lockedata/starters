library("mockery")
library("tufte")
library("bookdown")
library("xaringan")
library("revealjs")

# adapted from https://github.com/r-lib/usethis/blob/master/tests/testthat/helper.R

temp_folder <- function(pattern) {
  tmp <- tempfile(
    pattern = "aaa",
    tempdir(check = TRUE)
  )
  fs::dir_create(tmp)
  withr::defer({
    fs::dir_delete(tmp)
  }, envir = parent.frame())
  return(tmp)
}
