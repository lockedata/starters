context("createTrainingProject")

project_name <- "trainingProject"

test_that("createTrainingProject() creates as expected when using defaults",{

  createTrainingProject(project_name)

  expect_true(file.exists(file.path(project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(project_name, "R")))
  expect_true(file.exists(file.path(project_name, "README.Rmd")))
  expect_true(file.exists(file.path(project_name, "packrat")))
  expect_true(file.exists(file.path(project_name, ".git")))
  expect_true(file.exists(file.path(project_name, ".gitignore")))
  expect_true(file.exists(file.path(project_name, ".travis.yml")))
  expect_true(file.exists(file.path(project_name, "data")))
  expect_true(file.exists(file.path(project_name, "handouts")))
  expect_true(file.exists(file.path(project_name, "slides")))

})

unlink(project_name, recursive = TRUE, force = TRUE)

test_that("createTrainingProject() creates as expected when using bookdown and revealjs",{

  createTrainingProject(project_name, handoutEngine = "bookdown", slideEngine = "revealjs")

  expect_true(file.exists(file.path(project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(project_name, "R")))
  expect_true(file.exists(file.path(project_name, "README.Rmd")))
  expect_true(file.exists(file.path(project_name, "packrat")))
  expect_true(file.exists(file.path(project_name, ".git")))
  expect_true(file.exists(file.path(project_name, ".gitignore")))
  expect_true(file.exists(file.path(project_name, ".travis.yml")))
  expect_true(file.exists(file.path(project_name, "data")))
  expect_true(file.exists(file.path(project_name, "handouts")))
  expect_true(file.exists(file.path(project_name, "handouts", "index.Rmd")))
  expect_true(file.exists(file.path(project_name, "slides")))

})

unlink(project_name, recursive = TRUE, force = TRUE)

test_that("createTrainingProject() creates as expected when using tufte",{

  createTrainingProject(project_name, handoutEngine = "tufte")

  expect_true(file.exists(file.path(project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(project_name, "R")))
  expect_true(file.exists(file.path(project_name, "README.Rmd")))
  expect_true(file.exists(file.path(project_name, "packrat")))
  expect_true(file.exists(file.path(project_name, ".git")))
  expect_true(file.exists(file.path(project_name, ".gitignore")))
  expect_true(file.exists(file.path(project_name, ".travis.yml")))
  expect_true(file.exists(file.path(project_name, "data")))
  expect_true(file.exists(file.path(project_name, "handouts")))
  expect_true(file.exists(file.path(project_name, "handouts", "Tufte_Handout.Rmd")))
  expect_true(file.exists(file.path(project_name, "slides")))

})

unlink(project_name, recursive = TRUE, force = TRUE)
