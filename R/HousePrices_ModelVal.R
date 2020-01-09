library(caret)
set.seed(3456)

trainfull <- read.csv("C:/Users/utilisateur/Desktop/handson-ml2/HousePrices/R/trainfull_55feat.csv")

levels(trainfull$LotFrontage)<-c(levels(trainfull$LotFrontage),"none")
levels(trainfull$MasVnrType)<-c(levels(trainfull$MasVnrType),"none")
levels(trainfull$BsmtQual)<-c(levels(trainfull$BsmtQual),"none")
levels(trainfull$BsmtCond)<-c(levels(trainfull$BsmtCond),"none")
levels(trainfull$BsmtExposure)<-c(levels(trainfull$BsmtExposure),"none")
levels(trainfull$BsmtFinType1)<-c(levels(trainfull$BsmtFinType1),"none")
levels(trainfull$BsmtBsmtFinType2)<-c(levels(trainfull$BsmtFinType2),"")
levels(trainfull$GarageType)<-c(levels(trainfull$GarageType),"none")
levels(trainfull$GarageFinish)<-c(levels(trainfull$GarageFinish),"none")
levels(trainfull$GarageQual)<-c(levels(trainfull$GarageQual),"none")
levels(trainfull$GarageCond)<-c(levels(trainfull$GarageCond),"none")
trainfull[is.na(trainfull)] <- "none"
trainfull<-select(trainfull, -BsmtFinType2)

# summarize attribute distributions
summary(trainfull)

# create a list of 80% of the rows in the original dataset we can use for training
validation_index <- createDataPartition(trainfull$logSalePrice, p=0.80, list=FALSE)
# select 20% of the data for validation
validation <- trainfull[-validation_index,]
# use the remaining 80% of data to training and testing the models
train80 <- trainfull[validation_index,]

# dimensions of dataset
dim(train80)

# list types for each attribute
sapply(train80, class)

# take a peek at the first 5 rows of the data
head(train80)

library(psych)
dataNum<-select_if(trainfull, is.numeric)
pairs.panels(dataNum, method = "pearson", hist.col = "#00AFBB", density = TRUE,  ellipses = TRUE)

# fit model
reg1 = lm(logSalePrice ~., data=trainfull)
# find the best model with te lower AIC
fit <- step(reg1)
#Use the model found above
reg.fitter <- lm(logSalePrice ~ MSZoning + LotArea + Street + LandContour + LotConfig + 
                   LandSlope + Neighborhood + Condition1 + BldgType + 
                   HouseStyle + OverallQual + OverallCond + YearBuilt + YearRemodAdd + 
                   RoofStyle + Foundation + BsmtQual + BsmtCond + 
                   BsmtExposure + BsmtUnfSF + TotalBsmtSF + HeatingQC + 
                   CentralAir + FullBath + BedroomAbvGr + KitchenQual + 
                   GarageType + GarageArea + SaleType + SaleCondition + FireplaceQu + PoolQC, data=train80)

# summarize the fit
summary(reg.fitter)

#Vérifier les corrélations trop fortes
vif(reg.fitter)
alias(reg.fitter)

library(coefplot)
coefplot(reg.fitter)
dataNum<-select_if(train80, is.numeric)
matrice.cor <- cor(dataNum, use = "pairwise.complete.obs")

library(corrplot)
corrplot(matrice.cor, method="circle", tl.cex=0.5)

# findCorrelation (ci-dessous) fait partie du package caret
correlations.fortes <- findCorrelation(matrice.cor, cutoff = 0.6)
colnames(dataNum)[correlations.fortes]

#make predictions
predictions <- predict.lm(reg.fitter, validation)
realpredictions <- exp(predictions)
realpredictions
validation$SalePrice <- exp(validation$logSalePrice)
validation$SalePrice

# Evaluate
error <- validation$SalePrice - realpredictions
error

MeanAbsoluteError <- mean(abs(error))
MeanAbsoluteError

RootMeanSquaredError <- mean(sqrt((validation$SalePrice - realpredictions)^2))
RootMeanSquaredError
