use_readme <- function(name){
  usethis::use_template("README.Rmd",
                        data = list(Package = name),
                        package = "pRojects")
}


knit_readme <- function(){
  rmarkdown::render(file.path(usethis::proj_get(),
                              "README.Rmd"),
                    quiet = TRUE)
  file.remove(file.path(usethis::proj_get(),
                        "README.html"))
  repo <- git2r::init(usethis::proj_get())
  git2r::add(repo, path = "README.md")
  git2r::commit(repo, message = "add README.md",
                all = TRUE)

}
