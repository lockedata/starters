#' Create project health report under health
#'
#' @export
#'
get_project_health <- function(){
  fs::dir_create("health")
  file.copy(system.file("templates", "health.Rmd",
                        package = "pRojects"),
            "health/README.Rmd")
  rmarkdown::render(input = "health/README.Rmd",
                    output_format = "github_document")

}
