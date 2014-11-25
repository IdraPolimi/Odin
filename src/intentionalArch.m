function [ relSig, onthoSig, catOut, ics, POI ] = intentionalArch( i, args )
%INTENTIONALARCH Summary of this function goes here
%   Detailed explanation goes here

pathImg = args.pathImg;
relSigFromOtherLayer = args.relSigFromOtherLayer;
numIM = args.numIM;
strImg = args.strImg;
learningRate = args.learningRate;
maxClusters = args.maxClusters;
maxPoints = args.maxPoints;
relThr = args.relThr;
thresholdFixingOntho = args.thresholdFixingOntho;
distThr = args.distThr;
pathSavedDoc = args.pathSavedDoc;
minPhylo = args.minPhylo;
maxPhylo = args.maxPhylo;
ics = args.ics;
POI = args.POI;
layer = args.layer;

%test audio in ampiezza
inputCat = wavread(strcat(pathImg,strImg,int2str(i),'.wav')); %inserire nome sequenziale
inputCat = createInputIA(inputCat, 4);

% inputCat = imread(strcat(pathImg,strImg,int2str(i),'.png')); %inserire nome sequenziale
% inputCat = createInputIA(inputCat, 1);

% inputPhy = imread(strcat(pathImg,strImg,int2str(i),'.png'));
% inputPhy = createInputIA(inputPhy, 1);
% imgPhy = inputPhy;
% phyloSig = phylogenetic(imgPhy, minPhylo, maxPhylo);

%riconoscimento di immagini BW con un phylo alto
phyloSig = 0;

structIM = struct('learningRate', learningRate, 'relSigFromOtherLayer', relSigFromOtherLayer,...
    'maxClusters', maxClusters, 'inputCat', inputCat,'ics', ics, 'POI', POI, 'maxPoints', ...
    maxPoints,'phyloSig',phyloSig, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'numIM', numIM, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg,'layer', layer);

[relSig, onthoSig, catOut, ics, POI] = intentionalModule1(structIM);


end

