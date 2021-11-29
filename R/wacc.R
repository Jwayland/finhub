#The Weighted Average Cost of Capital can be used as the companies
#Required Rate of Return for decisions regarding future capital 
#expenditures
##' wacc
#'
#' @param TC 
#' @param coutstanding_shares 
#' @param cstock_price 
#' @param cstock_dividend 
#' @param cstock_growth 
#' @param cstock_beta 
#' @param poutstanding_shares 
#' @param pstock_price 
#' @param pstock_beta 
#' @param bvalue_debt 
#' @param rf 
#' @param cmrp 
#' @param pmrp 
#' @param coupon_rate 
#'
#' @return
#' @export
#'
#' @examples
#' wacc(
#' #corporate tax rate
#' TC = .22,
#' #common stock shares/price/dividend/growth/beta (yahoo finance)
#' coutstanding_shares = 346300407,
#' cstock_price = 108.12,
#' cstock_dividend = 4,
#' cstock_growth = .0444,
#' cstock_beta = .49,
#' #preferred stock shares/price/beta (yahoo finance)
#' poutstanding_shares = 346300407,
#' pstock_price = 108.12,
#' pstock_beta = .49,
#' #book value of debt
#' bvalue_debt = 35973686275,
#' #risk free rate (tYcharts.com/indicators/3_month_t_bill)
#' rf = .0232,
#' #market risk premium (www.market-risk-premia.com)
#' cmrp = .05,
#' pmrp = .05,
#' #market rate of new debt (coupon rate)
#' coupon_rate = .0395
#' )

wacc <- function(TC,
                 coutstanding_shares,
                 cstock_price,
                 cstock_dividend,
                 cstock_growth,
                 cstock_beta,
                 poutstanding_shares,
                 pstock_price,
                 pstock_beta,
                 bvalue_debt,
                 rf,
                 cmrp,
                 pmrp,
                 coupon_rate){
  #Market Value of Equity (market common stock price * #shares outstanding)
  VE <- coutstanding_shares * cstock_price
  #Market Value of Preferred (market preferred stock price * #shares outstanding)
  VP <- poutstanding_shares * pstock_price
  #Market Value of Debt (book value of debt)
  VD <- bvalue_debt
  #calculating weights
  WE <- VE/(VE+VP+VD)
  WP <- VP/(VE+VP+VD)
  WD <- VD/(VE+VP+VD)
  #dividend discount model (DDM)
  DDM <- cstock_dividend/cstock_price + cstock_growth
  #capital asset pricing model (CAPM) for common stock
  CAPMC <- rf+cstock_beta*cmrp
  #calculating rate on equity (average DDM & CAPM)
  RE <- (DDM+CAPMC)/2
  #calculating rate on preferred (CAPM)
  RP <- rf+pstock_beta*pmrp
  #calculating rate on debt
  RD <- coupon_rate
  #calculating the weighted average cost of capital for the firm
  weighted_average_cc <- (WE*RE)+(WD*(RD*(1-TC))+(WP*RP))
  cat("The Firm's Weighted Average Cost of Capital (WWAC) is:", weighted_average_cc)
}