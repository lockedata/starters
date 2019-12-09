projectGadget <- function() {
  if (!requireNamespace("shinyFiles", quietly = TRUE)) {
    stop("The shinyFiles package is required for this gadget to work. Please install it.",
      call. = FALSE
    )
  }

  if (!requireNamespace("clipr", quietly = TRUE)) {
    stop("The clipr package is required for this gadget to work. Please install it.",
         call. = FALSE
    )
  }

  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Create Project"),
    miniUI::miniContentPanel(
      shiny::tags$style("#folder {width: 210px; };",
        type = "text/css"
      ),
      # Custom shiny to javascript binding
      # scrolls "content" to bottom once called
      shiny::tags$script(
        "Shiny.addCustomMessageHandler('scrollCallback',
          function(x) {
            var content = document.getElementsByClassName('gadget-scroll')[0];
            content.scrollTop = content.scrollHeight - content.clientHeight;
          }
        );"
      ),
      shiny::inputPanel(
        shiny::selectInput(
          "projectType",
          label = "Project Type",
          choices = c("Basic", "Package", "Analysis", "Training"),
          selected = "Basic"
        ),
        shiny::tags$div(
          title = "A badge from repostatus.org will be added to the README.",
          shiny::selectInput(
            "initial_status",
            label = "Initial Status",
            choices = statuses()$status,
            selected = "wip"
          )
        ),
        shiny::tags$div(
          title = "This will be used as the name for the project.",
          shiny::textInput("name", "Project Name", value = NULL)
        ),
        shiny::tags$div(
          title = "A description of what the project does.",
          shiny::textInput("title", "Project Title", value = NULL)
        ),
        shiny::div("Project Folder", class = "control-label", style = "font-weight: bold;"),
        shiny::br(),
        shinyFiles::shinyDirButton("folder",
          label = "Choose Folder",
          title = "Please choose a project folder",
          class = "btn-primary"
        ),
        shiny::uiOutput("folder")
      ),
      shiny::uiOutput("ui"),
      shiny::conditionalPanel(
        condition = "input.externalSetup",
        shiny::inputPanel(
          shiny::radioButtons("git_service",
            label = "Git Service",
            choices = "GitHub"
          ),
          shiny::radioButtons("private",
            label = "Repository",
            choices = c("public" = FALSE, "private" = TRUE)
          ),
          shiny::radioButtons("protocol",
            label = "Protocol",
            choices = c("ssh", "http"),
            select = "ssh"
          ),
          shiny::radioButtons("ci_activation",
            label = "Continuous Integration",
            choices = c("none" = "", "travis")
          ),
          shiny::textInput("login", label = "Login", value = gh::gh_whoami()$login)
        )
      )
    )
  )

  server <- function(input, output, session) {

    # Call custom javascript to scroll window
    shiny::observeEvent(input$externalSetup,
      if(input$externalSetup) session$sendCustomMessage(type = "scrollCallback", 1)
    )

    volumes <- c(
      "Working Directory" = getwd(),
      Home = fs::path_home(),
      shinyFiles::getVolumes()()
    )

    shinyFiles::shinyDirChoose(
      input, "folder",
      roots = volumes, session = session,
      restrictions = system.file(package = "base")
    )

    folder <- shiny::reactive({
      folder <- shinyFiles::parseDirPath(volumes, input$folder)
      if (length(folder) == 0) {
        folder <- getwd()
      }
      folder
    })

    output$folder <- shiny::renderUI({
      shiny::textInput("folder", NULL,
        value = folder()
      )
    })

    output$ui <- shiny::renderUI({
      switch(input$projectType,

        "Basic" = shiny::inputPanel(
          shiny::checkboxInput("git", "Use Git", value = TRUE),
          shiny::tags$div(
            title = "This will reset the active RStudio project after setup completes",
            shiny::checkboxInput("reset", "Reset Project", value = TRUE)
          ),
          shiny::checkboxInput("externalSetup", label = "External Setup", value = FALSE),
          shiny::br(),
          shiny::radioButtons("packagedeps",
            label = "Dependency Management",
            choices = okpackagedeps(),
            selected = "checkpoint"
          )
        ),
        "Analysis" = shiny::inputPanel(
          shiny::checkboxInput("git", "Use Git", value = TRUE),
          shiny::tags$div(
            title = "This will reset the active RStudio project after setup completes",
            shiny::checkboxInput("reset", "Reset Project", value = TRUE)
          ),
          shiny::checkboxInput("externalSetup", label = "External Setup", value = FALSE),
          shiny::br(),
          shiny::selectInput("dirs",
            label = "Directories",
            choices = c("data", "analysis", "output"),
            selected = c("data", "analysis", "output"),
            multiple = TRUE
          ),
          shiny::radioButtons("packagedeps",
            label = "Dependency Management",
            choices = okpackagedeps(),
            selected = "checkpoint"
          )
        ),
        "Package" = shiny::inputPanel(
          shiny::checkboxInput("git", "Use Git", value = TRUE),
          shiny::tags$div(
            title = "This will reset the active RStudio project after setup completes",
            shiny::checkboxInput("reset", "Reset Project", value = TRUE)
          ),
          shiny::checkboxInput("externalSetup", label = "External Setup", value = FALSE),
          shiny::br(),
          shiny::radioButtons("coverage",
            label = "Code Coverage",
            choices = c("codecov", "coveralls"),
            selected = "codecov"
          ),
          shiny::radioButtons("pkgdown",
            label = "Add pkgdown config",
            choices = c("Yes" = TRUE, "No" = FALSE)
          )
        ),
        "Training" = shiny::inputPanel(
          shiny::checkboxInput("git", "Use Git", value = TRUE),
          shiny::tags$div(
            title = "This will reset the active RStudio project after setup completes",
            shiny::checkboxInput("reset", "Reset Project", value = TRUE)
          ),
          shiny::checkboxInput("externalSetup", label = "External Setup", value = FALSE),
          shiny::br(),
          shiny::selectInput("dirs",
            label = "Directories",
            choices = c("data", "handouts", "slides"),
            selected = c("data", "handouts", "slides"),
            multiple = TRUE
          ),
          shiny::radioButtons("packagedeps",
            label = "Dependency Management",
            choices = okpackagedeps(),
            selected = "checkpoint"
          ),
          shiny::radioButtons("handoutE",
            label = "Handouts",
            choices = c("rmarkdown", "bookdown", "tufte"),
            selected = "rmarkdown"
          ),
          shiny::radioButtons("slideE",
            label = "Slides",
            choices = c("rmarkdown", "revealjs", "xaringan"),
            selected = "rmarkdown"
          )
        )
      )
    })

    shiny::observeEvent(input$done, {
      shiny::stopApp()

      switch(input$projectType,

        "Basic" = capture(
          call("createBasicProject",
            name = input$name,
            title = empty_as_null(input$title),
            folder = as.character(folder()),
            initial_status = input$initial_status,
            packagedeps = input$packagedeps,
            git = input$git,
            external_setup = ext_setup(input),
            reset = input$reset
          )
        ),

        "Analysis" = capture(
          call("createAnalysisProject",
            name = input$name,
            title = empty_as_null(input$title),
            folder = as.character(folder()),
            initial_status = input$initial_status,
            dirs = input$dirs,
            git = input$git,
            packagedeps = input$packagedeps,
            external_setup = ext_setup(input),
            reset = input$reset
          )
        ),

        "Package" = capture(
          call("createPackageProject",
            name = input$name,
            title = empty_as_null(input$title),
            folder = as.character(folder()),
            initial_status = input$initial_status,
            coverage = input$coverage,
            git = input$git,
            pkgdown = input$pkgdown,
            external_setup = ext_setup(input),
            reset = input$reset
          )
        ),

        "Training" = capture(
          call("createTrainingProject",
            name = input$name,
            title = empty_as_null(input$title),
            folder = as.character(folder()),
            initial_status = input$initial_status,
            dirs = input$dirs,
            handoutEngine = input$handoutE,
            slideEngine = input$slideE,
            git = input$git,
            packagedeps = input$packagedeps,
            external_setup = ext_setup(input),
            reset = input$reset
          )
        )
      )
    })
  }

  shiny::runGadget(ui, server)
}
