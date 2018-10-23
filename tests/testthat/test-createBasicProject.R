context("createBasicProject")

project_name <- "basicProject"

test_that("createBasicProject() creates as expected when using defaults", {

  createBasicProject(project_name)

  expect_true(file.exists(file.path(project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(project_name, "R")))
  expect_true(file.exists(file.path(project_name, "README.Rmd")))
  expect_true(file.exists(file.path(project_name, "packrat")))
  expect_true(file.exists(file.path(project_name, ".git")))
  expect_true(file.exists(file.path(project_name, ".gitignore")))
  expect_true(file.exists(file.path(project_name, ".travis.yml")))

})

unlink(project_name, recursive = TRUE, force = TRUE)

test_that("createBasicProject() cleans if there was an error", {
  expect_message(createBasicProject("pRojects"),
                 "Oops")
})

