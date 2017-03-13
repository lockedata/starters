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

createdesc <- function(name) {
  desc <- devtools:::build_description(
    devtools:::extract_package_name(name)
  )
  devtools:::write_dcf(file.path(name,"DESCRIPTION"),desc)
}
