#' @title Create a training project
#'
#' @description Create a project laid out for producing training materials
#'
#' @inheritParams createBasicProject
#' @param dirs Directories to create
#' @param handoutEngine Package for building handouts
#' @param slideEngine Package for building slides
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
createTrainingProject <- function(name, folder = getwd(),
                                  dirs = c("data", "handouts", "slides"),
                                  handoutEngine = "rmarkdown",
                                  slideEngine = "rmarkdown",
                                  travis = TRUE,
                                  packagedeps = "packrat",
                                  git = TRUE,
                                  readme = TRUE) {
  packagedeps <- match.arg(packagedeps, okpackagedeps())

  # Supported packages
  handoutEngine <- match.arg(handoutEngine,
                             handoutEngine())

  slideEngine <- match.arg(slideEngine,
                           slideEngine())

  if(!requireNamespace(handoutEngine, quietly = TRUE)){
    stop("You need to install ", handoutEngine, " first")
  }
  if(!requireNamespace(slideEngine, quietly = TRUE)){
    stop("You need to install ", slideEngine, " first")
  }

  # Skeleton
  message("Creating skeleton")
  createBasicProject(name,
                     folder = folder,
                     travis = travis,
                     packagedeps = "none",
                     git = git,
                     readme = readme)
  createdirs(dirs)

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

  setup_dep_system(packagedeps)


  invisible(TRUE)
}

handoutEngine <- function(){
  c("rmarkdown", "bookdown", "tufte")
}

slideEngine <- function(){
  c("rmarkdown", "revealjs", "xaringan")
}
