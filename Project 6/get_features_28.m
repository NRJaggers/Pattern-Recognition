function features = get_features(bw_mnist_im)
%GET_FEATURES get all regionprop features from mnist training pictures
%   input photo must be a binary image

% go through 28x28 bit samples one by one
i = 1;
total_samples = (size(bw_mnist_im,1)/28)*(size(bw_mnist_im,2)/28);
features = zeros(total_samples,(28*28));
for m = 1:28:size(bw_mnist_im,1)
    for n = 1:28:size(bw_mnist_im,2)
        sample = bw_mnist_im(m:m+27, n:n+27);
        %row = m/28 + 1;
        %col = n/28 + 1;        
        %imshow(sample);
        features(i,:) = sample(:)';
        %features{i} = regionprops(sample,"Area", "Circularity", "Eccentricity","Orientation");
        i = i + 1;
    end
end

