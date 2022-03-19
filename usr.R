#source(file="fm_casestudy_0_InstallOrLoadLibraries.r")

#source(file="fm_casestudy_fx_1.r")

load(file="fm_casestudy_fx_1.Rdata")

list.symbol0<-c("DEXCHUS", "DEXJPUS", "DEXKOUS", "DEXMAUS","DEXUSEU", "DEXUSUK", "DEXTHUS", "DEXSZUS")

fxrates000<-fred.fxrates.00[,list.symbol0]

dim(fxrates000)

head(fxrates000)

tail(fxrates000)
