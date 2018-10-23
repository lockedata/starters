
#' Create directories
#'
#' @param rootdir Project
#' @param dirs Subfolders
#'
createdirs <- function(rootdir, dirs) {
  stopifnot(length(dirs) > 0)
  dirstocreate <- file.path(rootdir, dirs)
  lapply(dirstocreate, function(x){if(!dir.exists(x)) dir.create(x)})
}

#' Make DESCRIPTION
#'
#' @param name Package / project
createdesc <- function(name) {
  desc <- desc::desc("!new")
  desc$add_me(role = "cre")
  desc$write(file.path(name, "DESCRIPTION"))
}


#' Check availability
#'
#' @param name Package / project

is_available <- function(name) {
  cran <- available::available_on_cran(name)
  gh <- available::available_on_github(name)
  if(cran == FALSE){
    stop('package name is taken on CRAN')
  }
  if(gh$available == FALSE){
    stop('package name is taken on Github')
  }
  invisible(TRUE)
}


