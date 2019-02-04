add_package_checks()

if (Sys.getenv("id_rsa") != "") {
  get_stage("before_deploy") %>%
    add_step(step_setup_ssh())

  if (ci()$get_branch() == "master") {
    # analysis or your folder holding reports
    reports <- dir(path = "analysis", pattern = "*.[Rr]md",
                   full.names = TRUE)
    if(length(reports) > 0){
      output_dir <- "outputs"
      get_stage("deploy") %>%
        add_code_step(lapply(reports,
                             rmarkdown::render,
                             output_dir = output_dir)) %>%
        add_step(step_push_deploy(path = output_dir, branch = "gh-pages"))
      }
    }

}
