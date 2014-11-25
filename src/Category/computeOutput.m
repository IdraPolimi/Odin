function [ outputCat ] = computeOutput( inputProjected, centroids, numOfClusters, maxNumOfClusters )
%COMPUTEOUTPUT [outputCat] -> prende in ingresso l'inputProiettato, la matrice dei centroidi, numeroDiCluster e numeroMassimoDiCluster.
%   Detailed explanation goes here

%fixme....se il numero di cluster è zero devo avviare kmeans

outputCat = zeros(maxNumOfClusters, 1);
for i=1:numOfClusters
    outputCat(i,1) = 1 - tanh(norm(inputProjected'-centroids(i,:),2));
end

end

