context("createAnalysisProject")

tmp <- tempfile(pattern = "aaa",
                tempdir(check = TRUE))
fs::dir_create(tmp)

project_name <- "analysisProject"

test_that("createAnalysisProject() creates as expected when using defaults",{

  createAnalysisProject(project_name, folder = tmp,
                        github = NULL)

  #expect_true(file.exists(file.path(tmp, project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(tmp, project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(tmp, project_name, "R")))
  expect_true(file.exists(file.path(tmp, project_name, "README.md")))
  expect_true(file.exists(file.path(tmp, project_name, ".git")))
  expect_true(file.exists(file.path(tmp, project_name, ".gitignore")))
  expect_true(file.exists(file.path(tmp, project_name, "data")))
  expect_true(file.exists(file.path(tmp, project_name, "analysis")))
  expect_true(file.exists(file.path(tmp, project_name, "outputs")))

})

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
fs::dir_delete(tmp)
usethis::proj_set(getwd())
