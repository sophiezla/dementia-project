library(tidyverse)

# Load the data
data <- read.csv('data/dementia_dataset.csv')

# Filter the data to include only people with dementia and exclude NA values in SES
demented_data <- data %>% filter(Group == 'Demented' & !is.na(SES))

# Count the number of people in each SES level
ses_counts <- demented_data %>% count(SES)

# Create the plot
ggplot(ses_counts, aes(x = SES, y = n)) +
  geom_bar(stat = 'identity', fill = 'steelblue') +
  labs(x = 'Social Economic Level',
       y = 'Number of People', 
       title = 'Number of People with Dementia by SES Level', 
       caption = "Source: dementia_dataset.csv") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    axis.text.x = element_text(size = 12),
    axis.text.y = element_text(size = 12)
  ) +
  scale_x_continuous(breaks = seq(min(ses_counts$SES), max(ses_counts$SES), by = 1))

ggsave("SES.png", plot = last_plot())