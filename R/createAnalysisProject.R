#' Create a project laid out for an analysis project
#'
#' @param name Project
#' @param dirs Directories to create
#' @param ... Pass to [createBasicProject()]
#'
#' @export
#'
#' @examples
#' \dontrun{
#' proj<-"analysisproj"
#' createAnalysisProject(proj)
#' list.files(proj)
#' unlink(proj)
#' }
createAnalysisProject <- function(name,
                                  dirs = c("R", "data", "analysis", "outputs"),
                                  ...) {
  createBasicProject(name, ...)
  createdirs(name, dirs)
  invisible(TRUE)
}
