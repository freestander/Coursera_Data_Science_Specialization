library(shiny)
library(stringr)
library(tm)
library(RWeka)

source("./LoadModel.R")

predict <- function(inputText, input) {
    ngc <- input$ngramComplexity
    if (is.null(inputText) || (str_length(inputText) == 0)) {
      'the'
    } else if ((length(ngc) == 0) || (ngc == 'Default')) {
      predictAll(inputText)
    } else if (ngc == 'Bi-Grams') {
      bigramPredict(inputText)
    } else if (ngc == 'Tri-Grams') {
      trigramPredict(inputText)
    } else if (ngc == 'Quad-Grams') {
      quadgramPredict(inputText)
    } else {
      'the'
    }
}

shinyServer(
  function(input, output) {
    inputText <- reactive({input$textInput})
    algoOptions <- reactive({
      cat("Rendering N-Grams Model \n")
      selectInput('N-Grams Options', 'N-Grams Options', c('Default', 'Bi-Grams', 'Tri-Grams', 'Quad-Grams'))
      })
    output$algoOptions <- renderUI({algoOptions()})
    output$textOutput <- renderText({
      prediction = predict(inputText(), input)
      paste0("Predicted Next Word: ", prediction, sep="", collapse="")
    })
  }
)