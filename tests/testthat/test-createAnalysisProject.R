context("createAnalysisProject")

tmp <- tempdir(check = TRUE)

teardown({
  fs::dir_delete(tmp)
})


project_name <- "analysisProject"

test_that("createAnalysisProject() creates as expected when using defaults",{

  createAnalysisProject(project_name, folder = tmp)

  expect_true(file.exists(file.path(tmp, project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(tmp, project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(tmp, project_name, "R")))
  expect_true(file.exists(file.path(tmp, project_name, "README.Rmd")))
  expect_true(file.exists(file.path(tmp, project_name, ".git")))
  expect_true(file.exists(file.path(tmp, project_name, ".gitignore")))
  expect_true(file.exists(file.path(tmp, project_name, ".travis.yml")))
  expect_true(file.exists(file.path(tmp, project_name, "data")))
  expect_true(file.exists(file.path(tmp, project_name, "analysis")))
  expect_true(file.exists(file.path(tmp, project_name, "outputs")))

})

unlink(project_name, recursive = TRUE, force = TRUE)
