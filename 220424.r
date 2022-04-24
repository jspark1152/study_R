cat("a", "b", "c")

a<-1
print(a)

b=1
print(b)

c<-2
print(c)

x<-c(1,2,3,4)
cat("x is ", x)

x<-c("fee", "fie", "fun")
print(x)

x<-1:5
print(x)

x<-9:-2
print(x)

x<-10:8
print(x)

x<-seq(from=0, to=20, by=2)
print(x)

x<-seq(from=0, to=20, length.out=5)
print(x)

print(rep(1, times=5))

x<-rep(1, times=5)
print(x)

x<-rep(1:4, each=2)
print(x)

x<-rep(seq(from=0, to=20, by=5), each=3)
print(x)

print(rep(x, each=2))

A<-paste("a", "b", "c", sep="-")
print(A)

B<-paste("a", "b", sep="")
print(B)

print(paste(A, c("e", "f")))

print(paste(A, 10, sep="-"))

print(substr("BigdataAnalysis", 1, 6))

Y<-c(a<-T, b<-F)
print(Y)

print(Y[2])

Z<-1:10
print(Z[3])

Z<-seq(from=1, to=10, by=2)
print(Z[5])

print(c(1,2,3)+c(4,5,6,7))