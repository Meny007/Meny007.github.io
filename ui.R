#This is the user interface where the user will choose the parameter of interest
source("datarep.R",local=TRUE)
shinyUI(fluidPage(
  titlePanel("Gage R&R Calculation"),
    sidebarLayout(
    sidebarPanel(
      h4("Quick Explanation"),
      
      p("The ANOVA Gage R&R is a statistical method to estimate the amount of variability induced in measurements by the measurement system itself, and compares it to the total variability observed in order to determine the variability of the measurement system"),
      
      p("For the purpose of the project, the dataset has been sourced by the author of this routine (me), as this is real collected data. However, future version can include upload dataset by the user with the proper format"),
      
      helpText("Choose parameter of interest"),
    
      selectInput(inputId = "var",
              label = "Choose Parameter:",
              choices = c(colnames(testDat[,3:(ncol(testDat))])),
              selected = colnames(testDat[3]))
      

    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Instructions",verbatimTextOutput("instr")),
        tabPanel("Table Example",dataTableOutput("table")),
        tabPanel("Gage R&R Summary",verbatimTextOutput("sum")),
        tabPanel("Plot",plotOutput("plot",height = 750))
        
      )
    )
  )
))