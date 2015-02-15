library(shiny)
library(caret)
library(Cubist)
library(ggplot2)

load("cubist_mod.Rda")
load("dat.Rda")



# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$text1 <- renderText({ 
        
        new.data <- data.frame(Male=as.numeric(input$Male) , 
                               Meters=input$Meters ,
                               Age=input$Age
        )
        
        paste("Predicted time for the average ",input$Age,
              "year old",if(input$Male==1){"Male"}else{"Female"},
              "master runner in the U.S. All-time List for a", round(as.numeric(input$Meters),0) ,"meters race is",
              round(predict(cubist.mod, new.data)/60,2) ,
              "minutes")
        
    })
    
    output$pacePlot <- renderPlot({
        new.data <- data.frame(Male=as.numeric(input$Male) , 
                               Meters=input$Meters ,
                               Age=input$Age
        )
        
        Minute.Mile <- (predict(cubist.mod, new.data)/60) / 
            ( as.numeric(input$Meters) / 1609.34 )

        qplot(x=Age , y=(Seconds/60)/(Meters/1609.34) , data = dat 
              , colour=Gender 
              , geom = c("point", "smooth") 
              , span = 1) + ylab("Minutes / Mile") +
            #geom_vline(xintercept = as.numeric(input$Age) , colour="red") +
            #geom_hline(yintercept = Minute.Mile , colour="red") +
            ggtitle("Predicted Pace") + 
            theme(plot.title = element_text(lineheight=.8, face="bold")) +
            geom_point(aes(y= Minute.Mile , x=as.numeric(input$Age)) , 
                       colour="black" , size=5 ) +
            geom_text(data = NULL, x = as.numeric(input$Age), y = Minute.Mile + 1 , 
                      label = paste("predicted pace of\n",round(Minute.Mile,2),"\n minute/mile") ,
                      vjust=0 , colour="black")
        

    })
    
    output$speedPlot <- renderPlot({
        new.data <- data.frame(Male=as.numeric(input$Male) , 
                               Meters=input$Meters ,
                               Age=input$Age
        )
        
        Meters.Second <- as.numeric(input$Meters) / predict(cubist.mod, new.data)
        
        qplot(x=Age , y=Meters/Seconds , data = dat 
              , colour=Gender 
              , geom = c("point", "smooth") 
              , span = 1) + ylab("Meters / Second") +
            #geom_vline(xintercept = as.numeric(input$Age) , colour="red") +
            #geom_hline(yintercept = Meters.Second , colour="red") +
            ggtitle("Predicted Speed")+ 
            theme(plot.title = element_text(lineheight=.8, face="bold")) +
            geom_point(aes(y= Meters.Second , x=as.numeric(input$Age)) , 
                       colour="black" , size=5 ) +
            geom_text(data = NULL, x = as.numeric(input$Age), y = Meters.Second - 1 , 
                      label = paste("predicted speed of\n",round(Meters.Second,2)," meters/second") ,
                      vjust=0 , colour="black") 
        
        
    })
    
})
