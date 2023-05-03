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
%% SVM
close all;
clear;
clc;
%%
%read in image
im0 = imread("mnist_train0.jpg");
im1 = imread("mnist_train1.jpg");
im2 = imread("mnist_train2.jpg");

%%
%create binary image and show results
binary_im0 = imbinarize(im0);
%%imshow(binary_im0);
binary_im1 = imbinarize(im1);
%%imshow(binary_im1);
binary_im2 = imbinarize(im2);
%%imshow(binary_im2);

%%
features_0 = get_features(binary_im0);
features_1 = get_features(binary_im1);
features_2 = get_features(binary_im2);

%%
featarry_0 = make_feat_array(features_0);
featarry_1 = make_feat_array(features_1);
featarry_2 = make_feat_array(features_2);

%%
%initialize variables for training
%Y is augmented matrix holding (+/-)1's and two values to describe digit 
%in each row 

class_1 = [ones(length(featarry_0(:,3)),1) featarry_0(:,2) featarry_0(:,7)];
class_2 = [-ones(length(featarry_0(:,3)),1) -featarry_0(:,2) -featarry_0(:,7)];
Y = [class_1; class_2];


%a is weight (column) vector to be adjusted
%rows of a should equal the rows of Y
a = zeros(size(Y,2), 1);

%%
% the predictors in the matrix X and the class labels in vector Y

features = Y(:,1).*Y(:,2:3); % matrix X
classification = Y(:,1); % matrix Y

%% Train a linear kernel SVM classifier
SVMModel = fitcsvm(features,classification);

%%
%using mathworks example to create plot 
sv = SVMModel.SupportVectors; % Support vectors
beta = SVMModel.Beta; % Linear predictor coefficients
b = SVMModel.Bias; % Bias term

%%
hold on
gscatter(features(:,1),features(:,2),classification)
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)

%%
feature1 = linspace(min(features(:,1)),max(features(:,1)),100);
feature2 = -(beta(1)/beta(2)*feature1)-b/beta(2);
plot(feature1,feature2,'-')
%%
m = 1/sqrt(beta(1)^2 + beta(2)^2);  % Margin half-width
X1margin_low = feature1+beta(1)*m^2;
X2margin_low = feature2+beta(2)*m^2;
X1margin_high = feature1-beta(1)*m^2;
X2margin_high = feature2-beta(2)*m^2;
plot(X1margin_high,X2margin_high,'b--')
plot(X1margin_low,X2margin_low,'r--')
xlabel('feature 1')
ylabel('feature 2')
legend('0','1','Support Vector', ...
    'Boundary Line','Upper Margin','Lower Margin')
hold off

%% classifying using SVM
% get the test data set features
im0 = imread("mnist_test0.jpg");
im1 = imread("mnist_test1.jpg");
im2 = imread("mnist_test2.jpg");

%create binary image and show results
binary_im0 = imbinarize(im0);
%%imshow(binary_im0);
binary_im1 = imbinarize(im1);
%%imshow(binary_im1);
binary_im2 = imbinarize(im2);
%%imshow(binary_im2);

%%
features_0 = get_features(binary_im0);
features_1 = get_features(binary_im1);
%features_2 = get_features(binary_im2);

%%
featarry_0 = make_feat_array(features_0);
featarry_1 = make_feat_array(features_1);
%featarry_2 = make_feat_array(features_2);

%%
class_1 = [ones(length(featarry_0(:,3)),1) featarry_0(:,2) featarry_0(:,7)];
class_2 = [-ones(length(featarry_0(:,3)),1) -featarry_0(:,2) -featarry_0(:,7)];
Y = [class_1; class_2];

% the predictors in the matrix X and the class labels in vector Y
test_features = Y(:,1).*Y(:,2:3); % matrix X

%%
% classify test data
[label,score] = predict(SVMModel,test_features);
