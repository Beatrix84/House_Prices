# librairies
library(dplyr)
library(ggplot2)
set.seed(3456)


# Chargement
test <- read.csv("C:/Users/utilisateur/Desktop/handson-ml2/HousePrices/test_ohe.csv")

# Dimensions
dim(test)

# Summary
summary(test)

test_id <- test$Id

colSums(is.na(test))

test[is.na(test)] <- 0


reg.model <- lm(logSalePrice~MSSubClass + LotArea + OverallCond + 
                  YearRemodAdd + TotalBsmtSF + GrLivArea + BsmtFullBath + FullBath + 
                  HalfBath + BedroomAbvGr + KitchenAbvGr + Fireplaces + 
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
                  ExterCond_Fa + ExterCond_Po + 
                  Foundation_CBlock + Foundation_BrkTil + Foundation_Wood + 
                  Foundation_Slab + BsmtQual_Ex + BsmtCond_Fa + BsmtExposure_Gd + 
                  BsmtFinType1_GLQ + BsmtFinType2_BLQ + Heating_GasW + Heating_Grav + 
                  Heating_Floor + HeatingQC_Ex + HeatingQC_Gd + CentralAir_Y + 
                  KitchenQual_Ex + Functional_Maj1 + Functional_Mod + Functional_Maj2 + 
                  Functional_Sev + GarageType_Detchd + GarageType_None + GarageType_2Types + 
                  GarageFinish_Unf + GarageCond_Ex + PoolQC_Gd + Fence_GdWo + 
                  MiscFeature_Shed + MiscFeature_Gar2 + 
                  SaleType_WD + SaleType_COD + SaleType_ConLD + SaleType_ConLI + 
                  SaleCondition_Normal + SaleCondition_AdjLand, data=trainfull)

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

setwd("C:/Users/utilisateur/Desktop/handson-ml2/HousePrices/R")

#on crée un dataframe avant de le sauver

prediction<-data.frame(SalePrice)

# on utilise la fonction write.table, voir ?write.table
# ne pas oublier le .csv à la fin du nom du fichier excel "data.csv"


write.csv(prediction, "predictions_ohe.csv")

# Score Kaggle : 0,14903
