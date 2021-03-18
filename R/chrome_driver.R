#' chrome_driver
#'
#' This starts a chrome driver instance in Python
#'
#' @param download_dir - Where downloads should go by default
#' @param timeout - The amount of time (in seconds) before webpage timeout
#'
#' @return A chrome driver instance with browser opened.
#' @export
#' @import reticulate
chrome_driver <- function(download_dir,
                              timeout = '3600'){
  #Locate chromedriver
  base <- system.file('extdata', package='barchart.com.tools')
  file <- "/chromedriver"

  #Load driver
  sel <- reticulate::import("selenium")

  #Set options
  options <- sel$webdriver$ChromeOptions()
  new_opt <- reticulate::dict("download.default_directory" = glue::glue("{download_dir}"),
                              'download.prompt_for_download' = 'False',
                              'profile.default_content_setting_values.automatic_downloads'= 2)
  options$add_experimental_option("prefs", new_opt)

  #Load driver, set timeout length, return driver
  driver <- sel$webdriver$Chrome(paste0(base, file), chrome_options = options)
  driver$set_page_load_timeout(timeout)
  return(driver)
}
