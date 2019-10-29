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

head(nb_data)

# Define UI ----

k <- highlight_key(nb_data, ~datetime)

p1 <- plot_ly(nb_data, x= ~datetime, y = ~air_pressure, color = I("black"), 
              name = "air pressure",
              showlegend = FALSE) %>%
  add_lines(hoverinfo = 'y') %>%
  layout(yaxis = list(title = "air pressure"))

p2 <- plot_ly(nb_data, x= ~datetime, y = ~humidity, color = I("black"), 
              name = "humidity",
              showlegend = FALSE) %>%
  add_lines(hoverinfo = 'y')

p3 <- plot_ly(nb_data, x= ~datetime, y = ~temperature, color = I("black"),
              name = "temperature",
              showlegend = FALSE) %>%
  add_lines(hoverinfo = 'y')

p4 <- plot_ly(nb_data, x= ~datetime, y = ~light, color = I("black"), 
              name = "light",
              showlegend = FALSE) %>%
  add_lines(hoverinfo = 'y')

p5 <- plot_ly(nb_data, x= ~datetime, y = ~movement, type = "bar", color = I("black"), 
              name = "movement",
              showlegend = FALSE,
              hoverinfo = 'y')


subplot(p1, p2, p3, p4, p5,
        nrows = 5,
        margin = 0.03,
        shareX = TRUE,
        titleX = FALSE,
        titleY = TRUE) %>%
  highlight(on = "plotly_hover")


library(plotly)
library(crosstalk)
library(tidyverse)

df <- data.frame(
  x = c(1, 2, 3, 4, 5, 6, 7, 8), 
  y1 = c(1, 3, 5, 7, 11, 13, 15, 17),
  y2 = c(1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5)
)

shared_df <- SharedData$new(df, key = ~x)

p1 <- plot_ly(shared_df, x = ~x, y = ~y1, type = "scatter", mode = "markers",
              showlegend = FALSE, 
              hovertemplate = ~paste(
                "x: ", x,
                "<br>y1: ", y1,
                "<br>y2: ", y2))

p2 <- plot_ly(shared_df, x = ~x, y = ~y2, type = "scatter", mode = "markers",
              showlegend = FALSE, hoverinfo = "y")

subplot(p1, p2, nrows = 2, shareX = TRUE) %>%
  highlight(on = "plotly_hover", off = "plotly_doubleclick")




ggplotly(
  shared_df %>%
    ggplot(aes(x = ID, y = Value)) + 
    geom_point() +
    facet_grid(~ group)
)


# Define server logic ----
server <- function(input, output) {


}

# Run the app ----
shinyApp(ui = ui, server = server)
