library(shiny)

# Server logic required to draw histogram
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is wrapped in a call
  # to renderPlot() to indicate that:
  #
  # * it is reactive, i.e. it should re-execute automatically when inputs change
  # * its input type is a plot

  output$distPlot <- renderPlot({
    x    <- faithful[, 2]   # Old Faithful Geyser data
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # Draw histogram with specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
})
