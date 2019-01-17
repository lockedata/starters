#' Set up the repo for the project
#' @param git_service git platform to use
#' @param login login for the git platform
#' @param protocol protocol to use
#' @param ci_activation how to activate CI stuff
#' @param project project name (repo name)
#' @param title project title (repo description)
#' @param project_type what kind of project it is
#' @param coverage coverage service
#' @noRd

setup_repo <- function(git_service, login,
                       private, protocol,
                       ci_activation,
                       name, title,
                       project_type,
                       coverage = NULL) {

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

  # coverage
  if(!is.null(coverage)){
    add_coverage_badge(login, name, coverage)
  }

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
                            save_as = ".travis.yml",
                            package = "travis")
      travis::travis_enable(repo = travis::github_repo(path = usethis::proj_get()))
      # copy custom tic depending on proj
      usethis::use_template(file.path("tic", project_type,
                                      "tic.R"),
                            save_as = "tic.R",
                            package = "starters",
                            data = list(coverage_service = coverage))


      if (project_type != "basic"){
        travis::use_travis_deploy(path = usethis::proj_get())
      }

      # in all cases
      travis::travis_set_pat(repo = travis::github_repo(path = usethis::proj_get()))

      add_travis_badge(login, name)
      repo <- git2r::init(usethis::proj_get())
      git2r::add(repo, path = ".travis.yml")
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

#' Add coverage badge to the README
#' @param login login (assumed to be the same as for the git
#' platform)
#' @param name project name (repo name)
#' @param coverage coverage service
#' @noRd
add_coverage_badge <- function(login, name, coverage) {
  github_repo_spec <- paste(login, name, sep ="/")
  if(coverage == "codecov"){
    # from https://github.com/r-lib/usethis/blob/85bf30af12dc5a99faf20115a0396add72aa6d12/R/coverage.R#L47
    url <- glue::glue("https://codecov.io/gh/{github_repo_spec}?branch=master")
    img <- glue::glue(
      "https://codecov.io/gh/{github_repo_spec}/branch/master/graph/badge.svg"
    )
    usethis::use_badge("Codecov test coverage", url, img)

  }else{

    if(coverage == "coveralls"){
      # from https://github.com/r-lib/usethis/blob/85bf30af12dc5a99faf20115a0396add72aa6d12/R/coverage.R#L56
      url <- glue::glue("https://coveralls.io/r/{github_repo_spec}?branch=master")
      img <- glue::glue(
        "https://coveralls.io/repos/github/{github_repo_spec}/badge.svg"
      )
      usethis::use_badge("Coveralls test coverage", url, img)
    }
  }
}
