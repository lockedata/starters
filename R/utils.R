#' Revised function to not try to open file
#'
#' @param pkg See [devtools::use_news_md()]
#'
use_news_md <- function(pkg = ".") {
  pkg <- devtools:::as.package(pkg)
  devtools:::use_template("NEWS.md", data = pkg, pkg = pkg)
}

#' Revised function to not try to open file
#'
#' @param pkg See [devtools::use_package_doc()]
#'
use_package_doc <- function(pkg = ".") {
  pkg <- devtools:::as.package(pkg)

  devtools:::use_template(
    "packagename-package.r",
    file.path("R", paste(pkg$package, "-package.r", sep = "")),
    data = list(name = pkg$package),
    pkg = pkg
  )
}

#' Revised function to not try to open file
#'
#' @param pkg See [devtools::use_readme_rmd()]
#'
use_readme_rmd <- function(pkg = ".") {
  pkg <- devtools:::as.package(pkg)
  if (packageVersion("devtools") >= "1.12.0.9000") {
    devtools:::use_template("omni-README", save_as = "README.Rmd", ignore = TRUE,  pkg = pkg)
  }
  else {
    devtools:::use_template("README.Rmd", ignore = TRUE,  pkg = pkg)
  }
  devtools:::use_build_ignore("^README-.*\\.png$", escape = FALSE, pkg = pkg)
  if (devtools:::uses_git(pkg$path) && !file.exists(pkg$path, ".git",
                                         "hooks", "pre-commit")) {
    message("* Adding pre-commit hook")
    devtools:::use_git_hook("pre-commit", devtools:::render_template("readme-rmd-pre-commit.sh"),
                 pkg = pkg)
  }
  invisible(TRUE)
}

#' Create directories
#'
#' @param rootdir Project
#' @param dirs Subfolders
#'
createdirs <- function(rootdir, dirs) {
  stopifnot(length(dirs) > 0)
  dirstocreate <- file.path(rootdir, dirs)
  lapply(dirstocreate, dir.create)
}

#' Make DESCRIPTION
#'
#' @param name Package / project
createdesc <- function(name) {
  desc <- devtools:::build_description(
    devtools:::extract_package_name(name)
  )
  devtools:::write_dcf(file.path(name,"DESCRIPTION"),desc)
}
