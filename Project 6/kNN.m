function prediction = kNN(train1,train2,test,k,p)
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

%create total training points and label matrix
totalpoints = [train1;train2];
data_label = [ones(size(train1,1),1),ones(size(train2,1),1)*2];

    for sample_n = 1:size(test1,1)
        %Initialize nearest neighbor list
        nn_list = Inf(k,1);
        nn_dist = Inf(k,1);
        %create column vector sample from test data
        sample = test1(sample_n,:)';

        %calculate distance from sample to all training points and find
        %nearest neighbors
        for datapoint_n = 1: size(totalpoints,1)
            %create column vector sample from datapoints
            datapoint = totalpoints(datapoint_n,:)';
            dist = find_distance(sample,datapoint,p);

            %test if distance is less than value in list
            %if so, replace value in nn_list and nn_dist
            dist_lt = find(dist<nn_dist,1);
            if (~isempty(dist_lt))
                nn_dist(dist_lt) = dist;
                nn_list(dist_lt) = data_label(datapoint_n);
            end
            
        end
    
        %take mode on nn_list to gather votes and make prediction
        prediction(sample_n) = mode(nn_list);
    end



end