library("quantmod")
library("tseries")
library("vars")
library("fxregime")
library("moments")
library("rugarch")

getFX("TRY/USD")
chartSeries(TRYUSD)
TRY <- getFX("TRY/USD")
# currency <- c("TRY/USD",'EUR/USD','INR/USD')

