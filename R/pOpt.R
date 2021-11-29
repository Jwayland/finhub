#-----------Function for Finding Optimized Portfolio (combines weights and returns)----------
#' pOpt
#'
#' @param my_portfolio String of tickers (symbols)
#' @param hist_ret_start Historic Start Date
#' @param hist_ret_end Historic End Date
#' @param test_year_start Test Start Date
#' @param test_year_end Test End Date
#' @param use_shorts Boolean makes leverage of shorts possible
#'
#' @return Optimal portfolio by weight of ticker given the historic start and end dates
#' @export
#'
#' @examples 
#' pOpt(my_portfolio = c("WKHS", "MSFT", "AMZN", "GOOGL"),
#' hist_ret_start = "2012-01-01",
#' hist_ret_end = "2018-12-31",
#' test_year_start = "2021-01-01",
#' test_year_end = "2021-12-31",
#' use_shorts = FALSE)
pOpt <- function(my_portfolio,
                 hist_ret_start,
                 hist_ret_end,
                 test_year_start,
                 test_year_end,
                 use_shorts){
  #--------------------------Function for Finding Portfolio Weights----------------------------
  port_weights <- function(my_portfolio, hist_ret_start, hist_ret_end){
    require(quantmod)
    require(tseries)
    require(xts)
    require(dplyr)
    require(tidyr)
    # Pull data for tickers
    for(i in 1:length(my_portfolio)){
      getSymbols(my_portfolio[i], src="yahoo", from = hist_ret_start, to = hist_ret_end)
    }
    # Creating the log_returns data.frame
    log_returns <- data.frame(SYMBOL = as.character(), RETURN = as.numeric())
    # Looping through all of your portfolio
    for(j in 1:length(my_portfolio)){
      # This line does some metaprogamming
      monthly_data <- eval(parse(text = my_portfolio[j]))
      # This pulls the ".Adjusted" column as it's always the final column
      monthly_data <- monthly_data[,ncol(monthly_data)]
      # This pulls the monthly returns in log-scale
      monthly_data <- monthlyReturn(monthly_data, subset = NULL, type = "log", leading = TRUE)
      # This adds the log returns to your log_returns dataframe
      log_returns <- rbind(log_returns, data.frame(
        SYMBOL = my_portfolio[j],
        RETURNS = monthly_data
      ))
    }
    # Clean-up
    log_returns <- tibble::rownames_to_column(log_returns, "Date")
    log_returns <- log_returns %>%
      rowwise() %>%
      mutate(
        Date = ifelse(nchar(Date) == 11,substr(Date,1,10),Date)
      )
    log_returns <- tidyr::spread(log_returns, key = SYMBOL, value = monthly.returns)
    return(log_returns)
  }
  efficiency <- port_weights(my_portfolio,
                             hist_ret_start,
                             hist_ret_end)
  #-----------------------Function for Testing Portfolio Returns-------------------------------
  port_returns <- function(my_portfolio, test_year_start, test_year_end){
    require(quantmod)
    require(tseries)
    require(xts)
    require(dplyr)
    require(tidyr)
    # Pull data for tickers
    for(i in 1:length(my_portfolio)){
      getSymbols(my_portfolio[i], src="yahoo", from = test_year_start, to = test_year_end)
    }
    # Creating the abs_returns data.frame
    abs_returns <- data.frame(SYMBOL = as.character(), RETURN = as.numeric())
    # Looping through all of your portfolio
    for(j in 1:length(my_portfolio)){
      # This line does some metaprogamming
      yearly_data <- eval(parse(text = my_portfolio[j]))
      # This pulls the ".Adjusted" column as it's always the final column
      yearly_data <- yearly_data[,ncol(yearly_data)]
      # This pulls the yearly returns
      yearly_data <- yearlyReturn(yearly_data, subset = NULL, leading = TRUE)
      # This adds the absolute returns to your abs_returns dataframe
      abs_returns <- rbind(abs_returns, data.frame(
        SYMBOL = my_portfolio[j],
        RETURNS = yearly_data
      ))
    }
    # Clean-up
    abs_returns <- tibble::rownames_to_column(abs_returns, "Date")
    abs_returns <- abs_returns %>%
      rowwise() %>%
      mutate(
        Date = ifelse(nchar(Date) == 11,substr(Date,1,10),Date)
      )
    abs_returns <- tidyr::spread(abs_returns, key = SYMBOL, value = yearly.returns)
    
    return(abs_returns)
  }
  returns <- port_returns(my_portfolio,
                          test_year_start,
                          test_year_end)
  #---------------------------------Evaluating Results-----------------------------------------
  eff_port <- tseries::portfolio.optim(as.matrix(efficiency[,-1]), pm = .01, shorts = use_shorts)
  perc_ret <- as.matrix(returns[,-1])
  port_cont = 100
  ret_testyr <- eff_port$pw*perc_ret*port_cont
  percent_gain <- sum(ret_testyr)/port_cont
  #----------------------------------------Answers---------------------------------------------
  Ticker = sort(my_portfolio, decreasing = FALSE)
  Weight = eff_port$pw
  invest = data.frame(Ticker, Weight)
  print(invest)
  cat("portfolio return for test year:", percent_gain, "portfolio standard deviation:", eff_port$ps)
}