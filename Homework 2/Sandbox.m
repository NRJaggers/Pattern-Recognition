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

boundary = 1; %make error give 5 percent

error_1 = subs(F,[t,mu,sigma],[boundary,-1,1])

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

%% Problem 6, part e
% boundary = 0; %gives 5
% t=boundary;
% mu = -1;
% sigma = 1;

F = 2*(1/2)*int(normal_dist,x,t,inf);
error_b = subs(F,[t,mu,sigma],[0,-1,1]);

fprintf("error:%f\n",error_b);

%% Problem 37 part a

syms x mu1 mu2 x1 x2;
g1 = -(abs(x-mu1))^2;
g2 = -(abs(x-mu2))^2;
g = g1-g2;

eval = subs(g,{x mu1 mu2},{[x1 x2] [0 0] [1 1]});

%% part b
w1_mean = [0;0];
w2_mean = [1;1];
w1_cov = [1 0; 0 1];
w2_cov = w1_cov;
w1_P = 1/2;
w2_P = 1/2;

mu2_mu1 = w2_mean - w1_mean;
cov2_cov1 = w1_cov+w2_cov;
ln_num = det(cov2_cov1/2);
ln_den = sqrt(det(w1_cov)*det(w2_cov));

k_bha = (1/8)*mu2_mu1'*inv(cov2_cov1/2)*mu2_mu1+(1/2)*log(ln_num/ln_den);

P_error_bound = sqrt((w1_P)*(w2_P))*exp(-k_bha);
disp(P_error_bound);

%% part c
Pwi = 0.5;
Pwj = 0.5;

sigi = [2 0.5; 0.5 2];
inv_sigi = inv(sigi);

sigj = [5 4; 4 5];
inv_sigj = inv(sigj);

mu_i = [0;0];
mu_j = [1;1];

W_i = -0.5*inv_sigi;
W_j = -0.5*inv_sigj;

w_i = inv_sigi*mu_i;
w_j = inv_sigj*mu_j;

w_i0 = -0.5*mu_i'*inv_sigi*mu_i-0.5*log(det(sigi))+log(Pwi);
w_j0 = -0.5*mu_j'*inv_sigj*mu_j-0.5*log(det(sigj))+log(Pwj);

syms x x1 x2;
x = [x1;x2];
x_t = [x1 x2];

gi = x_t*W_i*x+w_i'*x+w_i0;
gj = x_t*W_j*x+w_j'*x+w_j0;

g = gi-gj;

w1_mean = mu_i;
w2_mean = mu_j;
w1_cov = sigi;
w2_cov = sigj;
w1_P = 1/2;
w2_P = 1/2;

mu2_mu1 = w2_mean - w1_mean;
cov2_cov1 = w1_cov+w2_cov;
ln_num = det(cov2_cov1/2);
ln_den = sqrt(det(w1_cov)*det(w2_cov));

k_bha = (1/8)*mu2_mu1'*inv(cov2_cov1/2)*mu2_mu1+(1/2)*log(ln_num/ln_den);

P_error_bound = sqrt((w1_P)*(w2_P))*exp(-k_bha);
disp(P_error_bound);

%% Problem 5
P1 = 0.6;
P2 = 0.4;

cov1 = 4;
cov2 = 4;

mu1 = [4;16];
mu2 = [16;4];

w1 = (1/cov1)*mu1;
w2 = (1/cov2)*mu2;

w10 = -0.5*(1/cov1)*mu1'*mu1+log(P1);
w20 = -0.5*(1/cov2)*mu2'*mu2+log(P2);

