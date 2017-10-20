#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Old Faithful Geyser Data"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 30)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

shinyUI(fluidPage(
  
  titlePanel("BODY MASS Index Calculator"),
  
  sidebarLayout(
    sidebarPanel( 
      
      helpText("BMI Index is common measure for health, this application helps you find it out"),            
      br(),           
      numericInput("ing_weight_kg",label = h4("How much do you weight (KG)"),min = 40, max = 300,0), #, value = 70
      br(),
      numericInput("int_height_cm",label = h4("What is your height (CM)"),min = 50, max = 250,0), #,value = 170
      br(),
      
      br(),   
      actionButton("FindBMI", label = "Your BMI is")    
      
      
    ),
    mainPanel
    (
      tabsetPanel
      (
        tabPanel("Find out you BMI",
                 p(h4("Here are your current measures:")),
                 textOutput("current_height"),
                 textOutput("current_weight"),
                 br(),
                 p(h4("Your BMI is displayed below:")),
                 textOutput("BMI_result"),
                 p(h4("Your BMI classification is:")),
                 textOutput("status_indicator")
                 
        ),
        tabPanel(
          "Documentation",
          p(h4("Body Mass Index Application")),
          br(),
          helpText("This simple application calculates a person BMI based on current weight and height"),
          p(h3("Why is BMI important?")),
          helpText("BMI tells you if you weight is normal, underweight or overweight is a common measure used by doctor to have a parameter about a person health")
        )
        
        
      )
    )
  )
))


