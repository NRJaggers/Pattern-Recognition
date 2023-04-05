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

%get histogram of data and determine threshold to create binary image
histogram(im0);

%%
%create binary image and show results
binary_im0 = im0 > 50;
imshow(binary_im0);

%%
% go through 28x28 bit samples one by one
for m = 1:28:size(binary_im0,1)
    for n = 1:28:size(binary_im0,2)
        sample = binary_im0(m:m+27, n:n+27);
        row = m/28 + 1;
        col = n/28 + 1;        %imshow(sample);
    end
end


