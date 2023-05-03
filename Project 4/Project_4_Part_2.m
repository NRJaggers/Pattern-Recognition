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

%%
%two classes w1 and w2
mu1 = [0 0]';
mu2 = [2 2]';
Sigma = [1 0.25; 0.25 1];

%%
%create random data sets
data_set_1 = mvnrnd(mu1,Sigma,500);
data_set_2 = mvnrnd(mu2,Sigma,500);

%plot the data sets
hold on;
scatter(data_set_1(:,1),data_set_1(:,2));
scatter(data_set_2(:,1),data_set_2(:,2));
hold off;

%%
% b)
% Assign each one of the points of X to either ω1 or ω2, according to the Bayes
% decision rule, and plot the points with different colors, depending on the class
% they are assigned to. Plot the corresponding classifier.



