# Load necessary libraries
library(survival)
library(survminer)
library(dplyr)
library(lubridate)

# Load the dataset
df <- read.csv("C:\\Users\\agatw\\Downloads\\healthcare_dataset.csv")

head(df)


## Data Preprocessing

# Missing values checking
colSums(is.na(df))
sum(is.na(df))  

str(df)

#Let's convert dates to date format
df$Date.of.Admission <- as.Date(df$Date.of.Admission, format = "%Y-%m-%d")
df$Date.of.Admission

df$Discharge.Date <- as.Date(df$Discharge.Date, format = "%Y-%m-%d")
df$Discharge.Date

str(df)

# Check for inconsistencies in the Survival.Time column:

# 1. Firstly, let's check for missing values in Survival.Time

missing_values <- sum(is.na(df$Survival.Time))
if (missing_values > 0) {
  print(paste("There are", missing_values, "missing values in the Survival.Time column."))
} else {
  print("No missing values in the Survival.Time column.")
}


# 2. Secondly, let's check for negative values in Survival.Time column

negative_values <- sum(df$Survival.Time < 0)
if (negative_values > 0) {
  print(paste("There are", negative_values, "negative values in the Survival.Time column."))
} else {
  print("No negative values in the Survival.Time column.")
}

# 3. Thirdly, let's check for unrealistic values in Survival.Time

# Before doing that, let's define a threshold for unrealistic values: We decide that more than 365 days is unrealistic.

unrealistic_values <- sum(df$Survival.Time > 365)
if (unrealistic_values > 0) {
  print(paste("There are", unrealistic_values, "unrealistic values in the Survival.Time column."))
} else {
  print("No unrealistic values in the Survival.Time column.")
}

# 4. Finaly, let's compare Survival.Time with the calculated difference between Discharge.Date and Date.of.Admission

if ("Date.of.Admission" %in% colnames(df) & "Discharge.Date" %in% colnames(df)) {
  # Ensure dates are in Date format
  df$Date.of.Admission <- as.Date(df$Date.of.Admission, format = "%Y-%m-%d")
  df$Discharge.Date <- as.Date(df$Discharge.Date, format = "%Y-%m-%d")
  
  # Calculate survival time from dates
  calculated_survival_time <- as.numeric(difftime(df$Discharge.Date, df$Date.of.Admission, units = "days"))
  
  # Compare with provided Survival.Time
  discrepancies <- sum(df$Survival.Time != calculated_survival_time, na.rm = TRUE)
  
  if (discrepancies > 0) {
    print(paste("There are", discrepancies, "rows where the provided Survival.Time does not match the calculated time from dates."))
  } else {
    print("All provided Survival.Time values match the calculated time from dates.")
  }
} else {
  print("Date.of.Admission or Discharge.Date columns do not exist to perform the comparison.")
}

  
# Let's convert relevant columns to factors
df$Gender <- as.factor(df$Gender)
df$Medical.Condition <- as.factor(df$Medical.Condition)
df$Admission.Type <- as.factor(df$Admission.Type)

# Conversion checking
str(df)



## Data Modeling

# Now, let's perform a Kaplan-Meier Estimation
km_fit <- survfit(Surv(Survival.Time) ~ Medical.Condition, data = df)

# Plot the Kaplan-Meier curves
ggsurvplot(km_fit, data = df, pval = TRUE, 
           risk.table = TRUE, 
           ggtheme = theme_minimal())


# Now, let's perform a log-Rank Test for Comparison
logrank_test <- survdiff(Surv(Survival.Time) ~ Medical.Condition, data = df)
print(logrank_test)

# Cox Proportional Hazards Model performing
cox_fit <- coxph(Surv(Survival.Time) ~ Age + Gender + Medical.Condition, data = df)

# Summary of Cox Model
summary(cox_fit)

# Plotting the Cox Model
ggforest(cox_fit, data = df)

