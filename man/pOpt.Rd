% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pOpt.R
\name{pOpt}
\alias{pOpt}
\title{pOpt}
\usage{
pOpt(
  my_portfolio,
  hist_ret_start,
  hist_ret_end,
  test_year_start,
  test_year_end,
  use_shorts
)
}
\arguments{
\item{my_portfolio}{String of tickers (symbols)}

\item{hist_ret_start}{Historic Start Date}

\item{hist_ret_end}{Historic End Date}

\item{test_year_start}{Test Start Date}

\item{test_year_end}{Test End Date}

\item{use_shorts}{Boolean makes leverage of shorts possible}
}
\value{
Optimal portfolio by weight of ticker given the historic start and end dates
}
\description{
pOpt
}
\examples{
pOpt(my_portfolio = c("WKHS", "MSFT", "AMZN", "GOOGL"),
hist_ret_start = "2012-01-01",
hist_ret_end = "2018-12-31",
test_year_start = "2021-01-01",
test_year_end = "2021-12-31",
use_shorts = FALSE)
}
