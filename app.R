#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(fmsb)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Balance Wheel Prototype"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("love",
                        "Love:",
                        min = 1,
                        max = 10,
                        value = 1),
            sliderInput("mentalhealth",
                        "Mental Health:",
                        min = 1,
                        max = 10,
                        value = 1),
            sliderInput("community",
                        "Community:",
                        min = 1,
                        max = 10,
                        value = 1),
            sliderInput("family",
                        "Family:",
                        min = 1,
                        max = 10,
                        value = 1),
            sliderInput("career",
                        "Career:",
                        min = 1,
                        max = 10,
                        value = 1),
            sliderInput("money",
                        "Money:",
                        min = 1,
                        max = 10,
                        value = 1),
            sliderInput("physicalhealth",
                        "Physical Health:",
                        min = 1,
                        max = 10,
                        value = 1),
            sliderInput("purpose",
                        "Purpose:",
                        min = 1,
                        max = 10,
                        value = 1),
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    ),
    
    hr(),
    print("~~~my disclaimer~~~~")

)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        
        var1=input$love
        var2=input$mentalhealth
        var3=input$community
        var4=input$family
        var5=input$career
        var6=input$money
        var7=input$physicalhealth
        var8=input$purpose
        
        
        data <- as.data.frame(matrix(c(var1,var2,var3,var4,var5,var6,var7,var8),ncol=8))
        colnames(data) <- c("Love" , "Mental Health" , "Community" , "Family" , "Career", "Money" , "Physical Health" , "Purpose" )
        
        # To use the fmsb package, I have to add 2 lines to the dataframe: the max and min of each topic to show on the plot!
        data <- rbind(rep(11,8) , rep(0,8) , data)
        
        # Check your data, it has to look like this!
        # head(data)
        
        # The default radar chart 
        radarchart(data)
        
        
        # generate bins based on input$bins from ui.R
        #x    <- faithful[, 2]
        #bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        #hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
