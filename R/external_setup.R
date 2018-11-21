#' Set up the repo for the project
#' @param git_service git platform to use
#' @param login login for the git platform
#' @param protocol protocol to use
#' @param ci_activation how to activate CI stuff
#' @param project project name (repo name)
#' @param title project title (repo description)
#' @noRd

setup_repo <- function(git_service, login,
                       private, protocol,
                       ci_activation,
                       name, title) {
  if (tolower(git_service) != "github") {
    stop(glue::glue(
      "Only GitHub is supported at the moment, not {git_service}."
    ),
    call. = FALSE
    )
  }

  setup_gh_repo(
    username = login, private = private,
    protocol = protocol,
    name = name, title = title
  )

  if (!is.null(ci_activation)) {
    if (ci_activation != "travis") {
      stop(glue::glue(
        "Only travis is supported at the moment, not {ci_activation}."
      ),
      call. = FALSE
      )
    }

    if (ci_activation == "travis") {
      usethis::use_travis()
      add_travis_badge(login, name)
    }
  }
}

#' Add Travis badge to the README
#' @param login login (assumed to be the same for the git
#' platform and Travis)
#' @param name project name (repo name)
#' @noRd
add_travis_badge <- function(login, name) {
  readme_path <- find_readme()
  readme <- readLines(readme_path)
  readme[grepl("<!-- badges -->", readme)] <-
    paste(
      readme[grepl("<!-- badges -->", readme)],
      glue::glue("[![Build Status](https://travis-ci.org/{login}/{name}.svg?branch=master)](https://travis-ci.org/{login}/{name})") # nolint
    )
  writeLines(readme, readme_path)
}
