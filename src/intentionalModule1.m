function [ relSig, onthoSig, inputCat, ics, POI ] = intentionalModule1( args )
%INTENTIONALMODULE Summary of this function goes here
%   Detailed explanation goes here

%VAR DI CONFIGURAZIONE
relSigFromOtherLayer = args.relSigFromOtherLayer;
learningRate = args.learningRate; 
maxClusters = args.maxClusters;
inputCat = args.inputCat;
maxPoints = args.maxPoints;
phyloSig = args.phyloSig;
relThr = args.relThr;
thresholdFixingOntho = args.thresholdFixingOntho;
distThr = args.distThr;
numIM = args.numIM; %fondamentale per i caricamenti e salvataggi da file
pathSavedDoc = args.pathSavedDoc;
layer = args.layer;
%FINE VAR DI CONFIGURAZIONE
ics = args.ics;
POI = args.POI;

pathSavedDoc = strcat(pathSavedDoc,'/IM',int2str(layer),'.',int2str(numIM));

% str = datestr(clock);
% disp(sprintf('Start Load %s........ ',str))

if (ics == 0)
    
    str = datestr(clock);
    disp(sprintf('%s........ Inizio Caricamento ics IM%d.......  ',str,numIM))
    
    ics = load(strcat(pathSavedDoc,'\ics.txt'));
    
    str = datestr(clock);
    disp(sprintf('%s........ Fine Caricamento ics IM%d.......  ',str,numIM))
end
if (POI == 0)
    str = datestr(clock);
    disp(sprintf('%s........ Inizio Caricamento POI IM%d.......  ',str,numIM))
    
    POI = load(strcat(pathSavedDoc,'\POI.txt'));
    
    str = datestr(clock);
    disp(sprintf('%s........ Fine Caricamento POI IM%d.......  ',str,numIM))
end

ctrs = load(strcat(pathSavedDoc,'\ctrs.txt'));
weightsArr = load(strcat(pathSavedDoc,'\weightsArr.txt'));
numClusters = load(strcat(pathSavedDoc,'\numClusters.txt'));



inputP = inputProjection(inputCat, ics);
catOut = computeOutput(inputP, ctrs, numClusters, maxClusters);

onthoSig = onthogenetic(catOut, weightsArr); %STAMP

signals = [phyloSig, onthoSig, relSigFromOtherLayer];
relSig = max(signals);

weightsArr = hebbianLearning(pathSavedDoc ,weightsArr, relSig, catOut, learningRate, thresholdFixingOntho);
%     weightsArr = hebbianLearning(weightsArr, relSig, catOut, learningRate, thresholdFixingOntho);
    %print2file(catOut, pathSavedDoc, 'catOut', 'matrix');
print2file(weightsArr, pathSavedDoc, 'weightsArr', 'matrix');



% [~, nearestCluster] = min(distances(:));
% nearestClusterBIN = de2bi(nearestCluster, 7, 'left-msb')';
% centro = ctrs(nearestCluster,:)';
        

%categorize()
if(relSig > relThr)
    %i %phyloSig %onthoSig %relSig
    if (size(POI,1) ~= 0)
        if (maxPoints == length(POI(:,1))) %numero massimo di punti raggiunto
            %far salvare tutto e uscire
            disp('arresto per raggiunto maxPoints');
        exit;
        end
    end
    k = load(strcat(pathSavedDoc,'\k.txt'));
    POI(k,:) = inputP; %STAMP

    %print2file(POI(k,:), pathSavedDoc, 'POI', 'vector');

    k=k+1; %numero del prossimo POI da salvare;

    print2file(k, pathSavedDoc, 'k', 'matrix');

    earlyDev = load(strcat(pathSavedDoc,'\earlyDev.txt'));
    if (earlyDev == 0) %primo POI, primo passo dell'architettura
        earlyDev = earlyDev + 1;
        numClusters = 1;  
        ctrs = categorize(POI, numClusters);

        print2file(earlyDev, pathSavedDoc, 'earlyDev', 'matrix');
        print2file(ctrs, pathSavedDoc, 'ctrs', 'matrix');
        print2file(numClusters, pathSavedDoc, 'numClusters', 'matrix');
        disp('Errore nel Training, earlyDev dovrebbe essere 1 invece è 0.............')
    else
        distances = (zeros(length(ctrs(:,1)),1));
        for j=1:length(ctrs(:,1))  %calcolo le distanze dai centroidi
            distances(j) = norm(inputP'-ctrs(j,:),2);
        end

        if (min(distances) >= distThr && numClusters < maxClusters)
            numClusters = numClusters + 1;
            ctrs = categorize(POI, numClusters);
            print2file(ctrs, pathSavedDoc, 'ctrs', 'matrix');
            print2file(numClusters, pathSavedDoc, 'numClusters', 'matrix');
        else
            ctrs = categorize(POI, numClusters);
            print2file(ctrs, pathSavedDoc, 'ctrs', 'matrix');
        end
    end
end
end



