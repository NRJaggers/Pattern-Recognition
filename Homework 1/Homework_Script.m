%% Homework 1
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Nathan Jaggers
%
% Description: See coresponding document <Can add description later>
%%
close all;
clear;
clc;

%% fixed-increment single-sample perception
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
%create augmented matrix and initialize weight vector
Y = [1 class1(1,:); 1 class1(2,:); -1 class2(1,:); -1 class2(2,:)];
%weight vector should be a column vector with same amount of rows as the Y
%matrix has columns
a = zeros(size(Y,2),1);

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

%%
%recreate scatter plot
hold on;
scatter(class1(1,:),class1(2,:),"bx");
scatter(class2(1,:),class2(2,:),"ro");
xlim([-0.5 1.5]);
ylim([-0.5 1.5]);

%create boundry line and plot results
x1 = linspace(-2,2);
x2 = (a(1) + a(2)*x1)/(-1*a(3));
plot(x1,x2);
hold off;

%% Minimum Square Error
% want to find a from a = ((Y'Y)^-1)Y'*b

%initialize b to possitive numbers
b = ones(size(Y,1),1);

%get results for transpose, inverse and pseudo inverse
Yt = Y';
YtYinv=(Yt*Y)^-1;
Ypseudo=YtYinv*Yt;

a = Ypseudo*b;

%recreate scatter plot
hold on;
scatter(class1(1,:),class1(2,:),"bx");
scatter(class2(1,:),class2(2,:),"ro");
xlim([-1.5 1.5]);
ylim([-1.5 1.5]);

%create boundry line and plot results
x2 = linspace(-2,2);
x1 = zeros(1,numel(x2)) - 0.5;
plot(x1,x2);
hold off;

%%
a = zeros(size(Y,2),1);
b = ones(size(Y,1),1);
n = 1;

for k = 1: 1000
    e = Y*a - b;
    b = b + n*(e+abs(e));
    a = ((Y'*Y)^-1)*Y'*b;
    if(abs(e)<=0)
        break
    end
end


