library(tidyverse)
data <- read.csv("data/dementia_patients_health_data.csv")

ggplot(data, aes(x = factor(Dementia), fill = factor(Diabetic))) +
  geom_bar(position = "dodge") +
  labs(
    title = "Number of People with Diabetes by Dementia Status",
    x = "Dementia",
    y = "Number of People",
    fill = "Diabetes"
  ) +
  scale_x_discrete(labels = c("No", "Yes")) +
  scale_fill_discrete(labels = c("No", "Yes"))
  theme_minimal()
