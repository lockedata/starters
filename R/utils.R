######################################
# Dependencies management
#####################################
#' supported package dependency tools
#'
#' @noRd
okpackagedeps <- function() {
  c("none", "renv")
}

#' set up dependencies management
#'
#' @param packagedeps package dependency tool
#'
#' @noRd
setup_dep_system <- function(packagedeps) {
  if (packagedeps == "renv") {
    desc::desc_set_dep(
      package = "renv",
      type = "Imports",
      file = usethis::proj_get()
    )
    renv::init(project = usethis::proj_get(),
               restart = FALSE)
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
reset_proj <- function(current_proj, current_wd) {
  usethis::proj_set(current_proj, force = TRUE)
  setwd(current_wd)
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

#####################################
# Process inputs in shiny gadget
#####################################

#' Treat empty string as NULL
#' @noRd
empty_as_null <- function(arg) {
  if(arg == "") return(NULL)
  arg
}

#' Create config list for external_setup
#' @noRd
ext_setup <- function(input) {
  if(!input$externalSetup) {
    NULL
  } else {
    list(
      git_service = input$git_service,
      private = input$private,
      protocol = input$protocol,
      login = input$login,
      ci_activation = ifelse(input$ci_activation == "", NULL, input$ci_activation)
    )
  }
}

#' Capture expression, write to clipboard, evaluate & output as message
#' @noRd
capture <- function(x) {
  str_x <- deparse(x)
  eval(x)
  message(
    "The starters function call is shown below and has been copied to the clipboard:\n\n",
    str_x
  )
  clipr::write_clip(str_x)
}

####################
# name validation
####################
#' Validate name
#' @noRd
#' @param name Package / project

validate_name <- function(name) {
  if (missing(name)) stop("Failed name validation: The name is required.",
                          call. = FALSE)
  if (!is.character(name)) stop("Failed name validation: The name has to be a character.",
                                call. = FALSE)
  if(length(name) > 1) stop("Failed name validation: Please only provide one name.")
  if (nchar(name) < 2) stop("Failed name validation: The name needs to have at least two characters.",
                            call. = FALSE)
  #  Validate name
  if(!grepl("^[A-Za-z](?:\\.?[A-Za-z0-9]+)*[^\\.]$", name)) {

    stop("Failed name validation: The name should contain only (ASCII) letters, numbers and dot,start with a letter and not end in a dot.",# nolint
         call. = FALSE)
  }
  invisible(TRUE)
}
