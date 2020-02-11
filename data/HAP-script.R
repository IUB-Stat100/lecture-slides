## This code and the related data are open-source under the BSD 2-clause license.
## See http://www.tldrlegal.com/l/BSD2 for details
## Michael Ash, Thomas Herndon, and Robert Pollin April-May 2013
## Replicate and extend Reinhart and Rogoff (2010) using data from RR working spreadsheet

## DJM: See the below RR.R, this script is a subset thereof


RR = foreign::read.dta("data/HAPData/RR-processed.dta")


## Limit to actually available data
RR <- subset(RR,  !is.na(dRGDP) & !is.na(debtgdp))


## Create RR public debt/GDP categories
RR$dgcat.lm <- cut(RR$debtgdp, breaks=c(0,30,60,90,Inf))
RR$dgcat <- factor(RR$dgcat.lm, labels = c("0-30%","30-60%","60-90%","Above 90%"),ordered=TRUE)

## Scatterplot (continuous)
ggplot(RR, aes(x=debtgdp,y=dRGDP)) + 
  geom_vline(xintercept=90,color='lightgray',size=1.5) +
  geom_point(aes(color=dgcat), alpha=.8) + 
  ylab("Real GDP Growth") + xlab("Public Debt/GDP Ratio") + 
  scale_x_continuous(breaks=seq(0,240,30)) + theme_cowplot() +
  geom_smooth(color="black") +
  geom_hline(yintercept = 0, linetype="dashed") +
  theme(legend.title = element_blank())

