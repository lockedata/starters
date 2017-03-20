basicProjectGadget <- function() {

ui <- miniUI::miniPage(
  miniUI::gadgetTitleBar("Create Basic pRoject"),
  miniUI::miniContentPanel(
    shiny::inputPanel(
      shiny::textInput("name", "Project Name")
    ),
    shiny::inputPanel(
      shiny::checkboxInput("readme", "Create README", value = TRUE),
      shiny::checkboxInput("git", "Use Git", value = TRUE),
      shiny::checkboxInput("travis", "Use Travis", value = TRUE),
      shiny::checkboxInput("packrat", "Use Packrat", value = TRUE)
    )
  )
)

server <- function(input, output, session) {

  shiny::observeEvent(input$done, {
    createBasicProject(name = input$name, readme = input$readme,
                       git = input$git, travis = input$travis,
                       packrat = input$packrat)
    shiny::stopApp()
  })
}

shiny::runGadget(ui, server)
}
