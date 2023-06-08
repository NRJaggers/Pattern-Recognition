%% Homework 4
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
%manually
a=0.4*0.1*0.5*0.4*0.7*0.7
b=0.4*0.1*0.1*0.4*0.7*0.3
c=0.4*0.7*0.5*0.4*0.3*0.4
d=0.4*0.7*0.1*0.4*0.3*0.6
e=0.2*0.1*0.5*0.6*0.4*0.7
f=0.2*0.1*0.1*0.6*0.4*0.3
g=0.2*0.7*0.5*0.6*0.6*0.4
h=0.2*0.7*0.1*0.6*0.6*0.6

prob=a+b+c+d+e+f+g+h
%%

trans = [0.7 0.3;
         0.4 0.6];

emis = [0.1 0.4 0.5;
        0.7 0.2 0.1];

sequence = [2 1 3];

%%
% find rmax to determine max possible combinations of hidden states for
% observed sequence
hidden_states = size(trans,1);
T = length(sequence);
rmax = hidden_states^T;

