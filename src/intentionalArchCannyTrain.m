function [inputCat, relSig, onthoSig, contIcsTmp,icsTemp, ics, POI ] = intentionalArchCannyTrain( i, args )
%INTENTIONALARCH Summary of this function goes here
%   Detailed explanation goes here

pathImg = args.pathImg;
numIM = args.numIM;
relSigFromOtherLayer = args.relSigFromOtherLayer;
contIcsTmp = args.contIcsTmp;
strImg = args.strImg;
learningRate = args.learningRate;
maxClusters = args.maxClusters;
maxPoints = args.maxPoints;
maxNumofIMG = args.maxNumofIMG;
relThr = args.relThr;
thresholdFixingOntho = args.thresholdFixingOntho;
distThr = args.distThr;
pathSavedDoc = args.pathSavedDoc;
icsTemp = args.icsTemp;
minPhylo = args.minPhylo;
maxPhylo = args.maxPhylo;
ics = args.ics;
POI = args.POI;
layer = args.layer;

%test audio in fase
% inputCat = wavread(strcat(pathImg,strImg,int2str(i),'.wav')); %inserire nome sequenziale
% inputCat = createInputIA(inputCat, 4);

inputCat = imread(strcat(pathImg,strImg,int2str(i),'.png')); %inserire nome sequenziale
inputCat = createInputIA(inputCat, 3);

% inputPhy = imread(strcat(pathImg,strImg,int2str(i),'.png'));
% inputPhy = createInputIA(inputPhy, 2);
% imgPhy = inputPhy;
% phyloSig = phylogenetic(imgPhy, minPhylo, maxPhylo);

%riconoscimento di immagini BW con un phylo alto
phyloSig = 0.9;

structIM1 = struct('learningRate', learningRate, 'relSigFromOtherLayer', relSigFromOtherLayer,...
    'maxClusters', maxClusters,'ics', ics,'layer', layer, 'POI', POI, 'inputCat', inputCat, 'maxPoints', ...
    maxPoints,'phyloSig',phyloSig, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'numIM', numIM, 'pathSavedDoc', pathSavedDoc, ...
    'maxNumofIMG', maxNumofIMG, 'contIcsTmp', contIcsTmp, 'strImg', strImg, 'icsTemp', icsTemp);

[~, relSig, onthoSig, contIcsTmp, icsTemp, ics, POI] = intentionalModuleTrain1(i, structIM1);

end

