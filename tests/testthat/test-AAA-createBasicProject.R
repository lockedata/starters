context("createBasicProject")

tmp <- tempfile(pattern = "aaa",
                 tempdir(check = TRUE))
fs::dir_create(tmp)

project_name <- "basicProject"

test_that("createBasicProject() creates as expected", {

  createBasicProject(project_name, folder = tmp,
                     packagedeps = "packrat",
                     git = TRUE,
                     external_setup = NULL)

  expect_true(file.exists(file.path(tmp, project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(tmp, project_name, "DESCRIPTION")))
  expect_true(dir.exists(file.path(tmp, project_name, "R")))
  expect_true(file.exists(file.path(tmp, project_name, "README.md")))
  expect_true(dir.exists(file.path(tmp, project_name, "packrat")))
  expect_true(file.exists(file.path(tmp, project_name, ".git")))
  expect_true(file.exists(file.path(tmp, project_name, ".gitignore")))

})

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
usethis::proj_set(getwd())

test_that("createBasicProject() creates as expected when using checkpoint", {
testthat::skip()
  createBasicProject(project_name, folder = tmp,
                     packagedeps = "checkpoint",
                     external_setup = NULL,
                     git = FALSE)

  expect_true(file.exists(file.path(tmp, project_name, paste0(project_name, ".Rproj"))))
  expect_true(file.exists(file.path(tmp, project_name, "DESCRIPTION")))
  expect_true(dir.exists(file.path(tmp, project_name, "R")))
  expect_true(file.exists(file.path(tmp, project_name, "README.md")))

})

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
usethis::proj_set(getwd())

test_that("createBasicProject() cleans if there was an error", {
  m <- mockery::mock(stop())
  with_mock(dir.create = m, {
    expect_message(createBasicProject("blablabla",
                                      external_setup = NULL),
                   "Oops")
  })


  test_that("createBasicProject() can create a GitHub repo", {
    skip_if_not(identical(Sys.getenv("TRAVIS"), "true"))
    createBasicProject(name = "test",
                       external_setup = list(
                         git_service = "GitHub",
                         login = "chibimaelle",
                         private = TRUE,
                         protocol = "ssh",
                         ci_activation = "travis"),
                       folder = tmp)

    expect_true(repo_exists("chibimaelle", "test"))
    gh::gh("DELETE /repos/:owner/:repo",
           owner = "chibimaelle", repo = "test")
    })

})

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
fs::dir_delete(tmp)
usethis::proj_set(getwd())
