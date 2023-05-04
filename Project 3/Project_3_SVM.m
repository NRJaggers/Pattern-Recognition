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
features_train0 = get_features(binary_imtrain0);
features_train1 = get_features(binary_imtrain1);
features_train2 = get_features(binary_imtrain2);

%%
featarry_train0 = make_feat_array(features_train0);
featarry_train1 = make_feat_array(features_train1);
featarry_train2 = make_feat_array(features_train2);

%%
%initialize variables for training
%Y is augmented matrix holding (+/-)1's and two values to describe digit 
%in each row 

class_1 = [ones(length(featarry_train0(:,3)),1) featarry_train0(:,3) featarry_train0(:,7)];
class_2 = [-ones(length(featarry_train1(:,3)),1) -featarry_train1(:,3) -featarry_train1(:,7)];
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
%default for two class classifier is linear kernel, for one class
%classifier it is gaussian (rbf - radial basis function) kernel

%%
%using mathworks example to create plot 
sv = SVMModel.SupportVectors; % Support vectors
beta = SVMModel.Beta; % Linear predictor coefficients
b = SVMModel.Bias; % Bias term

%%
%make scatter plot like in project 1
% Create scatter plot 0 and 1
figure;
hold on;
first = 3;
second = 7;
scatter(featarry_train0(:,first),featarry_train0(:,second));
scatter(featarry_train1(:,first),featarry_train1(:,second));
legend("0","1");
hold off
%%
hold on
color = [0.8500 0.3250 0.0980 ; 0 0.4470 0.7410 ];
gscatter(features(:,1),features(:,2),classification, color)
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)

%%
%X1 = linspace(min(features(:,1)),max(features(:,1)),100);
X1 = linspace(-1,2,100); %jank to make margins extend whole plot in next section
X2 = -(beta(1)/beta(2)*X1)-b/beta(2);
plot(X1,X2,'-')
%%
m = 1/sqrt(beta(1)^2 + beta(2)^2);  % Margin half-width
X1margin_low = X1+beta(1)*m^2;
X2margin_low = X2+beta(2)*m^2;
X1margin_high = X1-beta(1)*m^2;
X2margin_high = X2-beta(2)*m^2;
plot(X1margin_low,X2margin_low,'b--')
plot(X1margin_high,X2margin_high,'r--')
xlabel('feature 1')
ylabel('feature 2')
legend('1','0','Support Vector', ...
    'Boundary Line','Upper Margin','Lower Margin')
hold off

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
features_test0 = get_features(binary_imtest0);
features_test1 = get_features(binary_imtest1);
%features_2 = get_features(binary_im2);

%%
featarry_test0 = make_feat_array(features_test0);
featarry_test1 = make_feat_array(features_test1);
%featarry_2 = make_feat_array(features_2);

%%
class_1 = [ones(length(featarry_test0(:,3)),1) featarry_test0(:,3) featarry_test0(:,7)];
class_2 = [-ones(length(featarry_test1(:,3)),1) -featarry_test1(:,3) -featarry_test1(:,7)];
Y = [class_1; class_2];

% the predictors in the matrix X and the class labels in vector Y
test_features = Y(:,1).*Y(:,2:3); % matrix X
test_classification = Y(:,1); % matrix Y

%%
%make scatter plot like in project 1
% Create scatter plot 0 and 1
figure;
hold on;
first = 3;
second = 7;
scatter(featarry_test0(:,first),featarry_test0(:,second));
scatter(featarry_test1(:,first),featarry_test1(:,second));
legend("0","1");
hold off

%%
hold on
color = [0.8500 0.3250 0.0980 ; 0 0.4470 0.7410 ];
gscatter(test_features(:,1),test_features(:,2),test_classification,color)
%plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)

%X1 = linspace(min(features(:,1)),max(features(:,1)),100);
X1 = linspace(-1,2,100); %jank to make margins extend whole plot in next section
X2 = -(beta(1)/beta(2)*X1)-b/beta(2);
plot(X1,X2,'-')
m = 1/sqrt(beta(1)^2 + beta(2)^2);  % Margin half-width
X1margin_low = X1+beta(1)*m^2;
X2margin_low = X2+beta(2)*m^2;
X1margin_high = X1-beta(1)*m^2;
X2margin_high = X2-beta(2)*m^2;
plot(X1margin_low,X2margin_low,'b--')
plot(X1margin_high,X2margin_high,'r--')
xlabel('feature 1')
ylabel('feature 2')
legend('0','1', ...
    'Boundary Line','Upper Margin','Lower Margin')
hold off

%%
% classify test data
[label,score] = predict(SVMModel,test_features);

%find how many samples are misclassified
miss_samples = find(test_classification ~= label);
miss_count = length(miss_samples);

classification_error = (miss_count/length(label))*100;

%% Train a linear kernel SVM classifier - 2
SVMModel = fitcsvm(features,classification, "KernelFunction", "rbf", "BoxConstraint", 10); 
%default for two class classifier is linear kernel, for one class
%classifier it is gaussian (rbf - radial basis function) kernel

%using mathworks example to create plot 
sv = SVMModel.SupportVectors; % Support vectors
beta = SVMModel.Beta; % Linear predictor coefficients
b = SVMModel.Bias; % Bias term

%%
hold on
gscatter(features(:,1),features(:,2),classification)
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)

%X1 = linspace(min(features(:,1)),max(features(:,1)),100);
X1 = linspace(-1,2,100); %jank to make margins extend whole plot in next section
X2 = -(beta(1)/beta(2)*X1)-b/beta(2);
plot(X1,X2,'-')
m = 1/sqrt(beta(1)^2 + beta(2)^2);  % Margin half-width
X1margin_low = X1+beta(1)*m^2;
X2margin_low = X2+beta(2)*m^2;
X1margin_high = X1-beta(1)*m^2;
X2margin_high = X2-beta(2)*m^2;
plot(X1margin_high,X2margin_high,'b--')
plot(X1margin_low,X2margin_low,'r--')
xlabel('feature 1')
ylabel('feature 2')
legend('0','1','Support Vector', ...
    'Boundary Line','Upper Margin','Lower Margin')
hold off

%%
hold on
gscatter(test_features(:,1),test_features(:,2),test_classification)
%plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)

%X1 = linspace(min(features(:,1)),max(features(:,1)),100);
X1 = linspace(-1,2,100); %jank to make margins extend whole plot in next section
X2 = -(beta(1)/beta(2)*X1)-b/beta(2);
plot(X1,X2,'-')
m = 1/sqrt(beta(1)^2 + beta(2)^2);  % Margin half-width
X1margin_low = X1+beta(1)*m^2;
X2margin_low = X2+beta(2)*m^2;
X1margin_high = X1-beta(1)*m^2;
X2margin_high = X2-beta(2)*m^2;
plot(X1margin_high,X2margin_high,'b--')
plot(X1margin_low,X2margin_low,'r--')
xlabel('feature 1')
ylabel('feature 2')
legend('0','1', ...
    'Boundary Line','Upper Margin','Lower Margin')
hold off

%%
% classify test data
[label,score] = predict(SVMModel,test_features);

%find how many samples are misclassified
miss_samples = find(test_classification ~= label);
miss_count = length(miss_samples);

%%

