#' bc_get_greeks_single
#'
#' This function will download a single greeks file from barcharts.com and will
#' do basic data manipulation (remove footer row, no commas in the 'Open Int' column)
#'
#' @param webdriver - The webdriver used (use chrome_driver function)
#' @param symbol - The stock symbol to be downloaded
#' @param date_val - The date to pull, plus whether it is a 'monthly' (m)
#' or 'weekly' (w) list
#' @param near_or_all - An option to specify whether to downloadd all records
#' or just the 'near the money' records
#' @param download_dir - The directory where the file will be downloaded.
#'
#' @return A downloaded file from barcharts.com in the specified folder
#' @export
#' @import reticulate
#' @importFrom glue glue
#' @importFrom magrittr %>%
#' @importFrom utils read.csv write.csv
bc_get_greeks_single <- function(webdriver,
                              symbol,
                              date_val,
                              near_or_all = c('near', 'all'),
                              download_dir){

  #######
  # DOWNLOAD FILE
  #######
  #Make sure either near or all have been selected (throw error if not)
  match.arg(near_or_all)

  #Go to the page for this symbol
  symbol_week_url <- glue::glue(paste0("https://www.barchart.com/stocks/quotes/",
                                       "{symbol}/volatility-greeks?expiration=",
                                       "{date_val}"))
  symbol_url <- webdriver$get(symbol_week_url)
  Sys.sleep(3)

  #Select the appropriate near the money/all observations option based on user input
  near_or_all_opt <- ifelse(near_or_all == 'near', 1, 2)
  near_or_all_xpath <- glue::glue(paste0('//*[@id="main-content-column"]/div/',
                                         'div[3]/div[1]/div/div[3]/select/',
                                         'option[{near_or_all_opt}]'))
  near_or_all_click <- webdriver$find_element_by_xpath(near_or_all_xpath)$click()
  Sys.sleep(6)

  #Find the download button, click it to download (will go to default download dir)
  dl_xpath <- '//*[@id="main-content-column"]/div/div[3]/div[2]/div[2]/a/i'
  dl_btn <- webdriver$find_element_by_xpath(dl_xpath)$click()
  Sys.sleep(6)

  #######
  # FIND FILE ON LOCAL DRIVE
  #######
  #Now, we just need to figure out the name of the file based on their naming convention
  #Identify the name of the file
  file_date_val <- ifelse(grepl('w', date_val),
                          paste0(date_val, "eekly"),
                          paste0(date_val, "onthly"))
  file_near_or_all <- ifelse(near_or_all == 'near',
                             '%moneyness%',
                             'show-all')
  file_date <- format(Sys.Date(), '%m-%d-%Y')
  file <- paste0('{symbol}-volatility-greeks-exp-{file_date_val}',
                 '-{file_near_or_all}-{file_date}.csv') %>%
    glue::glue() %>%
    tolower()
  Sys.sleep(3)

  #######
  # CHECK FOR FILE, OUTPUT METADATA
  #######
  if(file.exists(paste0(download_dir, "\\", file))){
    out <- data.frame(`download_dir` = download_dir,
                `file` = file,
                time = Sys.time())

    #Load the file and manipulate: No footer row, remove comma from `Open Int`
    load_ff <- utils::read.csv(paste0(download_dir, file), check.names = FALSE)
    load_ff_out <- load_ff[1:(nrow(load_ff)-1),]
    load_ff_out$`Open Int` <- as.numeric(gsub(",", "", load_ff_out$`Open Int`))

    #Overwrite the original file with the new modified version
    write.csv(load_ff_out, paste0(download_dir, file), row.names = FALSE)

    #Message that this was all successful
    message('File ', file, ' successfully downloaded to: ', download_dir)
  } else{
    stop('Something unexpected occurred, please try again.')
  }
  #Return metadata
  return(out)
}
