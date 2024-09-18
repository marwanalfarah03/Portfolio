library(ggplot2)
library(maps)
#library(RColorBrewer)
library(reshape2)
library(htmlwidgets)
#library(GGally)
#library(sf)
library(leaflet)
library(dplyr)
library(plotly)
library(shiny)
library(readr)

# Load your data
data <- read.csv("D:/Marwan/HTU/Third Year/Spring Semester/Data Visualization/My Solutions/Final/archive (14)/housing.csv")

# Creating new features
# Rooms per Household
data$rooms_per_household <- data$total_rooms / data$households

# Bedrooms per Household
data$bedrooms_per_household <- data$total_bedrooms / data$households

# Population per Household
data$population_per_household <- data$population / data$households

# Scaling the median_house_value
data$median_house_value <- data$median_house_value/ 1e+05

# Scaling the households
data$households <- data$households/ 1e+05

# Calculate the median construction year of each region
data$construction_year <- 1990 - data$housing_median_age

# Create age bins
data$age_group <- cut(data$housing_median_age,
                      breaks=c(0, 15, 30, 45, 60),
                      labels=c("0-15", "16-30", "31-45", "45-60"),
                      include.lowest=TRUE)

# Remove rows with NA values in total_bedrooms and bedrooms_per_household
data <- data %>%
  filter(!is.na(total_bedrooms) & !is.na(bedrooms_per_household))

# Save the updated dataset as a new CSV file
write_csv(data, "updated_housing_data.csv")

