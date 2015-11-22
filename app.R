#load in a table from my github account (copy of table from the London DataStore)
library(RCurl)
data <- getURL("https://raw.githubusercontent.com/Paul-Hodgson/shiny-pop/master/GLA_pop_2014.csv", ssl.verifypeer = FALSE)
pop_raw <- read.csv(textConnection(data))

#create a sorted list of boroughs to use in the drop down
borough_list <- borough_list <- data.frame(unique(pop_raw$Borough.Name))
borough_list <- borough_list[order(borough_list$unique.pop_raw.Borough.Name),]
borough_list <- as.character(borough_list)
Ans_pop <- 1000

library(ggplot2)
library(shiny)

#create the 3 input areas
ui <- fluidPage(
  headerPanel("London's population predictor"),
  
  sidebarPanel(

#instruction text for users    
        
    p("This app looks up how many people of a particular age, live in each of the 33 London Boroughs."),
    p("It uses the most recent population projections from the Greater London Authority for future years (thanks to the London DataStore, for the data)."),
    br(),
    strong("To use, simply adjust the 3 inputs below and see the 'predicted value' change:"),
    p(""),
    br(),
    br(),
    br(),
    br(),
    
#collect the 3 inputs    
    
    sliderInput("yr", 
                label = "Year",
                min = 2001, max = 2040, value = 2015),
    br(),
    numericInput("age", 
                 label = "Age",
                 min = 0, max = 90, value = 6),
    br(),
    selectInput("borough",
                label = "London Borough",
                choices = borough_list,
                selected = "Brent"
    )
  ),

#show the values that have been entered back to the users
  mainPanel(
    fluidRow(
      column(4,
             h2(paste("Year"))),
      column(4,
             h2(paste("Borough"))),
      column(4,
             h2(paste("Age")))
    ),
    
    fluidRow(
      column(4,
             h3(textOutput("text"))
      ),
      column(4,
             h3(textOutput("text2"))
      ),
      column(4,
             h3(textOutput("text1"))
      )
    )
#take the output value from the lookup table and also show how population changes over time for this age group    
    ,
            h3(paste("Which resulted in a prediction of:")),
            h1(textOutput("pred")),
            br(),
            p("The graph below shows the population each year, for your chosen Borough and age."),
            br(),
            plotOutput("mygraph")

            
  )
)


server <- function(input, output) {
  output$text <- renderText({
    print(input$yr)
  })
  output$text1 <- renderText({
    print(input$age)
  })
  output$text2 <- renderText({
    print(input$borough)
  })
  output$text3 <- renderText({
    print(input$Ans_pop)
  }) 
  #subset just those row for the chosen Borough and year. Subset for chosen age column (note there are 6 extra columns at start)
  output$pred <- renderText({
    pop2 <- pop_raw
    pop2 <- pop2[pop2$Borough.Name == input$borough & pop2$Year == input$yr,(input$age + 6)]
  })
  #subset just those row for the chosen Borough (all years this time). Subset Year and age columns. Plot value against years
  output$mygraph <- renderPlot({
    pop <- pop_raw[which(pop_raw$Borough.Name == input$borough), c(3,(input$age + 6)) ]
    colnames(pop)[2] <- "forecast" # give the values column this name so that the plot knows to look for it
    ggplot(pop, aes(x=Year, y=forecast)) + geom_area(fill = 'blue', alpha = 0.3) + ylab("Predicted number of people")
  })
  
  
}

shinyApp(ui = ui, server = server)