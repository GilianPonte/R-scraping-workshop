# Building a scraper ------------------------------------------------------
#install.packages("rvest")
library("rvest")

## setting the working directory
setwd("C:/Users/Gilia/Documents/")

## load EAN's
dataEAN <- read.csv("EAN.csv", header = F)

## create dataframe
pricedata <- data.frame(EAN = dataEAN, Article_name = NA, Selling_price = NA, Number_of_sellers = NA, Rating = NA, Pages = NA, stringsAsFactors=FALSE)


for (i in 1:nrow(pricedata)) {
  EAN <- as.character(pricedata[i,1])
  
  url <- paste0("https://www.bol.com/nl/s/algemeen/zoekresultaten/Ntt/",EAN,"/N/0/Nty/1/search/true/searchType/qck/defaultSearchContext/media_all/sc/media_all/index.html")
  
  Sys.sleep(1)
  result <- tryCatch({pdp <- read_html(url)}, error = function(err) {error <- err})
  
  #SKIP ERROR 404 & 503
  if(class(result$message) == "character"){
    print(result$message)
    next()
  } 
  
  
  print(paste(i,url))
  
  
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
  try(pricedata[i,6] <- pdp %>% html_nodes(".product-small-specs--large li:nth-child(5)") %>% html_text())
}


## cleaning some of the data
pricedata$Selling_price <- as.numeric(gsub(",\n  ", ".", pricedata$Selling_price))
pricedata$Number_of_sellers <- as.numeric(substr(pricedata$Number_of_sellers, start = nchar(pricedata$Number_of_sellers)-1, stop = nchar(pricedata$Number_of_sellers)-1))
pricedata$Pages <- as.numeric(substr(pricedata$Pages, start = 51, stop = 53))


#Save data
write.csv2(pricedata, file = "pricedata.csv")

