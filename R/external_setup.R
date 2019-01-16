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
      usethis::use_template("dot-travis.yml",
                            target = ".travis.yml",
                            package = "travis")
      travis::travis_enable()
      # copy custom tic depending on proj
      # if sthg
      travis::use_travis_deploy()
      # in all cases
      travis::travis_set_pat()

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
  # from https://github.com/r-lib/usethis/blob/02fc4b20f022b0b98afcb323ef770fd78c00ae5a/R/ci.R#L39
  url <- glue::glue("https://travis-ci.org/{login}/{name}")
  img <- glue::glue("{url}.svg?branch=master")
  usethis::use_badge("Travis build status", url, img)
}
