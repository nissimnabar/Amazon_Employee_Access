library(verification)

train <- read.csv("~/Desktop/Amazon_Employee_Access/train.csv", header = TRUE, 
                  stringsAsFactors = FALSE)

test <- read.csv("~/Desktop/Amazon_Employee_Access/test.csv", header = TRUE, 
                  stringsAsFactors = FALSE)

colnames(train)
View(head(train))
