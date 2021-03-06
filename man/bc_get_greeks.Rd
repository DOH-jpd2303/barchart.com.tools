% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bc_get_greeks.R
\name{bc_get_greeks}
\alias{bc_get_greeks}
\title{bc_get_greeks}
\usage{
bc_get_greeks(
  webdriver,
  df,
  download_dir,
  symbol = "symbol",
  date_val = "date_val",
  near_or_all = "near_or_all"
)
}
\arguments{
\item{webdriver}{\itemize{
\item The webdriver used (use chrome_driver function)
}}

\item{df}{\itemize{
\item The dataframe containing the symbol, date, and near or all specifications
}}

\item{download_dir}{\itemize{
\item The directory where the file will be downloaded.
}}

\item{symbol}{\itemize{
\item The dataframe column corresponding to stock symbol
}}

\item{date_val}{\itemize{
\item The dataframe column corresponding to the date to pull, plus
whether it is a 'monthly' (m) or 'weekly' (w) listing
}}

\item{near_or_all}{\itemize{
\item The dataframe column corresponding to the option of downloading
all records or just 'near the money' records.
}}
}
\value{
A downloaded file from barcharts.com in the specified folder
}
\description{
This function will allows a user to specify multiple symbols to download in
a dataframe format. The user will specify the dataframes name, the download directory,
and the column names corresponding to the stock symbol, date value, and whether
near the money or all observations are desired.
}
