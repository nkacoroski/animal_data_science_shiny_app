# ---- Install Packages ----
# install necessary packages

install.packages("shiny")

library(shiny)

runExample("01_hello")

# Define UI ----
ui <- fluidPage(
  
)

# Define server logic ----
server <- function(input, output) {
  
}

# Run the app ----
shinyApp(ui = ui, server = server)
