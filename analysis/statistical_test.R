# Get data
data1 = read.csv('all_processed.csv',header = F)
colnames(data1) = c('Date','Week','Volume','Turnover','AvgPrice','Opening Price','Closing Price','MaxPrice','MinPrice','NetInflow')
data1$Week = as.factor(data1$Week)
data1$return[1] =  0
for(i in 1:633){
  data1$return[i+1] = (data1$AvgPrice[i+1]-data1$AvgPrice[i])/data1$AvgPrice[i]
}

# Data visualization: Candlestick chart
library(quantmod)
getSymbols('BTCUSD',src = "csv")
chartSeries(BTCUSD)

# Box plot
library(ggplot2)
ggplot(data1,aes(x=Week,y=return))+
  geom_boxplot()
ggplot(data1,aes(x=Week,y=Volume))+
  geom_boxplot()

# two sample t-test
tt = c()
for(i in 1:6){
  for(j in (i+1):7){
    p1 = t.test(data1$return[data1$Week==i],data1$return[data1$Week==j])['p.value']
    p2 = t.test(data1$Volume[data1$Week==i],data1$Volume[data1$Week==j])['p.value']
    tt = append(tt,paste(i,j,p1,p2))
  }
}
print(tt)

# Tuckey test
summary(fm1 <- aov(return ~ Week, data = data1))
TukeyHSD(fm1, "Week", ordered = F)
plot(TukeyHSD(fm1, "Week"))

summary(fm2 <- aov(Volume ~ Week, data = data1))
TukeyHSD(fm2, "Week", ordered = F)
plot(TukeyHSD(fm2, "Week"))
