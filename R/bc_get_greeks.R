#' bc_get_greeks
#'
#' This function will allows a user to specify multiple symbols to download in
#' a dataframe format. The user will specify the dataframes name, the download directory,
#' and the column names corresponding to the stock symbol, date value, and whether
#' near the money or all observations are desired.
#'
#' @param webdriver - The webdriver used (use chrome_driver function)
#' @param df - The dataframe containing the symbol, date, and near or all specifications
#' @param symbol - The dataframe column corresponding to stock symbol
#' @param date_val - The dataframe column corresponding to the date to pull, plus
#' whether it is a 'monthly' (m) or 'weekly' (w) listing
#' @param near_or_all - The dataframe column corresponding to the option of downloading
#' all records or just 'near the money' records.
#' @param download_dir - The directory where the file will be downloaded.
#'
#' @return A downloaded file from barcharts.com in the specified folder
#' @export
#' @import reticulate
bc_get_greeks <- function(webdriver,
                          df,
                          download_dir,
                          symbol = 'symbol',
                          date_val = 'date_val',
                          near_or_all = 'near_or_all'){

  #Find the column corresponding to symbol, date, and near/all option in DF
  symbol_index <- which(colnames(df) == symbol)
  date_val_index <- which(colnames(df) == date_val)
  near_or_all_index <- which(colnames(df) == near_or_all)

  #Run the single greek data download function once for each row in the dataframe
  out <- do.call(rbind,
                 apply(df, 1, function(x)
                   bc_get_greeks_single(webdriver = webdriver,
                                        symbol = x[symbol_index],
                                        date_val = x[date_val_index],
                                        near_or_all = x[near_or_all_index],
                                        download_dir = download_dir)))
  return(out)
}
