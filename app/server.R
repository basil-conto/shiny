library(shiny)

shinyServer(function(input,output){
  dat <- reactive({
    dist <- switch(input$dist,norm=rnorm, unif=runif, exp=rexp)
    
    dist(input$n)
  })

  
  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$n
    ntrials <- input$ntrials
    psucc <- input$psucc
    lambda <- input$lambda
    
    if(input$distType=="Continuous"){
      hist(dat(),col="orange")
      lines(density(dat(),adjust=input$bw),lwd=2)
    }
    else{
      if(input$dist_disc=="bino"){
        bindat<-rbinom(n,ntrials,psucc)         
        hist(bindat,col="orange")
      }
      else
      {
        poisdat<-rpois(n,lambda)         
        hist(poisdat,col="orange")
      }
    }
  })
  
  output$summary <- renderPrint({
    summary(dat())
  })
  
  output$table <- renderTable({
    data.frame(x=dat())
  })
})
