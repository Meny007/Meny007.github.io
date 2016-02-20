#server.R

source("datarep.R",local=TRUE)
library(shiny)
library(qualityTools)
# Define a server for the Shiny app

shinyServer(function(input, output){
  source("datarep.R",local=TRUE)
  # Fill in the spot we created for a plot
  output$instr <- renderPrint({
    cat("This is Gage R&R Tool.\nEach parameter was collected under electrical test of semiconductor device.\nYou can see an example of the Table output in the Example Tab and how the parameteres were collected.\nYou have a column for the Tester used, a column for the Deviced tested and the following columns are each one a different electrical test, i.e., parameter.\nFor this data, 10 devices were used. They were tested 3 times in each tester, i.e., overall there are 30 data-points for each device.\nThe reason it's measure 3x in each tester is in order to estimate the within tester repeatability. The reason in repeating this in 3 different testers is in order to estimate tester to tester reproducibility, thus Gage R&R.\n \n \nYou need to select a parameter each time you do an evaluation for the Repeatabiltiy and Reproducibility values.\nThe goal in the industry in to keep the TotalRR variance lower than 30% the total Variance. Everything above that you should disqualify the measurement tools, fix, calibrate and perform the test again.\n\nHere an example from the semiconductor industry industry was brought, however this can be applied in a variety of fields. ")
  })
  output$table <- renderDataTable(testDat[,1:12])
  output$sum <-renderPrint({
    source("datarep.R",local=TRUE)
    gdo = gageRRDesign(3,10, 3, method = "crossed",sigma=6,randomize = TRUE)
    response(gdo)<-testDat[,input$var]
    gdo<-gageRR(gdo)
  })
  output$plot<- renderPlot({
    source("datarep.R",local=TRUE)
    gdo = gageRRDesign(3,10, 3, method = "crossed",sigma=6,randomize = TRUE)
    response(gdo)<-testDat[,input$var]
    gdo<-gageRR(gdo)
    plot(gdo)})
})