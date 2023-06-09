%% Project 5
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Group 4: Nathan Jaggers, Nicholas Brunet, Jordan Rubio Perlas
%
% Description: See coresponding document <Can add description later>
%% Part 1
close all;
clear;
clc;

%%
% load data set
load("fisheriris.mat")

%%
% Features:
% 1. sepal length
% 2. sepal width
% 3. petal length
% 4. petal width

setosa_X = meas(1:50,:); % w1
versicolor_X = meas(51:100,:); % w2
virginica_X = meas(101:150,:); % w3

setosa_Y = ones(50, 1);
versicolor_Y = ones(50, 1) * 2;
virginica_Y = ones(50, 1) * 3;
Y = [setosa_Y; versicolor_Y; virginica_Y];

% BAD
hold on
histogram(setosa_X(:,1), 'FaceColor', 'r', 'BinWidth', .2);
histogram(versicolor_X(:,1), 'FaceColor', 'g', 'BinWidth', .2);
histogram(virginica_X(:,1), 'FaceColor', 'b', 'BinWidth', .2);
xlabel("Value");
ylabel("Frequency");
title("Sepal Length");
legend("Setosa", "Versicolor", "Virginica");
hold off

% BAD
figure;
hold on
histogram(setosa_X(:,2), 'FaceColor', 'r', 'BinWidth', .2);
histogram(versicolor_X(:,2), 'FaceColor', 'g', 'BinWidth', .2);
histogram(virginica_X(:,2), 'FaceColor', 'b', 'BinWidth', .2);
xlabel("Value");
ylabel("Frequency");
title("Sepal Width");
legend("Setosa", "Versicolor", "Virginica");
hold off

% GOOD
figure;
hold on
histogram(setosa_X(:,3), 'FaceColor', 'r', 'BinWidth', .2);
histogram(versicolor_X(:,3), 'FaceColor', 'g', 'BinWidth', .2);
histogram(virginica_X(:,3), 'FaceColor', 'b', 'BinWidth', .2);
xlabel("Value");
ylabel("Frequency");
title("Petal Length");
legend("Setosa", "Versicolor", "Virginica");
hold off

% GOOD
figure;
hold on
histogram(setosa_X(:,4), 'FaceColor', 'r', 'BinWidth', .2);
histogram(versicolor_X(:,4), 'FaceColor', 'g', 'BinWidth', .2);
histogram(virginica_X(:,4), 'FaceColor', 'b', 'BinWidth', .2);
xlabel("Value");
ylabel("Frequency");
title("Petal Width");
legend("Setosa", "Versicolor", "Virginica");
hold off

% Prior probabilities
w1_P = size(setosa_X,1)/size(meas,1); % 1/3 % each have 50 samples
w2_P = size(versicolor_X,1)/size(meas,1); % 1/3 % total samples is 150
w3_P = size(virginica_X,1)/size(meas,1); % 1/3 % 1/3 = 50/150

%% Data cleaning

% Remove sepal features
setosa_X = setosa_X(:,3:4);
versicolor_X = versicolor_X(:,3:4);
virginica_X = virginica_X(:,3:4);


%% Analysis

% PROCESS
% for s in samples
%   leave s out
%   train with dataset
%   test on s => record score
% average scores



C = loo_bayes(Y, setosa_X, w1_P, versicolor_X, w2_P, virginica_X, w3_P);
%confusionchart(C);
confusionchart(C,["Setosa", "Versicolor", "Virginica",]);

% xvalues = {'Setosa', 'Versicolor', 'Virginica'};
% yvalues = {'Setosa', 'Versicolor', 'Virginica'};
% h = heatmap(xvalues, yvalues, conf_mat);
% h.XLabel = 'Actual';
% h.YLabel = 'Predicted';

%%
C = naive_loo_bayes(Y, setosa_X, w1_P, versicolor_X, w2_P, virginica_X, w3_P);
%confusionchart(C);
confusionchart(C,["Setosa", "Versicolor", "Virginica",]);