# Histogram of Median House Values
p1 <- ggplot(data, aes(x = median_house_value)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  labs(title = "Distribution of Median House Values", x = "Median House Value (1e+05)", y = "Count") +
  theme_minimal()

# Bar Chart of Ocean Proximity Counts
p2 <- ggplot(data, aes(x = ocean_proximity)) +
  geom_bar(fill = "coral", color = "black") +
  labs(title = "Counts by Ocean Proximity", x = "Ocean Proximity", y = "Count") +
  theme_minimal()

avg_median_house_value <- data %>%
  group_by(ocean_proximity) %>%
  summarise(Average_Population = mean(median_house_value))

p3 <- ggplot(avg_median_house_value, aes(x = ocean_proximity, y = Average_Population, fill = ocean_proximity)) +
  geom_bar(stat = "identity", color = "black") +
  labs(title="Average Median House Value by Ocean Proximity", x="Ocean Proximity", y="Average Median House Value") +
  theme_minimal()

# Geographic Heat Map of House Values
california <- map_data('county', regions='california')
p4 <- ggplot() +
  geom_polygon(data=california, aes(x=long, y=lat, group=group), fill="gray80", color="white") +
  geom_point(data=data, aes(x=longitude, y=latitude, color=median_house_value), size=1) +
  scale_color_gradient(low="yellow", high="red") +
  labs(title="Geographic Distribution of House Values", x="Longitude", y="Latitude", color="Median House Value (1e+05)") +
  theme_minimal()

# Scatter Plot of Median Income vs. Median House Value
p5 <- ggplot(data, aes(x = median_income, y = median_house_value)) +
  geom_point(alpha = 0.5, color = "blue") +
  labs(title = "Median Income vs. Median House Value", x = "Median Income", y = "Median House Value (1e+05)") +
  theme_minimal()

# Total Rooms vs Total Bedrooms
p6 <- ggplot(data, aes(x=total_rooms, y=total_bedrooms)) +
  geom_point(alpha = 0.5, color = "blue") +
  labs(title="Total Rooms vs Total Bedrooms", x="Total Rooms", y="Total Bedrooms") +
  theme_minimal()

# Density Plot of Locations
p7 <- ggplot() +
  geom_polygon(data=california, aes(x=long, y=lat, group=group), fill="gray80", color="white") +
  geom_point(data=data, aes(x=longitude, y=latitude), color="red", size=0.5, alpha=0.5) +
  labs(title="Density Plot of Locations", x="Longitude", y="Latitude") +
  theme_minimal()

# Overlay of Median Income
p8 <- ggplot() +
  geom_polygon(data=california, aes(x=long, y=lat, group=group), fill="gray80", color="white") +
  geom_point(data=data, aes(x=longitude, y=latitude, color=median_income), size=1) +
  scale_color_gradient(low="yellow", high="red") +
  labs(title="Overlay of Median Income", x="Longitude", y="Latitude", color = "Median Income") +
  theme_minimal()

avg_pop_per_household <- data %>%
  group_by(ocean_proximity) %>%
  summarise(Average_Population = mean(population_per_household))

p9 <- ggplot(avg_pop_per_household, aes(x = ocean_proximity, y = Average_Population, fill = ocean_proximity)) +
  geom_bar(stat = "identity", color = "black") +
  labs(title="Average Population per Household by Ocean Proximity", x="Ocean Proximity", y="Average Population per Household") +
  theme_minimal()


# Bar Chart of Age Group
p10 <- ggplot(data, aes(x=age_group)) +
  geom_bar() +  # This uses stat_count by default which counts the number of cases for each group
  labs(title="Count of Housing by Age Group", x="Age Group", y="Count") +
  theme_minimal()

# Aggregating data
age_value_avg <- data %>%
  group_by(housing_median_age) %>%
  summarise(avg_median_house_value = mean(median_house_value, na.rm = TRUE)) %>%
  arrange(housing_median_age)

# Create a line chart
p11 <- ggplot(age_value_avg, aes(x=housing_median_age, y=avg_median_house_value)) +
  geom_line() +  # Line plot
  geom_point() +  # Add points for each age group mean
  labs(title="Average Median House Value by Housing Age", x="Housing Median Age", y="Average Median House Value") +
  theme_minimal()


# Aggregate the data: Sum of households grouped by construction year
households_by_year <- data %>%
  group_by(construction_year) %>%
  summarise(Total_Households = sum(households)) %>%
  arrange(construction_year)

# Creating the line chart
p12 <- ggplot(households_by_year, aes(x = construction_year, y = Total_Households)) +
  geom_line() +
  geom_point() +
  labs(title="Sum of Households by Construction Year", x="Construction Year", y="Total Households (1e+05)") +
  theme_minimal()

# Map Highlighting Ocean Proximity
p13 <- ggplot() +
  geom_polygon(data=california, aes(x=long, y=lat, group=group), fill="gray80", color="white") +
  geom_point(data=data, aes(x=longitude, y=latitude, color=ocean_proximity)) +
  labs(title="Map Highlighting Ocean Proximity", x="Longitude", y="Latitude", color = "Ocean Proximity") +
  theme_minimal()

# Aggregating data by housing_median_age and ocean proximity
age_value_avg <- data %>%
  group_by(housing_median_age, ocean_proximity) %>%
  summarise(avg_median_house_value = mean(median_house_value, na.rm = TRUE)) %>%
  arrange(housing_median_age, ocean_proximity)  # Arrange by age and ocean proximity for clarity in plotting

# Create a line chart
p14 <- ggplot(age_value_avg, aes(x=housing_median_age, y=avg_median_house_value, color=ocean_proximity)) +
  geom_line() +
  geom_point() +
  facet_grid(ocean_proximity~.) +
  labs(title="Average Median House Value by Housing Age and Ocean Proximity", x="Housing Median Age", y="Average Median House Value (1e+05)", color="Ocean Proximity") +
  theme_minimal()


# Clusters of Housing Age
p15 <- ggplot() +
  geom_polygon(data=california, aes(x=long, y=lat, group=group), fill="gray80", color="white") +
  geom_point(data=data, aes(x=longitude, y=latitude, color=age_group)) +
  labs(title="Clusters of Housing Age", x="Longitude", y="Latitude", color = "Age Group") +
  theme_minimal()

# Create a ggplot object for the histogram of construction years
p16 <- ggplot(data, aes(x = construction_year)) +
  geom_histogram(fill = 'blue', color = 'black', bins = 52) +
  labs(title = "Histogram of Construction Years", x = "Construction Year", y = "Frequency") +
  theme_minimal()

cor_data <- round(cor(data[, sapply(data, is.numeric)]), 2)
p17 <- ggplot(melt(cor_data), aes(Var1, Var2, fill=value)) +
  geom_tile() +
  scale_fill_gradient2(low="blue", high="red", mid="white", midpoint=0, limit=c(-1, 1)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title="Correlation Heat Map", x="", y="") +
  theme_minimal()

# Aggregate data to sum households built each year
yearly_data <- data %>%
  group_by(construction_year) %>%
  summarise(Total_Households = sum(households, na.rm = TRUE))

# Calculate cumulative households built over time
yearly_data$cumulative_households <- cumsum(yearly_data$Total_Households)

# Create a ggplot object for cumulative total households
p18 <- ggplot(yearly_data, aes(x = construction_year, y = cumulative_households)) +
  geom_line(color = 'blue') +
  geom_point(color = 'blue') +
  labs(title = 'Cumulative Total Households by Year Built', x = 'Year Built', y = 'Cumulative Total Households (1e+05)') +
  theme_minimal()

# Create a ggplot object for Rooms vs. Bedrooms per Household
p19 <- ggplot(data, aes(x = rooms_per_household, y = bedrooms_per_household, color = population_per_household)) +
  geom_point(size = 3) +
  scale_color_continuous(type = "viridis") +
  labs(title = "Rooms vs. Bedrooms per Household", x = "Rooms per Household", y = "Bedrooms per Household", color = "Population per Household") +
  theme_minimal()

# Create a ggplot object for annual total households
p20 <- ggplot(yearly_data, aes(x = construction_year, y = Total_Households)) +
  geom_line(color = 'blue') +
  geom_point(color = 'blue') +
  labs(title = 'Annual Total Households by Year Built', x = 'Year Built', y = 'Total Households (1e+05)') +
  theme_minimal()

# Save the plots
plot_list <- list(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20)
names(plot_list) <- paste("Plot ", 1:20, ".png", sep="")

for (i in 1:length(plot_list)) {
  ggsave(names(plot_list)[i], plot_list[[i]], width=10, height=6)
}

# Interactive Plots
int_p1 <- ggplotly(p13)
int_p2 <- ggplotly(p14)
int_p3 <- ggplotly(p15)
int_p4 <- ggplotly(p16)
int_p5 <- ggplotly(p17)
int_p6 <- ggplotly(p18)
int_p7 <- ggplotly(p19)
int_p8 <- ggplotly(p20)

plot_list <- list(int_p1, int_p2, int_p3, int_p4, int_p5, int_p6, int_p7, int_p8)
names(plot_list) <- paste("Interactive Plot ", 1:8, ".html", sep="")

for (i in 1:length(plot_list)) {
  saveWidget(plot_list[[i]], names(plot_list)[i], selfcontained = TRUE)
}

# Define UI for the updated Shiny app
ui <- fluidPage(
  titlePanel("California Housing Data Exploration"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("year", "Year:",
                  min = min(data$construction_year, na.rm = TRUE), 
                  max = max(data$construction_year, na.rm = TRUE), 
                  value = min(data$construction_year, na.rm = TRUE),
                  step = 1,
                  animate = animationOptions(interval = 2500, loop = TRUE)),
      
      selectInput("variable", "Variable:",
                  choices = c("Median House Value" = "median_house_value",
                              "Median Income" = "median_income",
                              "Population" = "population",
                              "Total Rooms" = "total_rooms",
                              "Total Bedrooms" = "total_bedrooms")),
      
      checkboxGroupInput("ocean_proximity", "Ocean Proximity:",
                         choices = unique(data$ocean_proximity),
                         selected = unique(data$ocean_proximity))
    ),
    
    mainPanel(
      leafletOutput("map"),
      plotOutput("histogram")
    )
  )
)

# Define server logic for the updated Shiny app
server <- function(input, output, session) {
  # Filter data based on input
  filtered_data <- reactive({
    data %>%
      filter(construction_year <= input$year,
             ocean_proximity %in% input$ocean_proximity)
  })
  
  # Render leaflet map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      setView(lng = mean(data$longitude, na.rm = TRUE), 
              lat = mean(data$latitude, na.rm = TRUE), 
              zoom = 10)
  })
  
  # Update map based on filtered data
  observe({
    leafletProxy("map", data = filtered_data()) %>%
      clearMarkers() %>%
      addCircleMarkers(
        lng = ~longitude, 
        lat = ~latitude, 
        radius = 3, 
        color = "blue", 
        stroke = FALSE, 
        fillOpacity = 0.5,
        label = ~paste("Value:", get(input$variable))
      )
  })
  
  # Render histogram for the selected variable
  output$histogram <- renderPlot({
    ggplot(filtered_data(), aes_string(x = input$variable)) +
      geom_histogram(fill = "blue", color = "black", bins = 30) +
      labs(title = paste("Distribution of", input$variable), x = input$variable, y = "Count") +
      theme_minimal()
  })
}

# Run the updated Shiny app
shinyApp(ui = ui, server = server)
