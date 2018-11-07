okpackagedeps <- function(){
  c("none", "packrat", "checkpoint")
}

setup_dep_system <- function(packagedeps){
  if (packagedeps == "packrat") {
    desc::desc_set_dep(package = "packrat",
                       type = "Imports",
                       file = usethis::proj_get())
    packrat::init(usethis::proj_get(), enter = FALSE)
  }

  if (packagedeps == "checkpoint") {
    desc::desc_set_dep(package = "checkpoint",
                       type = "Imports",
                       file = usethis::proj_get())

    checkpoint::checkpoint(Sys.Date(),
                           project = usethis::proj_get(),
                           checkpointLocation = usethis::proj_get(),
                           forceProject = TRUE,
                           verbose = FALSE)
  }
}

#' Create directories
#'
#' @param dirs Subfolders
#'
createdirs <- function(dirs) {
  stopifnot(length(dirs) > 0)
  dirstocreate <- file.path(usethis::proj_get(), dirs)
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


is_org <- function(username){
  info <- gh::gh("GET /users/:username", username = username)
  info$type == "Organization"
}

# very much inspired by usethis!
setup_repo <- function(username, private, protocol){
  # create repo
  if(is_org(username)){
    endpoint <- "POST /orgs/:org/repos"
  }else{
    endpoint <- "POST /user/repos"
  }
  create <- gh::gh(endpoint,
         org = username,
         name = as.character(
           fs::path_file(usethis::proj_get())),
         description = as.character(
           desc::desc(usethis::proj_get())$get("Title")),
         private = tolower(as.character(private)))

  r <- git2r::repository(usethis::proj_get())
  origin_url <- switch(protocol, https = create$clone_url,
                       ssh = create$ssh_url)
  git2r::remote_add(r, "origin", origin_url)
  git2r::checkout(r, "master")
  #git2r::branch_set_upstream(git2r::repository_head(r),
  #                           "origin/master")
  desc::desc_set("URL", create$html_url,
                 file = usethis::proj_get())
  desc::desc_set("BugReports",
                 paste0(create$html_url, "/issues"),
                 file = usethis::proj_get())
}
