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
%initialize variables for training
%Y is augmented matrix holding 1's and two values to describe digit in each
%row 
Y = [1 1 1;1 0 1;1 1 0;1 1 1];

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
            a = a + y;
            %change exit status
            not_tuned = true;
        end

    end
end



