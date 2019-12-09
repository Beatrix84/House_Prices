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

### Pandas:

 * Houseprices_ML_Mastery.ipynb ( Chapters: 5,6,7 ML book)
 * Houseprices_preparationdesdonnees.ipynb

 * Keras:
  * House_prices_challenge_Keras_1.ipynb
    - Kaggle public score : 0.19288
  * House-Prices-Keras-Feat_Num.ipynb
    - Kaggle score estimate : 0.149844
  * HousePrices_Keras-Allnum.ipynb
    - Kaggle score : 0.14182
  * HousePrices_Keras-Allnum-logoutput.ipynb
    - Kaggle score : 0.14387
  * HousePrices_Keras_10features.ipynb
    - Kaggle score : 0.17197

 * Scikit-learn:
  * Houseprices_Linear_Regression_Sklearn.ipynb

 * Xgboost:
  * HousePrices_XGBoost.ipynb
    - Kaggle score : 0.13504
