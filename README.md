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
    - BigMl was used to train the dataset without any pretreatment, with deepnet model. We also evaluate the prediction through by using error metrics (MSE and MAE).


## Analysis, modifications and new predictions:

### R platform:

 * HousePrices_prepdata.R: Analysis and treatment of datasets (final=55 features)
 * HousePrices_ModelVal.R: Train the linear model (lm) on the val set
 * HousePrices_Modellm.R: Prediction on test set
   - Kaggle public score: 0.14431
 * HousePrices_ModelVal_ohe.R: Train the linear model (lm) on the val set (all features: categorical and numerical)
 * HousePrices_Modellm_ohe.R: Prediction on test set
   - Kaggle score: 0.14903

### Pandas:

 * Houseprices_ML_Mastery.ipynb ( Chapters: 5,6,7 of Machine Learning Mastery with Python)
   - We used the ML book to visualize data in order to find correlations between features and to pretreat them (rescale, normalization, binarization)
 * Data_Exploration_Selection.ipynb
   - In this section we went deeper in the analysis of the dataset. Through correlation matrix, we have selected 5 features.
 * Houseprices_preparationdesdonnees.ipynb
   - Transform the categorical features to numericals one with pandas.get.dummies
 * Houseprices_preparationdesdonnees-OneHotEncoder.ipynb
   - Transform the categorical features to numericals one with OneHotEncoder (all train features)

### Xgboost/linear regression:

 * Houseprices_Linear_Regression_Sklearn.ipynb
   - MAE : 211550/R-MAE : 16681
   - Test with linear regression to compare with R
 * HousePrices_XGBoost.ipynb
   - Kaggle score : 0.13504
   - best XGB model with most relevant features
 
### Keras:

 * House_prices_challenge_Keras_1.ipynb
   - Kaggle public score : 0.19288
   - Using the dataset modified in 'HousePrices_prepdata.R', categorical features were transformed in numericals and after correlation matrix, only 10 features were used in the neural network model.
 * KerasPrediction_Exploration_Selection.ipynb
   - Kaggle score : 0.18967
   - We took the modifications done on the 'Data_Exploration_Selection.ipynb' notebook to train the dataset with NN model using Keras.
 * House-Prices-Keras-Feat_Num.ipynb
   - Kaggle score estimate : 0.149844
   - Only numerical features were taken to train the NN model.
 * HousePrices_Keras-Allnum.ipynb
   - Kaggle score : 0.14182
   - Keras model on just numerical features
 * HousePrices_Keras-Allnum-logoutput.ipynb
   - Kaggle score : 0.14387
   - Keras model on just numerical features with log on the SalePrice
 * HousePrices_Keras_10features.ipynb
   - Kaggle score : 0.17197
   - Keras model with the first 10 more correlated numerical features, creation of a new feature, only 8 features used for the neural network model.
 * HousePrices_Keras-Allfeat-ohe.ipynb
   - Kaggle score : 0.15647
   - Keras model on the OneHotEncoder dataset


