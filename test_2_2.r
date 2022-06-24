#제 2 유형 2번
library(caret)
library(ModelMetrics)

ds <- mtcars
str(ds)
summary(ds)

set.seed(4000)
idx1 <- sample(1:nrow(ds), size = (nrow(ds))*0.7)
train_ds <- ds[idx1, ]
test_ds <- ds[-idx1, ]

#전처리 : 결측값은 없음
#명목형으로 분류만 하다가 연비 예측은 뭐로 해야하나

md_lm <- lm(mpg ~., data = train_ds)

#조금 더 정교하게 > 변수 선택법 
step(md_lm, direction = 'backward')

summary(lm(mpg ~ wt+qsec+am, train_ds))

md_fit <- lm(mpg ~ wt+qsec+am, data = train_ds)
pred_fit <- predict(md_fit, newdata = test_ds, type = 'response')
rmse(test_ds$mpg, pred_fit)