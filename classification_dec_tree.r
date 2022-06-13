comment = '
3. 의사결정나무 Decision Tree
- 데이터들이 가진 속성들로부터 분할 기준 속성을 판별
- 분할 기준 속성에 따라 트리 형태로 모델링
- 분석의 대상을 분류 함수를 활용하여 의사결정 규칙으로 이루어진 나무 모양
- 연속적으로 발생하는 의사결정 문제를 시각화해서 의사결정이 이루어지는 시점과 성과 파악이 쉬움
- 해석이 용이한 이유는 결과가 나무에 직접 나타남

분석 함수 종류
rpart(formula, data) : CART 기법, 불순도 측도 = 지니지수(범주형)/분산(연속형)
tree(formula, data) : 불순도 측도로 엔트로피 지수 사용
ctree(formula, data) : 결과에서 별도 가지치기가 불필요, 변수레벨이 31개로 제한
'

#데이터 탐색
str(iris)
head(iris)
summary(iris)

#전처리 : 결측값이 없음

#변수 선택 : Species를 제외한 변수를 선택

#분석 모형 구축
md <- rpart(Species ~., data = iris)
md
#시각화는 실전 시험에서 사용할 수 없다고 함;;
plot(md, compress = TRUE, margin = 0.5)
text(md, cex = 1)
prp(md, type = 2, extra = 2)

#분석 모형 평가
ls(md)
#가지치기 및 트리의 최대 크기를 조절하기 위해 cptable 변수를 사용
md$cptable
#nsplit이 2일 경우, rel error가 가장 적어 가장 적절한 것으로 cp가 0.01인 것을 판단
plotcp(md)
#혼동행렬을 통해 분류 정확도를 확인
tree_pred <- predict(md, newdata = iris, type = 'class')
confusionMatrix(tree_pred, reference = iris$Species)
#정확도가 0.96으로 상당히 높음
#클래스별 민감도 및 특이도 또한 높음