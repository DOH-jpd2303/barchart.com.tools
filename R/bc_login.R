#' bc_login
#'
#' After opening a chrome driver, this function navigates to the barcharts.com
#' webpage and logs a user in. Username and password must be specified.
#'
#' @param webdriver - The webdriver used (use chrome_driver function)
#' @param username - The login email address
#' @param pw - The password associated with the login
#'
#' @return The supplied webdriver will now be logged in to barchart.com
#' @export
#' @import reticulate
bc_login <- function(webdriver, username, pw){
  #Go to login page
  login_url <- "https://barchart.com/login"
  login_lnk <- webdriver$get(login_url)

  #Add login information
  xpath_login <- '//*[@id="bc-main-content-wrapper"]/div/div[2]/div[2]/div/div/div/div[1]/form/div[1]/input'
  login_email <- webdriver$find_element_by_xpath(xpath_login)$send_keys(list(username))

  #Add password information
  xpath_pw <- '//*[@id="login-page-form-password"]'
  login_pw <- webdriver$find_element_by_xpath(xpath_pw)$send_keys(list(pw))

  #Click login button
  xpath_login_btn <- '//*[@id="bc-main-content-wrapper"]/div/div[2]/div[2]/div/div/div/div[1]/form/div[6]/button'
  login_btn <- webdriver$find_element_by_xpath(xpath_login_btn)$click()
  message("User ", username, " successfully logged in at ", Sys.time())

}
