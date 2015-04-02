library(shiny)

shinyUI(pageWithSidebar(

  # Title
  headerPanel("Distributions of Random Variables"),

  # User input panel
  sidebarPanel(

    # Select between types of distributions
    selectInput(
      "distType", "Distribution Type",
      choices = c("Discrete", "Continuous"), selected = "Discrete"
    ),

    # Continuous distributions
    conditionalPanel(
      condition = "input.distType == 'Continuous'",
      radioButtons("dist", "Distribution Name:",
                   list("Normal"      = "norm",
                        "Uniform"     = "unif",
                        "Exponential" = "exp")
                  )
    ),

    # Discrete distributions
    conditionalPanel(
      condition = "input.distType == 'Discrete'",
      radioButtons("dist_disc", "Distribution Name:",
                   list("Poisson" = "pois",
                        "Binomial" = "bino")
      )
    ),

    # Sample size slider
    sliderInput("n", "Sample size:", min = 1, max = 1000, value = 500),

    # Numeric input boxes for trials and success probability
    conditionalPanel(
      condition = "input.dist_disc=='bino'",
      numericInput("ntrials", "Number of trials:", 10),
      numericInput("psucc", "Probability of success:", 0.5)
    ),

    # Numeric input box for lambda
    conditionalPanel(
      condition = "input.dist_disc=='pois'",
      numericInput("lambda", "Lambda:", 0.5)
    ),

    # Checkbox governing whether density curve is plotted
    checkboxInput("density", "Show density curve", FALSE),

    # Numeric input box for density curve bandwidth
    conditionalPanel(
      condition = "input.density==true",
      numericInput("bw", "bandwidth:", 1)
    )
  ),

  # Tabs
  mainPanel(
    tabsetPanel(
      tabPanel("Plot",    plotOutput("plot")),
      tabPanel("Summary", verbatimTextOutput("summary")),
      tabPanel("Table",   tableOutput("table"))
    )
  )
))
