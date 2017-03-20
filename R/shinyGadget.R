library(shiny)
library(miniUI)

basicProjectGadget <- function() {

ui <- miniPage(
  gadgetTitleBar("Create Basic pRoject"),
  miniContentPanel(
    inputPanel(
      textInput("name", "Project Name")
    ),
    inputPanel(
      checkboxInput("readme", "Create README", value = TRUE),
      checkboxInput("git", "Use Git", value = TRUE),
      checkboxInput("travis", "Use Travis", value = TRUE),
      checkboxInput("packrat", "Use Packrat", value = TRUE)
    )
  )
)

server <- function(input, output, session) {

  observeEvent(input$done, {
    createBasicProject(name = input$name, readme = input$readme,
                       git = input$git, travis = input$travis,
                       packrat = input$packrat)
    stopApp()
  })
}

runGadget(ui, server)
}
