function prediction = kNN(train1,train2,test1,test2,k,p)
%kNN K Nearest Neighbor function classifies test data based on training
%data
%   train1 is the feature vector for one class
%   train2 is the feature vector for another class
%   test is the input data to be classified
%   k is the amount of neighbors to consider
%   p is the distance_metric and decides what distance measure to use 
%   (Euclidian,Manhattan, Hamming or others)

%initialize predicion matrix 
prediction = zeros(size(test1,1));

    for sample_n = 1:size(test1,1)
        %Initialize nearest neighbor list
        nn_list = Inf(k,1);
    
        %take mode on nn_list to gather votes and make prediction
        prediction(sample_n) = mode(nn_list);
    end



end