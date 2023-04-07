%% Project 1
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Group 7: Nathan Jaggers, Ronit Singh
%
% Description: See coresponding document <Can add description later>
%% Part <#>
close all;
clear;
clc;

%%
%read in image
im0 = imread("mnist_train0.jpg");
im1 = imread("mnist_train1.jpg");
im2 = imread("mnist_train2.jpg");

%%
%get histogram of data and determine threshold to create binary image
figure(1);
histogram(im0);
figure(2);
histogram(im1);
figure(3);
histogram(im2);

%%
%create binary image and show results
binary_im0 = im0 > 50;
%%imshow(binary_im0);
binary_im1 = im1 > 50;
%%imshow(binary_im0);
binary_im2 = im2 > 50;
%%imshow(binary_im0);
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
num = 9;
histogram(featarry_0(:,num));
histogram(featarry_1(:,num));
histogram(featarry_2(:,num));
title("Comparing Test");
legend("0 test","1 test","2 test");
hold off

