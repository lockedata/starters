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
                                  github = gh::gh_whoami()$login,
                                  private = FALSE,
                                  protocol = "ssh",
                                  readme = TRUE,
                                  dirs = c("data", "analysis", "outputs")) {
  packagedeps <- match.arg(packagedeps, okpackagedeps())
  check_github_name(github, name)
  current_proj <- get_current_proj()
  createBasicProject(name,
                     folder = folder,
                     travis = travis,
                     packagedeps = packagedeps,
                     git = git,
                     github = github,
                     private = private,
                     protocol = protocal,
                     readme = readme,
                     reset = FALSE)
  createdirs(dirs)
  reset_proj(current_proj)
  invisible(TRUE)


}
