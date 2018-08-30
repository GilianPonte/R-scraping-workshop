library(rvest)

## clean the environment in R
rm(list = ls())

## download phantomjs here: http://phantomjs.org/download.html

## get the working directory you are working in
getwd()

## store the phantom.exe file in your working directory

## start scraping
url <- "https://www.ah.nl/producten/product/wi200726/ah-aansteker-flex"
print(url)

## simulate a browser and run JavaScript
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


## run the defined JavaScript in the browser and write a html file.
system("phantomjs ah_pricing.js > ah_pricing.html")
write(readLines(pipe("phantomjs ah_pricing.js", "r")), "ah_pricing.html")

## load the html file and scrape
html <- "ah_pricing.html"
pg <- read_html(html)


# Exercise 1: Try to scrape the price of the lighter now
price <- pg %>% 
  html_node("") %>% 
  html_text()

print(price)
