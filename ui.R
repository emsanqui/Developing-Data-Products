library(shiny)
load("agelist.Rda")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Predicted time for the average Masters Runner in the All-time List"),
    h4("USATF - U.S. All-time List - Masters Age Graded Road Running (by distance), as of 3/2/2012"),
    a("http://www.usatf.org/statistics/All-Time-Lists/usa track and field all-time data.aspx"),
    
    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(
            radioButtons("Male", label="Competitor's Gender", 
                         choices=list("Male"=1, "Female"=0),
                         selected=0),
            radioButtons("Meters", label="Race Distance",
                         choices=list(
                             "5K"=5000 ,
                             "8K"=8000 ,
                             "10K"=10000, 
                             "10 Miles"= 16093.4 ,
                             "12K"=12000 ,
                             "15K"=15000 ,
                             "20K"=20000 ,
                             "25K"=25000 ,
                             "30K"=30000 ,
                             "Half Marathon"=21082.41 ,
                             "Marathon"=42164.81 )
                         ),
            selectInput("Age", label="Competitor's Age",
                        choices = age.list,
                        selected = 48
                        )
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            textOutput("text1") ,
            plotOutput("pacePlot") ,
            plotOutput("speedPlot") 
        )
    )
))
