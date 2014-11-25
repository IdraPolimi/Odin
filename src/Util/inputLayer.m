function [ outArr ] = inputLayer( flag, arr1, arr2, arr3 )
%Flag = #array to merge; if you have only 2 array put arr3 = 0
%   Detailed explanation goes here
if(flag == 0)
    
    outArr = cat(1,arr1, arr2)';
 
elseif(flag == 1)
    
    outArr = cat(1, arr1, arr2, arr3)';
    
elseif (flag == 2)
    
    for i=1:length(arr1)
        outArr (i) = (arr1(i) + arr2(i)) /2;
    end
    
elseif (flag == 3)

    for i=1:length(arr1)
        outArr (i) = (arr1(i) + arr2(i) + arr3(i)) /3;
    end

end

outArr = outArr'; %deve essere un vettore colonna quando viene ritornato

end
