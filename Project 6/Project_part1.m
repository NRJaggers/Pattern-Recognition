%% Project 6
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Group 4: Nathan Jaggers, Colt Whitley, Kai Ponting
%
% Description: See coresponding document <Can add description later>
%% Part 1 - Using Features
close all;
clear;
clc;

%%
%read in image
im_train0 = imread("mnist_train0.jpg");
im_train1 = imread("mnist_train1.jpg");
im_train2 = imread("mnist_train2.jpg");

%%
%create binary image and show results
binary_imtrain0 = imbinarize(im_train0);
%%imshow(binary_im0);
binary_imtrain1 = imbinarize(im_train1);
%%imshow(binary_im1);
binary_imtrain2 = imbinarize(im_train2);
%%imshow(binary_im2);

%%
features_train0 = get_features(binary_imtrain0);
features_train1 = get_features(binary_imtrain1);
features_train2 = get_features(binary_imtrain2);

%%
featarry_train0 = make_feat_array(features_train0);
featarry_train1 = make_feat_array(features_train1);
featarry_train2 = make_feat_array(features_train2);

%%


