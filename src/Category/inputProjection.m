function [ inputProjected ] = inputProjection( input, ics )
%INPUTPROJECTION [inputProjected] -> prende in ingresso l'input del categorization e lo spazio delle componenti indipendenti per ritornare la proiezione in questo spazio dell'input.
%   Detailed explanation goes here

media = mean(input);
    for i=1:length(input)
        input(i) = input(i) - media;
    end
%     
%     size(ics)
%     size(input)
    
temp = ics * input;
norma = norm(temp,2);
if (norma == 0)
    inputProjected = zeros(length(temp),1);
else
inputProjectedTemp = zeros(length(temp),1);
    for i=1:length(temp)
        inputProjectedTemp(i) = temp(i) / norma;
    end
    
    inputProjected = inputProjectedTemp;
end
end

