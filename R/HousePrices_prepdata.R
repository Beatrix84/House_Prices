# librairies
library(dplyr)
library(ggplot2)
library(FactoMineR)
library(factoextra)

# Chargement
train <- read.csv("C:/Users/utilisateur/Desktop/HousePrices/trainfull.csv")

# Dimensions
dim(train)

# Summary
summary(train)

# Ah... Il y a beaucoup de données manquantes.
# Combien par colonne?
# nb de donnees manquantes par colonne
colSums(is.na(train))
# Je me rends compte que les colonnes avec beaucoup de NA
# correspondent à la présence/l'absence d'un attribut particulier
# dans la maison. Il serait intéressant de mettre ces colonnes
# A part pour en faire une analyse hors-ACP, parce que
# dans l'ACP, toute ligen avec au moins un NA est éliminée.
# Cependant, l'analyse de ces présence/absence d'attribut
# peut être très intéressante d'un point de vue explication/prédiction
# de SalesPrice

# Etude de SalePrice
hist(train$SalePrice)
# Il y a une queue de distribution sur la droite
# == il y a certaines maisons beaucoup trop chères
# comparées aux autres
# Statistiquement il est plus intéressant de travailler
# sur des données normales (ou gaussiennes)
# Transformation des données
train$logSalePrice<-log(train$SalePrice)
hist(log(train$SalePrice))

# Etude des attributs rares et leur impact sur SalesPrice
# Récupération des colonnes avec NA > 300
AttributRare<-train[,c(which(colSums(is.na(train))>300),82)]
head(AttributRare)
summary(AttributRare)
# La valeur NA dans ces colonnes porte une information
# importante : absence de la feature!
# REmplaçons par "none"
levels(AttributRare$Alley)<-c(levels(AttributRare$Alley),"none")
levels(AttributRare$FireplaceQu)<-c(levels(AttributRare$FireplaceQu),"none")
levels(AttributRare$PoolQC)<-c(levels(AttributRare$PoolQC),"none")
levels(AttributRare$Fence)<-c(levels(AttributRare$Fence),"none")
levels(AttributRare$MiscFeature)<-c(levels(AttributRare$MiscFeature),"none")
AttributRare[is.na(AttributRare)] <- "none"
# Box plots
qplot(Alley, logSalePrice, data=AttributRare, 
      geom="boxplot")
qplot(FireplaceQu, logSalePrice, data=AttributRare, 
      geom="boxplot")
qplot(PoolQC, logSalePrice, data=AttributRare, 
      geom="boxplot")
qplot(Fence, logSalePrice, data=AttributRare, 
      geom="boxplot")
qplot(MiscFeature, logSalePrice, data=AttributRare, 
      geom="boxplot")


# On passe à l'autre partie du jeu de données
# Elimination des colonnes avec NA > 300
TrainFull<-train[,which(colSums(is.na(train))<300)]
dim(TrainFull)
TrainFull<-TrainFull[complete.cases(TrainFull),]

# Nombre de lignes restantes entières
# après élimination
# des colonnes avec données manquantes
length(which(complete.cases(TrainFull)==T))

# Récupération des colonnes numériques
trainNum<-select_if(TrainFull, is.numeric)
dim(trainNum)

# Summary
summary(trainNum)
# JE me rends compte qu'il y a pas mal de
# 3rd Quartile à zéro. Cela dénote 
# des variables avec beaucoup de zéro.

# Jeter un coup d'oeil aux variables avec 
# Beaucoup de zéros
colSums(trainNum == 0, na.rm=T)


# Var. déjà exploitées : PoolArea, MiscVal, FirePlaces.
# On les élimine.

# Var. qui dépendent de la présence/absence d'une
# feature : ScreenPorch, X3SsnPorch, EnclosedPorch,
#           OpenPorchSF, WoodDeckSF, HalfBath, BsmtHalfBath
#           LowQualFinSF, BsmtFullBath, BsmtFinSF2, BsmtFinSF1
# Solution 1: transformer en présence/absence de feature
#             et dessiner des boxplots de logSalesPrce
#             en fonction de chaque feature binarisée,
#             puis éliminer les colonnes pour l'ACP'
# Solution 2: créer des classes de score pour chaque feature
#             exemple : 0 pour 0, 1 pour 0 à 150, 2 pour 150 à
#             + l'infini. Définir les intervalles en se basant
#             sur les médianes/quartiles. Faire des boxplots aussi.

