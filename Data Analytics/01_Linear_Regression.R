# File:   Linear_Regression.R

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

# Using the lm() function for modelling

myModel = lm(dist~speed, data = cars)
myModel



# PLOTTING #####################################################################

# Plotting the model with the regression line
plot(dist~speed, data = cars,
     xlab = "Speed (in Miles per Hour)",
     ylab = "Stopping Distance (in Feet)",
     main = "Stopping Distance vs. Speed",
     pch = 20,
     cex = 2,
     col = "grey")
abline(myModel, lwd = 3, col = "darkorange")


# MORE INFORMATION #############################################################

# More Information about myModel class we created
names(myModel)
summary(myModel)

# Checking whether our model is fitting the assumption of a linear model
myModel$residuals

# Distribution of the residual against the car speed (normality)
hist(myModel$residuals)

qqnorm(myModel$residuals)


# Plotting to check the Homoscedasticity
plot(myModel$fitted.values, myModel$residuals)


#predicting stopping distance for cars when the speed is given
predict(myModel, newdata = data.frame(speed = c(10,35, 50)))


# CLEAN UP #####################################################################

# Clear Environment
rm(list = ls())

detach("package:datasets", unload = TRUE)

p_unload(all)                  # Claear all add-ons

dev.off()

cat("\014")