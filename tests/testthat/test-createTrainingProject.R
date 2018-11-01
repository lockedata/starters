context("createTrainingProject")
tmp <- tempdir(check = TRUE)

project_name <- "trainingProject2"

test_that("createTrainingProject() creates as expected when using defaults",{

  createTrainingProject(project_name, folder = tmp,
                        packagedeps = "none")
  expect_true(file.exists(file.path(tmp, project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(tmp, project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(tmp, project_name, "R")))
  expect_true(file.exists(file.path(tmp, project_name, "README.Rmd")))
  expect_true(file.exists(file.path(tmp, project_name, ".git")))
  expect_true(file.exists(file.path(tmp, project_name, ".gitignore")))
  expect_true(file.exists(file.path(tmp, project_name, ".travis.yml")))
  expect_true(file.exists(file.path(tmp, project_name, "data")))
  expect_true(file.exists(file.path(tmp, project_name, "handouts")))
  expect_true(file.exists(file.path(tmp, project_name, "slides")))

})

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
usethis::proj_set(getwd())

test_that("createTrainingProject() creates as expected when using bookdown and revealjs",{

  createTrainingProject(project_name, folder = tmp,
      handoutEngine = "bookdown", slideEngine = "revealjs",
      packagedeps = "none")
  expect_true(file.exists(file.path(tmp, project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(tmp, project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(tmp, project_name, "R")))
  expect_true(file.exists(file.path(tmp, project_name, "README.Rmd")))
  expect_true(file.exists(file.path(tmp, project_name, ".git")))
  expect_true(file.exists(file.path(tmp, project_name, ".gitignore")))
  expect_true(file.exists(file.path(tmp, project_name, ".travis.yml")))
  expect_true(file.exists(file.path(tmp, project_name, "data")))
  expect_true(file.exists(file.path(tmp, project_name, "handouts")))
  expect_true(file.exists(file.path(tmp, project_name, "handouts", "index.Rmd")))
  expect_true(file.exists(file.path(tmp, project_name, "slides", "revealjs_slides.Rmd")))

})

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
usethis::proj_set(getwd())

test_that("createTrainingProject() creates as expected when using tufte and xaringan",{
 createTrainingProject(project_name, folder = tmp,
      handoutEngine = "tufte", slideEngine = "xaringan",
      packagedeps = "none")

  expect_true(file.exists(file.path(tmp, project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(tmp, project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(tmp, project_name, "R")))
  expect_true(file.exists(file.path(tmp, project_name, "README.Rmd")))
  expect_true(file.exists(file.path(tmp, project_name, ".git")))
  expect_true(file.exists(file.path(tmp, project_name, ".gitignore")))
  expect_true(file.exists(file.path(tmp, project_name, ".travis.yml")))
  expect_true(file.exists(file.path(tmp, project_name, "data")))
  expect_true(file.exists(file.path(tmp, project_name, "handouts")))
  expect_true(file.exists(file.path(tmp, project_name, "handouts", "tufte_handout.Rmd")))
  expect_true(file.exists(file.path(tmp, project_name, "slides", "xaringan_slides.Rmd")))

})

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
fs::dir_delete(tmp)
usethis::proj_set(getwd())
