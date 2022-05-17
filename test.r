z=c(1,2,3,NA)

3*z

s <- c('monday', 'tuesday', 'wednesday')
substr(s, 2, 3)

dfm1 <- data.frame('T_name'=c('T1', 'T2', 'T3', 'T4', 'T5', 'T6'), 'x'=c(1.4, 1.8, 1.5, 1.4, 1.6, 1.5), 'y'=c(3.2, 3.4, 3.9, 3.2, 3.4, 3.9))
dfm2 <- data.frame('T_name'=c('T1', 'T3', 'T5'), 'z'=c(5.7, 5.8, 6.9))

merge(dfm1, dfm2, by='T_name')

x <- c(1:5)
y <- seq(10, 50, 10)
rbind(x,y)