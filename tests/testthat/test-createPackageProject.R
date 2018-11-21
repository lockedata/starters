context("createPackageProject")
tmp <- tempfile(
  pattern = "aaa",
  tempdir(check = TRUE)
)
fs::dir_create(tmp)

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

test_that("createPackageProject() creates as expected when using defaults", {
  createPackageProject(project_name,
    folder = tmp,
    external_setup = NULL
  )
  expect_true(file.exists(file.path(tmp, project_name,
                                    paste0(project_name, ".Rproj"))))
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

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
usethis::proj_set(getwd(), force = TRUE)

test_that("createPackageProject() cleans if there was an error", {
  m <- mockery::mock(stop())
  with_mock(dir.create = m, {
    expect_message(
      createPackageProject("reallynotapkgnameplease",
        external_setup = NULL
      ),
      "Oops"
    )
  })
})

unlink(file.path(tmp, project_name), recursive = TRUE, force = TRUE)
fs::dir_delete(tmp)
usethis::proj_set(getwd(), force = TRUE)
