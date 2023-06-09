function distance = MinkowskiDistance(referenceVector,inputVector, p)
    distance = (sum((abs(inputVector - referenceVector)) .^ p)) .^ (1 / p);
end

