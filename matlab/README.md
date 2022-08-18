# A quick guide to MATLAB for running Classical Machine Learning algorithms


### Install:
Matlab is available for Queen's Student at free of cost. You may find additional instructions to download and install Matlab here: https://queensuca.sharepoint.com/sites/software-centre/SitePages/MATLAB.aspx

### Dataset:
We have a Human Activity Recognition dataset `raw_accelerometer_dataset.csv`, obtained from the [UCI repository](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphone). This is a small subset of original dataset, using for a simple demonstrative purpose. It has 3 axis of accelerometer data and 6 different labels as follows: 'bike', 'sit', 'stairsdown', 'stairsup', ‘stand', 'walk'.

### Feature Extraction:
We aim to extract simple features from the raw signals. In particular, we extract 5 features (maximum, minimum, mean, standard deviation, and skewness) from each axis of the accelerometer data. You can simply run the `feature_extraction.m` file to extract the setup features. Moreover, you can modify the `feature_extraction.m` file to extract additional statistical features as well.

### Train and Validation:
Matlab comes with pre-installed machine learning algorithms defined. Here are a few examples to use different machine learning algorithms using Matlab. You can find the complete code in `main.m`

**SVM**
```
% with a linear kernel
model = templateSVM('KernelFunction', 'linear', 'PolynomialOrder', [], 'KernelScale', 'auto', 'BoxConstraint', 1,'Standardize', true);

% with a gaussian kernel
model = templateSVM('KernelFunction', 'gaussian', 'PolynomialOrder', [], 'KernelScale', 'auto', 'BoxConstraint', 1,'Standardize', true);

% with a polynomial kernel of order 3
model = templateSVM('KernelFunction', 'polynomial', 'PolynomialOrder', 3, 'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', true);

% train the model
model_trained = fitcecoc(x_train, y_train, 'Learners', model, 'Coding', 'onevsone'); 
```

**KNN**
```
% with a k=5
model = templateKNN('Distance', 'euclidean', 'NumNeighbors', 5);

% with a k=1
model = templateKNN('Distance', 'euclidean', 'NumNeighbors', 1);

% train the model
model_trained = fitcecoc(x_train, y_train, 'Learners', model);
```

**Naive Bayes**
```
% train the model
model_trained = fitcnb(x_train,y_train, 'DistributionNames', 'normal');
```

**decision tree**
```
% train the model
model_trained = fitctree(x_train,y_train, 'MaxNumSplits', 8, 'MinLeafSize', 1, 'MinParentSize', 10);
```

