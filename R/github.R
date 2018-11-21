is_org <- function(username) {
  info <- gh::gh("GET /users/:username", username = username)
  info$type == "Organization"
}

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

check_github_name <- function(username, name) {
  if (is.null(username)) {
    return(invisible(TRUE))
  } else {
    if (repo_exists(username, name)) {
      stop(glue::glue("There is already a GitHub repo named {name} for the {github} account"),
        call. = FALSE
      )
    } else {
      return(invisible(TRUE))
    }
  }
}

# very much inspired by usethis!
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
  create <- gh::gh(endpoint,
    org = username,
    name = name,
    description = title,
    private = private
  )

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
