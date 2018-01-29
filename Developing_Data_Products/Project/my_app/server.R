library(shiny)

# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
#   (Intercept) 33.70832    2.60489  12.940 7.73e-13 ***
#   cyl6        -3.03134    1.40728  -2.154  0.04068 *  
#   cyl8        -2.16368    2.28425  -0.947  0.35225    
#   hp          -0.03211    0.01369  -2.345  0.02693 *  
#   wt          -2.49683    0.88559  -2.819  0.00908 ** 
#   amManual     1.80921    1.39630   1.296  0.20646  

carMPG <- function(cyl, hp, wt, am) {
  
  value <- 33.70832  

  if (cyl == "6")
    value <- value - 3.03134
  else if (cyl == "8")    
    value <- value - 2.16368
  
  value <- value - 0.03211 * hp  
  value <- value - 2.49683 * wt   

  if (am == "Manual")
    value <- value + 1.80921
  
  return (value)  
}

  
shinyServer(function(input, output) {
  
  output$cyl <- renderPrint({
    if (input$cyl == "4") "4 cylinders" 
    else if (input$cyl == "6") "6 cylinders"
    else "8 Cylinders"
  })
  
  output$hp <- renderPrint({input$hp})

  output$wt <- renderPrint({input$wt})
  
  output$am <- renderPrint({input$am})
  
  output$prediction <- renderPrint({carMPG(input$cyl, input$hp, input$wt, input$am)}) 
  
  }
)