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


add_travis_badge <- function(login, name) {
  readme_path <- find_readme()
  readme <- readLines(readme_path)
  readme[grepl("<!-- badges -->", readme)] <-
    paste(
      readme[grepl("<!-- badges -->", readme)],
      glue::glue("[![Build Status](https://travis-ci.org/{login}/{name}.svg?branch=master)](https://travis-ci.org/{login}/{name})")
    )
  writeLines(readme, readme_path)
}
