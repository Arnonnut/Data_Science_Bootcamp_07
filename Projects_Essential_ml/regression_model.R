library(caret)
library(tidyverse)
library(readxl)

house_price_data <- read_xlsx("House Price India.xlsx")
glimpse(house_price_data)
#View(house_price_data)

#Fix skewness by using log transformation
new_house <- house_price_data %>%
  mutate(price_log = log(Price + 1))

# rename column
house_price_data_renamed <- new_house %>%
  rename("living_area" = "living_area_renov" ,
         "lot_area" = "lot_area_renov",
         "number_of_bathrooms" = "number of bathrooms",
         "area_of_the_house" = "Area of the house(excluding basement)",
         "grade_of_the_house" = "grade of the house")




# 1. split data 70:30
#create function
train_test_split <- function(data, train_ratio = 0.7) {
  set.seed(42)
  n <- nrow(data)
  id <- sample(1 : n, size = train_ratio * n)
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return( list(train = train_data, test = test_data) )
}

splitData <- train_test_split(house_price_data_renamed, 0.7)
train_data <- splitData[[1]]
test_data <- splitData[[2]]

# 2. train model
set.seed(42)

ctrl <- trainControl(
  method = "cv",
  number = 5,
  verboseIter = TRUE
)

## lm_model , rf_model, knn_model
lm_model <- train(price_log ~ living_area + 
                 lot_area + 
                 number_of_bathrooms +
                 area_of_the_house+
                 grade_of_the_house,
               data = train_data,
               method = "lm",
               trControl = ctrl)

rf_model <- train(price_log ~ number_of_bedrooms + 
                    number_of_bathrooms + 
                    distance_from_the_airport +
                    area_of_the_house +
                    condition_of_the_house,
                  data = train_data,
                  method = "rf",
                  trControl = ctrl)

knn_model <- train(price_log ~ living_area + 
                     lot_area + 
                     number_of_bathrooms +
                     area_of_the_house+
                     grade_of_the_house,
                   data = train_data,
                   method = "lm",
                   trControl = ctrl)



# 3. score model
p_lm <- predict(lm_model, newdata = test_data)
#p_rm <- predict(im_model, newdata = test_data)
p_knn <- predict(knn_model, newdata = test_data)

# 4. evaluate model
mae_metric <- function(actual, prediction) {
  #mean adsolute error
  abs_error <- abs(actual - prediction)
  mean(abs_error)
}

mse_metric <- function(actual, prediction) {
  # mean squared error
  sq_error <- (actual - prediction)**2
  mean(sq_error)
}

rmse_metric <- function(actual, prediction) {
  # root mean squared error
  sq_error <- (actual - prediction)**2
  sqrt(mean(sq_error)) ## back to normal unit
}

lm_model
mae_metric(test_data$price_log, p_lm)
mse_metric(test_data$price_log, p_lm)
rmse_metric(test_data$price_log, p_lm)

rf_model
mae_metric(test_data$price_log, p_rf)
mse_metric(test_data$price_log, p_rf)
rmse_metric(test_data$price_log, p_rf)

knn_model
mae_metric(test_data$price_log, p_knn)
mse_metric(test_data$price_log, p_knn)
rmse_metric(test_data$price_log, p_knn)


# 5. save model
saveRDS(lm_model, "lm_model.RDS")
saveRDS(rf_model, "rf_model.RDS")
saveRDS(knn_model, "knn_model.RDS")
