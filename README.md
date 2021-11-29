# finhub
R Package for finaicial analysis

To install `finhub`, use the following command:
`devtools::install_github("jwayland/finhub")`

## `pOpt`

**Description:** Optimizing portfolios with historical tickers using adjustable time-frames. The franchise function is called `pOpt` and it contains the following parameters:

* `hist_ret_start` - Historic start date
* `hist_ret_end` - Historic End Date
* `test_year_start` - Test Start Date
* `test_year_end` - Test End Date
* `my_portfolio` - String of tickers (symbols)
* `use_shorts` - Boolean makes leverage of shorts possible

Using these inputs, `pOpt` will return the optimal portfolio by weight of ticker given the historic start and end dates. By toggling `use_shorts`, the optimal portfolio will leverage the short proceeds for a long position. It will populate the standard deviation and return value of the investment given the optimal portfolio weights over the provided test dates. 

### Examples

```
pOpt(my_portfolio = c("WKHS", "MSFT", "AMZN", "GOOGL"),
hist_ret_start = "2012-01-01",
hist_ret_end = "2018-12-31",
test_year_start = "2021-01-01",
test_year_end = "2021-12-31",
use_shorts = FALSE)
```
```
#   Ticker    Weight
# 1   AMZN 0.0000000
# 2  GOOGL 0.6017229
# 3   MSFT 0.2802644
# 4   WKHS 0.1180127
# portfolio return for test year: 0.4841054 portfolio standard deviation: 0.05848876
```

## `wacc`

**Description:** The Weighted Average Cost of Capital `wacc` can be used as the companies required rate of return for decisions regarding future capital expenditures using the following parameters:

* `TC` - Corporate Tax Rate
* `coutstanding_shares` - Common Stock Outstanding Shares
* `cstock_price` - Common Stock Market Price
* `cstock_dividend` - Common Stock Dividend
* `cstock_growth` - Common Stock Growth Rate
* `cstock_beta` - Common Stock Beta
* `poutstanding_shares` - Preferred Stock Outstanding Shares
* `pstock_price` - Preferred Stock Market Price
* `pstock_beta` - Preferred Stock Beta
* `bvalue_debt` - Book Value of Debt
* `rf` - Risk Free Rate of Return (3 mo treasury bill)
* `cmrp` - Market Risk Premium (common stock) 
* `pmrp` - Market Risk Premium (preferred stock) 
* `coupon_rate` - Market Rate of New Debt (coupon rate)

Using these inputs, `wacc` will return the weighted average cost of capital for the firm. It automatically calculates the weight of debt and equity through common stock, preferred stock, and book value of loans. The only difference between this function and typical weighted average cost of capital calculations is this function will calculate rate on equity using an average of both the dividend discount model `DDM` and the capital asset pricing model `CAPM`. (Automation of some parameters through web scraping is currently in progress. Returning values using the input option of choosing `DDM`, `CAPM`, or an average of both is currently in progress)

### Examples

```
wacc(
#corporate tax rate
TC = .22,
#common stock shares/price/dividend/growth/beta (yahoo finance)
coutstanding_shares = 346300407,
cstock_price = 108.12,
cstock_dividend = 4,
cstock_growth = .0444,
cstock_beta = .49,
#preferred stock shares/price/beta (yahoo finance)
poutstanding_shares = 346300407,
pstock_price = 108.12,
pstock_beta = .49,
#book value of debt
bvalue_debt = 35973686275,
#risk free rate (tYcharts.com/indicators/3_month_t_bill)
rf = .0232,
#market risk premium (www.market-risk-premia.com)
cmrp = .05,
pmrp = .05,
#market rate of new debt (coupon rate)
coupon_rate = .0395
)
```
```
# The Firm's Weighted Average Cost of Capital (WWAC) is: 0.04790951
```