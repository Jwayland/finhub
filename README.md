# finhub

**Description:** R Package for optimizing portfolios with historical tickers using adjustable timeframes. The franchise function is called `pOpt` and it contains the following parameters:

* `hist_ret_start` - Historic start date
* `hist_ret_end` - Historic End Date
* `test_year_start` - Test Start Date
* `test_year_end` - Test End Date
* `my_portfolio` - String of tickers (symbols)
* `use_shorts` - Boolean makes leverage of shorts possible

Using these inputs, `pOpt` will return the optimal portfolio by weight of ticker given the historic start and end dates. By toggling `use_shorts`, the optimal portfolio will leverage the short proceeds for a long position. It will populate the standard deviation and return value of the investment given the optimal portfolio weights over the provided test dates. 

There are more functions currently in development. To install `finhub`, use the following command:
`devtools::install_github("jwayland/finhub")`

## Examples
[PLACEHOLDER]
