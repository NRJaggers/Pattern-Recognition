%% EE 516 Project 6
close all; clc; clear;

%% Load and Preproccess Images into Bianary
% Load Images from files
ims0 = imread("Images/mnist_train0.jpg");
ims1 = imread("Images/mnist_train1.jpg");
ims2 = imread("Images/mnist_train2.jpg");

ims0_test = imread("Images/mnist_test0.jpg");
ims1_test = imread("Images/mnist_test1.jpg");
ims2_test = imread("Images/mnist_test2.jpg");

% Convert to bianary images
bw0 = ims0 > 100;
bw1 = ims1 > 100;
bw2 = ims2 > 100;

bw0_test = ims0_test > 100;
bw1_test = ims1_test > 100;
bw2_test = ims2_test > 100;

% Splice image into individual digits
num0s = 5923;
num1s = 6742;
num2s = 5958;

num0s_test = 980;
num1s_test = 1002;
num2s_test = 1027;

width0 = length(bw0(1, :)) / 28;
height0 = length(bw0(:, 1)) / 28;

width1 = length(bw1(1, :)) / 28;
height1 = length(bw1(:, 1)) / 28;

width2 = length(bw2(1, :)) / 28;
height2 = length(bw2(:, 1)) / 28;

width0_test = length(bw0_test(1, :)) / 28;
height0_test = length(bw0_test(:, 1)) / 28;

width1_test = length(bw1_test(1, :)) / 28;
height1_test = length(bw1_test(:, 1)) / 28;

width2_test = length(bw2_test(1, :)) / 28;
height2_test = length(bw2_test(:, 1)) / 28;

bw0seperated = zeros(28,28,width0*height0);
bw1seperated = zeros(28,28,width1*height1);
bw2seperated = zeros(28,28,width2*height2);

bw0seperated_test = zeros(28,28,width0_test * height0_test);
bw1seperated_test = zeros(28,28,width1_test * height1_test);
bw2seperated_test = zeros(28,28,width2_test * height2_test);

% add each picture to a 3d array where each slice is a 28 by 28 image
for i = 0:(width0-1)
    for j = 0:(height0-1)
        bw0seperated(:,:,sub2ind([width0 height0], (i + 1), (j + 1))) = ...
        bw0(((1 + i * 28):(28 + i * 28)), (1 + j * 28):(28 + j * 28));
    end
end

%Remove all empty images of 0s
bw0seperated = bw0seperated(:,:,1:num0s);

% add each picture to a 3d array where each slice is a 28 by 28 image
for i = 0:(width1-1)
    for j = 0:(height1-1)
        bw1seperated(:,:,sub2ind([height1 width1], (j + 1), (i + 1))) = ...
        bw1(((1 + j * 28):(28 + j * 28)), (1 + i * 28):(28 + i * 28));
    end
end

%Remove all empty images of 1s
bw1seperated = bw1seperated(:,:,1:num1s);

% add each picture to a 3d array where each slice is a 28 by 28 image
for i = 0:(width2-1)
    for j = 0:(height2-1)
        bw2seperated(:,:,sub2ind([height2 width2], (j + 1), (i + 1))) = ...
        bw2(((1 + j * 28):(28 + j * 28)), (1 + i * 28):(28 + i * 28));
    end
end

%Remove all empty images of 2s
bw2seperated = bw2seperated(:,:,1:num2s);

% add each picture to a 3d array where each slice is a 28 by 28 image
for i = 0:(width0_test-1)
    for j = 0:(height0_test-1)
        bw0seperated_test(:,:,sub2ind([height0_test width0_test], (j + 1), (i + 1))) = ...
        bw0_test(((1 + j * 28):(28 + j * 28)), (1 + i * 28):(28 + i * 28));
    end
end

%Remove all empty images of 2s from the test data
bw0seperated_test = bw0seperated_test(:,:,1:num0s_test);

