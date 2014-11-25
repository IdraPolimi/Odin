disp('........................TESTING START...........................');

warning('off','all');
%CONFIG VARS
maxNumofIMG =500; % per test 200 per provare il sistema 400
learningRate = 0.1; %discount factor hebbian learning
maxClusters = 128;
maxPoints = 6001;
minPhylo = 0.55;
maxPhylo = 1;
pathImg = 'testingYale/';
strImg = 'img'; % img per qualsiasi test, img028-00 per test duro
pathSavedDoc = 'IMSdoc';
%END CONFIG VARS

%DECL & INIT COMMON PARAM FOR IM
relThr = 0.6;
thresholdFixingOntho = 0.8;
distThr = 0.652;%sqrt(length(ics(:,1))/89); % 0.652 magically magical ...EX-TER-MI-NATE!
disc = 1; %0.905 EX-TER-MI-NATE

%Display Vars
contDispTrain = 1;
%Display Vars END
%START: global var init
if (~exist('ics1'))
ics1=0;
ics2=0;
ics3=0;
ics4=0;
ics5=0;
ics6=0;
ics7=0;
ics8=0;
ics9=0;
ics10=0;
ics11=0;
ics12=0;
end
if(~exist('POI1'))
POI1 = 0;
POI2 = 0;
POI3 = 0;
POI4 = 0;
POI5 = 0;
POI6 = 0;
POI7 = 0;
POI8 = 0;
POI9 = 0;
POI10 = 0;
POI11 = 0;
POI12 = 0;
end
%END: global var init



