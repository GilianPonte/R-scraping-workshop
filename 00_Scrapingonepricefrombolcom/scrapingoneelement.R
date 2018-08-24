
# Scraping one element ----------------------------------------------------

## Settings
#install.packages("rvest")
library("rvest")

## scrape one price
price <- read_html("https://www.bol.com/nl/p/weapons-of-math-destruction/9200000072434087/") %>%
  html_nodes(".promo-price") %>% 
  html_text()

## check price
print(price)

## get rid of the spaces
price <- gsub("\n ", "", price)


