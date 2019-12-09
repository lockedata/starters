tmp <- tempfile(
  pattern = "ttt",
  tempdir(check = TRUE)
)
fs::dir_create(tmp)

project_name <- "trainingProject2"

test_that("createTrainingProject() errors if name missing or not correct", {
  expect_error(createTrainingProject(
    folder = tmp,
    packagedeps = "renv",
    git = TRUE,
    external_setup = NULL
  ))

  expect_error(createTrainingProject(
    name = 1,
    folder = tmp,
    packagedeps = "renv",
    git = TRUE,
    external_setup = NULL
  ))

  expect_error(createTrainingProject(
    name = "a",
    folder = tmp,
    packagedeps = "renv",
    git = TRUE,
    external_setup = NULL
  ))
})


test_that("createTrainingProject() creates as expected when using defaults", {
  createTrainingProject(project_name,
    folder = tmp,
    packagedeps = "none",
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
  expect_true(file.exists(file.path(tmp, project_name, "handouts")))
  expect_true(file.exists(file.path(tmp, project_name, "slides")))
})

fs::dir_delete(file.path(tmp, project_name))
usethis::proj_set(getwd(), force = TRUE)

test_that("createTrainingProject() creates as expected when using bookdown and revealjs", { # nolint
  createTrainingProject(project_name,
    folder = tmp,
    handoutEngine = "bookdown", slideEngine = "revealjs",
    packagedeps = "none",
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
  expect_true(file.exists(file.path(tmp, project_name, "handouts")))
  expect_true(file.exists(file.path(
    tmp, project_name, "handouts",
    "index.Rmd"
  )))
  expect_true(file.exists(file.path(
    tmp, project_name, "slides",
    "revealjs_slides.Rmd"
  )))
})

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
usethis::proj_set(getwd(), force = TRUE)

test_that("createTrainingProject() creates as expected when using tufte and xaringan", { # nolint
  createTrainingProject(project_name,
    folder = tmp,
    handoutEngine = "tufte", slideEngine = "xaringan",
    packagedeps = "none",
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
  expect_true(file.exists(file.path(tmp, project_name, "handouts")))
  expect_true(file.exists(file.path(
    tmp, project_name, "handouts",
    "tufte_handout.Rmd"
  )))
  expect_true(file.exists(file.path(
    tmp, project_name, "slides",
    "xaringan_slides.Rmd"
  )))
})

test_that("createTrainingProject() cleans if there was an error", {
  mockery::stub(where = createTrainingProject,
                what = "createdirs",
                how = stop)
    expect_message(
      createTrainingProject(project_name,
        folder = tmp,
        handoutEngine = "tufte", slideEngine = "xaringan",
        packagedeps = "none",
        external_setup = NULL
      ),
      "Oops"
    )
    unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)

})

teardown({
fs::dir_delete(tmp)
usethis::proj_set(getwd(), force = TRUE)
unloadNamespace("tufte")
unloadNamespace("bookdown")
unloadNamespace("xaringan")
unloadNamespace("revealjs")
})
