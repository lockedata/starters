add_styler_hook <- function() {
  fs::dir_create(file.path(
    usethis::proj_get(),
    ".git", "hooks"
  ))
  fs::file_copy(
    system.file("stylerprecommit.sh", package = "starters"),
    file.path(
      usethis::proj_get(),
      ".git", "hooks",
      "pre-commit"
    )
  )
  fs::file_copy(
    system.file("precommit.R", package = "starters"),
    file.path(
      usethis::proj_get(),
      ".git", "hooks",
      "precommit.R"
    )
  )
  usethis::use_package("styler", type = "Suggests")
}
