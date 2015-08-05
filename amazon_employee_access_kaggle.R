library(verification)
library(randomForest)

train <- read.csv("~/Desktop/Amazon_Employee_Access/train.csv", header = TRUE, 
                  stringsAsFactors = FALSE)

test <- read.csv("~/Desktop/Amazon_Employee_Access/test.csv", header = TRUE, 
                  stringsAsFactors = FALSE)

# Naive Random Forest (without any Feature Selection) # Score = 0.861 rank = 856
# library(randomForest)
forest.model = randomForest(as.factor(ACTION) ~ .,
                            data=train,ntree=100)
forest.prediction = predict(forest.model,newdata =test[-1],type="vote",predict.all=TRUE)
# View(head(forest.prediction))

submission <- cbind(test$id,as.data.frame(forest.prediction$aggregate[,2]))
colnames(submission) <- c("id","ACTION")

write.csv(submission, file = "~/Desktop/Amazon_Employee_Access/my_submission_naive_RF2.csv",row.names = FALSE)

# Tried a very naive decision tree but it gave same result as random (AUC = 0.5000)
# Might come back to try once more

# Logistic Regression (AUC of 0.52, Rank = 1546)
logistic.model <- glm(formula = as.factor(ACTION) ~ .,data = train, family = "binomial")
logistic.prediction <- predict(logistic.model,newdata = test[,-1],type = "response")

submission.logistic <- cbind(test$id,as.data.frame(logistic.prediction))
colnames(submission.logistic) <- c("id","ACTION")

write.csv(submission.logistic, file = "~/Desktop/Amazon_Employee_Access/my_submission_naive_logistic2.csv",row.names = FALSE)


# Average Random Forest and Logistic Regression (AUC = 0.857, Rank = 880)

submission.average <- cbind(submission$id,(submission$ACTION + submission.logistic$ACTION)/2)
colnames(submission.average) <- c("id","ACTION")
write.csv(submission.average, file = "~/Desktop/Amazon_Employee_Access/my_submission_RF_logistic2.csv",row.names = FALSE)
