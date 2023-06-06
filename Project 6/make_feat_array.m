function featureArray = make_feat_array(features)
%MAKE_FEAT_ARRAY take features, select certain ones and put into an array
%   Detailed explanation goes here

count = 1;
featureArray = zeros(length(features),length(fieldnames(features{1})));
for index = 1 : length(features);
    if (length(features{index}) > 0)
        featureArray(count,1) = features{index}.Eccentricity;
        featureArray(count,2) = features{index}.MinorAxisLength;
        featureArray(count,3) = features{index}.Circularity;
        featureArray(count,4) = features{index}.Perimeter;
        count = count + 1;
    end
end

end