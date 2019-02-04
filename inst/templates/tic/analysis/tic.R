add_package_checks()

if (Sys.getenv("id_rsa") != "") {
  get_stage("before_deploy") %>%
    add_step(step_setup_ssh())

  if (ci()$get_branch() == "master") {
    if(length(dir(path = "analysis", pattern = "*.[Rr]md")) > 0){
      get_stage("deploy") %>%
        add_code_step(lapply(dir(path = "analysis", pattern = "*.[Rr]md"),
                             rmarkdown::render,
                             output_dir = "outputs")) %>%
        add_step(step_push_deploy(path = "outputs", branch = "gh-pages"))
      }
    }

}
