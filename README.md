# How to start the project

## Create a docker folder with:
* docker.compose.yml
* Dockerfile
* requirements 
* auth.env document:
    BIGML_API_KEY=()
    BIGML_USERNAME=()
    KAGGLE_USERNAME=()
    KAGGLE_KEY=()

## In House_prices/docker:
    docker-compose up --build

# Project

## In House_prices/docker:
    docker-compose up 

## First submission to Kaggle using BigML without modifications:
 
 * House_prices_challenge.ipynb
    - Kaggle public score: 0.15452

## Analysis, modifications and new predictions:

### R platform:

 * HousePrices_prepdata: Analysis and treatment of datasets (final=55 features)
 * HousePrices_ModelVal.R: Train the linear model (lm) on the val set
 * HousePrices_Modellm.R: Prediction on test set
   - Kaggle public score: 0.14431
 * HousePrices_ModelVal_ohe.R: Train the linear model (lm) on the val set (all features: categorical and numerical)
 * HousePrices_Modellm_ohe.R: Prediction on test set
   - Kaggle score: 0.14903

### Pandas:

 * Houseprices_ML_Mastery.ipynb ( Chapters: 5,6,7 ML book)
 * Data_Exploration_Selection.ipynb
 * Houseprices_preparationdesdonnees.ipynb
 * Houseprices_preparationdesdonnees-OneHotEncoder.ipynb

### Xgboost/linear regression:

 * Houseprices_Linear_Regression_Sklearn.ipynb
   - MAE : 211550/R-MAE : 16681
 * HousePrices_XGBoost.ipynb
   - Kaggle score : 0.13504
 
### Keras:

 * House_prices_challenge_Keras_1.ipynb
   - Kaggle public score : 0.19288
 * KerasPrediction_Exploration_Selection.ipynb
   - Kaggle score : 0.18967
 * House-Prices-Keras-Feat_Num.ipynb
   - Kaggle score estimate : 0.149844
 * HousePrices_Keras-Allnum.ipynb
   - Kaggle score : 0.14182
 * HousePrices_Keras-Allnum-logoutput.ipynb
   - Kaggle score : 0.14387
 * HousePrices_Keras_10features.ipynb
   - Kaggle score : 0.17197
 * HousePrices_Keras-Allfeat-ohe.ipynb
   - Kaggle score : 0.15647


