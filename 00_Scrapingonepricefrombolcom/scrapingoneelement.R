## Settings
#install.packages("rvest")
library("rvest")

## read url
url <- read_html("https://www.bol.com/nl/p/weapons-of-math-destruction/9200000072434087/")
print(url)

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

# Exercise 2: This is a product from Amazon.de. Try to scrape the price. You can use the code from exercise 1.
url <- "https://www.amazon.de/LG-Products-29UM68-P-DisplayPort-Reaktionszeit/dp/B01AWG59V6?pd_rd_wg=vt28V&pd_rd_r=8e2846d5-6ac0-4c5e-9754-6ed132b0dc6b&pd_rd_w=H8MSq&ref_=pd_gw_simh&pf_rd_r=ZM8RNJDM5HRJA15SPKA8&pf_rd_p=c4fdae14-5430-5b71-9fd2-0dd831fbb997"



# Exercise 3: Try to srape the price from an Albert Heijn product. I have already provided the url. You will probably not succeed but try to think of why you are getting this result. Check out how the website loads its products.
url <- "https://www.ah.nl/producten/product/wi200726/ah-aansteker-flex"


