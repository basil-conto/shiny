shinyUI(pageWithSidebar(
  headerPanel("Distributions of Random Variables"),
  
  sidebarPanel(
    
    selectInput(
      "distType", "Distribution Type",
      choices=c("Discrete", "Continuous"), selected="Discrete"
    ),
    
    conditionalPanel(
      condition = "input.distType == 'Continuous'",
      radioButtons("dist","Distribution Name:",
                    list("Normal"="norm","Uniform"="unif","Exponential"="exp")
                   )
    ),
    
    conditionalPanel(
      condition = "input.distType == 'Discrete'",
      radioButtons("dist_disc","Distribution Name:",
                   list("Poisson"="pois","Binomial"="bino")
      )
    ),
    sliderInput("n","Sample size:", min=1, max=1000, value=500),
    conditionalPanel(
      condition="input.dist_disc=='bino'",
      numericInput("ntrials","Number of trials:",10),
      numericInput("psucc","Probability of success:",0.5)
    ),
    conditionalPanel(
      condition="input.dist_disc=='pois'",
      numericInput("lambda","Lambda:",0.5)
    ),
    checkboxInput("density","Show density curve",FALSE),
    conditionalPanel(
      condition="input.density==true",
      numericInput("bw","bandwidth:",1)
    )
  ),
  
  mainPanel(
    #plotOutput("plot")
    tabsetPanel(
      tabPanel("Plot",plotOutput("plot")),
      tabPanel("Summary",verbatimTextOutput("summary")),
      tabPanel("Table",tableOutput("table"))
    )
  )
))
