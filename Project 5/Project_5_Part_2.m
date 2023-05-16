%% Project 5
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Group 4: Nathan Jaggers, Nicholas Brunet, Jordan Rubio Perlas
%
% Description: See coresponding document <Can add description later>
%% Part <#>
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
for feature=1:30
    figure;
    hold on;
    histogram(pos_data(:,feature));
    histogram(neg_data(:,feature));
    hold off;
end

%%
%create histograms to compare positive and negative data to find good
%discriminant features





