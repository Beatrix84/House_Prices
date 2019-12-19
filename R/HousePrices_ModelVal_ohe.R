library(caret)
library(dplyr)
set.seed(3456)

trainfull <- read.csv("C:/Users/utilisateur/Desktop/handson-ml2/HousePrices/trainfull_ohe.csv")

# summarize attribute distributions
summary(trainfull)

trainfull$logSalePrice<-log(trainfull$SalePrice)
hist(log(trainfull$SalePrice))

trainfull <- select(trainfull, -Id, -SalePrice)

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

# fit model
reg1 = lm(logSalePrice ~., data=train80)
# find the best model depending of the AIC score
#fit <- step(reg1)
# use the best model
reg.fitter <- lm(logSalePrice ~ MSSubClass + LotArea + OverallQual + OverallCond + 
                   YearBuilt + YearRemodAdd + BsmtFinSF1 + BsmtFinSF2 + BsmtUnfSF + 
                   X1stFlrSF + X2ndFlrSF + LowQualFinSF + BsmtFullBath + FullBath + 
                   HalfBath + KitchenAbvGr + TotRmsAbvGrd + Fireplaces + GarageYrBlt + 
                   GarageArea + WoodDeckSF + EnclosedPorch + X3SsnPorch + ScreenPorch + 
                   PoolArea + MSZoning_C..all. + MSZoning_FV + Alley_None + 
                   Alley_Grvl + LotConfig_Inside + LotConfig_Corner + LotConfig_CulDSac + 
                   LandSlope_Gtl + LandSlope_Mod + Neighborhood_Veenker + Neighborhood_Crawfor + 
                   Neighborhood_NoRidge + Neighborhood_Mitchel + Neighborhood_Somerst + 
                   Neighborhood_NWAmes + Neighborhood_OldTown + Neighborhood_NridgHt + 
                   Neighborhood_IDOTRR + Neighborhood_MeadowV + Neighborhood_Edwards + 
                   Neighborhood_StoneBr + Neighborhood_ClearCr + Neighborhood_BrDale + 
                   Condition1_Norm + Condition1_Feedr + Condition1_PosN + Condition1_RRAn + 
                   Condition2_Norm + Condition2_Artery + Condition2_Feedr + 
                   Condition2_PosN + Condition2_PosA + Condition2_RRAn + BldgType_2fmCon + 
                   HouseStyle_1.5Fin + HouseStyle_2.5Unf + RoofStyle_Gable + 
                   RoofStyle_Hip + RoofStyle_Gambrel + RoofStyle_Mansard + RoofStyle_Flat + 
                   RoofMatl_CompShg + RoofMatl_WdShngl + RoofMatl_WdShake + 
                   RoofMatl_Membran + RoofMatl_Tar.Grv + RoofMatl_Roll + Exterior1st_VinylSd + 
                   Exterior1st_MetalSd + Exterior1st_Wd.Sdng + Exterior1st_HdBoard + 
                   Exterior1st_WdShing + Exterior1st_CemntBd + Exterior1st_Plywood + 
                   Exterior1st_AsbShng + Exterior1st_BrkComm + Exterior2nd_Wd.Sdng + 
                   MasVnrType_BrkFace + MasVnrType_None + MasVnrType_Stone + 
                   ExterQual_Gd + ExterQual_TA + ExterQual_Ex + ExterCond_Gd + 
                   Foundation_CBlock + Foundation_BrkTil + Foundation_Wood + 
                   BsmtQual_Ex + BsmtCond_TA + BsmtCond_Gd + BsmtExposure_Gd + 
                   BsmtExposure_Av + BsmtFinType1_GLQ + BsmtFinType1_ALQ + BsmtFinType2_BLQ + 
                   Heating_GasA + Heating_GasW + Heating_Wall + HeatingQC_Ex + 
                   CentralAir_Y + Electrical_FuseP + KitchenQual_Ex + Functional_Typ + 
                   Functional_Min1 + Functional_Maj1 + Functional_Min2 + Functional_Mod + 
                   GarageType_Attchd + GarageType_Detchd + GarageType_BuiltIn + 
                   GarageType_CarPort + GarageType_Basment + GarageQual_TA + 
                   GarageQual_Gd + GarageQual_Ex + GarageCond_TA + GarageCond_Fa + 
                   GarageCond_Gd + GarageCond_Po + PoolQC_None + PoolQC_Fa + 
                   Fence_GdWo + SaleType_New + SaleType_ConLD + SaleCondition_Normal, data=train80)

# summarize the fit
summary(reg.fitter)

# Evaluer la multicolinéarité avec le Variance Inflation Factor
library(car)
vif(reg.fitter)

