# Load necessary libraries
library(tidyverse)

# Read the data
data <- read_csv("data/dementia_dataset.csv")

# Clean up the 'Group' column to make people who later converted be counted as 'Nondemented
data <- data %>% 
  mutate(Group = case_when(
    is.na(Group) ~ "Nondemented",
    Group == "Converted" ~ "Nondemented",
    TRUE ~ Group
  ))

# Create a bar graph comparing the number of people with dementia to people without
d_overview_plot <- ggplot(data, aes(x = Group)) +
  geom_bar(width = 0.5, aes(fill = Group)) +
  scale_fill_manual(values = c("Demented" = "darkred", "Nondemented" = "steelblue"), 
                    labels = c("Demented" = "People with dementia", 
                               "Nondemented" = "People without dementia")) +
  # The labels above did not seem to work, so a second attempt to relabel was made
  scale_x_discrete(labels = c("Demented" = "People with dementia",
                              "Nondemented" = "People without dementia")) +
  # Titles and such are made
  labs(
    title = "Number of People with and without Dementia",
    x = "Dementia Status",
    y = "Count",
    fill = "Dementia Status",
    caption = "Source: dementia_dataset.csv"
  ) +
  # Base font size for better readability
  theme_minimal(base_size = 15) + # Base font size for better readability
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),  # Center and bold title
    legend.position = "top", #Move to top
    legend.title = element_text(face = "bold")  # Bold legend title
  )

# Save the plot as a png
ggsave("dementia_rates.png", d_overview_plot)

