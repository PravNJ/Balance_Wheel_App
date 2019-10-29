library(shiny)
library(fmsb) #For radar chart



fields <- c("love", "mentalhealth", "community","family","career","money","physicalhealth","purpose","email")

# Save a response
# ---- This is one of the two functions we will change for every storage type ----
saveData <- function(data) {
    data <- as.data.frame(t(data))
    if (exists("responses")) {
        responses <<- rbind(responses, data)
    } else {
        responses <<- data
    }
}

# Load all previous responses
# ---- This is one of the two functions we will change for every storage type ----
loadData <- function() {
    if (exists("responses")) {
        responses
    }
}

ui <- fluidPage(

    
    DT::dataTableOutput("responses", width = 300), tags$hr(),
    
    # Application title
    titlePanel("Balance Wheel by Coverhero"),

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
            textInput("email", "Email", ""),
            actionButton("submit", "Submit")
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           #plotOutput("distPlot", width = "50%")
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
        data <- rbind(rep(10,8) , rep(1,8) , data)
        
    
        
        # The default radar chart 
        radarchart( data  , axistype=1 , 
                    
                    #number of segments in scale
                    seg=10,
                    
                    #custom polygon
                    pcol=rgb(228, 68, 167,max=255), pfcol=rgb(0,213,155,max=255) , plwd=4 , 
                    
                    #pcol=rgb(0.2,0.5,0.5,0.9) , pfcol=rgb(0.2,0.5,0.5,0.5) , plwd=4 , 
                    
                    #custom the grid
                    cglcol="grey", cglty=1, axislabcol="grey", caxislabels=c("","","","","","","","","",""), cglwd=0.8,
                    
                    #custom labels
                    vlcex=0.8 
        )
        
        # Whenever a field is filled, aggregate all form data
        formData <- reactive({
            data <- sapply(fields, function(x) input[[x]])
            data
        })
        
        # When the Submit button is clicked, save the form data
        observeEvent(input$submit, {
            saveData(formData())
        })
        
        # Show the previous responses
        # (update with current response when Submit is clicked)
        output$responses <- DT::renderDataTable({
            input$submit
            loadData()
        })     
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
