# ---- Set Working Directory ----
setwd("C:/Users/Natasha/projects/animal_data_science_shiny_app/")

# ---- Load Packages ----
library(shiny)
library(dygraphs)
library(datasets)
library(ggplot2)
library(plotly)
library(crosstalk)

runExample("01_hello")

# ---- Import Data ----
load(file = "nb_data.rds")

tags$head(tags$script(src = "<file name>"))

head(nb_data)

# ---- Define UI ----
ui <- fluidPage(
  titlePanel(
    h1("eNest Visualization Dashboard", align = "center")),
  
  sliderInput("obs", label = h3("Date and Time Range"), min = 0, 
              max = 100, value = c(40, 60)),
  plotlyOutput("plot", height = 700),
  
)

# ---- Define server logic ----
server <- function(input, output) {
  
  output$plot <- renderPlotly({
  shared_df <- SharedData$new(nb_data, key = ~datetime)
  
  p1 <- plot_ly(nb_data, x= ~datetime, y = ~air_pressure, color = I("black"), 
                name = "air pressure",
                showlegend = FALSE) %>%
    add_lines(hovertemplate = ~paste("datetime: ", datetime,
                                     "<br>air pressure: ", air_pressure,
                                     "<br>humidity: ", humidity,
                                     "<br>temperature: ", temperature,
                                     "<br>light: ", light,
                                     "<br>movement: ", movement)) %>%
    layout(yaxis = list(title = "air pressure"))
  
  p2 <- plot_ly(nb_data, x= ~datetime, y = ~humidity, color = I("black"), 
                name = "humidity",
                showlegend = FALSE) %>%
    add_lines(hovertemplate = ~paste("datetime: ", datetime,
                                     "<br>air pressure: ", air_pressure,
                                     "<br>humidity: ", humidity,
                                     "<br>temperature: ", temperature,
                                     "<br>light: ", light,
                                     "<br>movement: ", movement))
  
  p3 <- plot_ly(nb_data, x= ~datetime, y = ~temperature, color = I("black"),
                name = "temperature",
                showlegend = FALSE) %>%
    add_lines(hovertemplate = ~paste("datetime: ", datetime,
                                     "<br>air pressure: ", air_pressure,
                                     "<br>humidity: ", humidity,
                                     "<br>temperature: ", temperature,
                                     "<br>light: ", light,
                                     "<br>movement: ", movement))
  
  p4 <- plot_ly(nb_data, x= ~datetime, y = ~light, color = I("black"), 
                name = "light",
                showlegend = FALSE) %>%
    add_lines(hovertemplate = ~paste("datetime: ", datetime,
                                     "<br>air pressure: ", air_pressure,
                                     "<br>humidity: ", humidity,
                                     "<br>temperature: ", temperature,
                                     "<br>light: ", light,
                                     "<br>movement: ", movement))
  
  p5 <- plot_ly(nb_data, x= ~datetime, y = ~movement, type = "bar", color = I("black"), 
                name = "movement",
                showlegend = FALSE,
                hovertemplate = ~paste("datetime: ", datetime,
                                       "<br>air pressure: ", air_pressure,
                                       "<br>humidity: ", humidity,
                                       "<br>temperature: ", temperature,
                                       "<br>light: ", light,
                                       "<br>movement: ", movement))
  
  subplot(p1, p2, p3, p4, p5,
          nrows = 5,
          margin = 0.03,
          shareX = TRUE,
          titleX = FALSE,
          titleY = TRUE)
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)
