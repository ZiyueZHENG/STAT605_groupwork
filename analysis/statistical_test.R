library(cars)
library(quantmod)
library(userfriendlyscience)
library(ggplot2)

# Get data
data1 = read.csv('all_processed.csv',header = F)
colnames(data1) = c('Date','Week','Volume','Turnover','AvgPrice','Opening Price','Closing Price','MaxPrice','MinPrice','NetInflow')
data1$Week = as.factor(data1$Week)
data1$return[1] =  0
for(i in 1:633){
  data1$return[i+1] = (data1$AvgPrice[i+1]-data1$AvgPrice[i])/data1$AvgPrice[i]
}

# Data visualization: Candlestick chart
getSymbols('BTCUSD',src = "csv")
chartSeries(BTCUSD)

# Box plot
ggplot(data1,aes(x=Week,y=return))+
  geom_boxplot()
ggplot(data1,aes(x=Week,y=Volume))+
  geom_boxplot()

# Homogeneity of variance test
leveneTest(return~Week,data = data1) # return is heteroscedasticity
leveneTest(Volume~Week,data = data1)

# two sample t-test
tt = c()
for(i in 1:6){
  for(j in (i+1):7){
    p1 = t.test(data1$return[data1$Week==i],data1$return[data1$Week==j])['p.value']
    p2 = t.test(data1$Volume[data1$Week==i],data1$Volume[data1$Week==j])['p.value']
    tt = append(tt,paste(i,j,p1,p2))
  }
}
print(tt)# Return between 6&7,3&7 is significant under 95% level.

# Using Games-Howell test with return (because of heteroscedasticity)
oneway.test(return~Week,data = data1)

# Using Tuckey test with trading volume
summary(fm2 <- aov(Volume ~ Week, data = data1))
TukeyHSD(fm2, "Week", ordered = F)
plot(TukeyHSD(fm2, "Week"))
