projectGadget <- function() {

  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Create pRoject"),
    miniUI::miniContentPanel(
      shiny::inputPanel(
        shiny::selectInput(
          "projectType", label = "Project Type",
          choices = c("Basic","Analysis","Package","Training"),
          selected = "Basic"
        ),
        shiny::textInput("name", "Project Name")
      ),
      shiny::uiOutput("ui"),
      shiny::conditionalPanel(
        condition = "input.projectType != 'Package'",
        shiny::inputPanel(
          shiny::h4("Best Practices"),
          shiny::br(),
          shiny::checkboxInput("readme", "Create README", value = TRUE),
          shiny::checkboxInput("git", "Use Git", value = TRUE),
          shiny::checkboxInput("travis", "Use Travis", value = TRUE),
          shiny::checkboxInput("packrat", "Use Packrat", value = TRUE)
        )
      )
    )
  )

  server <- function(input, output, session) {

    output$ui <- shiny::renderUI({

      switch(input$projectType,

        "Basic"     = shiny::div(),
        "Analysis"  = shiny::inputPanel(
                        shiny::selectInput("dirs", label = "Directories",
                          choices = c("data", "analysis", "output"),
                          selected = c("data", "analysis", "output"),
                          multiple = TRUE)
        ),
        "Package"   = shiny::inputPanel(
                        shiny::h4("Best Practice"),
                        shiny::br(),
                        shiny::checkboxInput("bestPractices",
                          label = "Adopt best practice?", value = TRUE),
                        shiny::br(),
                        shiny::conditionalPanel(
                          condition = "input.bestPractices",
                          shiny::selectInput("coverage", label = "Code Coverage",
                            choices = c("codecov", "coveralls"))
                        )
        ),
        "Training"  = shiny::inputPanel(
                        shiny::selectInput("dirs", label = "Directories",
                          choices = c("data", "handouts", "slides"),
                          selected = c("data", "handouts", "slides"),
                          multiple = TRUE)
        )

      )

    })

    shiny::observeEvent(input$done, {

      switch(input$projectType,

        "Basic"    = createBasicProject(
                        name = input$name, readme = input$readme,
                        git = input$git, travis = input$travis,
                        packrat = input$packrat),

        "Analysis" = createAnalysisProject(
                        name = input$name, dirs = input$dirs,
                        readme = input$readme, git = input$git,
                        travis = input$travis, packrat = input$packrat),

        "Package" = createPackageProject(
                        name = input$name, bestPractices = input$bestPractices,
                        coverage = input$coverage),

        "Training" = createTrainingProject(
                        name = input$name, dirs = input$dirs,
                        readme = input$readme, git = input$git,
                        travis = input$travis, packrat = input$packrat)

      )

      shiny::stopApp()

    })

  }

  shiny::runGadget(ui, server)

}
