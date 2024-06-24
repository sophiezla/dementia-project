library(tidyverse)

# Read the data
data <- read.csv("data/dementia_patients_health_data.csv")

# Convert dementia to a factor
data$Dementia <- factor(data$Dementia, levels = c(0, 1), labels = c("People with dementia", 
                                                                    "People without dementia"))

# Specify the order of education levels
education_order <- c("No School",
                     "Primary School", 
                     "Secondary School", 
                     "Diploma/Degree")

# Reorder the Education_Level factor
data$Education_Level <- factor(data$Education_Level, levels = education_order)

# Create the faceted bar graph 
ggplot(data, aes(x = Education_Level, fill = Dementia)) +
  geom_bar() +
  facet_grid(~ Dementia, scales = "free_y", switch = "x") +
  # Add colors
  scale_fill_manual(values = c( "People with dementia" = "darkred", 
                                "People without dementia" = "steelblue")) +
  # Add labels
  labs(
    title = "Comparison of Education Levels Between People with and without Dementia",
    x = "Education Level",
    y = "Number of People",
    fill = "Dementia Status",
    caption = "Source: dementia_patients_health_data.csv"
  ) +
  # Give the graph a cleaner theme
  theme_minimal() +
  # Adjust text size for better readability
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5, margin = margin(b = 20)),
    axis.title.x = element_text(size = 14, face = "bold", margin = margin(t = 20)),
    axis.title.y = element_text(size = 14, face = "bold", margin = margin(r = 20)),
    axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
    axis.text.y = element_text(size = 12),
    strip.text = element_text(size = 14, face = "bold"),
    legend.title = element_text(size = 14),
    legend.text = element_text(size = 12),
    strip.background = element_blank(),
    strip.placement = "outside"
  )

# Save graph as a png
ggsave("education_levels.png", plot = last_plot())