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
# add remaining stuff at the end
###################################
git_add_infrastructure <- function(){
  repo <- git2r::init(usethis::proj_get())
  if(length(git2r::status(repo)$unstaged) > 0){
    git2r::add(repo, path = dir(usethis::proj_get()))
    git2r::commit(repo, message = "add infrastructure")

  }
}

#####################################
# retries for gh
#####################################
gh <- gh::gh
gh_retry <- function(quoted_expression){
  ok <- FALSE
  i <- 1
  while (!ok && i < 6){
    message(glue::glue(
      "Trying to create GitHub repo, try {i}"))
    response <- try(eval(quoted_expression), silent = TRUE)
    ok <- !inherits(response, "try-error")
    i <- i + 1
    Sys.sleep(2^(i-1))
  }
  return(ok)
}
