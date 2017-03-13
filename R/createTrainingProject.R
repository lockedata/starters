#' Create a project laid out for producing training materials
#'
#' @param name Project
#' @param dirs Directories to create
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
                                  dirs = c("R", "data", "handouts", "slides"),
                                  ...) {
  createBasicProject(name, ...)
  createdirs(name, dirs)
  invisible(TRUE)
}
