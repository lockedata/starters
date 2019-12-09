tmp <- tempfile(
  pattern = "aaa",
  tempdir(check = TRUE)
)
fs::dir_create(tmp)

project_name <- "analysisProject"

test_that("createAnalysisProject() errors if name missing or not correct", {
  expect_error(createAnalysisProject(
    folder = tmp,
    packagedeps = "renv",
    git = TRUE,
    external_setup = NULL
  ))

  expect_error(createAnalysisProject(
    name = 1,
    folder = tmp,
    packagedeps = "renv",
    git = TRUE,
    external_setup = NULL
  ))

  expect_error(createAnalysisProject(
    name = "a",
    folder = tmp,
    packagedeps = "renv",
    git = TRUE,
    external_setup = NULL
  ))
})


test_that("createAnalysisProject() creates as expected", {
  createAnalysisProject(project_name,
    folder = tmp,
    external_setup = NULL,
    packagedeps = "none"
  )

  expect_true(file.exists(file.path(
    tmp, project_name,
    paste0(project_name, ".Rproj")
  )))
  expect_true(file.exists(file.path(tmp, project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(tmp, project_name, "R")))
  expect_true(file.exists(file.path(tmp, project_name, "README.Rmd")))
  expect_true(file.exists(file.path(tmp, project_name, ".git")))
  expect_true(file.exists(file.path(tmp, project_name, ".gitignore")))
  expect_true(file.exists(file.path(tmp, project_name, "data")))
  expect_true(file.exists(file.path(tmp, project_name, "analysis")))
  expect_true(file.exists(file.path(tmp, project_name, "outputs")))
  unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)

})

test_that("createAnalysisProject() cleans if there was an error", {
  mockery::stub(where = createAnalysisProject,
                what = "createdirs",
                how = stop)
    expect_message(
      createAnalysisProject(project_name,
        folder = tmp,
        external_setup = NULL,
        packagedeps = NULL
      ),
      "Oops"
    )
})

teardown({
fs::dir_delete(tmp)
usethis::proj_set(getwd(), force = TRUE)
})
