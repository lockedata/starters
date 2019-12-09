setup({
  options(usethis.description = list(
    usethis.name = "Jane Doe",
    usethis.description = list(
      `Authors@R` = 'person("Jane", "Doe", email = "jane@example.com", role = c("aut", "cre"))', # nolint
      License = "MIT + file LICENSE",
      Version = "0.0.0.9000"
    )
  ))
})

project_name <- "packageProject2"

test_that("createPackageProject() errors if name missing or not correct", {

  tmp <- temp_folder("ppp")

  expect_error(createPackageProject(
    folder = tmp,
    packagedeps = "renv",
    git = TRUE,
    external_setup = NULL
  ))

  expect_error(createPackageProject(
    name = 1,
    folder = tmp,
    packagedeps = "renv",
    git = TRUE,
    external_setup = NULL
  ))

  expect_error(createPackageProject(
    name = "a",
    folder = tmp,
    packagedeps = "renv",
    git = TRUE,
    external_setup = NULL
  ))
})

test_that("createPackageProject() creates as expected when using defaults", {

  tmp <- temp_folder("ppp")

  createPackageProject(project_name,
    folder = tmp,
    external_setup = NULL
  )
  expect_true(file.exists(file.path(
    tmp, project_name,
    paste0(project_name, ".Rproj")
  )))
  # expect_true(file.exists(file.path(tmp, project_name, "codecov.yml")))
  expect_true(file.exists(file.path(tmp, project_name, "_pkgdown.yml")))
  expect_true(file.exists(file.path(tmp, project_name, "CODE_OF_CONDUCT.md")))
  expect_true(file.exists(file.path(tmp, project_name, "DESCRIPTION")))
  expect_true(file.exists(file.path(tmp, project_name, "LICENSE")))
  expect_true(file.exists(file.path(tmp, project_name, "NAMESPACE")))
  expect_true(file.exists(file.path(tmp, project_name, "NEWS.md")))
  expect_true(file.exists(file.path(tmp, project_name, "R")))
  expect_true(file.exists(file.path(tmp, project_name, "README.Rmd")))
  expect_true(file.exists(file.path(tmp, project_name, "tests")))
  expect_true(file.exists(file.path(tmp, project_name, "vignettes")))
  expect_true(file.exists(file.path(tmp, project_name, ".git")))
  expect_true(file.exists(file.path(tmp, project_name, ".gitignore")))
})

test_that("createPackageProject() cleans if there was an error", {

  tmp <- temp_folder("ppp")

  mockery::stub(where = createPackageProject,
                what = "usethis::use_testthat",
                how = stop)
    expect_message(
      createPackageProject("reallynotapkgnameplease",
        external_setup = NULL
      ),
      "Oops"
    )

})
