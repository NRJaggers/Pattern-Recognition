%% Project 3
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Group 4: Nathan Jaggers, Tre Carmichael, Nickolas Ogilvie
%
% Description: See coresponding document <Can add description later>
% 0 & 1 - filled area, minor axis length, eccentricity
% 0 & 2 - circularity, perimeter, filled area
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

%% classifying 0 and 1
%initialize variables for training
%Y is augmented matrix holding (+/-)1's and two values to describe digit 
%in each row 

class_1 = [ones(length(featarry_0(:,2)),1) featarry_0(:,2) featarry_0(:,3)];
class_2 = [-ones(length(featarry_0(:,2)),1) featarry_0(:,2) featarry_0(:,3)];
Y = [class_1; class_2];


%a is weight (column) vector to be adjusted
%rows of a should equal the rows of Y
a = zeros(size(Y,2), 1);

%%
%single sample perceptron (maybe consider making this a function)
%until everything is correctly classified
not_tuned = true;
while (not_tuned)
    not_tuned = false;
    for k=1:size(Y,1) %rows in the Y matrix
        %run through all dot products and make sure they pass 
        %(pass = result is greater than zero)
        %if one didn't pass set status to true and update weights.
        y = Y(k,:);
        classification = y*a;
        if(classification <= 0)
            %update wights
            a = (a' + y)';
            %change exit status
            not_tuned = true;
        end

    end
end



