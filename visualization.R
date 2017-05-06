source("read_data.R")

train_by_year <- train %>% 
  group_by(year=year(timestamp), prod_type=product_type) %>% 
  summarise(price=mean(price_doc))
year_price <- ggplot(train_by_year, aes(year, price)) + 
  geom_line() + facet_grid(. ~ prod_type)
year_price

price_density <- ggplot(train, aes(price_doc)) + geom_density() + 
  facet_wrap(~year(timestamp)) + scale_x_continuous(limits = c(0, 20000000))
price_density

train$num_room <- as.integer(train$num_room)
room_filtered <- train[train$num_room>0 & train$num_room<5 & !is.na(train$num_room),]
room_filtered$year = year(room_filtered$timestamp)
ggplot(room_filtered) + geom_density(aes(x=price_doc)) + 
  facet_grid(year~num_room, scales="free_y")
