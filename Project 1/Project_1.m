%% Project 1
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Group 7: Nathan Jaggers, Ronit Singh
%
% Description: See coresponding document <Can add description later>
%% Part A
close all;
clear;
clc;

%%
%read in image
im0 = imread("mnist_train0.jpg");
im1 = imread("mnist_train1.jpg");
im2 = imread("mnist_train2.jpg");

%%
%create binary image and show results
binary_im0 = imbinarize(im0);
%%imshow(binary_im0);
binary_im1 = imbinarize(im1);
%%imshow(binary_im1);
binary_im2 = imbinarize(im2);
%%imshow(binary_im2);

%%
features_0 = get_features(binary_im0);
features_1 = get_features(binary_im1);
features_2 = get_features(binary_im2);

%%
featarry_0 = make_feat_array(features_0);
featarry_1 = make_feat_array(features_1);
featarry_2 = make_feat_array(features_2);

%%

figure;
hold on
histogram(featarry_0(:,1));
histogram(featarry_1(:,1));
histogram(featarry_2(:,1));
title("Comparing Area");
legend("0 Area","1 Area","2 Area");
hold off

figure;
hold on
histogram(featarry_0(:,2));
histogram(featarry_1(:,2));
histogram(featarry_2(:,3));
title("Comparing Circularity");
legend("0 Circ","1 Circ","2 Circ");
hold off

figure;
hold on
histogram(featarry_0(:,3));
histogram(featarry_1(:,3));
histogram(featarry_2(:,3));
title("Comparing Eccentricity");
legend("0 Eccen","1 Eccen","2 Eccen");
hold off

%%
figure;
hold on
num = 6;
histogram(featarry_0(:,num));
histogram(featarry_1(:,num));
histogram(featarry_2(:,num));
title("Comparing FilledArea");
legend("0 FilledArea","1 FilledArea","2 FilledArea");
hold off

figure;
hold on
num = 7;
histogram(featarry_0(:,num));
histogram(featarry_1(:,num));
histogram(featarry_2(:,num));
title("Comparing MinorAxisLength");
legend("0 MAL","1 MAL","2 MAL");
hold off
%%
figure;
hold on
num = 4;
histogram(featarry_0(:,num));
histogram(featarry_1(:,num));
histogram(featarry_2(:,num));
title("Comparing Test");
legend("0 test","1 test","2 test");
hold off

%%
% Create scatter plot 0 and 1
figure;
hold on;
first = 3;
second = 7;
scatter(featarry_0(:,first),featarry_0(:,second));
scatter(featarry_1(:,first),featarry_1(:,second));
legend("0","1");
hold off

%%
% Create scatter plot 0 and 2
figure;
hold on;
first = 2;
second = 6;
scatter(featarry_0(:,first),featarry_0(:,second));
scatter(featarry_2(:,first),featarry_2(:,second));
legend("0","2");
hold off