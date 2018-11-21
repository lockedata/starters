#' Create project health report under health
#'
#' @details for current working directory.
#' Aimed at use on CI. It currently includes \code{goodpractice}
#' and \code{devtools::spell_check()} output.
#'
#' @export
#'
get_project_health <- function() {
  fs::dir_create("health")
  file.copy(
    system.file("templates", "health.Rmd",
      package = "pRojects"
    ),
    "health/README.Rmd"
  )
  rmarkdown::render(
    input = "health/README.Rmd",
    output_format = "github_document"
  )
}
