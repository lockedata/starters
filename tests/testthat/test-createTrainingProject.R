context("createTrainingProject")
tmp <- tempdir(check = TRUE)
cur <- getwd()

setup({
  setwd(tmp)
})
teardown({
  fs::dir_delete(tmp)
  setwd(cur)
})


project_name <- "trainingProject2"

test_that("createTrainingProject() creates as expected when using defaults",{

  createTrainingProject(project_name,
                        packagedeps = "none",
                        git = FALSE,
                        readme = FALSE)
  expect_true(file.exists(file.path(project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(project_name, "R")))
  expect_true(file.exists(file.path(project_name, "README.Rmd")))
  expect_true(file.exists(file.path(project_name, ".git")))
  expect_true(file.exists(file.path(project_name, ".gitignore")))
  expect_true(file.exists(file.path(project_name, ".travis.yml")))
  expect_true(file.exists(file.path(project_name, "data")))
  expect_true(file.exists(file.path(project_name, "handouts")))
  expect_true(file.exists(file.path(project_name, "slides")))

})

unlink(project_name, recursive = TRUE, force = TRUE)

test_that("createTrainingProject() creates as expected when using bookdown and revealjs",{

  createTrainingProject(project_name,
      handoutEngine = "bookdown", slideEngine = "revealjs",
      packagedeps = "none",
      git = FALSE,
      readme = FALSE)
  expect_true(file.exists(file.path(project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(project_name, "R")))
  expect_true(file.exists(file.path(project_name, "README.Rmd")))
  expect_true(file.exists(file.path(project_name, ".git")))
  expect_true(file.exists(file.path(project_name, ".gitignore")))
  expect_true(file.exists(file.path(project_name, ".travis.yml")))
  expect_true(file.exists(file.path(project_name, "data")))
  expect_true(file.exists(file.path(project_name, "handouts")))
  expect_true(file.exists(file.path(project_name, "handouts", "index.Rmd")))
  expect_true(file.exists(file.path(project_name, "slides", "revealjs_slides.Rmd")))

})

unlink(project_name, recursive = TRUE, force = TRUE)

test_that("createTrainingProject() creates as expected when using tufte and xaringan",{
 createTrainingProject(project_name,
      handoutEngine = "tufte", slideEngine = "xaringan",
      packagedeps = "none",
      git = FALSE,
      readme = FALSE)

  expect_true(file.exists(file.path(project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(project_name, "R")))
  expect_true(file.exists(file.path(project_name, "README.Rmd")))
  expect_true(file.exists(file.path(project_name, ".git")))
  expect_true(file.exists(file.path(project_name, ".gitignore")))
  expect_true(file.exists(file.path(project_name, ".travis.yml")))
  expect_true(file.exists(file.path(project_name, "data")))
  expect_true(file.exists(file.path(project_name, "handouts")))
  expect_true(file.exists(file.path(project_name, "handouts", "tufte_handout.Rmd")))
  expect_true(file.exists(file.path(project_name, "slides", "xaringan_slides.Rmd")))

})

unlink(project_name, recursive = TRUE, force = TRUE)
