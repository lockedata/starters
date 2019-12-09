test_that("check_github_name works", {
  testthat::skip_if_not(nzchar(Sys.getenv("GITHUB_PAT")))
  expect_error(check_github_name("lockedata", "cransays"))
  expect_silent(check_github_name(NULL, "starters"))
  expect_silent(check_github_name("maelle", "pRRRojects"))
})
