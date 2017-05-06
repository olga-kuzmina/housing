source("read_data.R")

train_by_year <- train %>% group_by(year=year(timestamp), prod_type=product_type) %>% summarise(price=mean(price_doc))
year_price <- ggplot(train_by_year, aes(year, price)) + geom_line() + facet_grid(. ~ prod_type)
year_price
