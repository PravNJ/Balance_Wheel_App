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

ui <- fluidPage(

    # Application title
    titlePanel("Balance Wheel Prototype"),

    # Sidebar with a slider input
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

# Define server logic
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
        
        # Max and min of the radar plot
        data <- rbind(rep(11,8) , rep(0,8) , data)
        
    
        
        # The default radar chart 
        radarchart( data  , axistype=1 , 
                    
                    #custom polygon
                    pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4 , 
                    
                    #custom the grid
                    cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
                    
                    #custom labels
                    vlcex=0.8 
        )
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
