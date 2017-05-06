if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse)

macro = read_csv("data/raw/macro.csv")
train = read_csv("data/raw/train.csv")
glimpse(macro)
glimpse(train)