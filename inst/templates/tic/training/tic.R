add_package_checks()

if (Sys.getenv("id_rsa") != "") {
  get_stage("before_deploy") %>%
    add_step(step_setup_ssh())

  if (ci()$get_branch() == "master") {
    # handouts and slides
    reports <- dir(path = "handouts", pattern = "*.[Rr]md",
                   full.names = TRUE)
    slides <- dir(path = "slides", pattern = "*.[Rr]md",
                   full.names = TRUE)
    toknit <- c(reports, slides)
    if(length(toknit) > 0){
      output_dir <- "outputs"
      get_stage("deploy") %>%
        add_code_step(lapply(toknit,
                             rmarkdown::render,
                             output_dir = output_dir)) %>%
        add_step(step_push_deploy(path = output_dir, branch = "gh-pages"))
      }
    }

}
