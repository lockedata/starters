add_styler_hook <- function(){
  usethis::use_git_hook("pre-commit",
                        system.file("stylerprecommit.sh",
                                    package = "pRojects"))
  fs::file_copy(system.file("precommit.R",
                            package = "pRojects"),
                file.path(".git", "hooks",
                          "precommit.R"))
}
