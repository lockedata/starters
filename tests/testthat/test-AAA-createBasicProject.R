context("createBasicProject")

tmp <- tempdir(check = TRUE)
project_name <- "basicProject"

test_that("createBasicProject() creates as expected when using defaults", {

  createBasicProject(project_name, folder = tmp,
                     packagedeps = "packrat")

  expect_true(file.exists(file.path(tmp, project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(tmp, project_name, "DESCRIPTION")))
  expect_true(dir.exists(file.path(tmp, project_name, "R")))
  expect_true(file.exists(file.path(tmp, project_name, "README.Rmd")))
  expect_true(dir.exists(file.path(tmp, project_name, "packrat")))
  expect_true(file.exists(file.path(tmp, project_name, ".git")))
  expect_true(file.exists(file.path(tmp, project_name, ".gitignore")))
  expect_true(file.exists(file.path(tmp, project_name, ".travis.yml")))

})

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
usethis::proj_set(getwd())

# test_that("createBasicProject() creates as expected when using checkpoint", {
#
#   createBasicProject(project_name, folder = tmp,
#                      packagedeps = "checkpoint")
#
#   expect_true(file.exists(file.path(tmp, project_name, paste0(project_name, ".Rproj"))))
#   expect_true(file.exists(file.path(tmp, project_name, "DESCRIPTION")))
#   expect_true(dir.exists(file.path(tmp, project_name, "R")))
#   expect_true(file.exists(file.path(tmp, project_name, "README.Rmd")))
#   expect_true(file.exists(file.path(tmp, project_name, ".git")))
#   expect_true(file.exists(file.path(tmp, project_name, ".gitignore")))
#   expect_true(file.exists(file.path(tmp, project_name, ".travis.yml")))
#
# })

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
usethis::proj_set(getwd())

test_that("createBasicProject() cleans if there was an error", {
  m <- mockery::mock(stop())
  with_mock(dir.create = m, {
    expect_message(createBasicProject("blablabla"),
                   "Oops")
  })

})

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
fs::dir_delete(tmp)
usethis::proj_set(getwd())
