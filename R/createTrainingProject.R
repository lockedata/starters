#' Create a project laid out for producing training materials
#'
#' @param name Project
#' @param dirs Directories to create
#' @param handoutEngine Package for building handouts
#' @param slideEngine Package for building slides
#' @param ... Pass to [createBasicProject()]
#'
#' @export
#'
#' @examples
#' \dontrun{
#' proj<-"trainingproj"
#' createTrainingProject(proj)
#' list.files(proj)
#' unlink(proj)
#' }
createTrainingProject <- function(name,
                                  dirs = c("data", "handouts", "slides"),
                                  handoutEngine = "rmarkdown",
                                  slideEngine = "rmarkdown",
                                  ...) {
  #  Validate name
  if(!validateName(name)){
    stop("Failed name validation: The name should contain only (ASCII) letters, numbers and dot, have at least two characters and start with a letter and not end in a dot.")
  }

  # Supported packages
  handoutEngine <- match.arg(handoutEngine, c("rmarkdown", "bookdown", "tufte"))
  slideEngine <- match.arg(slideEngine, c("rmarkdown", "revealjs", "xaringan"))

  if(!requireNamespace(handoutEngine, quietly = TRUE)){
    stop("You need to install ",handoutEngine, " first")
  }
  if(!requireNamespace(slideEngine, quietly = TRUE)){
    stop("You need to install ",slideEngine, " first")
  }

  # Skeleton
  message("Creating skeleton")
  createBasicProject(name, ...)
  createdirs(name, dirs)

  # Handouts prep
  if ("handouts" %in% dirs) {
    desc::desc_set_dep(package = handoutEngine,
                       type = "Imports",
                       file = usethis::proj_get())
    if (handoutEngine != "rmarkdown") {
      message(paste(handoutEngine, "demo added"))
      file.copy(
        list.files(system.file("templates", handoutEngine, package = "pRojects"), full.names = TRUE),
        file.path(name,"handouts"),
        overwrite = TRUE,
        recursive = TRUE
      )
    }

  }

  # Slides prep
  if ("slides" %in% dirs) {
    desc::desc_set_dep(package = slideEngine,
                       type = "Imports",
                       file = usethis::proj_get())

    if (slideEngine != "rmarkdown") {
      message(paste(slideEngine, "demo added"))
      file.copy(
        list.files(system.file("templates", slideEngine, package = "pRojects"), full.names = TRUE),
        file.path(name, "slides"),
        overwrite = TRUE,
        recursive = TRUE
      )
    }

  }

  # Perform some basic packrat initialisation
  if("packagedeps" %in% names(list(...))){
    pkgdeps <- list(...)[["packagedeps"]]
    if(pkgdeps == "packrat"){
      packrat::snapshot(name)
      packrat::restore(name)
    }
  }

  invisible(TRUE)
}
