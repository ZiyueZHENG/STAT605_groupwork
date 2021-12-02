library(zoo)
library(forecast)
library(ggplot2)
library(tseries)
library(TSA)


data <- read.csv('all_processed.csv',head = FALSE)

name <- c('Date' ,'Week', 'Volume' ,'Turnover' , 'Avg.Price' , 
          'Opening Price' , 'Closing Price' , 'Max Price' , 
          'Min Price' ,'Net Inflow')

names(data) = name

data$Week = as.factor(data$Week)

# calculate the rate of return
dif = diff(data$Avg.Price)
r = dif/data$Avg.Price[2:length(data$Date)]
t = as.Date(data$Date[2:634])
da <- data.frame(Time = t,R=r,Week = data$Week[2:634])

# draw the time series plot
p = ggplot(da,aes(x=Time,y=R))+ geom_line(colour = 'red') + xlab('The Time Series of Date') + ylab('Rate of Return')
p

rs = ts(r)

week = data$Week[2:634]
w = model.matrix(~week)
w = w[,-1]

# adf test to test stationary
adf.test(rs)


# acf plot
acf(rs,plot = T)

# AR(1) model

ARModel = arima(rs,order = c(1,0,0),xreg = w)
ARModel


# arch test
Box.test(ARModel$residuals^2,type = "Ljung-Box")

# garch(1,1)
GModel = garch(ARModel$residuals,order = c(1,1))

summary(GModel)

# draw the interval 
r.pred = predict(GModel)

pred = data.frame(Time=t,R=r,lower=r.pred[,2],upper=r.pred[,1])

ggplot(pred)+ geom_line(aes(x=Time,y=R,colour = 'red'))+geom_line(aes(x=Time,y=upper))+geom_line(aes(x=Time,y=lower))+
  xlab('The Time Series of Date') + ylab('Rate of Return')+ theme(legend.position = 'none')
