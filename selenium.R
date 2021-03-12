library(glue)
library(tidyverse)
library(reticulate)
sel <- import('selenium')
driver <- sel$webdriver$Chrome('chromedriver.exe')

symbol <- 'TSLA'
date <- as.Date('2021-03-26')
w_or_m <- 'w'

login <- "jondowns88jd@gmail.com"
pw <- "blahblah!"

#Go to login page
login_url <- "https://barchart.com/login"
login_lnk <- driver$get(login_url)

#Add login information
xpath_login <- '//*[@id="bc-main-content-wrapper"]/div/div[2]/div[2]/div/div/div/div[1]/form/div[1]/input'
login_email <- driver$find_element_by_xpath(xpath_login)$send_keys(list(login))

#Add password information
xpath_pw <- '//*[@id="login-page-form-password"]'
login_pw <- driver$find_element_by_xpath(xpath_pw)$send_keys(list(pw))

#Click login button
xpath_login_btn <- '//*[@id="bc-main-content-wrapper"]/div/div[2]/div[2]/div/div/div/div[1]/form/div[6]/button'
login_btn <- driver$find_element_by_xpath(xpath_login_btn)$click()

#Url for the ticker
main_url <- glue::glue("https://www.barchart.com/stocks/quotes/{symbol}/volatility-greeks?expiration={date}-{w_or_m}")
main_page <- driver$get(main_url)

#Find the download button
download_btn <- driver$find_element_by_xpath('//*[@id="main-content-column"]/div/div[3]/div[2]/div[2]/a/i')
download_btn$click()

driver$quit()
