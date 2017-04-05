library(randomForest)
library(readr)

train <- read_csv("../input/train.csv")
test <- read_csv("../input/test.csv")

set.seed(181092)

sampSize <- 15000
treeNum <- 30

rows <- sample(1:nrow(train), sampSize)
facLabel <- as.factor(train$label[rows])
train <- train[rows,-1]

forest <- randomForest(train, facLabel, xtest=test, ntree=treeNum)
predictions <- data.frame(ImageId=1:nrow(test), Label=levels(facLabel)[forest$test$predicted])
head(predictions)

write_csv(predictions, "rf_benchmark.csv") #Accuracy: 0.947 

