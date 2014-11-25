function print2file(variable, pathVar, fileName, fileTypeStr)
% salva su file di nome fileName+.txt nella cartella path 
% crea una cartella per IM e salva all'interno
%display('Avvio salvataggio POI del modulo ') 
%display (int2str(cont))
%strIM=strcat(path,int2str(cont));
if (exist(pathVar,'dir')~= 7)
    mkdir(pathVar);%creo la cartella dell'IM attuale
end
nomefile=strcat(fileName,'.txt');

if (exist(pathVar,'file')~= 2)
  %  save(strcat(pathVar,'/',nomefile));%creo il file txt
end


 

%csvwrite(strcat(pathVar,'/',nomefile), variable);
switch (fileTypeStr)
    
    case 'matrix'
        testo=fopen(strcat(pathVar,'/',nomefile),'W');%apro per editare
        for i=1:size(variable,1);%ciclo riga
         for j=1:size(variable,2);%ciclo colonna
            if j==size(variable,2);% inserisce ; a fine riga
                fprintf(testo,'%6.9f ;\n',variable(i,j));
            else
                fprintf(testo,'%6.9f , \t', variable(i,j));
            end
         end
        end
        
    case 'vector'
        testo=fopen(strcat(pathVar,'/',nomefile),'A');%apro per editare
        %fseek(testo, 0, 'eof');
        for j=1:max(size(variable));
            if (j==max(size(variable)))
                fprintf(testo,'%6.9f ;\n',variable(j));
            else
                fprintf(testo,'%6.9f ,\t',variable(j));
            end
        end
end

fclose(testo);

%display('Completato')