%%
function conf_mat = loo_bayes(Y, setosa_X, w1_P, versicolor_X, w2_P, virginica_X, w3_P)

    correct = 0;
    conf_mat = zeros(3, 3);  % confusion matrix
    
    for i = 1:150
        
        % create train/test split
        setosa_X_train = setosa_X;
        versicolor_X_train = versicolor_X;
        virginica_X_train = virginica_X;
        if i <= 50
            x = setosa_X(i,:);
            setosa_X_train(i,:) = [];
        elseif i <= 100
            x = versicolor_X(i-50,:);
            versicolor_X_train(i-50,:) = [];
        else
            x = virginica_X(i-100,:);
            virginica_X_train(i-100,:) = [];
        end
        y = Y(i);
        
        x = x'; % make x a column vector
        
        w1_mean = mean(setosa_X_train)';
        w2_mean = mean(versicolor_X_train)';
        w3_mean = mean(virginica_X_train)';
        
        w1_cov = cov(setosa_X_train);
        w2_cov = cov(versicolor_X_train);
        w3_cov = cov(virginica_X_train);
        
        % Test
        
        g1 = g(x, w1_mean, w1_cov, w1_P);
        g2 = g(x, w2_mean, w2_cov, w2_P);
        g3 = g(x, w3_mean, w3_cov, w3_P);
    
        if g1 >= g2 && g1 >= g3
            result = 1;
        elseif g2 >= g1 && g2 >= g3
            result = 2;
        else
            result = 3;
        end
         
        conf_mat(result, y) = conf_mat(result, y) + 1;
        if(result == y)
            correct = correct + 1;
        end


    
    end

    fprintf("Accuracy: %.3f\n", correct / 150);

end

function conf_mat = naive_loo_bayes(Y, setosa_X, w1_P, versicolor_X, w2_P, virginica_X, w3_P)

    correct = 0;
    conf_mat = zeros(3, 3);  % confusion matrix
    
    for i = 1:150
        
        % create train/test split
        setosa_X_train = setosa_X;
        versicolor_X_train = versicolor_X;
        virginica_X_train = virginica_X;
        if i <= 50
            x = setosa_X(i,:);
            setosa_X_train(i,:) = [];
        elseif i <= 100
            x = versicolor_X(i-50,:);
            versicolor_X_train(i-50,:) = [];
        else
            x = virginica_X(i-100,:);
            virginica_X_train(i-100,:) = [];
        end
        y = Y(i);
        
        x = x'; % make x a column vector
        
        %Training
        w1_mean = mean(setosa_X_train)';
        w2_mean = mean(versicolor_X_train)';
        w3_mean = mean(virginica_X_train)';
        
        w1_cov = zeros(size(setosa_X_train,2),1);
        w2_cov = zeros(size(versicolor_X_train,2),1);
        w3_cov = zeros(size(virginica_X_train,2),1);

        for cols = 1:size(setosa_X_train,2)
            w1_cov(cols,1) = cov(setosa_X_train(:,cols));
            w2_cov(cols,1) = cov(versicolor_X_train(:,cols));
            w3_cov(cols,1) = cov(virginica_X_train(:,cols));
        end
        
        % Test

        %multiplication pdfs of of first class
        pdf_per_class = (1./(sqrt(2.*pi().*w1_cov))).*exp(-0.5.*((x-w1_mean).^2)./w1_cov);
        pdf_pi = prod(pdf_per_class);
        %discriminant of first class
        g1 = log(pdf_pi)*w1_P;
        
        %multiplication pdfs of of second class
        pdf_per_class = (1./(sqrt(2.*pi().*w2_cov))).*exp(-0.5.*((x-w2_mean).^2)./w2_cov);
        pdf_pi = prod(pdf_per_class);
        %discriminant of second class
        g2 = log(pdf_pi)*w2_P;

        %multiplication pdfs of of third class
        pdf_per_class = (1./(sqrt(2.*pi().*w3_cov))).*exp(-0.5.*((x-w3_mean).^2)./w3_cov);
        pdf_pi = prod(pdf_per_class);
        %discriminant of second class
        g3 = log(pdf_pi)*w3_P;
    
        if g1 >= g2 && g1 >= g3
            result = 1;
        elseif g2 >= g1 && g2 >= g3
            result = 2;
        else
            result = 3;
        end
         
        conf_mat(result, y) = conf_mat(result, y) + 1;
        if(result == y)
            correct = correct + 1;
        end
  
    end

    fprintf("Accuracy: %.3f\n", correct / 150);

end

% Calculate parameters once in separate function if this takes too long
function result = g(x, mean, cov, P)
    cov_i = inv(cov);
    W = -0.5 * cov_i;
    w = cov_i * mean;
    w0 = -0.5 * (mean' * cov_i * mean) - 0.5 * log(det(cov)) + log(P);
    result = x'*W*x + w'*x + w0;
end




