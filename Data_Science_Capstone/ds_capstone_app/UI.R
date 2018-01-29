library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Simple Text Prediction Model"),
  sidebarPanel(
    h4('Prediction Parameter'),
    uiOutput('algoOptions')    
  ),
  mainPanel(
    tabPanel('Prediction Model', verticalLayout(
    h5('This model uses a collection of N-Grams (2, 3 or 4) to predict the next word.'),
    textInput('textInput', 'Please Input Text'),
    textOutput('textOutput'))
    )
    )
  ))