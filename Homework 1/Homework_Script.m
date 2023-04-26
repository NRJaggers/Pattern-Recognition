%% Homework 1
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Nathan Jaggers
%
% Description: See coresponding document <Can add description later>
%% Part <#>
close all;
clear;
clc;

%%
%class one data points
class1 = [0 0; 0 1];

%class two data points
class2 = [1 1; 1 0];

%plot data points
hold on;
scatter(class1(1,:),class1(2,:),"bx");
scatter(class2(1,:),class2(2,:),"ro");
xlim([-0.5 1.5]);
ylim([-0.5 1.5]);
hold off;
%%
y = [1 class1(1,:); 1 class1(2,:); -1 class2(1,:); -1 class2(2,:)];
a = zeros(1,3);

%untill everything is correctly classified
not_tuned = true;
while (not_tuned)
    not_tuned = false
    for k=1:4
        %run through all dot products and make sure they pass
        %if one didn't set status to true
    end
    %if not tuned is true, update weights and move on to next iter
end

%%do i check weights each time to see if they pass and break or after each
%%epoch