% add each picture to a 3d array where each slice is a 28 by 28 image
for i = 0:(width1_test-1)
    for j = 0:(height1_test-1)
        bw1seperated_test(:,:,sub2ind([height1_test width1_test], (j + 1), (i + 1))) = ...
        bw1_test(((1 + j * 28):(28 + j * 28)), (1 + i * 28):(28 + i * 28));
    end
end

%Remove all empty images of 2s from the test data
bw1seperated_test = bw1seperated_test(:,:,1:num1s_test);

% add each picture to a 3d array where each slice is a 28 by 28 image
for i = 0:(width2_test-1)
    for j = 0:(height2_test-1)
        bw2seperated_test(:,:,sub2ind([height2_test width2_test], (j + 1), (i + 1))) = ...
        bw2_test(((1 + j * 28):(28 + j * 28)), (1 + i * 28):(28 + i * 28));
    end
end

%Remove all empty images of 2s from the test data
bw2seperated_test = bw2seperated_test(:,:,1:num2s_test);

clear width0 width0_test width1 width1_test width2 width2_test;
clear height0 height0_test height1 height1_test height2 height2_test;

%% Extract 0's Features
%Initialize vectors to zero
circularity0 = zeros(num0s, 1);
eccentricity0 = zeros(num0s, 1);
ConvexArea0 = zeros(num0s, 1);
perimeter0 = zeros(num0s, 1);

%Use matlabs built in function to extract features 
for i = 1:num0s
    stats = regionprops(bw0seperated(:,:,i), 'Circularity', ...
                        'Eccentricity', 'ConvexArea', 'Perimeter');
    circularity0(i) = stats.Circularity;
    eccentricity0(i) = stats.Eccentricity;
    ConvexArea0(i) = stats.ConvexArea;
    perimeter0(i) = stats.Perimeter;
end

%% Extract 1's Feature
eccentricity1 = zeros(num1s, 1);
ConvexArea1 = zeros(num1s, 1);

for i = 1:num1s
    stats = regionprops(bw1seperated(:,:,i),'Eccentricity', 'ConvexArea');

    eccentricity1(i) = stats.Eccentricity;
    ConvexArea1(i) = stats.ConvexArea;
end

%% Extract 2's Features
circularity2 = zeros(num2s, 1);
perimeter2 = zeros(num2s, 1);

for i = 1:num2s
    stats = regionprops(bw2seperated(:,:,i), 'Circularity', 'Perimeter');
    circularity2(i) = stats.Circularity;
    perimeter2(i) = stats.Perimeter;
end

%% Extract 0's Features from test data
%Initialize vectors to zero
circularity0_test = zeros(num0s_test, 1);
eccentricity0_test = zeros(num0s_test, 1);
ConvexArea0_test = zeros(num0s_test, 1);
perimeter0_test = zeros(num0s_test, 1);

%Use matlabs built in function to extract features 
for i = 1:num0s_test
    stats = regionprops(bw0seperated_test(:,:,i), 'Circularity', ...
                        'Eccentricity', 'ConvexArea', 'Perimeter');
    circularity0_test(i) = stats.Circularity;
    eccentricity0_test(i) = stats.Eccentricity;
    ConvexArea0_test(i) = stats.ConvexArea;
    perimeter0_test(i) = stats.Perimeter;
end

%% Extract 1's Feature from test data
eccentricity1_test = zeros(num1s_test, 1);
ConvexArea1_test = zeros(num1s_test, 1);

for i = 1:num1s_test
    stats = regionprops(bw1seperated_test(:,:,i),'Eccentricity', 'ConvexArea');

    eccentricity1_test(i) = stats.Eccentricity;
    ConvexArea1_test(i) = stats.ConvexArea;
end

%% Extract 2's Features from test data
circularity2_test = zeros(num2s_test, 1);
perimeter2_test = zeros(num2s_test, 1);

