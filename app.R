# ---- Set Working Directory ----
setwd("C:/Users/Natasha/projects/animal_data_science_shiny_app/")

# ---- Load Packages ----
library(shiny)
library(dygraphs)
library(datasets)
library(plotly)

runExample("01_hello")

# ---- Import Data ----
load(file = "nb_data.rds")

head(nb_data)

# Define UI ----

p1 <- plot_ly(nb_data, x= ~datetime, y = ~air_pressure, color = I("black"), 
              name = "air pressure",
              showlegend = FALSE) %>%
  add_lines() %>%
  layout(yaxis = list(title = "air pressure"))

p2 <- plot_ly(nb_data, x= ~datetime, y = ~humidity, color = I("black"), 
              name = "humidity",
              showlegend = FALSE) %>%
  add_lines()

p3 <- plot_ly(nb_data, x= ~datetime, y = ~temperature, color = I("black"),
              name = "temperature",
              showlegend = FALSE) %>%
  add_lines()

p4 <- plot_ly(nb_data, x= ~datetime, y = ~light, color = I("black"), 
              name = "light",
              showlegend = FALSE) %>%
  add_lines()

p5 <- plot_ly(nb_data, x= ~datetime, y = ~movement, type = "bar", color = I("black"), 
              name = "movement",
              showlegend = FALSE)


subplot(p1, p2, p3, p4, p5,
        nrows = 5,
        margin = 0.03,
        shareX = TRUE,
        titleX = TRUE,
        titleY = TRUE)

# Define server logic ----
server <- function(input, output) {


}

# Run the app ----
shinyApp(ui = ui, server = server)
