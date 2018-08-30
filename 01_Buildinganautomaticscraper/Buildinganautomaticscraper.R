# Building a scraper ------------------------------------------------------
rm(list = ls())

#install.packages("rvest")
library("rvest")
options(scipen=999)

## setting the working directory
setwd("C:/Users/Gilia/Documents/")

## load EAN's
dataEAN <-as.data.frame(c("9781292164779",
              "9780262035613",
              "9780198739838",
              "9780141985411",
              "9781449361327",
              "9781449358655",
              "9780393347777",
              "9781593273842"))

## change name of the dataframe header
names(dataEAN) <- "EAN"

## create dataframe
pricedata <- data.frame(EAN = dataEAN, Article_name = NA, Selling_price = NA, Number_of_sellers = NA, Rating = NA, Pages = NA, stringsAsFactors=FALSE)


for (i in 1:nrow(pricedata)) {
  
  ## for testing
  i <- 1
  
  ## look for the EAN
  EAN <- as.character(pricedata[i,1])
  
  ## create search url
  url <- paste0("https://www.bol.com/nl/s/algemeen/zoekresultaten/Ntt/",EAN,"/N/0/Nty/1/search/true/searchType/qck/defaultSearchContext/media_all/sc/media_all/index.html")
  print(url)
  
  ## take a nap
  Sys.sleep(1)
  
  ## load page
  try(pdp <- read_html(url))
  
  #Article name
  try(pricedata[i,2] <- pdp %>% html_nodes(".pdp-header__title.bol_header") %>% html_text())
  
  #Price
  try(pricedata[i,3] <- pdp %>% html_nodes(".promo-price") %>% html_text())
  
  #Sellers
  try(pricedata[i,4] <- pdp %>% html_nodes(".buy-block__alternative-sellers-title") %>% html_text())
  
  #Rating
  try(rating <- pdp %>% html_nodes(".rating-v2__average") %>% html_text())
  try(pricedata[i,5] <- rating[1])
  
  #Pages
  try(pricedata[i,6] <- pdp %>% html_nodes(".product-small-specs--large li:nth-child(6)") %>% html_text())
}


## cleaning some of the data
pricedata$Selling_price <- as.numeric(gsub(",\n  ", ".", pricedata$Selling_price))
pricedata$Number_of_sellers <- as.numeric(substr(pricedata$Number_of_sellers, start = nchar(pricedata$Number_of_sellers)-1, stop = nchar(pricedata$Number_of_sellers)-1))
pricedata$Pages <- as.numeric(substr(pricedata$Pages, start = 51, stop = 53))


## Save data
write.csv2(pricedata, file = "pricedata.csv")


# Exercise 1: This time we are asked to add the delivery time to the bol.com scraper
## First add one column to the dataframe we created

## Copy a line of code where we already extract one element.

## Find the CSS selectors output for the delivery time and add replace it in the line of code.

## Change the number of the column where the output will be stored.

## Run the creation of the dataframe and loop again.

## Check your result in the "pricedata" element!


# Exercise 2: We want to change the scraper to scrape Amazon.de. Try to find the search url that we can use for the scraper.


# Exercise 3: We want to scrape the prices of Amazon.de instead of Bol.com. Make a copy of the script and try to replace the search url and css selectors in the code. The result should be a dataframe with only the EAN and price.

  ## Amazon.de dataframe
  pricedataAmazonde <- data.frame(EAN = dataEAN, Selling_price = NA, stringsAsFactors=FALSE)

  ## Loop for Amazon.de



  ## Write a .csv file with the prices
  write.csv2(pricedata, file = "pricedataAmazonde.csv")

# Exercise 4: Compare the prices of the two stores. Where would you buy your books?
