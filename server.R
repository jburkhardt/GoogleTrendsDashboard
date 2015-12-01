## server.R ##
library(shiny)
library(shinydashboard)
library(gtrendsR)

function(input, output) {
  yesterday <- Sys.Date()-1
  #place your google credentials in gconnect
  gconnect(usr = "yourGoogleEmail", psw = "yourPassword")
  
  dataInput <- reactive({
        gtrends(query = input$queries,
                       geo = input$country,
                       start_date = input$daterange[1],
                       end_date = input$daterange[2])
  })
  
  output$plot1 <- renderPlot({
    res <- dataInput()
    plot(res)
  })
  
  output$data <- renderDataTable({
    res <- dataInput()
    res$trend
  })
  
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$dataset, '.csv', sep='') },
    content = function(file) {
      write.csv(res$trend, file, row.names = F, sep=",")
      })
}