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
  # Supported packages
  handoutEngine <- match.arg(handoutEngine, c("rmarkdown", "bookdown", "tufte"))
  slideEngine <- match.arg(slideEngine, c("rmarkdown", "revealjs", "xaringan"))

  # Installation dir
  usePackrat <- !methods::hasArg("packrat")
  if (!usePackrat)
    usePackrat <- list(...)[["packrat"]]
  installDir <- ifelse(usePackrat, name, .libPaths())

  # Skeleton
  message("Creating skeleton")
  createBasicProject(name, ...)
  createdirs(name, dirs)

  # Handouts prep
  if ("handouts" %in% dirs) {
    devtools:::add_desc_package(name, "Imports", handoutEngine)

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
    devtools:::add_desc_package(name, "Imports", slideEngine)

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

  if (usePackrat) {
    packrat::snapshot(name)
    packrat::restore(name)
  }

  invisible(TRUE)
}
