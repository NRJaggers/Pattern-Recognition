%% Project 4
%
% EE 516 - Pattern Recognition
% Spring 2023
%
% Group 4: Nathan Jaggers, Nicholas Brunet, Jordan Rubio Perlas
%
% Description: See coresponding document <Can add description later>
% mvnrnd
%% Part 2
close all;
clear;
clc;

%% Jordan's code

mu1 = [0 0]';
mu2 = [2 2]';
sigma12 = [1 0.25; 0.25 1];
isig12 = inv(sigma12);
samplenum = 500;

%part 2.a 
r1 = mvnrnd(mu1, sigma12, samplenum); %for w1
r2 = mvnrnd(mu2, sigma12, samplenum); %for w2

%lambdas
lam11=0; lam22=0; lam12=1; lam21=0.005;
%more costly to choose w1 when actually w2
%shrink R1 and make R2 bigger 

%part 2.b
%classifier
%W' * (X - xo) = 0
mudiff = mu1-mu2;
w = isig12*(mudiff);
xo = 0.5*(mu1+mu2);
xo_new = xo - (log(lam21/lam12)*mudiff)/(mudiff'*isig12*mudiff);

range = -3:0.1:5;
%bayes decision rule
dec_bound = ((w(1)*(range-xo(1)))/(-w(2)))+xo(2);

%bayes rules with lambdas
dec_bound_new = ((w(1)*(range-xo_new(1)))/(-w(2)))+xo_new(2);

%assign classes to plots 
r1_class = [ones(samplenum,1) r1];
r2_class = [-1*ones(samplenum,1) r2];
datasetX = [r1_class; r2_class];
%%
%for part e
misclass = 0; %starting counter for misclassified samples based on original boundary
misclass_new = 0; %starting counter for misclassified samples

for i = 1:1000
    gx = (w(1)*(datasetX(i,2)-xo_new(1))) + (w(2)*(datasetX(i,3)-xo_new(2)));
    if gx >= 0 %want w1 (classified as 1)
        if datasetX(i, 1) ~= 1 %classified as w1 but is w2, thats lambda12
            misclass = misclass + 1;
            misclass_new = misclass_new + 1*lam12;
        end
    else %want w2 (classified as -1)
        if datasetX(i, 1) ~= -1 %classified as w2 but is w1, thats lambda21
            misclass = misclass + 1;
            misclass_new = misclass_new + 1*lam21;
        end
    end
end

disp(['misclassified samples from orig boundary: ' num2str(misclass)])
disp(['misclassified samples: ' num2str(misclass_new)])
disp(['error rate = ' num2str((misclass_new/1000)*100) '%'])
%%
%plot for part d
for i = 1:1000
    %gx = (w(1)*(datasetX(i,2)-xo(1))) + (w(2)*(datasetX(i,3)-xo(2)));
    if datasetX(i,1) == 1
    %if gx >= 0 %depening on what she actually wants for this part the only thing that needs to change is this if
        hold on
        scatter(datasetX(i,2), datasetX(i,3), 'r')
    else
        hold on
        scatter(datasetX(i,2), datasetX(i,3), 'g')
    end
end
plot(range, dec_bound_new)
xlabel('x1')
ylabel('x2')
hold off

%%
%for part c
misclass = 0; %starting counter for misclassified samples

for i = 1:1000
    gx = (w(1)*(datasetX(i,2)-xo(1))) + (w(2)*(datasetX(i,3)-xo(2)));
    if gx >= 0 %want w1 (classified as 1)
        if datasetX(i, 1) ~= 1
            misclass = misclass + 1;
        end
    else %want w2 (classified as -1)
        if datasetX(i, 1) ~= -1
            misclass = misclass + 1;
        end
    end
end

disp(['Misclassified Samples: ' num2str(misclass)])
disp(['Error Rate = ' num2str((misclass/1000)*100) '%'])
%%
%plot for part 2
for i = 1:1000
    gx = (w(1)*(datasetX(i,2)-xo(1))) + (w(2)*(datasetX(i,3)-xo(2)));
    if datasetX(i,1) == 1
    %if gx >= 0 %depening on what she actually wants for this part the only thing that needs to change is this if
        hold on
        scatter(datasetX(i,2), datasetX(i,3), 'r')
    else
        hold on
        scatter(datasetX(i,2), datasetX(i,3), 'g')
    end
end
plot(range, dec_bound)
xlabel('x1')
ylabel('x2')
hold off

%%
%plot for part 1
figure
hold on
scatter(r1(:,1), r1(:,2), ".")
scatter(r2(:,1), r2(:,2), ".")
%plot(range, dec_bound)
xlabel('x1')
ylabel('x2')
legend("w1", "w2")
hold off



