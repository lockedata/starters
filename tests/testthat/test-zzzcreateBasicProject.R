project_name <- "basicProject"

test_that("createBasicProject() creates as expected", {
  tmp <- temp_folder("bbb")
  createBasicProject(project_name,
                     folder = tmp,
                     packagedeps = "renv",
                     git = TRUE,
                     external_setup = NULL
  )

  expect_true(file.exists(file.path(
    tmp, project_name,
    paste0(project_name, ".Rproj")
  )))
  expect_true(file.exists(file.path(tmp, project_name, "DESCRIPTION")))
  expect_true(dir.exists(file.path(tmp, project_name, "R")))
  expect_true(file.exists(file.path(tmp, project_name, "README.Rmd")))
  expect_true(dir.exists(file.path(tmp, project_name, "renv")))
  expect_true(file.exists(file.path(tmp, project_name, ".git")))
  expect_true(file.exists(file.path(tmp, project_name, ".gitignore")))
})

test_that("createBasicProject() errors if name missing or not correct", {
  tmp <- temp_folder("bbb")

  expect_error(createBasicProject(
    folder = tmp,
    packagedeps = "renv",
    git = TRUE,
    external_setup = NULL
  ))

  expect_error(createBasicProject(
    name = 1,
    folder = tmp,
    packagedeps = "renv",
    git = TRUE,
    external_setup = NULL
  ))

  expect_error(createBasicProject(
    name = "a",
    folder = tmp,
    packagedeps = "renv",
    git = TRUE,
    external_setup = NULL
  ))
})

test_that("createBasicProject() cleans if there was an error", {
  tmp <- temp_folder("bbb")

  mockery::stub(where = .createBasicProject,
                what = "desc::desc_set",
                how = stop)
    expect_message(
      .createBasicProject("blablabla",
                         folder = tmp,
        external_setup = NULL,
        packagedeps = "none"
      ),
      "Oops"
    )
})

test_that("createBasicProject() can create a GitHub repo", {
  skip_if_not(identical(Sys.getenv("TRAVIS"), "true"))

  tmp <- temp_folder("bbb")

  testthat::skip_if_not(nzchar(Sys.getenv("GITHUB_PAT")))
  testthat::skip_if_not(gh::gh_whoami()$name == "chibimaelle")
  createBasicProject(
    name = "test",
    packagedeps = "none",
    external_setup = list(
      git_service = "GitHub",
      login = "chibimaelle",
      private = FALSE,
      protocol = "ssh",
      ci_activation = NULL
    ),
    folder = tmp
  )

  expect_true(repo_exists("chibimaelle", "test"))

  quoted_expression <- quote(gh::gh("DELETE /repos/:owner/:repo",
                         owner = "chibimaelle", repo = "test"
    ))

  expect_true(gh_retry(quoted_expression))
})
