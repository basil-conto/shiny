library(shiny)

shinyServer(function(input, output){

  # Choose continuous distribution type
  dat <- reactive({
    dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   exp  = rexp)
    dist(input$n)
  })

  output$plot <- renderPlot({

    dist    <- input$dist       # Distribution type
    n       <- input$n          # Sample size
    ntrials <- input$ntrials    # Trials for binomial
    psucc   <- input$psucc      # Probability of success for binomial
    lambda  <- input$lambda     # Avg. no. of events for Poisson

    # Continuous distributions
    if (input$distType == "Continuous") {

      # Create continuous histogram
      hist(dat(), col = "orange", xlab = "Observations",
           main = paste('r', dist, '(', n, ')', sep=''), prob = TRUE)


      # Draw density curve?
      if (input$density) {
        lines(density(dat(), adjust = input$bw), lwd = 2)
      }

    # Discrete distributions
    } else if (input$dist_disc == "bino") {

      # Generate random binomial distribution
      bindat <- rbinom(n, ntrials, psucc)
      # Draw binomial histogram
      hist(bindat, col = "orange",
           main = paste('r', dist, '(', n, ')', sep=''), prob = TRUE)

      # Draw density curve?
      if (input$density) {
        lines(density(bindat, adjust = input$bw), lwd = 2)
      }

    } else {

      # Generate random Poisson distribution
      poisdat <- rpois(n, lambda)
      # Draw Poisson histogram
      hist(poisdat, col = "orange",
           main = paste('r', dist, '(', n, ')', sep=''),prob = TRUE)

      # Draw density curve?
      if (input$density) {
        lines(density(poisdat, adjust = input$bw), lwd = 2)
      }
    }
  })

  # Tab displaying summary statistics of data set
  output$summary <- renderPrint({
    summary(dat())
  })

  # Tab displaying table with entire data set
  output$table <- renderTable({
    data.frame(x = dat())
  })
})
