%% Homework 3
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Nathan Jaggers
%
%%
close all;
clear;
clc;

%% Problem 1
%part a
x = linspace(0, 10,100);
theta = 1;
y = theta*exp(-theta*x);

plot(x,y);
xlabel("x");
ylabel("p(x|theta)");

%%
theta = linspace(0, 5,100);
x = 2;
y = theta.*exp(-theta*x);

plot(theta,y);
xlabel("theta");
ylabel("p(x|theta)");

%%
%part c
x = linspace(0, 10,100);
theta = 1;
y = theta*exp(-theta*x);
[l,u] = bounds(y);


hold on;
plot(x,y);
xlabel("x");
ylabel("p(x|theta)");
plot(ones(size(y)),linspace(l,u,100));
hold off;
