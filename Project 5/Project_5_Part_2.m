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
feature_overlap = size(neg_data,2);
for feature=1:30
    figure;
    hold on;
    histogram(pos_data(:,feature));
    histogram(neg_data(:,feature));
    xlabel("Value");
    ylabel("Frequency");
    %figtitle = sprintf("Feature %d");
    title("Feature ",feature);
    hold off;
    feature_overlap(feature) = hist_overlap(pos_data(:,feature), neg_data(:,feature));

end

%%
%use overlap to  find best features
best_features = zeros(5,2);
min_Fill = max(feature_overlap);
tempMat = feature_overlap;
for i=1:size(best_features,1);
[best_features(i,1), best_features(i,2)] = min(tempMat);
tempMat(best_features(i,2)) = min_Fill;
fprintf("Minimums at %d: %f\n",best_features(i,2),best_features(i,1));
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
% pos_prior = pos80/(pos80+neg80);
% neg_prior = neg80/(pos80+neg80);

%%
%ones that we like: 28, 23, 21ish, 8, 3

%trying to use features 8 and 28 
%make bayesian characteristics mu and sigma
feature_1 = 23;
feature_2 = 28;
feature_3 = 8;
% pos_feat = [pos_Train(:,feature_1) pos_Train(:,feature_2)];
% neg_feat = [neg_Train(:,feature_1) neg_Train(:,feature_2)];

pos_feat = [pos_Train(:,feature_1) pos_Train(:,feature_2) pos_Train(:,feature_3)];
neg_feat = [neg_Train(:,feature_1) neg_Train(:,feature_2) neg_Train(:,feature_3)];

%%
%training and set up for dichotomizer
[X, Y, mu_pos, cov_pos, prior_pos, mu_neg, cov_neg, prior_neg] = feat_details(pos_feat,neg_feat); 

%using dichotomizer
[predict,~] = dichotomizer(X, Y, mu_pos, cov_pos, prior_pos, mu_neg, cov_neg, prior_neg);

%showing results through confusion matrix
C = confusionmat(Y, predict);
confusionchart(C,["Benign","Malignant"]);

%%
%using previous training on test set

%make test set feature vectors 
% pos_feat_test = [pos_Test(:,feature_1) pos_Test(:,feature_2)];
% neg_feat_test = [neg_Test(:,feature_1) neg_Test(:,feature_2)];

pos_feat_test = [pos_Test(:,feature_1) pos_Test(:,feature_2) pos_Test(:,feature_3)];
neg_feat_test = [neg_Test(:,feature_1) neg_Test(:,feature_2) neg_Test(:,feature_3)];

%get dataset and augmented matrix from test features
[X_test, Y_test, ~] = feat_details(pos_feat_test,neg_feat_test); 

%classify test set
[predict,~] = dichotomizer(X_test, Y_test, mu_pos, cov_pos, prior_pos, mu_neg, cov_neg, prior_neg);

%showing results through confusion matrix (TP, TN, FP, FN)
C = confusionmat(Y_test, predict);
confusionchart(C,["Benign","Malignant"]);

%%
%ROC curve
step = 0.05;
prior_list = 0:step:1;
tp_list = length(prior_list);
fp_list = length(prior_list);

for i = 1:length(prior_list)
%gather predictions for different priors
[predict,~] = dichotomizer(X_test, Y_test, mu_pos, cov_pos, prior_list(i), mu_neg, cov_neg, 1-prior_list(i));

%collect TP and FP info for each set of priors
C = confusionmat(Y_test, predict);
tp_list(i) = C(2,2)/(C(2, 2)+ C(2, 1));
fp_list(i) = C(1,2)/(C(1, 2)+ C(1, 1));
end

plot(fp_list,tp_list);
xlabel("False Alarms (FP)");
ylabel("Correct Detections (TP)");

%%
%Naïve Bayes classifier
% cov_pos_naive = [cov(pos_feat(:,1));cov(pos_feat(:,2))];
% cov_neg_naive = [cov(neg_feat(:,1));cov(neg_feat(:,2))];

cov_pos_naive = [cov(pos_feat(:,1));cov(pos_feat(:,2));cov(pos_feat(:,3))];
cov_neg_naive = [cov(neg_feat(:,1));cov(neg_feat(:,2));cov(neg_feat(:,3))];

[predict,~] = naive_bayes(X_test, Y_test, mu_pos, cov_pos_naive, prior_pos, mu_neg, cov_neg_naive, prior_neg);

%showing results through confusion matrix (TP, TN, FP, FN)
C = confusionmat(Y_test, predict);
confusionchart(C,["Benign","Malignant"]);

%%
%ROC curve
step = 0.05;
prior_list = 0:step:1;
tp_list = length(prior_list);
fp_list = length(prior_list);

