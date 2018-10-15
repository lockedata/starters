context("createPackageProject")

project_name <- "packageProject2"

test_that("createPackageProject() creates as expected when using defaults",{

  proj <- try(createPackageProject(project_name))
  if(!inherits(proj, 'try-error')){
    expect_true(file.exists(file.path(project_name, paste0(project_name, ".Rproj"))))
    expect_true(file.exists(file.path(project_name, "codecov.yml")))
    expect_true(file.exists(file.path(project_name, "CONDUCT.md")))
    expect_true(file.exists(file.path(project_name, "DESCRIPTION")))
    expect_true(file.exists(file.path(project_name, "LICENSE")))
    expect_true(file.exists(file.path(project_name, "NAMESPACE")))
    expect_true(file.exists(file.path(project_name, "NEWS.md")))
    expect_true(file.exists(file.path(project_name, "R")))
    expect_true(file.exists(file.path(project_name, "README.Rmd")))
    expect_true(file.exists(file.path(project_name, "tests")))
    expect_true(file.exists(file.path(project_name, "vignettes")))
    expect_true(file.exists(file.path(project_name, ".git")))
    expect_true(file.exists(file.path(project_name, ".gitignore")))
    expect_true(file.exists(file.path(project_name, ".travis.yml")))
  }
})

unlink(project_name, recursive = TRUE, force = TRUE)
