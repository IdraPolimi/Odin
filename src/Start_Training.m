%rmdir('IMSdoc','s');

disp('........................TRAINING START...........................');

datestr(clock)

%CONFIG VARS
maxNumofIMG = 50; % per test 200 per provare il sistema 400
learningRate = 0.1; %discount factor hebbian learning
maxClusters = 128;
maxPoints = 6001;
minPhylo = 0.55;
maxPhylo = 1;
pathImg = 'Images/Faces/fra/'; % per test test1/ per provare il sistema test/


strImg = 'img';
pathSavedDoc = 'IMSdoc';
disc = 0.905; %0.905 EX-TER-MI-NA-TE
%END CONFIG VARS

%DECL & INIT COMMON PARAM FOR IM
relThr = 0.6;
thresholdFixingOntho = 0.8;
distThr = 0.652;%sqrt(length(ics(:,1))/89); %magically magical ...EX-TER-MI-NATE!

%Display Vars
contDispTrain = 1;
%Display Vars END

%START: global var init
if (~exist('ics')) 
ics = 0;
end
if(~exist('POI'))
POI = 0;
end
%END: global var init



icsTemp = 0;

contIcsTmp = 1;

str = datestr(clock);
disp(sprintf('Inizio addestramento primo IM ......%s.....',str)); 
for i=1:maxNumofIMG
    
    if(mod(i,10) == 0)
        str = datestr(clock);
        disp(sprintf('......%d immagini......%s..........',i, str))
    end    
    structIA1 = struct ('pathImg', pathImg,'numIM', 1, 'relSigFromOtherLayer', -1,...
        'contIcsTmp', contIcsTmp, 'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
        'maxNumofIMG', maxNumofIMG, 'relThr', relThr, 'thresholdFixingOntho', ...
        thresholdFixingOntho,'ics', ics, 'POI', POI, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, 'icsTemp', icsTemp, 'layer', 1);

   [~, relSig1, onthoSig1, contIcsTmp, icsTemp, ics, POI] = intentionalArchTrain(i, structIA1);
%    if(onthoSig ~= -1)
%        ontoMatTrain1(contDispTrain) = (onthoSig);
%        contDispTrain = contDispTrain + 1;
%    end
end

%START: re-initialize variables
contIcsTmp = 1;
icsTemp = 0;
%contDispTrain = 1;
%END: re-initialize variables
str = datestr(clock);
disp(sprintf('Inizio addestramento secondo IM ......%s.....',str));

