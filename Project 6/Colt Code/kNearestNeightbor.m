function labelVector = kNearestNeightbor(trainingData, trainingLabels, testVectors, k, p)
    labelVector = zeros(length(testVectors(:,1)), 1);

    for i=1:length(testVectors(:,1))

        distances = Inf(k, 1);

        labels = zeros(k, 1);

        for j=1:length(trainingData(:,1))
            tempDistance = MinkowskiDistance(trainingData(j, :)', ...
                                             testVectors(i, :)', p);

            distanceIndicies = tempDistance < distances;

            distanceIndex = find(distanceIndicies, 1, 'first');

            if ~isempty(distanceIndex)
                distances = [distances(1:(distanceIndex - 1))' tempDistance distances(distanceIndex:end)']';
                labels = [labels(1:(distanceIndex - 1))' trainingLabels(j,1) labels(distanceIndex:end)']';

                distances(k + 1, :) = [];
                labels(k + 1, :) = [];
            end
        end

        labelVector(i, 1) = mode(labels);
    end
end

