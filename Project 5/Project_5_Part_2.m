%% Project 5
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Group 4: Nathan Jaggers, Nicholas Brunet, Jordan Rubio Perlas
%
% Description: See coresponding document <Can add description later>
%% Part 2
close all;
clear;
clc;

%%
% load data set
wdbc = importdata("wdbc.data");

%separate benign and malignant
pos_data = wdbc.data((wdbc.textdata(:,2))=="M",:);
neg_data = wdbc.data((wdbc.textdata(:,2))=="B",:);

%%
%create histograms to compare positive and negative data to find good
%discriminant features

for feature=1:30
    figure;
    hold on;
    histogram(pos_data(:,feature));
    histogram(neg_data(:,feature));
    xlabel("Value");
    ylabel("Frequency");
    figtitle = sprintf("Feature %d")
    title("Feature ",feature);
    hold off;
end

%%
% create data set for training and test

pos80 = round(length(pos_data)*0.8);
neg80 = round(length(neg_data)*0.8);

pos_Train = (pos_data(1:pos80,:));
neg_Train = (neg_data(1:neg80,:));

pos_Test = (pos_data(pos80:length(pos_data),:));
neg_Test = (neg_data(neg80:length(neg_data),:));

train_data = [pos_Train; neg_Train];
test_data = [pos_Test; neg_Test];

%getting prior probabilities from ratios in training data
pos_prior = pos80/(pos80+neg80);
neg_prior = neg80/(pos80+neg80);

%%
%ones that we like: 28, 23, 21ish, 8, 3

%trying to use features 8 and 28 
%make bayesian characteristics mu and sigma
pos_feat = [pos_Train(:,8) pos_Train(:,28)];
neg_feat = [neg_Train(:,8) neg_Train(:,28)];

%%
[predict,~] = dichotomizer(pos_feat,neg_feat,pos_prior,neg_prior);

C = confusionmat(Y, predict);
confusionchart(C);

%%
[pos_Test_samples,~] = size(pos_Test);
[neg_Test_samples,~] = size(neg_Test);
test_class = [ones(1,pos_Test_samples) zeros(1,neg_Test_samples)];

%Confusion matrix for TP, TN, FP, FN
C = confusionmat(test_class,test_class);
confusionchart(C);

%ROC curve

%%
%general dichotomizer
function [prediction, accuracy] = dichotomizer(w1_features, w2_features, w1_Prior, w2_Prior)
    %first two arguments are feature matricies for the two classes
    %last two arguments are priors for the two classes (scalars)

    %calculate mean and cov to train dichotomizer
    w1_mean = mean(w1_features)';
    w2_mean = mean(w2_features)';

    w1_cov = cov(w1_features);
    w2_cov = cov(w2_features);

    %create input matrix, augmented matrix, and class prediction matrix
    X = [w1_features; w2_features];
    Y = [ones(size(w1_features, 1), 1); zeros(size(w2_features, 1), 1)];
    prediction = [zeros(size(Y, 1), 1)];

    %initialize correct counter
    correct = 0;
    
    for i = 1:size(X, 1)
        x = X(i,:)';
        y = Y(i);
        g1_result = g(x, w1_mean, w1_cov, w1_Prior);
        g2_result = g(x, w2_mean, w2_cov, w2_Prior);
        prediction(i) = g1_result - g2_result > 0;
        correct = correct + (prediction(i) == y);
    end
    accuracy = correct / size(X, 1);
    fprintf("Accuracy: %.2f\n", accuracy);
end

% Calculate parameters once in separate function if this takes too long
function result = g(x, mean, cov, P)
    cov_i = inv(cov);
    W = -0.5 * cov_i;
    w = cov_i * mean;
    w0 = -0.5 * (mean' * cov_i * mean) - 0.5 * log(det(cov)) + log(P);
    result = x'*W*x + w'*x + w0;
end
