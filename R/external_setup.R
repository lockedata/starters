setup_repo <- function(git_service, login,
                       private, protocol,
                       ci_activation){
  if(tolower(git_service) != "github"){
    stop(glue::glue(
      "Only GitHub is supported at the moment, not {git_service}."),
      call. = FALSE)
  }
  setup_gh_repo(username = login, private = private,
                protocol = protocol,
                name = name, title = title)

  if(!is.null(ci_activation)){
    if(ci_activation != "tic"){
      stop(glue::glue(
        "Only tic is supported at the moment, not {ci_activation}."),
        call. = FALSE)
    }

    travis::use_tic()
    add_travis_badge()
  }
}


add_travis_badge <- function(github, name){
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
                         Status](https://travis-ci.org/{github}/{name}.svg?branch=master)](https://travis-ci.org/{github}/{name})"),
              readme[(readme_title+1):length(readme)])
  writeLines(readme, readme_path)
}
