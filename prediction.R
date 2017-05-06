source("read_data.R")
pacman::p_load(lubridate)

train$year = year(train$timestamp)
train$month = month(train$timestamp)
train$build_year = as.integer(train$build_year)
train$lprice_doc = log(train$price_doc)
train = train %>% filter(build_year > 1899 & build_year < 2020 & !is.na(build_year))
linear_model = lm(lprice_doc ~ floor + I(floor^2) + full_sq + I(full_sq^2) + product_type + sub_area + year + month + build_year + I(build_year^2), data=train)
summary(linear_model)
prediction.lm = data_frame(actual =  linear_model$model$lprice_doc, predicted = linear_model$fitted.values)
ggplot(prediction.lm) + geom_point(aes(actual, predicted)) + geom_abline(colour="red")

test = read_csv("data/raw/test.csv")
test = test %>% mutate(year = year(timestamp), month = month(timestamp), build_year = as.integer(build_year))
print(nrow(test))

result = data_frame(id = test$id, price_doc = exp(predict(linear_model, test)))
mean_price = mean(train$price_doc)
result[is.na(result)] = mean_price
result$price_doc[result$price_doc < 500000] = 500001
write_csv(result, "submission.csv")
