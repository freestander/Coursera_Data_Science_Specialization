library(shiny)

shinyUI(fluidPage(

  titlePanel("Developing Data Products Demo - Regression Model with mtcars"),
  
  sidebarLayout(
    sidebarPanel(     

      h3("Documentation"),
      
      helpText("The regression model is used to predict miles per gallon (MPG) by entering: "),
      
      tags$ul(
        tags$li("Number of cylinders"), 
        tags$li("Gross horsepower"), 
        tags$li("Weight (lb/1000)"),
        tags$li("Transmission (automatic/manual)")),
      
      helpText("Predicted MPG will be displayed on the right after you click on 'Submit' button."),
      
      h3("Input Car Parameters"),
      
      radioButtons("cyl", 
                   label = "Number of cylinders",
                   choices = list("4 cylinders" = "4", 
                                  "6 cylinders" = "6",
                                  "8 cylinders" = "8"), 
                   selected = "4"),
      
      sliderInput("hp", 
                  label = "Range of gross horsepower:",
                  min = 52, 
                  max = 335, 
                  value = 194),

      
      sliderInput("wt", 
                  label = "Weight (lb/1000):",
                  min = 1.513, 
                  max = 5.424, 
                  value = 3.4685),      

      radioButtons("am", 
                   label = "Transmission (automatic/manual)",
                   choices = list("Automatic" = "Automatic", 
                                  "Manual" = "Manual"), 
                   selected = "Automatic"),
      
      submitButton("Submit")
    ),
    
    mainPanel(
      
      h4("You have selected the number of cylinders:"),
      verbatimTextOutput("cyl"),
      
      h4("You have input gross horsepower:"),
      verbatimTextOutput("hp"),
      
      h4("You have input weight (lb/1000):"),
      verbatimTextOutput("wt"),
      
      h4("You have selected transmission type:"),
      verbatimTextOutput("am"),
      
      h4("======================================"),
      h4("The estimated MPG for the car with the specified parameters:"),
      verbatimTextOutput("prediction")
    )
  )
))