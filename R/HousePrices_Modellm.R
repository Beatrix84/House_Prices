# librairies
library(dplyr)
library(ggplot2)

# Chargement
test <- read.csv("C:/Users/utilisateur/Desktop/HousePrices/test.csv")

# Dimensions
dim(test)

# Summary
summary(test)

colSums(is.na(test))

levels(test$MSZoning)<-c(levels(test$MSZoning),"none")
levels(test$LotFrontage)<-c(levels(test$LotFrontage),"none")
levels(test$Alley)<-c(levels(test$Alley),"none")
levels(test$Utilities)<-c(levels(test$Utilities),"none")
levels(test$Exterior1st)<-c(levels(test$Exterior1st),"none")
levels(test$Exterior2nd)<-c(levels(test$Exterior2nd),"none")
levels(test$MasVnrType)<-c(levels(test$MasVnrType),"none")
levels(test$MasVnrArea)<-c(levels(test$MasVnrArea),"none")
levels(test$BsmtQual)<-c(levels(test$BsmtQual),"none")
levels(test$BsmtCond)<-c(levels(test$BsmtCond),"none")
levels(test$BsmtExposure)<-c(levels(test$BsmtExposure),"none")
levels(test$BsmtFinType1)<-c(levels(test$BsmtFinType1),"none")
levels(test$BsmtFinSF1)<-c(levels(test$BsmtFinSF1),"none")
levels(test$BsmtFinType2)<-c(levels(test$BsmtFinType2),"none")
levels(test$BsmtFinSF2)<-c(levels(test$BsmtFinSF2),"none")
levels(test$BsmtUnfSF)<-c(levels(test$BsmtUnfSF),"none")
levels(test$TotalBsmtSF)<-c(levels(test$TotalBsmtSF),"none")
levels(test$BsmtFullBath)<-c(levels(test$BsmtFullBath),"none")
levels(test$BsmtHalfBath)<-c(levels(test$BsmtHalfBath),"none")
levels(test$KitchenQual)<-c(levels(test$KitchenQual),"none")
levels(test$Functional)<-c(levels(test$Functional),"none")
levels(test$FireplaceQu)<-c(levels(test$FireplaceQu),"none")
levels(test$GarageType)<-c(levels(test$GarageType),"none")
levels(test$GarageYrBlt)<-c(levels(test$GarageYrBlt),"none")
levels(test$GarageFinish)<-c(levels(test$GarageFinish),"none")
levels(test$GarageCars)<-c(levels(test$GarageCars),"none")
levels(test$GarageArea)<-c(levels(test$GarageArea),"none")
levels(test$GarageQual)<-c(levels(test$GarageQual),"none")
levels(test$GarageCond)<-c(levels(test$GarageCond),"none")
levels(test$PoolQC)<-c(levels(test$PoolQC),"none")
levels(test$Fence)<-c(levels(test$Fence),"none")
levels(test$MiscFeature)<-c(levels(test$MiscFeature),"none")
levels(test$SaleType)<-c(levels(test$SaleType),"none")
test[is.na(test)] <- "none"

reg.model <- lm(logSalePrice ~ LotArea + Street + LandContour + LotConfig + 
                   LandSlope + Neighborhood + Condition1 + BldgType + 
                   HouseStyle + OverallQual + OverallCond + YearBuilt + YearRemodAdd + 
                   RoofStyle + Foundation + BsmtQual + BsmtCond + 
                   BsmtExposure + BsmtUnfSF + TotalBsmtSF + Heating + HeatingQC + 
                   CentralAir + FullBath + BedroomAbvGr + 
                   GarageType + GarageArea + SaleCondition + FireplaceQu + PoolQC, data=datareg)

# summarize the fit
summary(reg.model)
vif(reg.model)

#make predictions
predictions <- predict.lm(reg.model, test)
SalePrice <- exp(predictions)
SalePrice
test$SalePrice <- SalePrice

nrow(test)
length(SalePrice)

# on choisit le dossier dans lequel on veut sauver le fichier

setwd("C:/Users/utilisateur/Desktop/HousePrices")

#on crée un dataframe avant de le sauver

prediction<-data.frame(SalePrice)

# on utilise la fonction write.table, voir ?write.table
# ne pas oublier le .csv à la fin du nom du fichier excel "data.csv"

write.csv(predicition, "predictions.csv", row.names=FALSE, sep="t",dec=",", na=" ")
