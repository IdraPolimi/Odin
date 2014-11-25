function [ choice, nearestCtrs ] = cerebellum( dist, thr, ctrs )
%CEREBELLUM Summary of this function goes here
%   Detailed explanation goes here
minDist = max(dist);
for i=1:size(dist)
    if(dist(i) ~= 0)
        if(minDist > dist(i))
            minDist = dist(i)
            nearestCtrs = ctrs(i);
        end
    end
end

if(minDist < thr)
    choice = 1
else
    

end

