# File:   LinearModel_Describe.R

# INSTALL AND LOAD PACKAGES ####################################################

library(datasets)   # Load/unload base packages manually

# LOAD DATA ####################################################################

# Lear more about the cars data set

?cars
head(cars)

# Structure of cars data set
str(cars)

# Summary of cars data set
summary(cars)

# MODEL CREATION ###############################################################

# Using the lm() function for modelling simple linear model
# Fit a linear regression model
myModel = lm(dist~speed, data = cars)
myModel

# Print a summary of the model
summary(myModel)


# Extract coefficients and standard errors
coefficients <- coef(myModel)
standard_errors <- summary(myModel)$coef[, "Std. Error"]

# Calculate t-values
t_values <- coefficients / standard_errors

# Calculate two-tailed p-values
degrees_of_freedom <- df.residual(myModel)
p_values <- 2 * pt(abs(t_values), df = degrees_of_freedom, lower.tail = FALSE)

# Combine results into a data frame
results <- data.frame(Coefficient = coefficients, Standard_Error = standard_errors, t_Value = t_values, P_Value = p_values)


## Calculate R-Squared Values
# Extract residuals
residuals <- residuals(myModel)

# Calculate SSR
SSR <- sum(residuals^2)

# Calculate mean of the dependent variable
mean_y <- mean(cars$dist)

# Calculate SST
SST <- sum((cars$dist - mean_y)^2)

# Calculate R-squared
r_squared_manual <- 1 - (SSR / SST)


## Calculate Adjusted R-Squared Values

# Extract the number of observations
n <- length(myModel$residuals)

# Extract the number of predictor variables (including the intercept)
k <- length(coefficients(myModel))

# Calculate Adjusted R-squared
adjusted_r_squared_manual <- 1 - ((1 - r_squared_manual) * (n - 1) / (n - k - 1))


# CLEAN UP #####################################################################

# Clear Environment
rm(list = ls())

detach("package:datasets", unload = TRUE)

p_unload(all)                  # Claear all add-ons

dev.off()

cat("\014")