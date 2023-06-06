function distance = find_distance(vector1,vector2, p)
%find_distance This function takes the Minkowski Distance of a set of data
%   Vector1 is one point
%   Vector2 is another point
%   p is the distance_metric and decides what distance measure to use (Euclidian,
%   Manhattan, Hamming or others)

distance = sum(((vector1-vector2).^p))^(1/p);

end