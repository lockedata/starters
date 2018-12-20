#' Create a package the usethis way with a number of infrastructure
#' commands executed to save you hassle
#'
#' @param name Project / package name
#' @param title "What the Project Does (One Line, Title Case)"
#'              If NULL, a random one will be generated.
#' @param folder Folder under which to create the project
#' @param initial_status initial repostatus.org status for the project,
#'                       whose badge will be added to the README.
#' @param git Configure Git
#' @param pkgdown Add a pkgdown config file
#' @param bestPractices Run additional best practice commands
#' @param coverage What code coverage platform to use, "codecov" or "coveralls".
#' @param external_setup How to do the partly interactive setup
#'  of online git, CI and coverage platforms. If NULL, no setup.
#'  \itemize{
#'  \item \code{git_service} Only "GitHub" is supported at the moment.
#'  \item \code{login} username or organization name to use for the git service.
#'                If NULL, no GitHub repo is created.
#'  \item \code{private} whether to make the created repo private
#'  \item \code{protocol} "ssh" or "https", protocol to use for GitHub
#'  \item \code{ci_activation} Only NULL, and "travis" are supported at the moment.
#'  "travis" means calling \code{usethis::use_travis()} and adding the Travis
#'  badge to the README.
#'  }#' @param title "What the Project Does (One Line, Title Case)"
#'              If NULL, a random one will be generated.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' folder <- tempdir()
#' createPackageProject(
#'   name = "doggos", title = "Counting cute dogs",
#'   folder = folder,
#'   git = TRUE, external_setup = NULL
#' )
#' list.files(file.path(folder, "doggos"))
#' unlink(file.path(folder, "doggos"))
#' }
createPackageProject <- function(name, title = NULL,
                                 folder = getwd(),
                                 initial_status = "wip",
                                 bestPractices = TRUE,
                                 coverage = "codecov",
                                 git = TRUE,
                                 pkgdown = TRUE,
                                 external_setup = list(
                                   git_service = "GitHub",
                                   login = gh::gh_whoami()$login,
                                   private = FALSE,
                                   protocol = "ssh",
                                   ci_activation = "tic"
                                 )) {
  # create title
  if (is.null(title)) {
    title <- cool_stuff()
  }
  # only go on if available pkg name
  if (is_available(name)) {
    current_proj <- get_current_proj()
    tryCatch({
      # create directory
      dir.create(file.path(folder, name))
      # set active project to directory
      usethis::proj_set(file.path(folder, name),
        force = TRUE
      )
      # create package skeleton
      usethis::create_package(file.path(folder, name),
        open = FALSE,
        rstudio = TRUE,
        fields = list(License = "MIT + file LICENSE")
      )
      desc::desc_set("Title", title,
        file = usethis::proj_get()
      )
      if (bestPractices) {
        usethis::use_code_of_conduct()

        maintainer <- try(whoami::fullname(), silent = TRUE)

        if (inherits(maintainer, "try-error")) {
          maintainer <- "Jane Doe"
        }

        usethis::use_template("license-mit.md",
          "LICENSE.md",
          ignore = TRUE,
          data = list(
            year = format(Sys.Date(), "%Y"),
            name = maintainer,
            project = name
          )
        )
        usethis::use_template("license-mit.txt",
          "LICENSE",
          data = list(
            year = format(Sys.Date(), "%Y"),
            name = maintainer,
            project = name
          )
        )
        usethis::use_news_md(open = FALSE)
        usethis::use_package_doc()

        # README stuff
        usethis::use_readme_rmd(open = FALSE)
        readme_path <- find_readme()
        # add badges sign
        add_badges_sign(readme_path)
        # status
        add_repo_status(initial_status)

        usethis::use_testthat()
        usethis::use_vignette(name)
        if (git) {
          usethis::use_git(message = cool_first_commit())
        }

        if (pkgdown) {
          usethis::use_pkgdown()
          fs::dir_delete(file.path(
            usethis::proj_get(),
            "docs"
          ))
        }

        if (!is.null(external_setup)) {
          setup_repo(
            name = name,
            title = title,
            git_service = external_setup$git_service,
            login = external_setup$login,
            private = external_setup$private,
            protocol = external_setup$protocol,
            ci_activation = external_setup$ci_activation
          )
        }
      }
    },
    error = function(e) {
      message(paste("Error:", e$message))
      e
      # delete folder created earlier
      unlink(file.path(folder, name), recursive = TRUE)
      message(sprintf("Oops! An error was found and the `%s` directory was deleted", name)) # nolint
    }
    )
  }
  reset_proj(current_proj)
  invisible(TRUE)
}

#' @describeIn createPackageProject aesthetic addition for continuity purposes
create_package_project = createPackageProject
