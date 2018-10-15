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
                                  dirs = c("data", "analysis", "outputs"),
                                  ...) {
  cran <- available::available_on_cran(name)
  gh <- available::available_on_github(name)
  if(cran == FALSE){
    stop('package name is taken on CRAN')
  }
  if(gh$available == FALSE){
    stop('package name is taken on Github')
  }
  createBasicProject(name, ...)
  createdirs(name, dirs)
  invisible(TRUE)

  
}
