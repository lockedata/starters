setup_repo <- function(git_service, login,
                       private, protocol,
                       ci_activation,
                       name, title){
  if(tolower(git_service) != "github"){
    stop(glue::glue(
      "Only GitHub is supported at the moment, not {git_service}."),
      call. = FALSE)
  }

  setup_gh_repo(username = login, private = private,
                protocol = protocol,
                name = name, title = title)

  if(!is.null(ci_activation)){
    if(ci_activation != "travis"){
      stop(glue::glue(
        "Only travis is supported at the moment, not {ci_activation}."),
        call. = FALSE)
    }

    if(ci_activation == "travis"){
      usethis::use_travis()
      add_travis_badge(login, name)
    }

  }
}


add_travis_badge <- function(login, name){
  if(fs::file_exists(file.path(usethis::proj_get(), "README.Rmd"))){
    readme_path <- file.path(usethis::proj_get(), "README.Rmd")
  }else{
    readme_path <- file.path(usethis::proj_get(), "README.md")
  }

  readme <- readLines(file.path(usethis::proj_get(), "README.md"))
  readme_title <- which(grepl("#", readme))[1]
  if(readme_title > 1){
    first <- 1:readme_title
  }else{
    first <- readme_title
  }

  readme <- c(readme[first], "",
              glue::glue("[![Build
                         Status](https://travis-ci.org/{login}/{name}.svg?branch=master)](https://travis-ci.org/{login}/{name})"),
              readme[(readme_title+1):length(readme)])
  writeLines(readme, readme_path)
}
