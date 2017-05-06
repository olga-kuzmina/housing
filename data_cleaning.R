source(read_data.R)
train %>% 
  map(function(x){sum(is.na(x))/length(x)}) %>% 
  stack %>% 
  rename(attribute = ind, na_proportion = values) %>% 
  arrange(na_proportion)