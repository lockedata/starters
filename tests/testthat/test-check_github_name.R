context("test-check_github_name")

test_that("check_github_name works", {
  expect_error(check_github_name("lockedata", "cransays"))
  expect_silent(check_github_name(NULL, "starters"))
  expect_silent(check_github_name("maelle", "pRRRojects"))
})
