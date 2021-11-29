# finhub
R Package for finaicial analysis

To install `finhub`, use the following command:
`devtools::install_github("jwayland/finhub")`

## `pOpt`

**Description:** Optimizing portfolios with historical tickers using adjustable timeframes. The franchise function is called `pOpt` and it contains the following parameters:

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