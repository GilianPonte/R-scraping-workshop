# Scraping one element ----------------------------------------------------

## Settings
#install.packages("rvest")
library("rvest")

## scrape one price
price <- read_html("https://www.bol.com/nl/p/weapons-of-math-destruction/9200000072434087/") %>%
  html_nodes(".promo-price") %>% 
  html_text()

## get rid of the spaces
price <- gsub("\n ", "", price)

## check price
print(price)

# Exercise 1: Try to scrape the author of the book

author <- read_html("") %>%
  html_nodes("") %>% 
  html_text()

print(author)

# Exercise 2: Go to Amazon.de and try to scrape the price of a product of your interest



# Exercise 3: Try to srape the price from an Albert Heijn product. I have already provided the url. Try to think of why you are getting this result. Think of how this web page works.
url <- "https://www.ah.nl/producten/product/wi200726/ah-aansteker-flex"

