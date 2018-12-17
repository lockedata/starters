add_styler_hook <- function(){
  fs::dir_create(file.path(usethis::proj_get(),
                           ".git", "hooks"))

  file.remove(file.path(usethis::proj_get(),
                        ".git", "hooks",
                        "pre-commit"))

  fs::file_copy(system.file("stylerprecommit.sh",
                            package = "pRojects"),
                file.path(usethis::proj_get(),
                          ".git", "hooks",
                          "pre-commit"))
  fs::file_copy(system.file("precommit.R",
                            package = "pRojects"),
                file.path(usethis::proj_get(),
                          ".git", "hooks",
                          "precommit.R"))
}
