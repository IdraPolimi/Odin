function [ rel ] = IMout( relArr, nIng, flag )
%IMOUT Summary of this function goes here
%   Detailed explanation goes here
if (flag==0)
    rel= (relArr(1)+relArr(2)*2+relArr(3)*3+relArr(4)*2+ ...
        relArr(5)*2+relArr(6)+relArr(7)) / nIng;
elseif (flag==1)
    rel= (relArr(1)+relArr(2)+relArr(3)+relArr(4)+ ...
        relArr(5)+relArr(6)+relArr(7)) / nIng;
end
end

