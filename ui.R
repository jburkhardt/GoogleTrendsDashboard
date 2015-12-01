library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "Google Trends"),
  dashboardSidebar(sidebarMenu(
    menuItem("Chart", tabName = "chart", icon = icon("bar-chart")),
    menuItem("Data", tabName = "data", icon = icon("table")),
    selectInput("country", label = h5("Select Country"),
                choices = list("DE"="DE","AT"="AT","CH"="CH"), selected = "DE"),
    dateRangeInput("daterange", label=h5("Date range:"),
                   start = "2015-01-01",
                   end = Sys.Date()-1
                   ),
    textInput("queries", label = h5("Search Queries"),
              width = "100%", 
              value = 'nhl,nba,nfl'
              ),
    downloadButton("downloadData", label = "Download Data", class = NULL),
    tags$style(type="text/css", "#downloadData {padding: 10px; margin: 20px;}")
            )
      ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "chart",
                plotOutput("plot1", height = 500)
              ),
      # Second tab content
      tabItem(tabName = "data",
              dataTableOutput('data')
      )
    )
  )
)