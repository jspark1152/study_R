A = c(1, 3, 4)

print(A)
cat("A is ", A)
print(mean(A))
print(sum(A))
print(median(A))
print(var(A))
print(length(A))

print(pi)

#digits 지정하여 소수점 표현
print(pi, digits=5)

cat(format(pi, digits=5), "\n")

options(digits=9)
print(pi)

V = c(10, 20, 30)
#벡터 각 원소에 이름을 부여할 수 있음
names(V) = c("Jin", "Ji", "Min")

print(V[c(2,3)])

print(V["Ji"])

print(V[["Ji"]])

a = 1:9
print(a)
dim(a) = c(3, 3)
print(a)
#파이썬과 문법상 다른점이 있음. 헷갈리지 않게 조심.
print(a[1, 2])

b = 1:12
#다양한 차원 표현 가능. 단, 길이가 일치하게 해줘야. 이 경우 차원 테이블에 12자리가 있는데 만약 b 벡터의 길이가 12가 아닌 10 인 경우 에러 발생
dim(b) = c(2, 3, 2)
#직관적인 테이블로 바로 표현해주니까 상당히 보기 편함
print(b)