for i = 1:num2s_test
    stats = regionprops(bw2seperated_test(:,:,i), 'Circularity', 'Perimeter');
    circularity2_test(i) = stats.Circularity;
    perimeter2_test(i) = stats.Perimeter;
end

%% Create Feature matricies for all pixel values 
featureMatrixAllPixels0 = zeros(num0s, 28 * 28);
featureMatrixAllPixels0test = zeros(num0s, 28 * 28);
featureMatrixAllPixels1 = zeros(num0s, 28 * 28);
featureMatrixAllPixels1test = zeros(num0s, 28 * 28);
featureMatrixAllPixels2 = zeros(num0s, 28 * 28);
featureMatrixAllPixels2test = zeros(num0s, 28 * 28);

for i=1:num0s
    pixelData = bw0seperated(:,:,i);
    featureMatrixAllPixels0(i,:) = pixelData(:);
end

for i=1:num0s_test
    pixelData = bw0seperated_test(:,:,i);
    featureMatrixAllPixels0test(i,:) = pixelData(:);
end

for i=1:num1s
    pixelData = bw1seperated(:,:,i);
    featureMatrixAllPixels1(i,:) = pixelData(:);
end

for i=1:num1s_test
    pixelData = bw1seperated_test(:,:,i);
    featureMatrixAllPixels1test(i,:) = pixelData(:);
end

for i=1:num2s
    pixelData = bw2seperated(:,:,i);
    featureMatrixAllPixels2(i,:) = pixelData(:);
end

for i=1:num2s_test
    pixelData = bw2seperated_test(:,:,i);
    featureMatrixAllPixels2test(i,:) = pixelData(:);
end

featureMatrixAllPixels01 = [featureMatrixAllPixels0; featureMatrixAllPixels1];
featureMatrixAllPixels02 = [featureMatrixAllPixels0; featureMatrixAllPixels2];
featureMatrixAllPixels01test = [featureMatrixAllPixels0test; 
                                featureMatrixAllPixels1test];
featureMatrixAllPixels02test = [featureMatrixAllPixels0test;
                                featureMatrixAllPixels2test];

clear featureMatrixAllPixels0 featureMatrixAllPixels0test;
clear featureMatrixAllPixels1 featureMatrixAllPixels1test;
clear featureMatrixAllPixels2 featureMatrixAllPixels2test;


%% Clear non feature data

clear bw0 bw0seperated bw0_test bw0seperated_test;
clear bw1 bw1seperated bw1_test bw1seperated_test;
clear bw2 bw2seperated bw2_test bw2seperated_test;
clear ims0 ims0_test ims1 ims1_test ims2 ims2_test;

%% Construct feature Matricies for 0, 1, and 2

%Construct a matrix of augmented zero vectors
zeroMatrix01 = [ConvexArea0, eccentricity0];

%Construct a matrix of augmented one vectors
oneMatrix01 = [ConvexArea1, eccentricity1];

%Construct a matrix of augmented zero vectors
zeroMatrix01_test = [ConvexArea0_test, eccentricity0_test];

%Construct a matrix of augmented one vectors
oneMatrix01_test = [ConvexArea1_test, eccentricity1_test];

%Build Into actual feautre and test matricies
featureMatrix01 = [zeroMatrix01; oneMatrix01];
labelMatrix01 = [zeros(num0s,1); ones(num1s, 1)];
featureMatrix01_test = [zeroMatrix01_test; oneMatrix01_test];
labelMatrix01_test = [zeros(num0s_test,1); ones(num1s_test, 1)];

%Construct a matrix of augmented zero vectors
zeroMatrix02 = [circularity0, perimeter0];

%Construct a matrix of augmented one vectors
twoMatrix02 = [circularity2, perimeter2];

%Construct a matrix of augmented zero vectors
zeroMatrix02_test = [circularity0_test, perimeter0_test];

%Construct a matrix of augmented one vectors
twoMatrix02_test = [circularity2_test, perimeter2_test];

