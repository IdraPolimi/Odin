function [ ctrs ] = Categorize( M, numCtrs )
%CATEGORIZE input: pointsMatrix, numberOfCentroids ----- output:centoidsArr
%   Detailed explanation goes here

[idx, ctrs] = kmeans(M, numCtrs, 'EmptyAction','singleton', 'onlinephase','on');


end

