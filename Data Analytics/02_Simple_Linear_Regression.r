# Step 1: Install and load the "carData" package
install.packages("carData")
library(carData)

# Step 2: Explore and understand the dataset
data("Prestige")
head(Prestige)
summary(Prestige)

# Step 3: Create a subset with education and income columns
subset_data <- Prestige[, c("education", "income")]

# Step 4: Create a simple linear model
linear_model <- lm(income ~ education, data = subset_data)

# Step 5: Plot the dataset and regression line
plot(subset_data$education, subset_data$income, main = "Scatterplot with Regression Line", xlab = "Education", ylab = "Income")
abline(linear_model, col = "red")

# Step 6: Plot histogram and Q-Q plot for residuals
par(mfrow = c(1, 2))
hist(residuals(linear_model), main = "Histogram of Residuals", xlab = "Residuals")
qqnorm(residuals(linear_model), main = "Q-Q Plot of Residuals")
qqline(residuals(linear_model), col = 2)

# Step 7: Plot fitted values vs residuals
plot(predict(linear_model), residuals(linear_model), main = "Fitted Values vs Residuals", xlab = "Fitted Values", ylab = "Residuals")

# Step 8: Check assumptions of linear regression
# We can check assumptions by visually inspecting the plots and conducting formal tests. Some common checks include checking linearity, normality of residuals, and homoscedasticity.

# Comments on assumptions
# - Linearity: Check the scatterplot with the regression line.
# - Normality of Residuals: Check the histogram and Q-Q plot of residuals.
# - Homoscedasticity: Check the plot of fitted values vs residuals.

# Additional checks and tests can be performed based on the specific assumptions we want to validate.

# Note: This code assumes that the dataset and variables are correctly named in the "Prestige" dataset.

# Test for normality of residuals (Shapiro-Wilk test)
shapiro.test(residuals(linear_model))

# Test for homoscedasticity (Breusch-Pagan test)
library(lmtest)
bptest(linear_model)
