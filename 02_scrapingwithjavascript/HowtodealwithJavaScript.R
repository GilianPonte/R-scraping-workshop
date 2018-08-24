library(xml2)
library(rvest)
library(stringr)
library(plyr)
library(dplyr)
library(ggvis)
library(knitr)
options(digits = 4)
options(scipen = 999)

rm(list = ls())


##Set working directory
setwd("C:/Users/Gilia/Documents/")


#####LOAD AH REFLIST#####



##SCRAPE AH###

pricedata <- data.frame(EAN = data$EAN, Name_Seller = "AH.nl", Article_name = NA, Selling_price = NA, Shipping_cost = "0.00", From_price = "", Delivery_period = "", Article_Number = "", PDP_URL = data$URL, Extractiondate = NA, NL = "Y", BE = "N", DE = "N", Holding_ID = "", Eigen_shop = "", stringsAsFactors=FALSE)


for (i in 1:nrow(data)) {
  
  EAN <- as.character(pricedata[i,1])
  url <- "https://www.ah.nl/producten/product/wi200726/ah-aansteker-flex"
  print(url)
  
  writeLines(sprintf(paste0("var url ='",url,"';
var page = new WebPage()
                     var fs = require('fs');
                     
                     
                     page.open(url, function (status) {
                     just_wait();
                     });
                     
                     function just_wait() {
                     setTimeout(function() {
                     fs.write('ah_pricing.html', page.content, 'w');
                     phantom.exit();
                     }, 2500);
                     }"), url), con="ah_pricing.js")


  system("phantomjs ah_pricing.js > ah_pricing.html")
  write(readLines(pipe("phantomjs ah_pricing.js", "r")), "ah_pricing.html")
  
  html <- "ah_pricing.html"
  pg <- read_html(html)

  #Get product name#
  try(product_name <- pg %>% html_node(".multicol__column .bold") %>% html_text())
  print(product_name)
  
  
}
