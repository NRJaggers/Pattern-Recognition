%% Homework 2
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Group 4: Nathan Jaggers
%
%%
close all;
clear;
clc;
%%
syms t x sigma mu;

normal_dist = (1/(sqrt(2*pi()*sigma^2)))*exp(-0.5*((x-mu)^2)/sigma^2);
F = (1/2)*int(normal_dist,x,t,inf);

disp(F);

%% checking answer against book - Problem 6, part d

boundary = 0.7815; %gives 5%
%boundary = 0.2815; %gives 10%
t=boundary;
mu = -1/2;
sigma = 1;

%matlab - something wrong here
error = (2^(1/2)*((2^(1/2)*pi^(1/2)*limit(erf((2^(1/2)*(x - mu)*(1/sigma^2)^(1/2))/2), x, Inf))/(2*(1/sigma^2)^(1/2)) + (2^(1/2)*pi^(1/2)*erf((2^(1/2)*(mu - t)*(1/sigma^2)^(1/2))/2))/(2*(1/sigma^2)^(1/2))))/(4*pi^(1/2)*(sigma^2)^(1/2));

%symbolab -1/2 and 1
%error = 0.19947*(1.25331-1.25331*erf(sqrt(0.5)*(t+(1/2))));

fprintf("error:%f\n",error);
%looking for error of 0.05

%% Problem 6, part d - actual hw 

boundary = 0.2815; %gives 5
t=boundary;
mu = -1;
sigma = 1;

%matlab - something wrong here
error_1 = (2^(1/2)*((2^(1/2)*pi^(1/2)*limit(erf((2^(1/2)*(x - mu)*(1/sigma^2)^(1/2))/2), x, Inf))/(2*(1/sigma^2)^(1/2)) + (2^(1/2)*pi^(1/2)*erf((2^(1/2)*(mu - t)*(1/sigma^2)^(1/2))/2))/(2*(1/sigma^2)^(1/2))))/(4*pi^(1/2)*(sigma^2)^(1/2));

fprintf("error:%f\n",error_1);
%looking for error of 0.05

%%
F = (1/2)*int(normal_dist,x,-inf,t);

mu = 1;
sigma = 1;

error_2 = -(2^(1/2)*((2^(1/2)*pi^(1/2)*limit(erf((2^(1/2)*(x - mu)*(1/sigma^2)^(1/2))/2), x, -Inf))/(2*(1/sigma^2)^(1/2)) + (2^(1/2)*pi^(1/2)*erf((2^(1/2)*(mu - 563/2000)*(1/sigma^2)^(1/2))/2))/(2*(1/sigma^2)^(1/2))))/(4*pi^(1/2)*(sigma^2)^(1/2));

fprintf("error:%f\n",error_2);

%%
error_total = error_1 + error_2;

fprintf("error:%f\n", error_total);
