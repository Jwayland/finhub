# finhub

**Description:** R Package for optimizing portfolios with historical tickers using adjustable timeframes. The franchise function is called `popt` and it contains the following parameters:
* `historic_start_date` - Historic start date
* `` - Historic End Date
* `` - Test Start Date
* `` - Test End Date
* `portfolio` - String of tickers (symbols)

Using these inputs, `popt` will return the optimal portfolio by weight of ticker given the historic start and end dates. It will populate the standard deviation and return value of the investment given the optimal portfolio weights over the provided test dates. 

There are more functions currently in development. To install `finhub`, use the following command:
`devtools::install_github("jwayland/finhub")`

## Examples
[PLACEHOLDER]