# Var. quali : MoSold. Solution : éliminer de l'ACP, 
#              Etudier à part logSalePrice en fonction de MoSold
#              Ou de MoSold réparti en saisons plus grossières
trainNum$MoSoldFac<-factor(trainNum$MoSold)

qplot(MoSoldFac, logSalePrice, data=trainNum, 
      geom=c("violin","boxplot"))
qplot(MoSold, logSalePrice, data=trainNum,
      geom=c("point", "smooth"))


# Eliminer toutes les colonnes avec >>0 pour l'ACP
# Elimination également des MoSold et MoSoldFac
colSums(trainNum == 0, na.rm=T)
dataACP<-trainNum[,c(which(colSums(trainNum == 0, na.rm=T)<300))]
dataACP<-select(dataACP, -MoSold,-MoSoldFac, -Id, -SalePrice)
dim(dataACP)

# ACP
cor(dataACP)
res.pca<-PCA(dataACP)
fviz_pca_var(res.pca, select.var=list(contrib=10),repel=T)
# Un faisceau de variables li�es aux garages est corr�l� � logSalePrice
# Colorons par quartier, sur un biplot
fviz_pca_biplot(res.pca,select.var=list(contrib=10),
                select.ind=list(contrib=200),
                label="var",
                col.ind=TrainFull$Neighborhood)

# Dimensions 3 et 4:
fviz_pca_biplot(res.pca, axes=c(3,4), select.var=list(contrib=10),
                select.ind=list(contrib=200),
                label="var",
                col.ind=TrainFull$Neighborhood)


# R�gression
TrainFull<-train[,which(colSums(is.na(train))<300)]
datareg<-data.frame(TrainFull,AttributRare[,-ncol(AttributRare)])
datareg<-datareg[,c(which(colSums(datareg == 0, na.rm=T)<300))]
datareg$MoSoldFac<-factor(datareg$MoSold)
datareg<-select(datareg, -Id,-MoSold,-SalePrice)
reg1<-lm(logSalePrice~., data=datareg)

# Oups certaines colonnes sont constantes.
# La fonction suivante permet de les d�tecter facilement
library(caret)
nearZeroVar(datareg, saveMetrics=T)
datareg<-select(datareg, -Utilities)
reg1<-lm(logSalePrice~., data=datareg)
# Checkons les VIF
library(car)
vif(reg1)
# Oups des variables alias�es ont �t� d�tect�es. Pas bien.
# Variables alias�es = variables sensiblement identiques � une addition ou une multiplication près
# Le script suivant permet d'�liminer les redondances
alias(reg1)
# Variables num�riques
dataNum<-select_if(datareg, is.numeric)
matrice.cor <- cor(dataNum, use = "pairwise.complete.obs")
library(corrplot)
corrplot(matrice.cor, method="circle", tl.cex=0.5)
# findCorrelation (ci-dessous) fait partie du package caret
correlations.fortes <- findCorrelation(matrice.cor, cutoff = 0.6)
colnames(dataNum)[correlations.fortes]
# On �limine les colonnes correspondantes dans le jeu de données
datareg<-select(datareg, -GrLivArea, -GarageCars, -X1stFlrSF,-GarageYrBlt,-TotRmsAbvGrd)
# On relance la régression + VIF
reg1<-lm(logSalePrice~., data=datareg)
# Checkons les VIF
vif(reg1)
# ça ne marche toujours pas :(
summary(reg1)
# Aaah au fait les alias concernent des variables quali: Exterior1st
# Et Electrical
datareg<-select(datareg, -Electrical, -Exterior1st)
reg1<-lm(logSalePrice~., data=datareg)
# Checkons les VIF
vif(reg1)
# Virons MSSubClass
datareg<-select(datareg, -MSSubClass)
reg1<-lm(logSalePrice~., data=datareg)
summary(reg1)
# La fonction Anova est plus pratique pour 
# Tester la significativité des var. explicatives cat�gorielles
library(car)
Anova(reg1)
# Pour voir la direction de l'influence d'une var quanti sur la var. � expliquer, 
# Regarder les coefficients du summary.
# Pour visualiser la direction de l'influence d'une cat�gorielle, faites des boxplot. 
# Exemple pour MSZoning
library(ggplot2)
qplot(MSZoning, logSalePrice, data=datareg, 
      geom="boxplot")
# Diagnostic
plot(reg1, 1)
# Les observations 826 et 633 sont trop turbulentes
# Eventuellement les �liminer et reprendre le calcul

# Autres outils de régression: voir fiches r�sum� page 18