for i=1:maxNumofIMG
    if(mod(i,10) == 0)
        str = datestr(clock);
        disp(sprintf('......%d immagini......%s..........',i, str))
    end
    structIA1 = struct ('numIM', 1, 'pathImg', pathImg, 'relSigFromOtherLayer', -1,...
    'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
    'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
    'relThr', relThr,'ics', ics, 'POI', POI,  'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc);

   [relSig1, onthoSig1, catOut1, ics, POI] = intentionalArch(i, structIA1);

   phyloSig = -1; %nel secondo non c'� il phylogenetic ma l'architettura vuole cmq un parametro
   
    structIM2 = struct ('numIM', 2, 'inputCat', catOut1, 'relSigFromOtherLayer', relSig1*disc,...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp);

    [relSig2, onthoSig2, contIcsTmp, icsTemp] = intentionalModuleTrain1(i, structIM2);

end


%START: re-initialize variables
contIcsTmp = 1;
icsTemp = 0;
%contDispTrain = 1;
%END: re-initialize variables

str = datestr(clock);
disp(sprintf('Inizio addestramento terzo IM ......%s.....',str));
for i=100:maxNumofIMG
    if(mod(i,10) == 0)
        str = datestr(clock);
        disp(sprintf('......%d immagini......%s..........',i, str))
    end
    structIA1 = struct ('numIM', 1, 'pathImg', pathImg, 'relSigFromOtherLayer', -1,...
    'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
    'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
    'relThr', relThr,'ics', ics, 'POI', POI,  'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc);

   [relSig1, onthoSig1, catOut1, ics, POI] = intentionalArch(i, structIA1);
   
    phyloSig = -1; %nel secondo non c'� il phylogenetic ma l'architettura vuole cmq un parametro
   
   structIM2 = struct('numIM', 2, 'inputCat', catOut1,'relSigFromOtherLayer', relSig1*disc, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig2, onthoSig2, catOut2] = intentionalModule(structIM2);

   phyloSig = -1; %nel secondo non c'� il phylogenetic ma l'architettura vuole cmq un parametro
   
    structIM3 = struct ('numIM', 3, 'inputCat', catOut2, 'relSigFromOtherLayer', relSig2*disc,...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp);

    [relSig3, onthoSig3, contIcsTmp, icsTemp] = intentionalModuleTrain(i, structIM3);

%    if(onthoSig1 ~= -1)
%        ontoMat(contDispTrain) = (onthoSig);
%        ontoMat1(contDispTrain) = (onthoSig1);
%        contDispTrain = contDispTrain + 1;
%    end
end



%START: re-initialize variables
contIcsTmp = 1;
icsTemp = 0;
%contDispTrain = 1;
%END: re-initialize variables

str = datestr(clock);
disp(sprintf('Inizio addestramento quarto IM ......%s.....',str));
for i=1:maxNumofIMG
    if(mod(i,10) == 0)
        str = datestr(clock);
        disp(sprintf('......%d immagini......%s..........',i, str))
    end
    structIA1 = struct ('numIM', 1, 'pathImg', pathImg, 'relSigFromOtherLayer', -1,...
    'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
    'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
    'relThr', relThr,'ics', ics, 'POI', POI,  'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc);

   [relSig1, onthoSig1, catOut1, ics, POI] = intentionalArch(i, structIA1);
   
    phyloSig = -1; %nel secondo non c'� il phylogenetic ma l'architettura vuole cmq un parametro
   
   structIM2 = struct('numIM', 2, 'inputCat', catOut1,'relSigFromOtherLayer', relSig1*disc,...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig2, onthoSig2, catOut2] = intentionalModule(structIM2);

   phyloSig = -1; %nel secondo non c'� il phylogenetic ma l'architettura vuole cmq un parametro
   
   structIM3 = struct('numIM', 3, 'inputCat', catOut2,'relSigFromOtherLayer', relSig2*disc,...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig3, onthoSig3, catOut3] = intentionalModule(structIM3);

   phyloSig = -1; %nel secondo non c'� il phylogenetic ma l'architettura vuole cmq un parametro
   
    structIM4 = struct ('numIM', 4, 'inputCat', catOut3, 'relSigFromOtherLayer', relSig3*disc,...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp);

    [relSig4, onthoSig4, contIcsTmp, icsTemp] = intentionalModuleTrain(i, structIM4);

%    if(onthoSig1 ~= -1)
%        ontoMat(contDispTrain) = (onthoSig);
%        ontoMat1(contDispTrain) = (onthoSig1);
%        contDispTrain = contDispTrain + 1;
%    end
end

%START: re-initialize variables
contIcsTmp = 1;
icsTemp = 0;
contDispTrain = 1;
%END: re-initialize variables

str = datestr(clock);
disp(sprintf('Inizio addestramento quinto IM ......%s.....',str));
for i=1:maxNumofIMG
    if(mod(i,10) == 0)
        str = datestr(clock);
        disp(sprintf('......%d immagini......%s..........',i, str))
    end
    structIA1 = struct ('numIM', 1, 'pathImg', pathImg, 'relSigFromOtherLayer', -1,...
    'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
    'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
    'relThr', relThr,'ics', ics, 'POI', POI,  'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc);

   [relSig1, onthoSig1, catOut1, ics, POI] = intentionalArch(i, structIA1);
   
    phyloSig = -1; %nel secondo non c'� il phylogenetic ma l'architettura vuole cmq un parametro
   
   structIM2 = struct('numIM', 2, 'inputCat', catOut1,'relSigFromOtherLayer', relSig1*disc,...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig2, onthoSig2, catOut2] = intentionalModule(structIM2);

   phyloSig = -1; %nel secondo non c'� il phylogenetic ma l'architettura vuole cmq un parametro
   
   structIM3 = struct('numIM', 3, 'inputCat', catOut2,'relSigFromOtherLayer', relSig2*disc,...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig3, onthoSig3, catOut3] = intentionalModule(structIM3);
    
    phyloSig = -1; %nel secondo non c'� il phylogenetic ma l'architettura vuole cmq un parametro
   
   structIM4 = struct('numIM', 4, 'inputCat', catOut3,'relSigFromOtherLayer', relSig3*disc,...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig4, onthoSig4, catOut4] = intentionalModule(structIM4);

   phyloSig = -1; %nel secondo non c'� il phylogenetic ma l'architettura vuole cmq un parametro
   
    structIM5 = struct ('numIM', 5, 'inputCat', catOut4, 'relSigFromOtherLayer', relSig4*disc,...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp);

    [relSig5, onthoSig5, contIcsTmp, icsTemp] = intentionalModuleTrain(i, structIM5);

   if(onthoSig5 ~= -1)
       ontoMat1(contDispTrain) = (onthoSig1);
       ontoMat2(contDispTrain) = (onthoSig2);
       ontoMat3(contDispTrain) = (onthoSig3);
       ontoMat4(contDispTrain) = (onthoSig4);
       ontoMat5(contDispTrain) = (onthoSig5);
       contDispTrain = contDispTrain + 1;
   end
end

str = datestr(clock);
disp(sprintf('..............%s............',str))
disp('...........................TRAINING END...........................');

