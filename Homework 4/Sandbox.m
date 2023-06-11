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

%% Problem 1.1

%transmisson probability
a = [0.7 0.3;
     0.4 0.6];

%emission probability
b = [0.1 0.4 0.5;
     0.7 0.2 0.1];

sequence = [2 1 3];

%%
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
prob = zeros(8,1);
initial = 2;

w_T = [1 1 1;
       1 1 2;
       1 2 1;
       1 2 2;
       2 1 1;
       2 1 2;
       2 2 1;
       2 2 2]
for state=1:8
    w = w_T(state,:);
    prob(state) = (b(w(1),2)*b(w(2),1)*b(w(3),3))*(a(initial,w(1))*a(w(1),w(2))*a(w(2),w(3)))
end

%%
% find rmax to determine max possible combinations of hidden states for
% observed sequence
hidden_states = size(trans,1);
T = length(sequence);
rmax = hidden_states^T;

%% Problem 1.2
alpha = zeros(3,2);
initial = 2;

for t = [1 2 3]
    k = sequence(t);
    for j = [1 2]
        if(t==1)
            alpha(t,j) = 1*a(initial,j)*b(j,k);
        else
            alpha(t,j) = (alpha(t-1,1)*a(1,j)+alpha(t-1,2)*a(2,j))*b(j,k);
        end
    end
end
alpha
alpha(3,1)+alpha(3,2)

%% Problem 2.3
delta = zeros(3,2);
initial = 2;

for t = [1 2 3]
    k = sequence(t);
    for j = [1 2]
        if(t==1)
            delta(t,j) = 1*a(initial,j)*b(j,k);
        else
            delta(t,j) = max([delta(t-1,1)*a(1,j) delta(t-1,2)*a(2,j)])*b(j,k);
        end
    end
end

delta