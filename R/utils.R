okpackagedeps <- function(){
  c("none", "packrat", "checkpoint")
}

setup_dep_system <- function(packagedeps){
  if (packagedeps == "packrat") {
    desc::desc_set_dep(package = "packrat",
                       type = "Imports",
                       file = usethis::proj_get())
    packrat::init(name, enter = FALSE)
  }

  if (packagedeps == "checkpoint") {
    desc::desc_set_dep(package = "checkpoint",
                       type = "Imports",
                       file = usethis::proj_get())
    checkpoint::setSnapshot(Sys.Date(), online = TRUE)
  }
}

#' Create directories
#'
#' @param rootdir Project
#' @param dirs Subfolders
#'
createdirs <- function(rootdir, dirs) {
  stopifnot(length(dirs) > 0)
  dirstocreate <- file.path(rootdir, dirs)
  lapply(dirstocreate, function(x){if(!dir.exists(x)) dir.create(x)})
}

#' Make DESCRIPTION
#'
#' @param name Package / project
createdesc <- function(name) {
  desc <- desc::desc("!new")
  desc$add_me(role = "cre")
  desc$write(file.path(name, "DESCRIPTION"))
}


#' Check availability
#'
#' @param name Package / project

is_available <- function(name) {
  if (identical(Sys.getenv("TESTTHAT"), "true")&&
      name == "blablabla") {
    stop('package name is taken on Github')
  }
  if (identical(Sys.getenv("TESTTHAT"), "true")&&
      name != "blablabla") {
    return(invisible(TRUE))
  }
  cran <- available::available_on_cran(name)
  gh <- available::available_on_github(name)
  if(cran == FALSE){
    stop('package name is taken on CRAN')
  }
  if(gh$available == FALSE){
    stop('package name is taken on GitHub')
  }
  invisible(TRUE)
}

# from usethis since pushing doesn't work yet,
# removed pushing
use_github <- function (organisation = NULL, private = TRUE,
                        protocol = "ssh",
                        host = NULL)
{
  browser()
  auth_token <- usethis:::gh_token()
  usethis:::check_gh_token(auth_token)

  pkg <- usethis:::project_data()
  repo_name <- pkg$Project %||% gsub("\n", " ", pkg$Package)
  repo_desc <- pkg$Title %||% ""


  usethis:::done("Creating GitHub repository")
  if (is.null(organisation)) {
    create <- gh::gh("POST /user/repos", name = repo_name,
                     description = repo_desc, private = private, .api_url = host,
                     .token = auth_token)
  }
  else {
    create <- gh::gh("POST /orgs/:org/repos", org = organisation,
                     name = repo_name, description = repo_desc, private = private,
                     .api_url = host, .token = auth_token)
  }
  usethis:::done("Adding GitHub remote")
  r <- git2r::repository(usethis::proj_get())
  protocol <- match.arg(protocol)
  origin_url <- switch(protocol, https = create$clone_url,
                       ssh = create$ssh_url)
  git2r::remote_add(r, "origin", origin_url)
  if (usethis:::is_package()) {
    usethis:::done("Adding GitHub links to DESCRIPTION")
    use_github_links(auth_token = auth_token, host = host)
    if (git_uncommitted()) {
      git2r::add(r, "DESCRIPTION")
      git2r::commit(r, "Add GitHub links to DESCRIPTION")
    }
  }
  usethis:::done("Setting remote tracking branch")

  git2r::branch_set_upstream(git2r::repository_head(r), "origin/master")
  view_url(create$html_url)
  invisible(NULL)
}
# https://github.com/r-lib/usethis/blob/1e3c6a66e8b2d2790ee6d7e6d5651c52fb61abfc/R/utils.R#L100
"%||%" <- function(a, b) if (!is.null(a)) a else b

