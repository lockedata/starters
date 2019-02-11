start_here <- function(){
  usethis::ui_line("Checking GitHub account can be guessed...")
  gh_username <- try(whoami::gh_username(), silent = TRUE)
  if(inherits(gh_username, "try-error")){
    usethis::ui_stop("No GitHub account could be identified. Maybe you have not created a GitHub account yet? Or your email address is not public and you have not created a GIHUB_USERNAME variable via usethis::edit_r_environ()?")
  } else{
    usethis::ui_done(glue::glue("Your GitHub username is {gh_username}."))
  }

  # something to check git is installed
  usethis::ui_line("Checking git is installed...")
  if(!nzchar(Sys.which("git"))){
    usethis::ui_stop("git does not seem to be installed. See http://happygitwithr.com/install-git.html")
  } else{
    usethis::ui_done("git seems to be installed!")
  }

  usethis::ui_line("Checking gitconfig...")
  gitconfig <- usethis::use_git_config()
  if(!all(names(git2r::config()$global) ==
          c("user.email", "user.name"))){
    clipr::write_clip("use_git_config(user.name = 'Jane Doe', user.email = 'jane@example.com')")
    usethis::ui_todo("gitconfig not set yet. Use this code (copied to clipboard): use_git_config(user.name = 'Jane Doe', user.email = 'jane@example.com')")
    usethis::ui_stop("Set your gitconfig then run starters::start_here() again.")
  } else{
    usethis::ui_done("gitconfig is already set!")
  }

  usethis::ui_line("Checking GITHUB_PAT...")
  if(!nzchar(Sys.getenv("GITHUB_PAT"))){
    clipr::write_clip("usethis::browse_github_pat()")
    usethis::ui_todo("GITHUB_PAT not set yet. Use this code (copied to clipboard): usethis::browse_github_pat()")
    usethis::ui_stop("Set your GITHUB_PAT then run starters::start_here() again.")
  } else{
    usethis::ui_done("GITHUB_PAT is already set!")
  }

  usethis::ui_line("Checking default description values...")
  if(is.null(getOption("usethis.description"))){
    usethis::ui_code_block(options(
      usethis.description = list(
        `Authors@R` = 'person("Jane", "Doe", email = "jane@example.com", role = c("aut", "cre"),
                          comment = c(ORCID = "YOUR-ORCID-ID"))',
        License = "MIT + file LICENSE",
        Language =  "es"
      )
    ))

    usethis::ui_todo("DESCRIPTION defaults not set yet. Amend and paste the code above (copied to clipboard) to your .Rprofile via running usethis::edit_r_profile().")
    usethis::ui_stop("Set DESCRIPTION default then run starters::start_here() again.")
  } else{
    usethis::ui_done("DESCRIPTION defaults are already set!")
  }


  usethis::ui_line("Checking build tools are available...")
  if(!pkgbuild::has_build_tools()){
    browseURL("https://usethis.r-lib.org/articles/articles/usethis-setup.html#prepare-your-system-to-build-packages-from-source")
    usethis::ui_stop("Your system lacks a few tools, see link opened. https://usethis.r-lib.org/articles/articles/usethis-setup.html#prepare-your-system-to-build-packages-from-source")
  } else{
    usethis::ui_done("Build tools are available!")
  }

  usethis::ui_done("All set now!")
}
