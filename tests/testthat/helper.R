# adapted from https://github.com/r-lib/usethis/blob/master/tests/testthat/helper.R

temp_folder <- function(pattern) {
  tmp <- tempfile(
    pattern = pattern,
    tempdir(check = TRUE)
  )
  fs::dir_create(tmp)
  withr::defer({
    fs::dir_delete(tmp)
  }, envir = parent.frame())
  return(tmp)
}
