#' Create a project laid out for an analysis project
#'
#' @inheritParams createBasicProject
#' @param dirs Directories to create
#'
#' @export
#'
#' @examples
#' \dontrun{
#' folder <- tempdir()
#' createAnalysisProject(
#'   name = "doggos", title = "Counting cute dogs",
#'   folder = folder,
#'   packagedeps = "none",
#'   git = TRUE, external_setup = NULL,
#'   reset = TRUE,
#'   dirs = c("cats", "dogs")
#' )
#' list.files(file.path(folder, "doggos"))
#' unlink(file.path(folder, "doggos"))
#' }
createAnalysisProject <- function(name, title = NULL,
                                  folder = getwd(),
                                  initial_status = "wip",
                                  dirs = c("data", "analysis", "outputs"),
                                  packagedeps = "packrat",
                                  git = TRUE,
                                  external_setup = list(
                                    git_service = "GitHub",
                                    login = gh::gh_whoami()$login,
                                    private = FALSE,
                                    protocol = "ssh",
                                    ci_activation = "travis"
                                  ),
                                  reset = TRUE) {
  if (missing(name)) stop("name is required")
  if (!is.character(name)) stop("name has to be a character")
  if (nchar(name) < 2) stop("name needs to have at least two characters")

  packagedeps <- match.arg(packagedeps, okpackagedeps())

  current_proj <- get_current_proj()
  tryCatch({
    createBasicProject(
      name = name,
      title = title,
      folder = folder,
      initial_status = initial_status,
      packagedeps = packagedeps,
      git = git,
      external_setup = external_setup,
      reset = FALSE
    )
    createdirs(dirs)
  },
  error = function(e) {
    message(paste("Error:", e$message))
    e
    # delete folder created earlier
    unlink(file.path(folder, name), recursive = TRUE)
    message(sprintf("Oops! An error was found and the `%s` directory was deleted", name)) # nolint
  }
  )

  if (reset) {
    reset_proj(current_proj)
  }

  invisible(TRUE)
}

#' @export

#' @describeIn createAnalysisProject aesthetic addition for continuity purposes
create_analysis_project = createAnalysisProject
