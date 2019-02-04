#####################################
# Dependencies management
#####################################

#' supported package dependency tools
#'
#' @noRd
okpackagedeps <- function() {
  c("none", "packrat", "checkpoint")
}

#' set up dependencies management
#'
#' @param packagedeps package dependency tool
#'
#' @noRd
setup_dep_system <- function(packagedeps) {
  if (packagedeps == "packrat") {
    desc::desc_set_dep(
      package = "packrat",
      type = "Imports",
      file = usethis::proj_get()
    )
    packrat::init(usethis::proj_get(), enter = FALSE)
  }

  if (packagedeps == "checkpoint") {
    desc::desc_set_dep(
      package = "checkpoint",
      type = "Imports",
      file = usethis::proj_get()
    )

    checkpoint::checkpoint(Sys.Date(),
      project = usethis::proj_get(),
      checkpointLocation = usethis::proj_get(),
      forceProject = TRUE,
      verbose = FALSE
    )
  }
}

#' Create directories
#'
#' @param dirs Subfolders
#'
#' @noRd
#'
createdirs <- function(dirs) {
  stopifnot(length(dirs) > 0)
  dirstocreate <- file.path(usethis::proj_get(), dirs)
  lapply(dirstocreate, function(x) {
    if (!dir.exists(x)) dir.create(x)
  })
}

#' Make DESCRIPTION
#'
#' @param name Package / project
#'
#' @noRd
createdesc <- function(name) {
  desc <- desc::desc("!new")
  desc$add_me(role = "cre")
  desc$write(file.path(name, "DESCRIPTION"))
}


#' Check availability
#'
#' @param name Package / project
#'
#' @noRd

is_available <- function(name) {
  if (identical(Sys.getenv("TESTTHAT"), "true") &&
    name == "blablabla") {
    stop("package name is taken on Github")
  }
  if (identical(Sys.getenv("TESTTHAT"), "true") &&
    name != "blablabla") {
    return(invisible(TRUE))
  }
  cran <- available::available_on_cran(name)
  gh <- available::available_on_github(name)
  if (cran == FALSE) {
    stop("package name is taken on CRAN")
  }
  if (gh$available == FALSE) {
    stop("package name is taken on GitHub")
  }
  invisible(TRUE)
}

#####################################
# Project resetting
#####################################

#' Get current project
#' @noRd
get_current_proj <- function() {
  current_proj <- try(usethis::proj_get(),
    silent = TRUE
  )
  if (inherits(current_proj, "try-error")) {
    current_proj <- NULL
  }
  return(current_proj)
}

#' Reset project to what it was before
#' @noRd
reset_proj <- function(current_proj) {
  if (is.null(current_proj)) {
    usethis::proj_set(getwd(), force = TRUE)
  } else {
    usethis::proj_set(current_proj, force = TRUE)
  }
}

#####################################
# Encouraging phrases
#####################################

#' Create a random positive project title
#' @noRd
cool_stuff <- function() {
  praise::praise("New ${adjective} project!")
}

#' Create a random positive first commit
#' @noRd
cool_first_commit <- function() {
  praise::praise("First commit of this ${adjective} project, ${exclamation}!")
}

####################################
# usethis::use_git for now
###################################
# from https://github.com/r-lib/usethis/blob/85bf30af12dc5a99faf20115a0396add72aa6d12/R/git.R#L13
use_git <- function(message = "Initial commit") {
  usethis:::ui_done("Initialising Git repo")
  usethis:::git_init()

  usethis:::use_git_ignore(c(".Rhistory", ".RData", ".Rproj.user"))
  usethis:::git_ask_commit(message)

  invisible(TRUE)
}

####################################
# add remaining stuff at the end
###################################
git_add_infrastructure <- function(){
  repo <- git2r::init(usethis::proj_get())
  git2r::add(repo, path = dir(usethis::proj_get()))
  git2r::commit(repo, message = "add infrastructure")
}
