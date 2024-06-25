# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr) # For pivot_longer

# Load the data
data <- read.csv("data/dementia_patients_health_data.csv")

# Create columns for each variable we need to plot so that each variable is understandable
data <- data %>%
  mutate(
    Former_Smoker = Smoking_Status == "Former Smoker",
    APOE_e4_Positive = APOE_ε4 == "Positive",
    Medication_History_True = Medication_History == "Yes",
    Sleep_Quality_Poor = Sleep_Quality == "Poor",
    Diabetes = Chronic_Health_Conditions == "Diabetes",
    Family_History_True = Family_History == "Yes",
    Dominant_Hand_Left = Dominant_Hand == "Left",
    Dominant_Hand_Right = Dominant_Hand == "Right",
    Gender_Female = Gender == "Female",
    Gender_Male = Gender == "Male"
  )

# Summarize the data
summary_data <- data %>%
  group_by(Dementia) %>%
  summarize(
    Former_Smoker = sum(Former_Smoker),
    APOE_e4_Positive = sum(APOE_e4_Positive),
    Medication_History_True = sum(Medication_History_True),
    Sleep_Quality_Poor = sum(Sleep_Quality_Poor),
    Diabetes = sum(Diabetes),
    Family_History_True = sum(Family_History_True),
    Dominant_Hand_Left = sum(Dominant_Hand_Left),
    Dominant_Hand_Right = sum(Dominant_Hand_Right),
    Gender_Female = sum(Gender_Female),
    Gender_Male = sum(Gender_Male)
  ) %>%
  pivot_longer(cols = -Dementia, names_to = "Variable", values_to = "Count")

# Separate the data for plotting
data_with_dementia <- summary_data %>%
  filter(Dementia == 1) %>%
  mutate(Count = -Count)

data_without_dementia <- summary_data %>%
  filter(Dementia == 0)

# Combine the data for plotting
plot_data <- bind_rows(data_with_dementia, data_without_dementia)

# Modify the Variable names to replace underscores with spaces
plot_data$Variable <- gsub("_", " ", plot_data$Variable)

# Create the pyramid plot
overview_plot <- ggplot(plot_data, aes(x = Count, y = Variable, fill = factor(Dementia))) +
  geom_bar(stat = "identity", position = "identity") +
  scale_x_continuous(labels = abs) +
  scale_fill_manual(values = c("steelblue", "darkred"), labels = c("Person without dementia",
                                                           "Person with dementia")) +
  # Add titles
  labs(
    x = "Number of People",
    y = "Variables",
    title = "Comparison of Health Variables for People With and Without Dementia",
    fill = "Dementia Status",
    caption = "Source: dementia_patients_health_data.csv"
  ) +
  # Make a cleaner theme
  theme_minimal() +
  # Increase text size for better readability
  theme(axis.text.y = element_text(size = 12),
        axis.title = element_text(size = 14),
        plot.title = element_text(size = 16, hjust = 0.5))
# Save plot as a png. The graph was too tall so width and height were specified for better formatting.
ggsave("overview_graphic.png", overview_plot, width = 12, height = 6)