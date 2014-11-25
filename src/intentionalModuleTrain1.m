function [ inputCat, relSig, onthoSig, contIcsTmp, icsTemp, ics, POI] = intentionalModuleTrain1( i, args )
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
maxNumofIMG = args.maxNumofIMG;
contIcsTmp = args.contIcsTmp;
icsTemp = args.icsTemp;
ics = args.ics;
POI = args.POI;
layer = args.layer;
%numClusters = args.numClusters;
%earlyDev = args.earlyDev;
%FINE VAR DI CONFIGURAZIONE

relSig = -1;
onthoSig = -1;

pathSavedDoc = strcat(pathSavedDoc,'/IM',int2str(layer),'.',int2str(numIM));

if (exist(strcat(pathSavedDoc, '\ics.txt'), 'file') == 2)
    if (contIcsTmp == 1)
        str = datestr(clock);
        disp(sprintf('ics già creati per lo IM%d.........%s...',numIM, str))
        contIcsTmp = contIcsTmp + 1;
%         ics = load(strcat(pathSavedDoc,'\ics.txt'));
    end
else
    if (contIcsTmp == 1)
        str = datestr(clock);
        disp(sprintf('INIZIO DEL IM....%d........%s...',numIM, str))

    %     inputIM = imread(strcat(args.strImg,'100.png')); TROPPO PESANTE IL SAVE
    %     inputSize = size(inputIM,1)*size(inputIM,2);
        icsTemp = zeros(1,length(inputCat));
        weightsArr = zeros(maxClusters,1);
        k = 1;
        numClusters = 0;
        earlyDev = 0;

        print2file(k, pathSavedDoc, 'k', 'matrix');
    %     print2file('', pathSavedDoc, 'icsTemp','matrix');
        print2file(earlyDev, pathSavedDoc, 'earlyDev','matrix');
        print2file(weightsArr, pathSavedDoc, 'weightsArr','matrix');
        print2file(numClusters, pathSavedDoc, 'numClusters','matrix');


        print2file(weightsArr, pathSavedDoc, 'weightsArrFull','matrix');
    else
    %     icsTemp = load(strcat(pathSavedDoc,'\icsTemp.txt'));
    end

    % if (i<=ceil((maxNumofIMG)/2))
    if (i<=maxNumofIMG)

        icsTemp(contIcsTmp,:) = inputCat';

    %     print2file(icsTemp(contIcsTmp,:), pathSavedDoc, 'icsTemp','vector');

        contIcsTmp = contIcsTmp + 1;

        %if(i== ceil((maxNumofIMG)/2))
        if(i==maxNumofIMG)

            if (exist(strcat(pathSavedDoc, '\ics.txt'), 'file') == 2)
                str = datestr(clock);
                disp(sprintf('ics già creati.........%s...', str))
                ics = load(strcat(pathSavedDoc,'\ics.txt'));
            else
    %             str = datestr(clock);
    %             disp(sprintf('Saving icsTemp.........%s...', str))
    % 
    % 
    %             print2file(icsTemp, pathSavedDoc, 'icsTemp','matrix');
    % 
    %             str = datestr(clock);
    %             disp(sprintf('End saving icsTemp & Start Calculating ICA.........%s...', str))

                str = datestr(clock);
                disp(sprintf('Start Calculating ICA.........%s...', str))

                ics = ica(icsTemp);

                str = datestr(clock);
                disp(sprintf('End Calculating ICA.........%s...', str))
            end

            contIcsTmp = 0;
            POI = zeros(1, length(ics(:,1)));
            ctrs = zeros(maxClusters, length(ics(:,1)));

            %print2file(ics, pathSavedDoc, 'ics', 'matrix');
            print2file('', pathSavedDoc, 'POI', 'matrix');
            print2file(ctrs, pathSavedDoc, 'ctrs','matrix');

        end

    % else
    %     if (numIM == 1)
    % %         if (ics == 0)
    % %             ics = load(strcat(pathSavedDoc,'\ics.txt'));
    % %         end
    %         if (POI == 0)
    %             POI = load(strcat(pathSavedDoc,'\POI.txt'));
    %         end
    %     end
    % 
    %     ctrs = load(strcat(pathSavedDoc,'\ctrs.txt'));
    %     weightsArr = load(strcat(pathSavedDoc,'\weightsArr.txt'));
    %     numClusters = load(strcat(pathSavedDoc,'\numClusters.txt'));
    %     
    %     inputP = inputProjection(inputCat, ics);
    %     catOut = computeOutput(inputP, ctrs, numClusters, maxClusters);
    %     onthoSig = onthogenetic(catOut, weightsArr); %STAMP
    % 
    %     signals = [phyloSig, onthoSig, relSigFromOtherLayer];
    %     relSig = max(signals);
    %     weightsArr = hebbianLearning(pathSavedDoc ,weightsArr, relSig, catOut, learningRate, thresholdFixingOntho);
    % %     weightsArr = hebbianLearning(weightsArr, relSig, catOut, learningRate, thresholdFixingOntho);
    %     
    %     print2file(catOut, pathSavedDoc, 'catOut', 'matrix');
    %     print2file(weightsArr, pathSavedDoc, 'weightsArr', 'matrix');
    %     
    %     distances = (zeros(length(ctrs(:,1)),1));
    %     for j=1:length(ctrs(:,1))  %calcolo le distanze dai centroidi
    %         distances(j) = norm(inputP'-ctrs(j,:),2);
    %     end
    % % 
    % %     [useless, nearestCluster] = min(distances(:));
    % %     nearestClusterBIN = de2bi(nearestCluster, 7, 'left-msb')';
    %     
    %     %categorize()
    %     if(relSig > relThr)
    %         %i %phyloSig %onthoSig %relSig
    %         if (size(POI,1) ~= 0)
    %             if (maxPoints == length(POI(:,1))) %numero massimo di punti raggiunto
    %                 %far salvare tutto e uscire
    %                 disp('Arresto per raggiunto maxPoints...........END');
    %             exit;
    %             end
    %         end
    %         k = load(strcat(pathSavedDoc,'\k.txt'));
    %         
    % %         flagNotExist = 1;
    % %         
    % %         for s=1:size(POI,1)
    % %             if (isempty(find(POI(s,:)) == inputP)) 
    % %             else
    % %                 flagNotExist = 0;
    % %                 break;
    % %             end
    % %         end
    % %         if (flagNotExist == 1)
    %         POI(k,:) = inputP; %STAMP
    %         
    %         %print2file(POI(k,:), pathSavedDoc, 'POI', 'vector');
    %         
    %         k=k+1; %numero del prossimo POI da salvare;
    %         
    %         print2file(k, pathSavedDoc, 'k', 'matrix');
    %         
    %         earlyDev = load(strcat(pathSavedDoc,'\earlyDev.txt'));
    %         if (earlyDev == 0) %primo POI, primo passo dell'architettura
    %             earlyDev = earlyDev + 1;
    %             numClusters = 1;  
    %             ctrs = categorize(POI, numClusters);
    %             
    %             print2file(earlyDev, pathSavedDoc, 'earlyDev', 'matrix');
    %             print2file(ctrs, pathSavedDoc, 'ctrs', 'matrix');
    %             print2file(numClusters, pathSavedDoc, 'numClusters', 'matrix');
    %             
    %         else
    %             
    %             if (min(distances) >= distThr && numClusters < maxClusters)
    %                 numClusters = numClusters + 1;
    %                 ctrs = categorize(POI, numClusters);
    %                 print2file(ctrs, pathSavedDoc, 'ctrs', 'matrix');
    %                 print2file(numClusters, pathSavedDoc, 'numClusters', 'matrix');
    %             else
    %                 ctrs = categorize(POI, numClusters);
    %                 print2file(ctrs, pathSavedDoc, 'ctrs', 'matrix');
    %             end
    %         end
    % %         end
    %     end
    end
end

end

