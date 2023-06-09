load fisheriris

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

% % BAD
% hold on
% histogram(setosa_X(:,1), 'FaceColor', 'r', 'BinWidth', .2);
% histogram(versicolor_X(:,1), 'FaceColor', 'g', 'BinWidth', .2);
% histogram(virginica_X(:,1), 'FaceColor', 'b', 'BinWidth', .2);
% hold off
% 
% % BAD
% figure;
% hold on
% histogram(setosa_X(:,2), 'FaceColor', 'r', 'BinWidth', .2);
% histogram(versicolor_X(:,2), 'FaceColor', 'g', 'BinWidth', .2);
% histogram(virginica_X(:,2), 'FaceColor', 'b', 'BinWidth', .2);
% hold off
% 
% % GOOD
% figure;
% hold on
% histogram(setosa_X(:,3), 'FaceColor', 'r', 'BinWidth', .2);
% histogram(versicolor_X(:,3), 'FaceColor', 'g', 'BinWidth', .2);
% histogram(virginica_X(:,3), 'FaceColor', 'b', 'BinWidth', .2);
% hold off
% 
% % GOOD
% figure;
% hold on
% histogram(setosa_X(:,4), 'FaceColor', 'r', 'BinWidth', .2);
% histogram(versicolor_X(:,4), 'FaceColor', 'g', 'BinWidth', .2);
% histogram(virginica_X(:,4), 'FaceColor', 'b', 'BinWidth', .2);
% hold off

% Prior probabilities
w1_P = 1/3;
w2_P = 1/3;
w3_P = 1/3;

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



loo_bayes(1/3,1/3,1/3)

% xvalues = {'Setosa', 'Versicolor', 'Virginica'};
% yvalues = {'Setosa', 'Versicolor', 'Virginica'};
% h = heatmap(xvalues, yvalues, conf_mat);
% h.XLabel = 'Actual';
% h.YLabel = 'Predicted';


fprintf("Accuracy: %.3f\n", correct / 150);

function conf_mat = loo_bayes(w1_P, w2_P, w3_P)

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
    
    end
end


% Calculate parameters once in separate function if this takes too long
function result = g(x, mean, cov, P)
    cov_i = inv(cov);
    W = -0.5 * cov_i;
    w = cov_i * mean;
    w0 = -0.5 * (mean' * cov_i * mean) - 0.5 * log(det(cov)) + log(P);
    result = x'*W*x + w'*x + w0;
end