str = datestr(clock);
disp(sprintf('Start Testing %s........ ',str))
for i=1:maxNumofIMG
    
    if(mod(i,10) == 0)
        str = datestr(clock);
        disp(sprintf('......%d immagini......%s..........',i, str))
    end

    structIA1 = struct ('layer', 1,'numIM', 1, 'pathImg', pathImg, 'relSigFromOtherLayer', -1,...
    'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
    'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
    'relThr', relThr,'ics', ics1, 'POI', POI1,  'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc);

   [relSig1, ontoSig1, catOut1, ics1, POI1] = intentionalArch(i, structIA1);

   phyloSig = 0; %nel secondo non c'è il phylogenetic ma l'architettura vuole cmq un parametro
   
    structIA2 = struct ('layer', 1,'numIM', 2, 'pathImg', pathImg, 'relSigFromOtherLayer', -1,...
    'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
    'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
    'relThr', relThr,'ics', ics2, 'POI', POI2,  'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc);

   [relSig2, ontoSig2, catOut2, ics2, POI2] = intentionalArchCanny(i, structIA2);
   
   structIM3 = struct('layer', 2,'numIM', 3, 'inputCat', catOut1,'relSigFromOtherLayer', relSig1*disc, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics3, 'POI', POI3, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig3, ontoSig3, catOut3, ics3, POI3] = intentionalModule1(structIM3);

    structIM4 = struct('layer', 2,'numIM', 4, 'inputCat', inputLayer(2,catOut1, catOut2, 0),'relSigFromOtherLayer', (relSig2*disc+relSig1*disc)/2, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics4, 'POI', POI5, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig4, ontoSig4, catOut4, ics4, POI4] = intentionalModule1(structIM4);

   structIM5 = struct('layer', 2,'numIM', 5, 'inputCat', catOut2,'relSigFromOtherLayer', relSig2*disc, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics5, 'POI', POI5, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig5, ontoSig5, catOut5, ics5, POI5] = intentionalModule1(structIM5);

    structIM6 = struct('layer', 3,'numIM', 6, 'inputCat', catOut3,'relSigFromOtherLayer', relSig3*disc, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics6, 'POI', POI6, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [~, ontoSig6, ~, ics6, POI6] = intentionalModule1(structIM6);

    structIM7 = struct('layer', 3,'numIM', 7, 'inputCat', inputLayer(2,catOut3, catOut4, 0),'relSigFromOtherLayer', (relSig3*disc+relSig4*disc)/2, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics7, 'POI', POI7, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [~, ontoSig7, ~, ics7, POI7] = intentionalModule1(structIM7);

    structIM8 = struct('layer', 3,'numIM', 8, 'inputCat', inputLayer(3,catOut3, catOut4, catOut5),'relSigFromOtherLayer', (relSig3*disc+relSig4*disc+relSig5*disc)/3, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics8, 'POI', POI8, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [~, ontoSig8, ~, ics8, POI8] = intentionalModule1(structIM8);

    structIM9 = struct('layer', 3,'numIM', 9, 'inputCat', inputLayer(2,catOut4, catOut5, 0),'relSigFromOtherLayer', (relSig5*disc+relSig4*disc)/2, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics9, 'POI', POI9, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [~, ontoSig9, ~, ics9, POI9] = intentionalModule1(structIM9);

    structIM10 = struct('layer', 3,'numIM', 10, 'inputCat', inputLayer(2,catOut3, catOut5, 0),'relSigFromOtherLayer', (relSig3*disc+relSig5*disc)/2, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics10, 'POI', POI10, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [~, ontoSig10, ~, ics10, POI10] = intentionalModule1(structIM10);

    structIM11 = struct('layer', 3,'numIM', 11, 'inputCat', catOut5,'relSigFromOtherLayer', relSig5*disc, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics11, 'POI', POI11, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [~, ontoSig11, ~, ics11, POI11] = intentionalModule1(structIM11);

    structIM12 = struct('layer', 3,'numIM', 12, 'inputCat', catOut4,'relSigFromOtherLayer', relSig4*disc, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics12, 'POI', POI12, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [~, ontoSig12, ~, ics12, POI12] = intentionalModule1(structIM12);

   if(ontoSig4 ~= -1)
       ontoMatTest1(contDispTrain) = (ontoSig1);
       ontoMatTest2(contDispTrain) = (ontoSig2);
       ontoMatTest3(contDispTrain) = (ontoSig3);
       ontoMatTest4(contDispTrain) = (ontoSig4);
       ontoMatTest5(contDispTrain) = (ontoSig5);
       ontoMatTest6(contDispTrain) = (ontoSig6);
       ontoMatTest7(contDispTrain) = (ontoSig7);
       ontoMatTest8(contDispTrain) = (ontoSig8);
       ontoMatTest9(contDispTrain) = (ontoSig9);
       ontoMatTest10(contDispTrain) = (ontoSig10);
       ontoMatTest11(contDispTrain) = (ontoSig11);
       ontoMatTest12(contDispTrain) = (ontoSig12);
       contDispTrain = contDispTrain + 1;
   end
   
   
   relArr =[ontoSig6,ontoSig7,ontoSig8,ontoSig9,ontoSig10,ontoSig11,ontoSig12];
    %ogni colonna rappresenta il riconoscimento di una sola lettera da ...
    %tutti i moduli
%     val(dalek,strax) = IMout(relArr,12);
    temp = IMout(relArr,12);
%     if (exist('val', 'var'))
%         if (length(val)>= strax)
%             diffe(strax) = temp - val(strax);
%         end
%     end
    val(strax) = temp;
   
end

str = datestr(clock);
    disp(sprintf('%s..........INIZIO STAMPE...................',str))

if (exist(strcat('IMSdoc\IM1.1', '\ics.txt'), 'file') == 2)
    str = datestr(clock);
    disp(sprintf('Non scrivo ics tutti layer ......%s.....',str))
else
    str = datestr(clock);
    disp(sprintf('Inizio scrittura ics tutti layer ......%s.....',str))
    print2file(ics1, 'IMSdoc\IM1.1','ics', 'matrix');
    print2file(ics2, 'IMSdoc\IM1.2','ics', 'matrix');
    print2file(ics3, 'IMSdoc\IM2.3','ics', 'matrix');
    print2file(ics4, 'IMSdoc\IM2.4','ics', 'matrix');
    print2file(ics5, 'IMSdoc\IM2.5','ics', 'matrix');
    print2file(ics6, 'IMSdoc\IM3.6','ics', 'matrix');
    print2file(ics7, 'IMSdoc\IM3.7','ics', 'matrix');
    print2file(ics8, 'IMSdoc\IM3.8','ics', 'matrix');
    print2file(ics9, 'IMSdoc\IM3.9','ics', 'matrix');
    print2file(ics10, 'IMSdoc\IM3.10','ics', 'matrix');
    print2file(ics11, 'IMSdoc\IM3.11','ics', 'matrix');
    print2file(ics12, 'IMSdoc\IM3.12','ics', 'matrix');

    str = datestr(clock);
    disp(sprintf('Fine scrittura ics tutti layer ......%s.....',str))
end

str = datestr(clock);
disp(sprintf('Inizio scrittura POI tutti layer ......%s.....',str))
print2file(POI1, 'IMSdoc\IM1.1','POI', 'matrix');
print2file(POI2, 'IMSdoc\IM1.2','POI', 'matrix');
print2file(POI3, 'IMSdoc\IM2.3','POI', 'matrix');
print2file(POI4, 'IMSdoc\IM2.4','POI', 'matrix');
print2file(POI5, 'IMSdoc\IM2.5','POI', 'matrix');
print2file(POI6, 'IMSdoc\IM3.6','POI', 'matrix');
print2file(POI7, 'IMSdoc\IM3.7','POI', 'matrix');
print2file(POI8, 'IMSdoc\IM3.8','POI', 'matrix');
print2file(POI9, 'IMSdoc\IM3.9','POI', 'matrix');
print2file(POI10, 'IMSdoc\IM3.10','POI', 'matrix');
print2file(POI11, 'IMSdoc\IM3.11','POI', 'matrix');
print2file(POI12, 'IMSdoc\IM3.12','POI', 'matrix');
str = datestr(clock);
disp(sprintf('Fine scrittura POI tutti layer ......%s.....',str))


str = datestr(clock);
disp(sprintf('START: Printing OntoMat %s........ ',str))
print2file(ontoMatTest1, 'IMSdoc', 'ontoMatTest1', 'matrix');
print2file(ontoMatTest2, 'IMSdoc', 'ontoMatTest2', 'matrix');
print2file(ontoMatTest3, 'IMSdoc', 'ontoMatTest3', 'matrix');
print2file(ontoMatTest4, 'IMSdoc', 'ontoMatTest4', 'matrix');
print2file(ontoMatTest5, 'IMSdoc', 'ontoMatTest5', 'matrix');
print2file(ontoMatTest6, 'IMSdoc', 'ontoMatTest6', 'matrix');
print2file(ontoMatTest7, 'IMSdoc', 'ontoMatTest7', 'matrix');
print2file(ontoMatTest8, 'IMSdoc', 'ontoMatTest8', 'matrix');
print2file(ontoMatTest9, 'IMSdoc', 'ontoMatTest9', 'matrix');
print2file(ontoMatTest10, 'IMSdoc', 'ontoMatTest10', 'matrix');
print2file(ontoMatTest11, 'IMSdoc', 'ontoMatTest11', 'matrix');
print2file(ontoMatTest12, 'IMSdoc', 'ontoMatTest12', 'matrix');
str = datestr(clock);
disp(sprintf('END: Printing OntoMat %s........ ',str))



val
if (exist('diffe', 'var'))
    diffe
end

str = datestr(clock);
disp(sprintf('End Testing %s........ ',str))

disp('...........................TESTING END...........................');