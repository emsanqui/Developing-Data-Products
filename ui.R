library(shiny)
load("agelist.Rda")

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = "bootstrap.css",
    
    # Application title
    titlePanel("Predicted time for the average Masters Runner in the All-time List"),
    h4("USATF - U.S. All-time List - Masters Age Graded Road Running (by distance), as of 3/2/2012"),
    a("http://www.usatf.org/statistics/All-Time-Lists/Masters-Age-Graded-Road-Running.aspx"),
    
    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        
        sidebarPanel(
            h5("This application is for entertainment purpose only. 
               As competetive runners knows, performance can not be boiled down to gender, age, and distance.
               However, at a high level there are trends."),
            h5("This app predicts statistics about an average masters competitor in the list for a given gender, distance race, and age."),
            h5("In order to run it, the user needs only to select the desired values from the following options."),
            
            radioButtons("Male", label="Competitor's Gender", 
                         choices=list("Female"=0, "Male"=1),
                         selected=0),
            selectInput("Age", label="Competitor's Age",
                        choices = age.list,
                        selected = 60
                        ),
            radioButtons("Meters", label="Race Distance",
                         choices=list(
                             "5K"=5000 ,
                             "8K"=8000 ,
                             "10K"=10000, 
                             "10 Miles (16,093m)"= 16093.4 ,
                             "12K"=12000 ,
                             "15K"=15000 ,
                             "20K"=20000 ,
                             "25K"=25000 ,
                             "30K"=30000 ,
                             "Half Marathon (21,082m)"=21082.41 ,
                             "Marathon (42,165m)"=42164.81 )
                         )
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            textOutput("text1") ,
            plotOutput("pacePlot") 
        )
    )
))