for i = 1:length(prior_list)
%gather predictions for different priors
[predict,~] = naive_bayes(X_test, Y_test, mu_pos, cov_pos_naive, prior_list(i), mu_neg, cov_neg_naive, 1-prior_list(i));

%collect TP and FP info for each set of priors
C = confusionmat(Y_test, predict);
tp_list(i) = C(2,2)/(C(2, 2)+ C(2, 1));
fp_list(i) = C(1,2)/(C(1, 2)+ C(1, 1));
end

plot(fp_list,tp_list);
xlabel("False Alarms (FP)");
ylabel("Correct Detections (TP)");

%%
%set up for dichotomizer
function [dataset, classification, w1_mean, w1_cov, w1_Prior, w2_mean, w2_cov, w2_Prior] = feat_details(w1_features, w2_features)
    %calculate mean and cov to train dichotomizer
    w1_mean = mean(w1_features)';
    w2_mean = mean(w2_features)';

    w1_cov = cov(w1_features);
    w2_cov = cov(w2_features);

    %priors section
    w1_samples = size(w1_features,1);
    w2_samples = size(w2_features,1);
    w1_Prior = w1_samples/(w1_samples+w2_samples);
    w2_Prior = w2_samples/(w1_samples+w2_samples);

    %create input matrix and augmented matrix
    dataset = [w1_features; w2_features]; %input
    classification = [ones(size(w1_features, 1), 1); zeros(size(w2_features, 1), 1)]; %augmented (Y)
end

%general dichotomizer
function [prediction, accuracy] = dichotomizer(dataset, classification, w1_mean, w1_cov, w1_Prior, w2_mean, w2_cov, w2_Prior)
    %dataset - input data to be classified
    %classification - true classification of samples
    %w1_mean  - mean for class 1 
    %w1_cov   - covariance for class 2
    %w1_Prior - prior for class 1
    %w2_mean  - mean for class 2
    %w2_cov   - covariance for class 2
    %w2_Prior - prior for class 2

    %create class prediction matrix
    prediction = [zeros(size(classification, 1), 1)];

    %initialize correct counter
    correct = 0;
    
    for i = 1:size(dataset, 1)
        x = dataset(i,:)';
        y = classification(i);
        g1_result = g(x, w1_mean, w1_cov, w1_Prior);
        g2_result = g(x, w2_mean, w2_cov, w2_Prior);
        prediction(i) = g1_result - g2_result > 0;
        correct = correct + (prediction(i) == y);
    end
    accuracy = correct / size(dataset, 1);
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

%Naïve Bayes classifier
function [prediction, accuracy] = naive_bayes(dataset, classification, w1_mean, w1_cov, w1_Prior, w2_mean, w2_cov, w2_Prior)
    %dataset - input data to be classified
    %classification - true classification of samples
    %w1_mean  - mean for class 1 
    %w1_cov   - naive covariance for class 2 (one variance for each feature; column vector)
    %w1_Prior - prior for class 1
    %w2_mean  - mean for class 2
    %w2_cov   - covariance for class 2 (one variance for each feature; column vector)
    %w2_Prior - prior for class 2

    %create class prediction matrix
    prediction = [zeros(size(classification, 1), 1)];

    %initialize correct counter
    correct = 0;

    for i = 1:size(dataset, 1)
        x = dataset(i,:)';
        y = classification(i);
        %multiplication pdfs of of first class
        pdf_per_class = (1./(sqrt(2.*pi().*w1_cov))).*exp(-0.5.*((x-w1_mean).^2)./w1_cov);
        pdf_pi = prod(pdf_per_class);
        %discriminant of first class
        g1_result = log(pdf_pi)*w1_Prior;
        
        %multiplication pdfs of of second class
        pdf_per_class = (1./(sqrt(2.*pi().*w2_cov))).*exp(-0.5.*((x-w2_mean).^2)./w2_cov);
        pdf_pi = prod(pdf_per_class);
        %discriminant of second class
        g2_result = log(pdf_pi)*w2_Prior;

        prediction(i) = g1_result - g2_result > 0;
        correct = correct + (prediction(i) == y);
    end
    accuracy = correct / size(dataset, 1);
    fprintf("Accuracy: %.2f\n", accuracy);
end

%% Compare Histograms 
% edited from Dylan Baxter's and Nicholas Brunet's code
function [overlap] = hist_overlap(feature1, feature2)
    numBins = 50;
    % Extract histogram Information
    max_val = max([feature1;feature2], [], "all");
    min_val = min([feature1;feature2], [], "all");
    bins = linspace(min_val, max_val, numBins+1);
    hist1 = histcounts(feature1, bins);
    hist2 = histcounts(feature2, bins);
    
    % Iterate over histograms and calculate overlap
    overlap = 0;
    for m = 1:length(hist1)
        overlap = overlap + min(hist1(m), hist2(m));
    end
    overlap = overlap / sum(hist1, "all");
end