%Build Into actual feautre and test matricies
featureMatrix02 = [zeroMatrix02; twoMatrix02];
labelMatrix02 = [zeros(num0s,1); ones(num2s, 1) * 2];
featureMatrix02_test = [zeroMatrix02_test; twoMatrix02_test];
labelMatrix02_test = [zeros(num0s_test,1); ones(num2s_test, 1) * 2];

%Clear non array data
clear zeroMatrix01 zeroMatrix01_test oneMatrix01 oneMatrix01_test;
clear zeroMatrix02 zeroMatrix02_test twoMatrix02 twoMatrix02_test;
clear circularity0 circularity0_test circularity2 circularity2_test;
clear ConvexArea0 ConvexArea0_test ConvexArea1 ConvexArea1_test;
clear eccentricity0 eccentricity0_test eccentricity1 eccentricity1_test;
clear perimeter0 perimeter0_test perimeter2 perimeter2_test;


%% Find k nearest neightbors and record time/accuracy
classifierTypes = {"City Block ", "Euclidian "};
for i=[1 2]
    for j=[1 3 5 11]
        fprintf("----------------------------------------------------\n");
        string = strcat("Zeros and Ones K Nearest Neighbor Classifier with\nk = %d using ", ...
                        classifierTypes{i}, "Distance Measurement " + ...
                        "and\nTwo Features\n");
        fprintf(string , j);
        tic
        outputLabels = kNearestNeightbor(featureMatrix01, labelMatrix01, featureMatrix01_test, j, i);
        toc
        
        error = CalculateClassificationError(labelMatrix01_test, outputLabels);
        fprintf("Error: %2.2f %%\n", error * 100);
        fprintf("----------------------------------------------------\n\n");
    end
end

for i=[1 2]
    for j=[1 3 5 11]
        fprintf("----------------------------------------------------\n");
        string = strcat("Zeros and Two K Nearest Neighbor Classifier with\nk = %d using ", ...
                        classifierTypes{i}, "Distance Measurement " + ...
                        "and\nTwo Features\n");
        fprintf(string , j);
        tic
        outputLabels = kNearestNeightbor(featureMatrix02, labelMatrix02, featureMatrix02_test, j, i);
        toc
        
        error = CalculateClassificationError(labelMatrix02_test, outputLabels);
        fprintf("Error: %2.2f %%\n", error * 100);
        fprintf("----------------------------------------------------\n\n");
    end
end

for i=[1 2]
    for j=[1 3 5 11]
        fprintf("----------------------------------------------------\n");
        string = strcat("Zeros and Ones K Nearest Neighbor Classifier with\nk = %d using ", ...
                        classifierTypes{i}, "Distance Measurement " + ...
                        "and\nAll Pixel Data\n");
        fprintf(string , j);
        tic
        outputLabels = kNearestNeightbor(featureMatrixAllPixels01, labelMatrix01, featureMatrixAllPixels01test, j, i);
        toc
        
        error = CalculateClassificationError(labelMatrix01_test, outputLabels);
        fprintf("Error: %2.2f %%\n", error * 100);
        fprintf("----------------------------------------------------\n\n");
    end
end

for i=[1 2]
    for j=[1 3 5 11]
        fprintf("----------------------------------------------------\n");
        string = strcat("Zeros and Twos K Nearest Neighbor Classifier with\nk = %d using ", ...
                        classifierTypes{i}, "Distance Measurement " + ...
                        "and\nAll Pixel Data\n");
        fprintf(string , j);
        tic
        outputLabels = kNearestNeightbor(featureMatrixAllPixels02, labelMatrix02, featureMatrixAllPixels02test, j, i);
        toc
        
        error = CalculateClassificationError(labelMatrix02_test, outputLabels);
        fprintf("Error: %2.2f %%\n", error * 100);
        fprintf("----------------------------------------------------\n\n");
    end
end