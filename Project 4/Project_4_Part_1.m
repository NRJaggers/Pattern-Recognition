%% Project 4
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Group 4: Nathan Jaggers, Nicholas Brunet, Jordan Rubio Perlas
%
% Description: See coresponding document <Can add description later>
% mvnrnd
%% Part 1
close all;
clear;
clc;

%EE 516 Project 4

%Part 1
%always assume gaussian
%%
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



