%% Project 4
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

%% Jordans Code
%data for class w1 
w1x1 = [-5.01 -5.43 1.08 0.86 -2.67 4.94 -2.51 -2.25 5.56 1.03];
w1x2 = [-8.12 -3.48 -5.52 -3.78 0.63 3.29 2.09 -2.13 2.86 -3.33];
w1x3 = [-3.68 -3.54 1.66 -4.11 7.39 2.08 -2.59 -6.94 -2.26 4.33];

%data for class w2
w2x1 = [-0.91 1.30 -7.75 -5.47 6.14 3.60 5.37 7.18 -7.39 -7.50];
w2x2 = [-0.18 -2.06 -4.54 0.50 5.72 1.26 -4.63 1.46 1.17 -6.32];
w2x3 = [-0.05 -3.53 -0.95 3.92 -4.85 4.36 -3.65 -6.66 6.30 -0.31];

%assume indetical priors
Pw1 = 0.5;
Pw2 = 0.5;
len = 10;

%gaussian characteristics for w1
mu_11 = mean(w1x1); %mu = 1/nsigma(Xi)
standev_11 = std(w1x1);
y1 = pdf('Normal', -20:20,mu_11, standev_11);


%gaussian characteristics for w2
mu_21 = mean(w2x1); %mu = 1/nsigma(Xi)
standev_21 = std(w2x1);
y2 = pdf('Normal', -20:20,mu_21, standev_21);

figure(1)
plot(-20:20, y1)
hold on 
plot(-20:20, y2)
hold off
legend('w1', 'w2')

%% Nicks Code
dataset = [
   -5.01  -8.12  -3.68  -0.91  -0.18  -0.05   5.35   2.26   8.13;
   -5.43  -3.48  -3.54   1.30   2.06  -3.53   5.12   3.22  -2.66;
    1.08  -5.52   1.66  -7.75  -4.54  -0.95   1.34  -5.31  -9.87;
    0.86  -3.78  -4.11  -5.47   0.50   3.92   4.48   3.42   5.19;
   -2.67   0.63   7.39   6.14   5.72  -4.85   7.11   2.39   9.21;
    4.94   3.29   2.08   3.60   1.26   4.36   7.17   4.33  -0.98;
   -2.51   2.09  -2.59   5.37  -4.63  -3.65   5.75   3.97   6.65;
   -2.25  -2.13  -6.94   7.18   1.46  -6.66   0.77   0.27   2.41;
    5.56   2.86  -2.26  -7.39   1.17   6.30   0.90  -0.43  -8.71;
    1.03  -3.33   4.33  -7.50  -6.32  -0.31   3.52  -0.36   6.43;
];

w1_P = 0.5;
w2_P = 0.5;

d = 3; %dimensions

w1_x = dataset(:,1:d);
w2_x = dataset(:,4:d+3);

w1_mean = mean(w1_x)';
w2_mean = mean(w2_x)';

w1_cov = cov(w1_x);
w2_cov = cov(w2_x);

% Test
correct = 0;
Y = [ones(size(w1_x, 1), 1); zeros(size(w2_x, 1), 1)];
X = [w1_x; w2_x];
for i = 1:size(X, 1)
    x = X(i,:)';
    y = Y(i);
    g1_result = g(x, w1_mean, w1_cov, w1_P);
    g2_result = g(x, w2_mean, w2_cov, w2_P);
    correct = correct + ((g1_result - g2_result > 0) == y);
end
acc = correct / size(X, 1);
fprintf("Accuracy: %.2f\n", acc);

%%
% Bhattacharyya bound

%Assuming beta = 0.5 allows us to turn the chernoff equations into the
%following
mu2_mu1 = w2_mean - w1_mean;
cov2_cov1 = w1_cov+w2_cov;
ln_num = det(cov2_cov1/2);
ln_den = sqrt(det(w1_cov)*det(w2_cov));

k_bha = (1/8)*mu2_mu1'*inv(cov2_cov1/2)*mu2_mu1+(1/2)*log(ln_num/ln_den);

P_error_bound = sqrt((w1_P)*(w2_P))*exp(-k_bha);
disp(P_error_bound);

%%
%creating histograms for data

% % 1 feature
% figure;
% histogram(dataset(:,1));
% figure;
% histogram(dataset(:,4));

% 2 feature
figure;
histogram(dataset(:,1:2));
figure;
histogram(dataset(:,4:5));

% 3 feature
figure;
histogram(dataset(:,1:3));
figure;
histogram(dataset(:,4:6));

%% Functions

% Calculate parameters once in separate function if this takes too long
function result = g(x, mean, cov, P)
    cov_i = inv(cov);
    W = -0.5 * cov_i;
    w = cov_i * mean;
    w0 = -0.5 * (mean' * cov_i * mean) - 0.5 * log(det(cov)) + log(P);
    result = x'*W*x + w'*x + w0;
end


