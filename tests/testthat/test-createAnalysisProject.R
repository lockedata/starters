project_name <- "analysisProject"

test_that("createAnalysisProject() errors if name missing or not correct", {

  tmp <- temp_folder("aaa")

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
  tmp <- temp_folder("aaa")

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

})

test_that("createAnalysisProject() cleans if there was an error", {

  tmp <- temp_folder("aaa")

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

