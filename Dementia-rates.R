library(tidyverse)
data <- read_csv("data/dementia_dataset.csv")

# Replace NA values in the Group column with "Nondemented"
data <- data %>% 
  mutate(Group = if_else(is.na(Group), "Nondemented", Group))

# Replace NA values and convert "Converted" to "Nondemented"
data <- data %>% 
  mutate(Group = case_when(
    is.na(Group) ~ "Nondemented",
    Group == "Converted" ~ "Nondemented",
    TRUE ~ Group
  ))

# Create a bar graph comparing the number of demented people to nondemented
d_overview_plot <- ggplot(data, aes(x = Group)) +
  geom_bar(width = 0.5, aes(fill = Group)) +
  scale_fill_manual(values = c( "darkred","steelblue"), labels = c("Demented", "Nondemented")) +
  labs(
    title = "Number of People with and without Dementia",
    x = "Dementia Status",
    y = "Count",
    fill = "Dementia Status",
    caption = "Source: dementia_dataset.csv"
  ) +
  theme_minimal(base_size = 15) + # Base font size for better readability
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),  # Center and bold title
    legend.position = "top",
    legend.title = element_text(face = "bold"))  # Bold legend title

ggsave("dementia_rates.png", d_overview_plot)