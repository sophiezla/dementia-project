library(tidyverse)
data <- read_csv("data/dementia_dataset.csv")

# Filter the data for demented people
demented_data <- data %>% filter(Group == "Demented")

# Create a histogram of the ages of demented people
age_plot <- ggplot(demented_data, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "black") +
  labs(
    title = "Age Distribution of Demented People",
    x = "Age",
    y = "Count",
    caption = "Source: dementia_dataset.csv"
  ) +
  theme_minimal(base_size = 18) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", margin = margin(b = 20)), 
    plot.margin = margin(t = 20, r = 20, b = 20, l = 20)
  )

ggsave("age_distribution_demented1.png", age_plot)