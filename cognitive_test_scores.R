library(tidyverse)
library(dplyr)

# Load the data
data <- read.csv("data/dementia_patients_health_data.csv")

# Convert relevant columns to appropriate data types
data$Dementia <- as.factor(data$Dementia)
data$Cognitive_Test_Scores <- as.numeric(data$Cognitive_Test_Scores)

# Change the labels for dementia status from numbers to words
data$Dementia <- factor(data$Dementia, levels = c("1", "0"), labels = c("People with dementia", "People without dementia"))

# Create the facet bar graph
cognitive_plot <- ggplot(data, aes(x = Cognitive_Test_Scores, fill = Dementia)) +
  geom_bar() +
  facet_wrap(~ Dementia, scales = "free_y") + 
  # Add labels
  labs(title = "Cognitive Test Scores by Dementia Status",
       x = "Cognitive Test Scores",
       y = "Count",
       fill = "Dementia Status",
       caption = "Source: dementia_patients_health_data.csv") +
  theme_minimal() +
  # Make a cleaner theme
  theme(
    plot.title = element_text(size = 20, face = "bold"),
    axis.title = element_text(size = 15),
    axis.text = element_text(size = 12),
    strip.text = element_text(size = 15, face = "bold"),
    legend.title = element_text(size = 15),
    legend.text = element_text(size = 12)
  ) +
  # Add colors
  scale_fill_manual(values = c("People with dementia" = "darkred", 
                               "People without dementia" = "steelblue"))

# Save the plot as a png to be added to a page
ggsave("cognitive_test_scores.png", plot = cognitive_plot)