train80 <- select(train80, -OverallQual, -BsmtFinSF1, -BsmtUnfSF, -X1stFlrSF, -X2ndFlrSF, -TotRmsAbvGrd, -GarageYrBlt, -LotConfig_Inside,
                    -LandSlope_Gtl, -PoolArea, -Neighborhood_Somerst, -BldgType_1Fam, -HouseStyle_1Story, - Condition2_Artery, -Condition2_Feedr,
                    -Condition2_PosN, -Condition2_PosA, -RoofStyle_Gable, -RoofStyle_Hip, -RoofStyle_Gambrel, -RoofStyle_Mansard,
                    -RoofMatl_CompShg, -RoofMatl_WdShngl, -RoofMatl_WdShake, -RoofMatl_Membran, -RoofMatl_Tar.Grv,
                    -Exterior1st_VinylSd, -Exterior1st_Wd.Sdng, -Exterior1st_HdBoard, -Exterior1st_CemntBd,
                    -Exterior2nd_Wd.Sdng, -MasVnrType_None, -ExterQual_Gd, -Heating_GasA, -Functional_Typ, -Functional_Min1,
                    -Functional_Min2, -GarageType_Attchd, -GarageType_BuiltIn, -GarageType_Basment, -GarageQual_Ex,
                    -GarageCond_Fa, -GarageCond_Gd, -GarageCond_Po, -PoolQC_None)

# nouveau modèle sans les multi-colinéarité
reg2 <- lm(logSalePrice~., data=train80)
summary(reg2)
#fit <- step(reg2)

reg.fitter2 <- lm(logSalePrice~MSSubClass + LotArea + OverallCond + YearBuilt + 
                    YearRemodAdd + TotalBsmtSF + GrLivArea + BsmtFullBath + FullBath + 
                    HalfBath + BedroomAbvGr + KitchenAbvGr + Fireplaces + GarageCars + 
                    GarageArea + WoodDeckSF + EnclosedPorch + X3SsnPorch + ScreenPorch + 
                    MSZoning_RM + MSZoning_C..all. + MSZoning_FV + Street_Pave + 
                    LandContour_Bnk + Utilities_AllPub + LotConfig_Corner + LotConfig_CulDSac + 
                    LandSlope_Sev + Neighborhood_Veenker + Neighborhood_Crawfor + 
                    Neighborhood_NoRidge + Neighborhood_Mitchel + Neighborhood_NWAmes + 
                    Neighborhood_OldTown + Neighborhood_Sawyer + Neighborhood_NridgHt + 
                    Neighborhood_NAmes + Neighborhood_MeadowV + Neighborhood_Edwards + 
                    Neighborhood_Gilbert + Neighborhood_StoneBr + Condition1_Norm + 
                    Condition1_RRAe + Condition1_RRNn + Condition1_RRAn + Condition2_Norm + 
                    Condition2_RRNn + Condition2_RRAe + BldgType_2fmCon + BldgType_Twnhs + 
                    HouseStyle_1.5Unf + HouseStyle_SFoyer + HouseStyle_SLvl + 
                    HouseStyle_2.5Unf + HouseStyle_2.5Fin + RoofStyle_Flat + 
                    RoofStyle_Shed + RoofMatl_Metal + RoofMatl_ClyTile + Exterior1st_BrkFace + 
                    Exterior1st_Stucco + Exterior1st_BrkComm + Exterior2nd_HdBoard + 
                    Exterior2nd_Plywood + Exterior2nd_BrkFace + Exterior2nd_AsbShng + 
                    Exterior2nd_Stone + MasVnrType_BrkFace + MasVnrType_Stone + 
                    ExterCond_TA + ExterCond_Gd + ExterCond_Fa + ExterCond_Po + 
                    Foundation_CBlock + Foundation_BrkTil + Foundation_Wood + 
                    Foundation_Slab + BsmtQual_Ex + BsmtCond_Fa + BsmtExposure_Gd + 
                    BsmtFinType1_GLQ + BsmtFinType2_BLQ + Heating_GasW + Heating_Grav + 
                    Heating_Floor + HeatingQC_Ex + HeatingQC_Gd + CentralAir_Y + 
                    KitchenQual_Ex + Functional_Maj1 + Functional_Mod + Functional_Maj2 + 
                    Functional_Sev + GarageType_Detchd + GarageType_None + GarageType_2Types + 
                    GarageFinish_Unf + GarageQual_TA + GarageQual_Fa + GarageQual_Gd + 
                    GarageQual_Po + GarageCond_Ex + PoolQC_Gd + Fence_GdWo + 
                    MiscFeature_None + MiscFeature_Shed + MiscFeature_Gar2 + 
                    SaleType_WD + SaleType_COD + SaleType_ConLD + SaleType_ConLI + 
                    SaleCondition_Normal + SaleCondition_AdjLand, data=train80)


vif(reg.fitter2)

library(coefplot)
coefplot(reg.fitter2)

library(corrplot)
corrplot(matrice.cor, method="circle", tl.cex=0.5)

# findCorrelation (ci-dessous) fait partie du package caret
correlations.fortes <- findCorrelation(matrice.cor, cutoff = 0.6)
colnames(dataNum)[correlations.fortes]
            
#make predictions
predictions <- predict.lm(reg.fitter2, validation)
realpredictions <- exp(predictions)
realpredictions
validation$SalePrice <- exp(validation$logSalePrice)
validation$SalePrice

# Evaluate
error <- validation$SalePrice - realpredictions
error

MeanAbsoluteError <- mean(abs(error))
MeanAbsoluteError

# MAE2 = 13723,47

RootMeanSquaredError <- mean(sqrt((validation$SalePrice - realpredictions)^2))
RootMeanSquaredError

# RMSE2 = 13723,47
