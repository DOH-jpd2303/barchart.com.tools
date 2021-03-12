library(rvest)
library(glue)
library(tidyverse)
library(V8)
login_url <- "https://barchart.com/login"
session <- session(login_url)

#Find the log in form, fill in fields
form <- html_form(session)[[2]]
form$fields[[2]]$value <- "jondowns88jd@gmail.com"
form$fields[[3]]$value <- "blahblah!"

#Submit the form
session_submit(session, form)

###############################

symbol <- 'TSLA'
date <- as.Date('2021-03-26')


url_cand_1 <- glue::glue(paste0("https://www.barchart.com/stocks/quotes/{symbol}/",
                                "volatility-greeks?expiration={date}-w"))
url_cand_2 <- glue::glue(paste0("https://www.barchart.com/stocks/quotes/{symbol}/",
                                "volatility-greeks?expiration={date}-m"))

page <- session_jump_to(session, url_cand_1)
cat(as.character(read_html(page)), file="lul.html")
js <- page %>% html_nodes('script') 
js
ct <- v8()
read_html(ct$eval(js[2]))
session$response %>% ct$eval()
