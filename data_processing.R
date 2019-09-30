# ---- Set Working Directory ----
setwd("C:/Users/Natasha/projects/animal_data_science_shiny_app/")

# ---- Load libraries ----
library(lubridate)
library(tidyverse)
library(ggplot2)

# ---- Import Data ----
# Before importing I manually removed list the data was nested in, 
# and the "let data = " string before the nested list.

raw_data <- read.csv(file = "data.csv", header = FALSE)
head(raw_data)

# ---- Data Cleaning ----
# Data cleaning TO-DO.
# 1. Add column names
# 2. Remove last column
# 3. Remove brackets from first and 6th (now last) column.
# 4. Turn first column into datetime.
# 5. Check that 2nd thru 6th columns are numeric and coerce if not.

# Drop last column of nulls.
nb_data = subset(raw_data, select = -c(V7))
head(nb_data)

# Add column names.
names(nb_data) <- c("datetime",
                 "air_pressure",
                 "humidity",
                 "temperature",
                 "light",
                 "movement")
head(nb_data)

# Remove brackets in first and last columns.
nb_data$datetime <- gsub("\\[", "", nb_data$datetime)
head(nb_data)
nb_data$movement <- as.integer(gsub("\\]", "", nb_data$movement))
glimpse(nb_data)

# Change first column to datetime.
nb_data$datetime <- mdy_hm(nb_data$datetime,tz=Sys.timezone())
glimpse(nb_data)

# ---- Graph Data ----
ap_plot <- ggplot(nb_data, aes(x = datetime, y = air_pressure)) +
  geom_line() +
  ggtitle("Air Pressure (mmHg)") +
  theme_classic()
  
h_plot <- ggplot(nb_data, aes(x = datetime, y = humidity)) +
  geom_line() +
  ggtitle("Humidity (%)") +
  theme_classic()
  
t_plot <- ggplot(nb_data, aes(x = datetime, y = temperature)) +
  geom_line() +
  ggtitle("Temperature (celsius)") +
  theme_classic()

l_plot <- ggplot(nb_data, aes(x = datetime, y = light)) +
  geom_line() +
  ggtitle("Light (lux)") +
  theme_classic()

m_plot <- ggplot(nb_data, aes(x = datetime, y = movement)) +
  geom_bar(stat = "identity") +
  ggtitle("movement") +
  theme_classic()

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

mv_plot <- multiplot(ap_plot, h_plot, t_plot, l_plot, m_plot, cols=1)
