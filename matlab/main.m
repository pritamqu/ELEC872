clc
clear all
close all

% import the pre-extracted features 
dataset = readtable('full_dataset_features.csv');

% visualize the dataset
disp(dataset(1:5,:));

% find how many classes the dataset has
numb_of_classes = unique(dataset.activity);

% find how many subjects there are
subjects = unique(dataset.subject_id);

% get the total number of records
total_records = size(dataset, 1);

% set number of folds for training-testing
total_fold = 10;

% we will perform 10Fold cross-validation as our validation method
indices = crossvalind('Kfold',total_records,total_fold);

final_accuracy = 0;
final_precision = 0;
final_recall = 0;
final_f1_score = 0;

tic

for i = 1:total_fold
    % select the test indices
    test = (indices == i); 
    % select train indices, which are total indices - test indices
    train = ~test;
    % select x_train, y_train and x_test, y_test from the dataset
    x_train = dataset(train, 1:18);
    y_train = dataset.activity(train);
    x_test  = dataset(test, 1:18);
    y_test  = dataset.activity(test);
    
%% ------------> Build your model here <------------


% svm
% model = templateSVM('KernelFunction', 'linear', 'PolynomialOrder', [], 'KernelScale', 'auto', 'BoxConstraint', 1,'Standardize', true);
% model = templateSVM('KernelFunction', 'gaussian', 'PolynomialOrder', [], 'KernelScale', 'auto', 'BoxConstraint', 1,'Standardize', true);
% model = templateSVM('KernelFunction', 'polynomial', 'PolynomialOrder', 3, 'KernelScale', 'auto', 'BoxConstraint', 1, 'Standardize', true);
% model_trained = fitcecoc(x_train, y_train, 'Learners', model, 'Coding', 'onevsone'); 

% knn
% model = templateKNN('Distance', 'euclidean', 'NumNeighbors', 5);
% model = templateKNN('Distance', 'euclidean', 'NumNeighbors', 1);
% model_trained = fitcecoc(x_train, y_train, 'Learners', model);


% naive bayes
% model_trained = fitcnb(x_train,y_train, 'DistributionNames', 'normal');


% decision tree
% model = templateTree('MaxNumSplits', 5); 
% model_trained = fitcecoc(x_train,y_train,'Learners',model);
% model_trained = fitctree(x_train,y_train, 'MaxNumSplits', 8, 'MinLeafSize', 1, 'MinParentSize', 10);


% rng(1);
% model_trained = fitctree(x_train,y_train, 'CrossVal','on', 'MaxNumSplits', 8, 'MinLeafSize', 1, 'MinParentSize', 10);
% view(model_trained.Trained{1},'Mode','graph')

    %% evaluation
    
    % get the predicted value from test data    
    y_test_pred = model_trained.predict(x_test);
    
    % get predicted value from training data
    y_train_pred = model_trained.predict(x_train);
    
    % compute confusion matrix from true and predicted value
    train_confmat = confusionmat(y_train, y_train_pred);
    test_confmat = confusionmat(y_test, y_test_pred);
    
    te_acc = trace(test_confmat)/sum(test_confmat, 'all');
    tr_acc = trace(train_confmat)/sum(train_confmat, 'all');
    fprintf('Classifier output fold %d - test acc: %.2f%% - train acc: %.2f%% \n', i, te_acc*100, tr_acc*100);
    
    % calculate average precision, recall and f1 score of all the classes from test confusion matrix
    
    % initialization 
    each_fold_precision = 0;
    each_fold_recall = 0;
    each_fold_f1_score = 0;
    for c = 1:size(test_confmat, 1)
        
        % calculate precision, recall and f1 score for each class
        correctly_classified = test_confmat(c, c);
        prdicted = sum(test_confmat(c, :), 'all');
        actual   = sum(test_confmat(:, c), 'all');
        precision = correctly_classified/prdicted;
        recall    = correctly_classified/actual;
        f1_score  = (2 * precision * recall) / (precision + recall);
        
        each_fold_acc = te_acc;
        
        % getting the average of precision, recall and f1 score        
        each_fold_precision = each_fold_precision + precision;
        each_fold_recall    = each_fold_recall + recall;
        each_fold_f1_score  = each_fold_f1_score + f1_score;
    
    end
    
    final_accuracy = final_accuracy + each_fold_acc;
    final_precision = final_precision + each_fold_precision/size(test_confmat, 1);
    final_recall    = final_recall + each_fold_recall/size(test_confmat, 1);
    final_f1_score  = final_f1_score + each_fold_f1_score/size(test_confmat, 1);
    
end

% final result averaged after 10-fold cross validation
final_accuracy = final_accuracy/total_fold;
final_precision= final_precision/total_fold;
final_recall = final_recall/total_fold;
final_f1_score = final_f1_score/total_fold;

% note this final output

fprintf('Classifier final output Test: \n Accuracy:  %.2f%%\n Precision: %.2f%%\n Recall:    %.2f%%\n F1-Score:  %.2f \n', ...
    final_accuracy*100, final_precision*100, final_recall*100, final_f1_score);

toc


