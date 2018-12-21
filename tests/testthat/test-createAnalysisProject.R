context("createAnalysisProject")

tmp <- tempfile(
  pattern = "aaa",
  tempdir(check = TRUE)
)
fs::dir_create(tmp)

project_name <- "analysisProject"

test_that("createAnalysisProject() errors if name missing or not correct", {
  expect_error(createAnalysisProject(
    folder = tmp,
    packagedeps = "packrat",
    git = TRUE,
    external_setup = NULL
  ))

  expect_error(createAnalysisProject(
    name = 1,
    folder = tmp,
    packagedeps = "packrat",
    git = TRUE,
    external_setup = NULL
  ))
})


test_that("createAnalysisProject() creates as expected when using defaults", {
  createAnalysisProject(project_name,
    folder = tmp,
    external_setup = NULL
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
  m <- mockery::mock(stop("Nooo"))
  with_mock(createBasicProject = m, {
    expect_message(
      createAnalysisProject(project_name,
        folder = tmp,
        external_setup = NULL,
        dirs = 1,
        packagedeps = NULL
      ),
      "Oops"
    )
  })
})

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
fs::dir_delete(tmp)
usethis::proj_set(getwd(), force = TRUE)
