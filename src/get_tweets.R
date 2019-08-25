# load libraries
library(rtweet) # for tweets
library(ROAuth) # for twitter authorisation
library(tidyverse) # data munging and visualisations
library(lubridate) # working with dates
library(scales) # plotting axis in a formatted way
library(zoo) # working with mm-yyyy dates
library(tidytext) # text analysis

# The below code comes from the "rtweet" package. Much better as it doesn't shorten the tweets down to 140 characters
# https://rtweet.info/articles/auth.html
# https://rtweet.info/


## authenticate via access token
token <- create_token(
  # app = "my_twitter_research_app",
  consumer_key = Sys.getenv("twitter_consumer_key"),
  consumer_secret = Sys.getenv("twitter_consumer_secret"),
  access_token = Sys.getenv("twitter_access_token"),
  access_secret = Sys.getenv("twitter_access_secret"))


# Scrape tweets -----------------------------------------------------------

boomers <- search_tweets("#BoomersUSA", n=18000, include_rts = FALSE)

boomers2 <- search_tweets("@BasketballAus", n=18000, include_rts = FALSE)

boomers_joined <- rbind(boomers, boomers2)


boomers_joined <- boomers_joined %>% 
  distinct(status_id, .keep_all = T) %>% 
  distinct(text, .keep_all = T)

boomers_joined <- boomers_joined %>% 
  select(status_id, created_at, screen_name, text, source, favorite_count, retweet_count)


saveRDS(boomers_joined, "data/boomers_usa_tweets.rds")

write.csv(boomers_joined, "data/boomers_usa_tweets.csv", row.names = F)





