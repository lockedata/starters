#' Create a project laid out for an analysis project
#'
#' @inheritParams createBasicProject
#' @param dirs Directories to create
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
createAnalysisProject <- function(name, folder = getwd(),
                                  travis = TRUE,
                                  packagedeps = "packrat",
                                  git = TRUE,
                                  readme = TRUE,
                                  dirs = c("data", "analysis", "outputs")) {
  packagedeps <- match.arg(packagedeps, okpackagedeps())
  createBasicProject(name,
                     folder = folder,
                     travis = travis,
                     packagedeps = packagedeps,
                     git = git,
                     readme = readme)
  createdirs(dirs)
  invisible(TRUE)


}
