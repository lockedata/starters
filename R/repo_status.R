statuses <- function() {
  structure(list(status = c(
    "abandoned", "active", "concept", "inactive",
    "moved", "suspended", "unsupported", "wip"
  ), md_code = c(
    "[![Project Status: Abandoned - Initial development has started, but there has not yet been a stable, usable release; the project has been abandoned and the author(s) do not intend on continuing development.](https://www.repostatus.org/badges/latest/abandoned.svg)](https://www.repostatus.org/#abandoned)",
    "[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)",
    "[![Project Status: Concept - Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)",
    "[![Project Status: Inactive - The project has reached a stable, usable state but is no longer being actively developed; support/maintenance will be provided as time allows.](https://www.repostatus.org/badges/latest/inactive.svg)](https://www.repostatus.org/#inactive)",
    "[![Project Status: Moved to https://example.com - The project has been moved to a new location, and the version at that location should be considered authoritative.](https://www.repostatus.org/badges/latest/moved.svg)](https://www.repostatus.org/#moved) to [http://example.com](http://example.com)",
    "[![Project Status: Suspended - Initial development has started, but there has not yet been a stable, usable release; work has been stopped for the time being but the author(s) intend on resuming work.](https://www.repostatus.org/badges/latest/suspended.svg)](https://www.repostatus.org/#suspended)",
    "[![Project Status: Unsupported - The project has reached a stable, usable state but the author(s) have ceased all work on it. A new maintainer may be desired.](https://www.repostatus.org/badges/latest/unsupported.svg)](https://www.repostatus.org/#unsupported)",
    "[![Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)"
  ), name = c(
    "Project Status: Abandoned - Initial development has started, but there has not yet been a stable, usable release; the project has been abandoned and the author(s) do not intend on continuing development.",
    "Project Status: Active - The project has reached a stable, usable state and is being actively developed.",
    "Project Status: Concept - Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.",
    "Project Status: Inactive - The project has reached a stable, usable state but is no longer being actively developed; support/maintenance will be provided as time allows.",
    "Project Status: Moved to https://example.com - The project has been moved to a new location, and the version at that location should be considered authoritative.",
    "Project Status: Suspended - Initial development has started, but there has not yet been a stable, usable release; work has been stopped for the time being but the author(s) intend on resuming work.",
    "Project Status: Unsupported - The project has reached a stable, usable state but the author(s) have ceased all work on it. A new maintainer may be desired.",
    "Project Status: WIP - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public."
  ), src = c(
    "https://www.repostatus.org/badges/latest/abandoned.svg",
    "https://www.repostatus.org/badges/latest/active.svg", "https://www.repostatus.org/badges/latest/concept.svg",
    "https://www.repostatus.org/badges/latest/inactive.svg", "https://www.repostatus.org/badges/latest/moved.svg",
    "https://www.repostatus.org/badges/latest/suspended.svg", "https://www.repostatus.org/badges/latest/unsupported.svg",
    "https://www.repostatus.org/badges/latest/wip.svg"
  ), href = c(
    "https://www.repostatus.org/#abandoned",
    "https://www.repostatus.org/#active", "https://www.repostatus.org/#concept",
    "https://www.repostatus.org/#inactive", "https://www.repostatus.org/#moved",
    "https://www.repostatus.org/#suspended", "https://www.repostatus.org/#unsupported",
    "https://www.repostatus.org/#wip"
  )), row.names = c(NA, -8L), class = c(
    "tbl_df",
    "tbl", "data.frame"
  ))
}

add_repo_status <- function(status) {
  statuses <- statuses()
  if (!status %in% statuses$status) {
    stop(glue::glue("{status} is not a repostatus.org status."),
      call. = FALSE
    )
  }

  badge <- statuses$md_code[statuses$status == status]
  readme_path <- find_readme()
  readme <- readLines(readme_path)
  readme[grepl("<!-- badges -->", readme)] <-
    paste(
      readme[grepl("<!-- badges -->", readme)],
      badge
    )
  writeLines(readme, readme_path)
}
