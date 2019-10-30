# ---- Set Working Directory ----
setwd("C:/Users/Natasha/projects/animal_data_science_shiny_app/app")

# ---- Load Packages ----
library(plotly)
library(shinydashboard)
library(shinyjs)

# ---- Load Data ----
load(file = "nb_data.rds")
head(nb_data)

# ---- Define UI ----
ui <- fluidPage(
  titlePanel(
    h1("eNest Visualization Dashboard", align = "center")),
  mainPanel(
    shinyjs::useShinyjs(),
    includeScript(path = "www/renderTooltipsOnSubplots.js"),
    fluidRow(plotly::plotlyOutput('subplot_js_plot', height = 800), align = "center")
    ))

# ---- Define Server ----
server <- function(input, output, session) {
  
  output$subplot_js_plot <- plotly::renderPlotly({
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
    
    p <- subplot(p1, p2, p3, p4, p5,
                 nrows = 5,
                 margin = 0.03,
                 shareX = TRUE,
                 titleY = TRUE)
    
    
    # js hook to render tooltips on sublots
    hook <- list()
    hook$render[[1]]$code <- "renderTooltipsOnSubplots('subplot_js_plot')"
    
    p$jsHooks <- hook
    p
  })
  
}


# ---- Run App ----
shinyApp(ui = ui, server = server)
