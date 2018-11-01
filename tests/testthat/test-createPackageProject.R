context("createPackageProject")
tmp <- tempdir(check = TRUE)
cur <- getwd()

setup({
  setwd(tmp)
  options(usethis.description = list(usethis.name = "Jane Doe",
                                     usethis.description = list(
                                       `Authors@R` = 'person("Jane", "Doe", email = "jane@example.com", role = c("aut", "cre"))',
                                       License = "MIT + file LICENSE",
                                       Version = "0.0.0.9000"
                                     )))
})
teardown({
  fs::dir_delete(tmp)
  setwd(cur)
})



project_name <- "packageProject2"

test_that("createPackageProject() creates as expected when using defaults",{

  createPackageProject(project_name)
  expect_true(file.exists(file.path(project_name, paste0(project_name, ".Rproj"))))
  #expect_true(file.exists(file.path(project_name, "codecov.yml")))
  expect_true(file.exists(file.path(project_name, "CODE_OF_CONDUCT.md")))
  expect_true(file.exists(file.path(project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(project_name, "LICENSE")))
  expect_true(file.exists(file.path(project_name, "NAMESPACE")))
  expect_true(file.exists(file.path(project_name, "NEWS.md")))
  expect_true(file.exists(file.path(project_name, "R")))
  expect_true(file.exists(file.path(project_name, "README.Rmd")))
  expect_true(file.exists(file.path(project_name, "tests")))
  expect_true(file.exists(file.path(project_name, "vignettes")))
  expect_true(file.exists(file.path(project_name, ".git")))
  expect_true(file.exists(file.path(project_name, ".gitignore")))
  expect_true(file.exists(file.path(project_name, ".travis.yml")))

})

unlink(project_name, recursive = TRUE, force = TRUE)

test_that("createPackageProject() cleans if there was an error", {
  m <- mockery::mock(stop())
  with_mock(is_available = m, {
    expect_message(createPackageProject("blablabla"),
                   "Oops")
  })
})
