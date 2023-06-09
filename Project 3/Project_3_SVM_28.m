%% Project 3
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Group 4: Nathan Jaggers, Tre Carmichael, Nickolas Ogilvie
%
% Description: See coresponding document <Can add description later>
% 0 & 1 - filled area, minor axis length, eccentricity
% 0 & 2 - circularity, perimeter, filled area
%% SVM 28 x 28
close all;
clear;
clc;
%%
%read in image
im_train0 = imread("mnist_train0.jpg");
im_train1 = imread("mnist_train1.jpg");
im_train2 = imread("mnist_train2.jpg");

%%
%create binary image and show results
binary_imtrain0 = imbinarize(im_train0);
%%imshow(binary_im0);
binary_imtrain1 = imbinarize(im_train1);
%%imshow(binary_im1);
binary_imtrain2 = imbinarize(im_train2);
%%imshow(binary_im2);

%%
features_train0 = get_features_28(binary_imtrain0);
features_train1 = get_features_28(binary_imtrain1);
features_train2 = get_features_28(binary_imtrain2);

%%
%initialize variables for training
%Y is augmented matrix holding (+/-)1's and two values to describe digit 
%in each row 

class_1 = [ones(length(features_train0),1) features_train0];
class_2 = [-ones(length(features_train2),1) features_train2];
Y = [class_1; class_2];

%%
% the predictors in the matrix X and the class labels in vector Y

features = Y(:,2:end); % matrix X
classification = Y(:,1); % matrix Y

%% Train a linear kernel SVM classifier
SVMModel = fitcsvm(features,classification); 
%default for two class classifier is linear kernel, for one class
%classifier it is gaussian (rbf - radial basis function) kernel

%% classifying using SVM
% get the test data set features
im_test0 = imread("mnist_test0.jpg");
im_test1 = imread("mnist_test1.jpg");
im_test2 = imread("mnist_test2.jpg");

%create binary image and show results
binary_imtest0 = imbinarize(im_test0);
%%imshow(binary_im0);
binary_imtest1 = imbinarize(im_test1);
%%imshow(binary_im1);
binary_imtest2 = imbinarize(im_test2);
%%imshow(binary_im2);

%%
features_test0 = get_features_28(binary_imtest0);
features_test1 = get_features_28(binary_imtest1);
features_test2 = get_features_28(binary_imtest2);

%%
class_1 = [ones(length(features_test0),1) features_test0];
class_2 = [-ones(length(features_test2),1) features_test2];
Y = [class_1; class_2];

% the predictors in the matrix X and the class labels in vector Y
test_features = Y(:,2:end); % matrix X
test_classification = Y(:,1); % matrix Y

%%
% classify test data
[label,score] = predict(SVMModel,test_features);

%find how many samples are misclassified
miss_samples = find(test_classification ~= label);
miss_count = length(miss_samples);

classification_error = (miss_count/length(label))*100;
