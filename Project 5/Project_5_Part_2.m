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



