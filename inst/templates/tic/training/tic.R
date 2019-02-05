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

    if(length(c(reports, slides)) > 0){

      get_stage("deploy") %>%
        add_code_step(lapply(c(dir(path = "handouts", pattern = "*.[Rr]md",
                                   full.names = TRUE),
                               dir(path = "slides", pattern = "*.[Rr]md",
                                   full.names = TRUE)),
                             output_dir = "slides",
                             rmarkdown::render)) %>%
        add_step(step_push_deploy(path = "slides", branch = "gh-pages"))
    }
  }

}
