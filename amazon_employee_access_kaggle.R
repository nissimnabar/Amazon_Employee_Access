library(verification)

train <- read.csv("~/Desktop/Amazon_Employee_Access/train.csv", header = TRUE, 
                  stringsAsFactors = FALSE)

test <- read.csv("~/Desktop/Amazon_Employee_Access/test.csv", header = TRUE, 
                  stringsAsFactors = FALSE)

# Naive Random Forest (without any Feature Selection) # Score = 0.861 rank = 856
library(randomForest)
forest.model = randomForest(as.factor(ACTION) ~.,data=train,ntree=100)
forest.prediction = predict(forest.model,newdata =test[-1],type="prob",predict.all=TRUE)
View(head(forest.prediction))

submission <- cbind(test$id,as.data.frame(forest.prediction$aggregate[,2]))
colnames(submission) <- c("id","ACTION")

write.csv(submission, file = "~/Desktop/Amazon_Employee_Access/my_submission_naive_RF.csv",row.names = FALSE)

# 