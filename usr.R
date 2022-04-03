# Notation convention for comments is from bottom to the above

#source(file="fm_casestudy_0_InstallOrLoadLibraries.r") # Pre-process

#source(file="fm_casestudy_fx_1.r") # Pre-process

load(file="fm_casestudy_fx_1.Rdata") # To load data, without this, there is no data in the memory
library("quantmod")
library("tseries")
library("vars")
library("fxregime")
library("moments")
library(zoo)
#Load package

list.symbol0<-c("DEXCHUS", "DEXJPUS", "DEXKOUS", "DEXMAUS","DEXUSEU", "DEXUSUK", "DEXTHUS", "DEXSZUS")
# Ex that the research interested in
fxrates000<-fred.fxrates.00[,list.symbol0]
# Only fetch specified ex rate to the memory
head(fred.fxrates.00)

dim(fxrates000)

head(fxrates000)

tail(fxrates000)
# explore data set

options(width=120)

print(fred.fxrates.doc[match(list.symbol0, fred.fxrates.doc$symbol),c("symbol0", "fx.desc", "fx.units")])
# In order to print explainatory document
par(mfcol=c(2,2))

for (j0 in c(1:ncol(fxrates000))){
  plot(fxrates000[,j0],
  main=dimnames(fxrates000)[[2]][j0])
}
# picture can't display
# print regression for each of ex rate, x axis is date version instead of number
#1.3

# 2.0 Convert currencies to base rate of DEXSZUS, Swiss Franc
fxrates000.0<-fxrates000

for (jcol0 in c(1,2,3,4,7)){
  coredata(fxrates000.0)[,jcol0]<- coredata(fxrates000.0[,jcol0])/coredata(fxrates000[,8])
}
# to have other country / sz effect

for (jcol0 in c(5,6)){
  coredata(fxrates000.0)[,jcol0]<- coredata(1./fxrates000.0[,jcol0])/
  coredata(fxrates000.0[,8])
}
# For exchange rates with 1 U.S. $ in numerator, divide inverse by DEXSZUS


dimnames(fxrates000.0)[[2]]
coredata(fxrates000.0)[,8]<- 1/coredata(fxrates000)[,8]
# For USD, divide $1 by the DEXSZUS rate

list.symbol0.swiftcode<-c("CNY","YEN","WON","MYR","EUR","GBP","THB","USD")
mode(list.symbol0.swiftcode)

dimnames(fxrates000.0)[[2]]<-paste(list.symbol0.swiftcode,"_SFR",sep="")
head(fxrates000.0)
# Rename
par(mfcol=c(2,2))
for (j0 in c(1:ncol(fxrates000.0))){
  plot(fxrates000.0[,j0],
  main=dimnames(fxrates000.0)[[2]][j0])
}
# Plot exchange rate time series in 2x4 panel

fxrates000.0.logret<-diff(log(fxrates000.0)) # difference between the next - the prior to the log of the value
#apply(is.na(fxrates000.0),2,sum)
# apply(is.na(fxrates000.0),2,sum) can be used to check if there is missing data
# fxrates000.0<-na.locf(fxrates000.0) this function can fill in missing data

par(mfcol=c(2,2)) # X1-X2 variable?
for (j0 in c(1:ncol(fxrates000.0.logret))){
  plot(fxrates000.0.logret[,j0],
  main=dimnames(fxrates000.0.logret)[[2]][j0])
}

lmfit.period1<-lm( CNY_SFR ~ USD_SFR + YEN_SFR + EUR_SFR + GBP_SFR,
                   data=window(fxrates000.0.logret,
                                 start=as.Date("2001-01-01"), end=as.Date("2005-06-30")) )
summary.lm(lmfit.period1)


###
lmfit.period_test1<-lm( CNY_SFR ~ USD_SFR,
                   data=window(fxrates000.0.logret,
                               start=as.Date("2001-01-01"), end=as.Date("2005-06-30")) )
summary.lm(lmfit.period_test1)
### Self checking, it seems if we only keep USD, it still shows 0.99 R^2

###
lmfit.period_test2<-lm( CNY_SFR ~ (22/49) * USD_SFR + (16/49) * YEN_SFR + (11/49) * EUR_SFR,
                        data=window(fxrates000.0.logret,
                                    start=as.Date("2017-01-01"), end=as.Date("2022-06-30")) )
summary.lm(lmfit.period_test2)
### Self checking2
tail(fxrates000)

lmfit.period2<-lm( CNY_SFR ~ USD_SFR + YEN_SFR + EUR_SFR + GBP_SFR +WON_SFR + MYR_SFR + THB_SFR,
                   data=window(fxrates000.0.logret,
                                start=as.Date("2005-07-01"), end=as.Date("2005-12-31")) )
summary.lm(lmfit.period2)
# Basket in the paper is more reliable
###
lmfit.period_test<-lm( CNY_SFR ~ USD_SFR + YEN_SFR + EUR_SFR + GBP_SFR,
                   data=window(fxrates000.0.logret,
                               start=as.Date("2005-07-01"), end=as.Date("2005-12-31")) )
summary.lm(lmfit.period_test)
###


for (year0 in as.character(c(2013:2022))){
 # year0<-"2012"
    lmfit.year0<-lm( CNY_SFR ~ USD_SFR + YEN_SFR + EUR_SFR + GBP_SFR + WON_SFR + MYR_SFR + THB_SFR, data=fxrates000.0.logret[year0])

      cat("\n\n--------------------------------\n");cat(year0);cat(":\n")
      print(summary.lm(lmfit.year0))
      rate.appreciation.usd<-round( exp(252*log(1+ lmfit.year0$coefficients[1])) -1,digits=3)
      cat("\n"); cat(year0); cat("\t Annualized appreciation rate to implied reference basket: "); cat(rate.appreciation.usd); cat("\n")
      }

## 22/03/20
year0<-"2012"
par(mfcol=c(1,1))
ts.plot(cumsum(fxrates000.0.logret["2012"]), col=rainbow(NCOL(fxrates000.0.logret)),
        main="2012 Currency Returns")
legend(x=150,y=.15, legend=dimnames(fxrates000.0.logret)[[2]], lty=rep(1,times=ncol(fxrates000.0.logret)),
         col=rainbow(NCOL(fxrates000.0.logret)), cex=0.70)

#fxrates000.0.logret difference between the next - the prior to the log of the value
