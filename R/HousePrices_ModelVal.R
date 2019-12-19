library(caret)
set.seed(3456)

levels(datareg$LotFrontage)<-c(levels(datareg$LotFrontage),"none")
levels(datareg$MasVnrType)<-c(levels(datareg$MasVnrType),"none")
levels(datareg$BsmtQual)<-c(levels(datareg$BsmtQual),"none")
levels(datareg$BsmtCond)<-c(levels(datareg$BsmtCond),"none")
levels(datareg$BsmtExposure)<-c(levels(datareg$BsmtExposure),"none")
levels(datareg$BsmtFinType1)<-c(levels(datareg$BsmtFinType1),"none")
levels(datareg$BsmtBsmtFinType2)<-c(levels(datareg$BsmtFinType2),"")
levels(datareg$GarageType)<-c(levels(datareg$GarageType),"none")
levels(datareg$GarageFinish)<-c(levels(datareg$GarageFinish),"none")
levels(datareg$GarageQual)<-c(levels(datareg$GarageQual),"none")
levels(datareg$GarageCond)<-c(levels(datareg$GarageCond),"none")
datareg[is.na(datareg)] <- "none"
datareg<-select(datareg, -BsmtFinType2)
summary(datareg)

# create a list of 80% of the rows in the original dataset we can use for training
validation_index <- createDataPartition(datareg$logSalePrice, p=0.80, list=FALSE)
# select 20% of the data for validation
validation <- datareg[-validation_index,]
# use the remaining 80% of data to training and testing the models
train80 <- datareg[validation_index,]

# dimensions of dataset
dim(train80)

# list types for each attribute
sapply(train80, class)

# take a peek at the first 5 rows of the data
head(train80)

# summarize attribute distributions
summary(datareg)

# split input and output
x <- datareg[,c(1:47, 49:54)]
y <- datareg[,48]

# barplot for class breakdown
plot(y)
summary(x)

library(psych)
dataNum<-select_if(datareg, is.numeric)
pairs.panels(dataNum, method = "pearson", hist.col = "#00AFBB", density = TRUE,  ellipses = TRUE)

# scatterplot matrix
featurePlot(x=x, y=y, plot="ellipse")

# fit model
reg1 = lm(logSalePrice ~., data=datareg)
fit <- step(reg1)
reg.fitter <- lm(logSalePrice ~ MSZoning + LotArea + Street + LandContour + LotConfig + 
                   LandSlope + Neighborhood + Condition1 + BldgType + 
                   HouseStyle + OverallQual + OverallCond + YearBuilt + YearRemodAdd + 
                   RoofStyle + Foundation + BsmtQual + BsmtCond + 
                   BsmtExposure + BsmtUnfSF + TotalBsmtSF + Heating + HeatingQC + 
                   CentralAir + FullBath + BedroomAbvGr + KitchenQual + Functional + 
                   GarageType + GarageArea + SaleType + SaleCondition + FireplaceQu + PoolQC, data=train80)

# summarize the fit
summary(reg.fitter)
vif(reg.fitter)
coefplot(reg.fitter)
library(coefplot)

dataNum<-select_if(train80, is.numeric)
matrice.cor <- cor(dataNum, use = "pairwise.complete.obs")
library(corrplot)
corrplot(matrice.cor, method="circle", tl.cex=0.5)
# findCorrelation (ci-dessous) fait partie du package caret
correlations.fortes <- findCorrelation(matrice.cor, cutoff = 0.6)
colnames(dataNum)[correlations.fortes]

alias(reg.fitter)
train80<-select(train80, -GarageQual, -GarageCond -Condition2 -RoofMatl)
            
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
