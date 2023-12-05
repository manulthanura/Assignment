
# Reading the machine.data dataset

machine<-read.csv(file.choose(), header=F)
machine
str(machine)

names(machine) <- c("VENDOR", "MODEL", "MYCT", "MMIN", "MMAX", "CACH", "CHMIN",
                    "CHMAX", "PRP", "ERP")

### Removing the unwanted features. We don't need the first two for our analysis,
# as these are just the brand and model name of the cpu. Similarly, the final
# column is a predicted estimate of the relative performance that was produced by the 
# researches themselves; our actual output varialbe, PRP, is in column 09.

machine<-machine[,3:9]
head(machine, n=3)
summary(machine)

# install.packages("pacman") 

# install.packages("caret")
library(caret)
set.seed(123) # randomizing the dataset

# Splitting the dataset into training(85%) and test(15%) sets
machine_sampling_vector <- createDataPartition(machine$PRP, p=0.85, list=FALSE)
machine_train <- machine[machine_sampling_vector,]
machine_train_features <- machine[, 1:6] # Extract the features that used in the training model

machine_train_labels <- machine$PRP[machine_sampling_vector]
machine_train_labels

machine_test <- machine[-machine_sampling_vector, ]
machine_test_labels <- machine$PRP[-machine_sampling_vector]
machine_test_labels

# Checking for correlations between the features
machine_correlations <- cor(machine_train_features)
machine_correlations

# Check the cutoff of 90% of correlation between features as the default cutoff
findCorrelation(machine_correlations) 
findCorrelation(machine_correlations, cutoff = 0.75)

# Apply lm() function
machine_model1 <- lm(PRP ~ ., data=machine_train)
summary(machine_model1)

# Resudual analysis
machine_residuals <- machine_model1$residuals
qqnorm(machine_residuals, main = "Normal Q-Q Plot for CPU Data Set") # QQ Plot
qqline(machine_residuals)

plot(machine_model1, pch=16, which=1) # Residual Plot

# Predictions
machine_model1_predictions <- predict(machine_model1, machine_test)
machine_model1_predictions

# Test set performance
compute_mse <- function(predictions, actual){
  # Defining our own function to calculate MSE
  mean((predictions - actual)^2)
}

compute_mse(machine_model1$fitted.values, machine_train$PRP) # Compute MSE for training data
compute_mse(machine_model1_predictions, machine_test$PRP) # Compute MSE for test data


machine_model_null <- lm(PRP ~ 1, data=machine_train)

# Feature Selection Forward Selection
machine_model3 <- step(machine_model_null, scope = list(lower = machine_model_null, upper = machine_model1), direction = "forward")

# Feature selection - Backward Elimination
machine_model3 <- step(machine_model1, scope = list(lower = machine_model_null, upper = machine_model1), direction = "backward")

# Feature Selection - Bidirectional Elimination
Machine_model5 <- step(machine_model_null, scope = list(lower = machine_model_null, upper = machine_model1), direction = "both")

## CLEAN UP ####################################################################
# Clear Environment
rm(list = ls())

detach("package:datasets", unload = TRUE)
dev.off()

cat("\014")