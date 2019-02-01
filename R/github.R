#' Determine whether the account is a GitHub org
#' @param username account name
#' @noRd
is_org <- function(username) {
  info <- gh::gh("GET /users/:username", username = username)
  info$type == "Organization"
}

#' Determin whether the repo already exists
#' @param username account name
#' @param repo repo name
#' @noRd
repo_exists <- function(username, repo) {
  !inherits(
    try(gh::gh("GET /repos/:owner/:repo",
      owner = username,
      repo = repo
    ),
    silent = TRUE
    ),
    "try-error"
  )
}

#' check whether the repo name is ok i.e. not used
#' @param username account name
#' @param name repo name
#' @noRd
check_github_name <- function(username, name) {
  if (is.null(username)) {
    return(invisible(TRUE))
  } else {
    if (repo_exists(username, name)) {
      stop(glue::glue("There is already a GitHub repo named {name} for the {github} account"), # nolint
        call. = FALSE
      )
    } else {
      return(invisible(TRUE))
    }
  }
}

#' Set up GitHub repo
#' @param username account name
#' @param private whether to make the repo private
#' @param protocol protocol to use (ssh or https)
#' @param title project title (repo description)
#' @param name project name (repo name)
#' @details very much inspired by usethis!
#' @noRd
setup_gh_repo <- function(username, private, protocol,
                          title, name) {
  check_github_name(
    username = username,
    name = name
  )
  # create repo
  if (is_org(username)) {
    endpoint <- "POST /orgs/:org/repos"
  } else {
    endpoint <- "POST /user/repos"
  }

  quoted_expression <- quote(gh::gh(endpoint,
                                    org = username,
                                    name = name,
                                    description = title,
                                    private = private
  ))
  ok <- gh_retry(quoted_expression)
  if (!ok){
    stop("GitHub repo creation failed.")
  }

  r <- git2r::repository(usethis::proj_get())
  origin_url <- switch(protocol, https = create$clone_url,
    ssh = create$ssh_url
  )
  git2r::remote_add(r, "origin", origin_url)
  git2r::checkout(r, "master")
  # git2r::branch_set_upstream(git2r::repository_head(r),
  #                           "origin/master")
  desc::desc_set("URL", create$html_url,
    file = usethis::proj_get()
  )
  desc::desc_set("BugReports",
    paste0(create$html_url, "/issues"),
    file = usethis::proj_get()
  )
}
