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
ui <- fluidPage(
  titlePanel("eNest Dashboard"),
  plotlyOutput("plot", hover = "plot_hover")
  
)

# Define server logic ----
server <- function(input, output) {
  output$plot <- renderPlotly({
    vars <- setdiff(names(nb_data), "datetime")
    plots <- lapply(vars, function(var) {
      plot_ly(nb_data, x = ~datetime,
              height = 1000,
              y = as.formula(paste0("~", var))) %>%
        add_lines(name = var, color = I("black"),
                  showlegend = FALSE)
    })
    subplot(plots, nrows = length(plots), shareX = TRUE, titleX = FALSE,
            margin = 0.04) %>%
      layout(xaxis = list(showgrid = FALSE))
  })
  
}

# Run the app ----
shinyApp(ui = ui, server = server)

