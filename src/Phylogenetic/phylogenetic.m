function [ phyloSignal ] = Phylogenetic( filteredInput, min, max )
%PHYLOGENETIC [phyloSignal] -> modulo phylogenetico, come input riceve i segnali già filtrati (uno alla votla e le due soglie max e min 
%   Detailed explanation goes here
%prove
prova = zeros(length(filteredInput));
tot=0;
%prove fine

cont = 0;
for i=1:length(filteredInput)
       
    if (min <= filteredInput(i) && filteredInput(i) <= max)
        cont = cont + 1;
        prova(cont) = filteredInput(i);
    end
end

    
for i=1:cont
    tot = tot+prova(cont);
end
phyloSignal = tot/cont;

    %phyloSignal=cont/length(filteredInput);
end

