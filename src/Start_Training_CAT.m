
%rmdir('IMSdoc','s');
warning('off','all');
%CONFIG VARS
maxNumofIMG = 150; % per test 200 per provare il sistema 400
learningRate = 0.1; %discount factor hebbian learning
maxClusters = 128;
maxPoints = 6001;
minPhylo = 0.55;
maxPhylo = 1;
pathImg = 'audioicsfull/'; % per test test1/ per provare il sistema test/
strImg = 'img';
pathSavedDoc = 'IMSdoc';
disc = 1; %0.905 EX-TER-MI-NA-TE
%END CONFIG VARS

%DECL & INIT COMMON PARAM FOR IM
relThr = 0.6;
thresholdFixingOntho = 0.8;
distThr = 0.652;%sqrt(length(ics(:,1))/89); % 0.652 magically magical ...EX-TER-MI-NATE!

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

%INIZIO CREAZIONE ICS

icsTemp1 = 0;
icsTemp2 = 0;

contIcsTmp = 1;

str = datestr(clock);
disp(sprintf('Inizio creazione ics primo Layer ......%s.....',str)); 
for i=1:maxNumofIMG
    
%     if(min(min(ics1))~=0 && min(min(ics2)) ~=0 && min(min(POI1)) ~= 0 && min(min(POI2)) ~= 0 && i==1)
%         disp('Salto il primo for perchè ho già i dati salvati')
%         break
%     end
    
    if(mod(i,10) == 0)
        str = datestr(clock);
        disp(sprintf('......%d immagini......%s..........',i, str))
    end    
    structIA1 = struct ('pathImg', pathImg,'layer', 1,'numIM', 1, 'relSigFromOtherLayer', -1,...
        'contIcsTmp', contIcsTmp, 'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
        'maxNumofIMG', maxNumofIMG, 'relThr', relThr, 'thresholdFixingOntho', ...
        thresholdFixingOntho,'ics', ics1, 'POI', POI1, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, 'icsTemp', icsTemp1);

   [~, ~, ~, ~, icsTemp1, ics1, POI1] = intentionalArchTrain(i, structIA1);
 
    structIA2 = struct ('pathImg', pathImg,'layer', 1,'numIM', 2, 'relSigFromOtherLayer', -1,...
        'contIcsTmp', contIcsTmp, 'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
        'maxNumofIMG', maxNumofIMG, 'relThr', relThr, 'thresholdFixingOntho', ...
        thresholdFixingOntho,'ics', ics2, 'POI', POI2, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, 'icsTemp', icsTemp2);

   [~, ~, ~, contIcsTmp, icsTemp2, ics2, POI2] = intentionalArchCannyTrain(i, structIA2);
   
   if (exist('IM1.1\ics.txt', 'file') == 2 && exist('IM1.2\ics.txt', 'file') == 2)
       break;
   end
end

if (exist(strcat('IMSdoc\IM1.1', '\ics.txt'), 'file') == 2)
    str = datestr(clock);
    disp(sprintf('Non scrivo ics primo layer ......%s.....',str))
else
    str = datestr(clock);
    disp(sprintf('Inizio scrittura ics primo layer ......%s.....',str))
    print2file(ics1, 'IMSdoc\IM1.1','ics', 'matrix');
    print2file(ics2, 'IMSdoc\IM1.2','ics', 'matrix');
    str = datestr(clock);
    disp(sprintf('Fine scrittura ics primo layer ......%s.....',str))
end
str = datestr(clock);
disp(sprintf('Inizio scrittura POI primo layer ......%s.....',str))
%START: print ics and POI first IM
print2file(POI1, 'IMSdoc\IM1.1','POI', 'matrix');
print2file(POI2, 'IMSdoc\IM1.2','POI', 'matrix');
%END: print ics and POI first IM
str = datestr(clock);
disp(sprintf('Fine scrittura POI primo layer ......%s.....',str))

%START: re-initialize variables
contIcsTmp = 1;
clearvars icsTemp1 icsTemp2;
icsTemp1 = 0;
icsTemp2 = 0;
icsTemp3 = 0;
icsTemp4 = 0;
icsTemp5 = 0;
%contDispTrain = 1;
%END: re-initialize variables
str = datestr(clock);
disp(sprintf('Inizio creazione ics secondo Layer ......%s.....',str)); 

for i=1:maxNumofIMG
    if(mod(i,10) == 0)
        str = datestr(clock);
        disp(sprintf('......%d immagini......%s..........',i, str))
    end
    structIA1 = struct ('pathImg', pathImg,'layer', 1,'numIM', 1, 'relSigFromOtherLayer', -1,...
        'contIcsTmp', contIcsTmp, 'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
        'maxNumofIMG', maxNumofIMG, 'relThr', relThr, 'thresholdFixingOntho', ...
        thresholdFixingOntho,'ics', ics1, 'POI', POI1, 'distThr', distThr,...
        'pathSavedDoc', pathSavedDoc, 'icsTemp', icsTemp1);

   [catOut1, relSig1, ~, ~,~, ics1, POI1] = intentionalArchTrain(i, structIA1);

   phyloSig = -1; %nel secondo non c'è il phylogenetic ma l'architettura vuole cmq un parametro
   
    structIA2 = struct ('pathImg', pathImg,'layer', 1,'numIM', 2, 'relSigFromOtherLayer', -1,...
        'contIcsTmp', contIcsTmp, 'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
        'maxNumofIMG', maxNumofIMG, 'relThr', relThr, 'thresholdFixingOntho', ...
        thresholdFixingOntho,'ics', ics2, 'POI', POI2, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, 'icsTemp', icsTemp2);

   [catOut2, relSig2, ~, ~,~, ics2, POI2] = intentionalArchCannyTrain(i, structIA2);
   
    structIM3 = struct ('layer', 2,'numIM', 3, 'inputCat', catOut1, 'relSigFromOtherLayer', relSig1*disc,...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig,'ics', ics3, 'POI', POI3, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp3);

    [~, ~, ~, ~, icsTemp3, ics3, POI3] = intentionalModuleTrain1(i, structIM3);

    structIM4 = struct ('layer', 2,'numIM', 4, 'inputCat', inputLayer(0,catOut1, catOut2, 0), 'relSigFromOtherLayer', max(relSig2*disc, relSig1*disc), ...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig,'ics', ics4, 'POI', POI4, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp4);

    [~, ~, ~, ~, icsTemp4, ics4, POI4] = intentionalModuleTrain1(i, structIM4);

    structIM5 = struct ('layer', 2,'numIM', 5, 'inputCat', catOut2, 'relSigFromOtherLayer', relSig2*disc,...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig,'ics', ics5, 'POI', POI5, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp5);

    [~, ~, ~, contIcsTmp, icsTemp5, ics5, POI5] = intentionalModuleTrain1(i, structIM5);

    
    if (exist('IM2.3\ics.txt', 'file') == 2 && exist('IM2.4\ics.txt', 'file') == 2 ...
            && exist('IM2.5\ics.txt', 'file') == 2)
        break;
    end
    
end

if (exist(strcat('IMSdoc\IM2.3', '\ics.txt'), 'file') == 2)
    str = datestr(clock);
    disp(sprintf('Non scrivo ics secondo layer ......%s.....',str))
else
    str = datestr(clock);
    disp(sprintf('Inizio scrittura ics secondo layer ......%s.....',str))
    print2file(ics3, 'IMSdoc\IM2.3','ics', 'matrix');
    print2file(ics4, 'IMSdoc\IM2.4','ics', 'matrix');
    print2file(ics5, 'IMSdoc\IM2.5','ics', 'matrix');
    str = datestr(clock);
    disp(sprintf('Fine scrittura ics secondo layer ......%s.....',str))
end
str = datestr(clock);
disp(sprintf('Inizio scrittura POI secondo layer ......%s.....',str))
%START: print ics and POI first IM
print2file(POI3, 'IMSdoc\IM2.3','POI', 'matrix');
print2file(POI4, 'IMSdoc\IM2.4','POI', 'matrix');
print2file(POI5, 'IMSdoc\IM2.5','POI', 'matrix');
%END: print ics and POI first IM
str = datestr(clock);
disp(sprintf('Fine scrittura POI secondo layer ......%s.....',str))


%START: re-initialize variables
contIcsTmp = 1;
clearvars icsTemp3 icsTemp4 icsTemp5;

icsTemp1 = 0;
icsTemp2 = 0;
icsTemp3 = 0;
icsTemp4 = 0;
icsTemp5 = 0;
icsTemp6 = 0;
icsTemp7 = 0;
icsTemp8 = 0;
icsTemp9 = 0;
icsTemp10 = 0;
icsTemp11= 0;
icsTemp12= 0;
%contDispTrain = 1;
%END: re-initialize variables

str = datestr(clock);
disp(sprintf('Inizio creazione ics terzo Layer ......%s.....',str));
for i=1:maxNumofIMG
    if(mod(i,10) == 0)
        str = datestr(clock);
        disp(sprintf('......%d immagini......%s..........',i, str))
    end
    structIA1 = struct ('pathImg', pathImg,'layer', 1,'numIM', 1, 'relSigFromOtherLayer', -1,...
        'contIcsTmp', contIcsTmp, 'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
        'maxNumofIMG', maxNumofIMG, 'relThr', relThr, 'thresholdFixingOntho', ...
        thresholdFixingOntho,'ics', ics1, 'POI', POI1, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, 'icsTemp', icsTemp1);

   [catOut1, relSig1, ~, ~, ~, ics1, POI1] = intentionalArchTrain(i, structIA1);

   phyloSig = -1; %nel secondo non c'è il phylogenetic ma l'architettura vuole cmq un parametro
   
    structIA2 = struct ('pathImg', pathImg,'layer', 1,'numIM', 2, 'relSigFromOtherLayer', -1,...
        'contIcsTmp', contIcsTmp, 'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
        'maxNumofIMG', maxNumofIMG, 'relThr', relThr, 'thresholdFixingOntho', ...
        thresholdFixingOntho,'ics', ics1, 'POI', POI1, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, 'icsTemp', icsTemp2);

   [catOut2, relSig2, ~, ~, ~, ics2, POI2] = intentionalArchCannyTrain(i, structIA2);
   
   structIM3 = struct ('layer', 2,'numIM', 3, 'inputCat', catOut1, 'relSigFromOtherLayer', relSig1*disc,...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig,'ics', ics3, 'POI', POI3, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp3);

    [catOut3, relSig3, ~, ~, icsTemp3, ics3, POI3] = intentionalModuleTrain1(i, structIM3);
    
    structIM4 = struct ('layer', 2,'numIM', 4, 'inputCat', inputLayer(0,catOut1, catOut2, 0), 'relSigFromOtherLayer', max(relSig2*disc, relSig1*disc), ...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig,'ics', ics4, 'POI', POI4, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp4);

    [catOut4, relSig4, ~, ~, icsTemp4, ics4, POI4] = intentionalModuleTrain1(i, structIM4);

   structIM5 = struct ('layer', 2,'numIM', 5, 'inputCat', catOut2, 'relSigFromOtherLayer', relSig2*disc,...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig,'ics', ics5, 'POI', POI5, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp5);

    [catOut5, relSig5, ~, ~, icsTemp5, ics5, POI5] = intentionalModuleTrain1(i, structIM5);

    structIM6 = struct ('layer', 3,'numIM', 6, 'inputCat', catOut3, 'relSigFromOtherLayer', relSig3*disc,...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'ics', ics6, 'POI', POI6, 'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp6);

    [~, ~, ~, ~, icsTemp6, ics6, POI6] = intentionalModuleTrain1(i, structIM6); 

    structIM7 = struct ('layer', 3,'numIM', 7, 'inputCat', inputLayer(0,catOut3, catOut4, 0), 'relSigFromOtherLayer', max(relSig3*disc, relSig4*disc),...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'ics', ics7, 'POI', POI7, 'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp7);

    [~, ~, ~, ~, icsTemp7, ics7, POI7] = intentionalModuleTrain1(i, structIM7);

    structIM8 = struct ('layer', 3,'numIM', 8, 'inputCat', inputLayer(1,catOut3, catOut4, catOut5), 'relSigFromOtherLayer', max(relSig3*disc,max(relSig4*disc,relSig5*disc)),...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'ics', ics8, 'POI', POI8, 'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp8);

    [~, ~, ~, ~, icsTemp8, ics8, POI8] = intentionalModuleTrain1(i, structIM8);

    structIM9 = struct ('layer', 3,'numIM', 9, 'inputCat', inputLayer(0,catOut4, catOut5, 0), 'relSigFromOtherLayer', max(relSig4*disc,relSig5*disc),...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'ics', ics9, 'POI', POI9, 'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp9);

    [~, ~, ~, ~, icsTemp9, ics9, POI9] = intentionalModuleTrain1(i, structIM9);

    structIM10 = struct ('layer', 3,'numIM', 10, 'inputCat', inputLayer(0,catOut3, catOut5, 0), 'relSigFromOtherLayer', max(relSig3*disc,relSig5*disc),...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'ics', ics10, 'POI', POI10, 'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp10);

    [~, ~, ~, ~, icsTemp10, ics10, POI10] = intentionalModuleTrain1(i, structIM10);

    structIM11 = struct ('layer', 3,'numIM', 11, 'inputCat', catOut5, 'relSigFromOtherLayer', relSig5*disc,...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'ics', ics11, 'POI', POI11, 'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp11);

    [~, ~, ~, ~, icsTemp11, ics11, POI11] = intentionalModuleTrain1(i, structIM11);
    
    structIM12= struct ('layer', 3,'numIM', 12, 'inputCat', catOut4, 'relSigFromOtherLayer', relSig4*disc,...
        'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', ...
        maxPoints,'phyloSig',phyloSig, 'relThr', relThr,'maxNumofIMG', maxNumofIMG,  ...
        'ics', ics12, 'POI', POI12, 'thresholdFixingOntho', thresholdFixingOntho, 'distThr', distThr, ...
        'pathSavedDoc', pathSavedDoc, 'strImg', strImg,'contIcsTmp', contIcsTmp, 'icsTemp', icsTemp12);

    [~, ~, ~, contIcsTmp, icsTemp12, ics12, POI12] = intentionalModuleTrain1(i, structIM12);

%    if(onthoSig1 ~= -1)
%        ontoMat(contDispTrain) = (onthoSig);
%        ontoMat1(contDispTrain) = (onthoSig1);
%        contDispTrain = contDispTrain + 1;
%    end



end
str = datestr(clock);
disp(sprintf('Fine Creazione ICS ......%s.....',str))


if (exist(strcat('IMSdoc\IM3.6', '\ics.txt'), 'file') == 2)
    str = datestr(clock);
    disp(sprintf('Non scrivo ics terzo layer ......%s.....',str))
else
    str = datestr(clock);
    disp(sprintf('Inizio scrittura ics terzo layer ......%s.....',str))
    print2file(ics6, 'IMSdoc\IM3.6','ics', 'matrix');
    print2file(ics7, 'IMSdoc\IM3.7','ics', 'matrix');
    print2file(ics8, 'IMSdoc\IM3.8','ics', 'matrix');
    print2file(ics9, 'IMSdoc\IM3.9','ics', 'matrix');
    print2file(ics10, 'IMSdoc\IM3.10','ics', 'matrix');
    print2file(ics11, 'IMSdoc\IM3.11','ics', 'matrix');
    print2file(ics12, 'IMSdoc\IM3.12','ics', 'matrix');
    str = datestr(clock);
    disp(sprintf('Fine scrittura ics terzo layer ......%s.....',str))
end
str = datestr(clock);
disp(sprintf('Inizio scrittura POI terzo layer ......%s.....',str))
%START: print ics and POI first IM
print2file(POI6, 'IMSdoc\IM3.6','POI', 'matrix');
print2file(POI7, 'IMSdoc\IM3.7','POI', 'matrix');
print2file(POI8, 'IMSdoc\IM3.8','POI', 'matrix');
print2file(POI9, 'IMSdoc\IM3.9','POI', 'matrix');
print2file(POI10, 'IMSdoc\IM3.10','POI', 'matrix');
print2file(POI11, 'IMSdoc\IM3.11','POI', 'matrix');
print2file(POI12, 'IMSdoc\IM3.12','POI', 'matrix');
%END: print ics and POI first IM
str = datestr(clock);
disp(sprintf('Fine scrittura POI terzo layer ......%s.....',str))


clearvars icsTemp6 icsTemp7 icsTemp8 icsTemp9 icsTemp10 icsTemp11 icsTemp12;

str = datestr(clock);
disp(sprintf('......%s....... Fine creazione ICS',str))
%FINE CREAZIONE ICS
%%
warning('off','all');
%CONFIG VARS
maxNumofIMG = 160; % per test 200 per provare il sistema 400
learningRate = 0.1; %discount factor hebbian learning
maxClusters = 128;
maxPoints = 6001;
minPhylo = 0.55;
maxPhylo = 1;
pathImg = 'sure/'; % per test test1/ per provare il sistema test/
strImg = 'img';
pathSavedDoc = 'IMSdoc';
disc = 1; %0.905 EX-TER-MI-NA-TE
%END CONFIG VARS

%DECL & INIT COMMON PARAM FOR IM
relThr = 0.6;
thresholdFixingOntho = 0.8;
distThr = 0.652;%sqrt(length(ics(:,1))/89); % 0.652 magically magical ...EX-TER-MI-NATE!

%Display Vars
contDispTrain = 1;
%Display Vars END

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

str = datestr(clock);
disp(sprintf('Inizio vero addestramento ......%s.....',str))
disp(sprintf('cartella ......%s.....', pathImg))

% contDispTrain =1;


for strax=1:maxNumofIMG %ceil(maxNumofIMG*80/100)
    
    if(mod(strax,10) == 0)
        str = datestr(clock);
        disp(sprintf('......%d immagini......%s..........',strax, str))
    end

    structIA1 = struct ('layer', 1,'numIM', 1, 'pathImg', pathImg, 'relSigFromOtherLayer', -1,...
    'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
    'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
    'relThr', relThr,'ics', ics1, 'POI', POI1,  'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc);

   [relSig1, ontoSig1, catOut1, ics1, POI1] = intentionalArch(strax, structIA1);

   phyloSig = 0; %nel secondo non c'è il phylogenetic ma l'architettura vuole cmq un parametro
   
    structIA2 = struct ('layer', 1,'numIM', 2, 'pathImg', pathImg, 'relSigFromOtherLayer', -1,...
    'strImg', strImg, 'minPhylo', minPhylo, 'maxPhylo', maxPhylo, ...
    'learningRate', learningRate, 'maxClusters', maxClusters, 'maxPoints', maxPoints, ...
    'relThr', relThr,'ics', ics2, 'POI', POI2,  'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc);

   [relSig2, ontoSig2, catOut2, ics2, POI2] = intentionalArchCanny(strax, structIA2);
   
   structIM3 = struct('layer', 2,'numIM', 3, 'inputCat', catOut1,'relSigFromOtherLayer', relSig1*disc, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics3, 'POI', POI3, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig3, ontoSig3, catOut3, ics3, POI3] = intentionalModule1(structIM3);

    structIM4 = struct('layer', 2,'numIM', 4, 'inputCat', inputLayer(0,catOut1, catOut2, 0),'relSigFromOtherLayer', (relSig2*disc+relSig1*disc)/2, ...
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

    [relSig6, ontoSig6, ~, ics6, POI6] = intentionalModule1(structIM6);

    structIM7 = struct('layer', 3,'numIM', 7, 'inputCat', inputLayer(0,catOut3, catOut4, 0),'relSigFromOtherLayer', (relSig3*disc+relSig4*disc)/2, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics7, 'POI', POI7, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig7, ontoSig7, ~, ics7, POI7] = intentionalModule1(structIM7);

    structIM8 = struct('layer', 3,'numIM', 8, 'inputCat', inputLayer(1,catOut3, catOut4, catOut5),'relSigFromOtherLayer', (relSig3*disc+relSig4*disc+relSig5*disc)/3, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics8, 'POI', POI8, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig8, ontoSig8, ~, ics8, POI8] = intentionalModule1(structIM8);

    structIM9 = struct('layer', 3,'numIM', 9, 'inputCat', inputLayer(0,catOut4, catOut5, 0),'relSigFromOtherLayer', (relSig5*disc+relSig4*disc)/2, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics9, 'POI', POI9, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig9, ontoSig9, ~, ics9, POI9] = intentionalModule1(structIM9);

    structIM10 = struct('layer', 3,'numIM', 10, 'inputCat', inputLayer(0,catOut3, catOut5, 0),'relSigFromOtherLayer', (relSig3*disc+relSig5*disc)/2, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics10, 'POI', POI10, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig10, ontoSig10, ~, ics10, POI10] = intentionalModule1(structIM10);

    structIM11 = struct('layer', 3,'numIM', 11, 'inputCat', catOut5,'relSigFromOtherLayer', relSig5*disc, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics11, 'POI', POI11, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig11, ontoSig11, ~, ics11, POI11] = intentionalModule1(structIM11);

    structIM12 = struct('layer', 3,'numIM', 12, 'inputCat', catOut4,'relSigFromOtherLayer', relSig4*disc, ...
    'maxClusters', maxClusters, 'maxPoints', maxPoints,'learningRate', learningRate,  ...
    'phyloSig',phyloSig,'ics', ics12, 'POI', POI12, 'relThr', relThr, 'thresholdFixingOntho', ...
    thresholdFixingOntho, 'distThr', distThr, 'pathSavedDoc', pathSavedDoc, ...
    'strImg', strImg);

    [relSig12, ontoSig12, ~, ics12, POI12] = intentionalModule1(structIM12);

   if(ontoSig4 ~= -1)
       ontoMat1(contDispTrain) = (ontoSig1);
       ontoMat2(contDispTrain) = (ontoSig2);
       ontoMat3(contDispTrain) = (ontoSig3);
       ontoMat4(contDispTrain) = (ontoSig4);
       ontoMat5(contDispTrain) = (ontoSig5);
       ontoMat6(contDispTrain) = (ontoSig6);
       ontoMat7(contDispTrain) = (ontoSig7);
       ontoMat8(contDispTrain) = (ontoSig8);
       ontoMat9(contDispTrain) = (ontoSig9);
       ontoMat10(contDispTrain) = (ontoSig10);
       ontoMat11(contDispTrain) = (ontoSig11);
       ontoMat12(contDispTrain) = (ontoSig12);
       contDispTrain = contDispTrain + 1;
   end
   
%     relArr =[relSig6,relSig7,relSig8,relSig9,relSig10,relSig11,relSig12];
%     %ogni colonna rappresenta il riconoscimento di una sola lettera da ...
%     %tutti i moduli
% %     val(dalek,strax) = IMout(relArr,12);
% temp = IMout(relArr,12);
% if (exist('val'))
%     if (length(val)>= strax)
%         diffe(strax) = temp - val(strax);
%     end
% end
% val(strax) = temp;
   
end

str = datestr(clock);
    disp(sprintf('%s..........INIZIO STAMPE...................',str))

str = datestr(clock);
disp(sprintf('Inizio scrittura POI tutti layer ......%s.....',str))
print2file(POI1, strcat(pathSavedDoc,'\IM1.1'),'POI', 'matrix');
print2file(POI2, strcat(pathSavedDoc,'\IM1.2'),'POI', 'matrix');
print2file(POI3, strcat(pathSavedDoc,'\IM2.3'),'POI', 'matrix');
print2file(POI4, strcat(pathSavedDoc,'\IM2.4'),'POI', 'matrix');
print2file(POI5, strcat(pathSavedDoc,'\IM2.5'),'POI', 'matrix');
print2file(POI6, strcat(pathSavedDoc,'\IM3.6'),'POI', 'matrix');
print2file(POI7, strcat(pathSavedDoc,'\IM3.7'),'POI', 'matrix');
print2file(POI8, strcat(pathSavedDoc,'\IM3.8'),'POI', 'matrix');
print2file(POI9, strcat(pathSavedDoc,'\IM3.9'),'POI', 'matrix');
print2file(POI10, strcat(pathSavedDoc,'\IM3.10'),'POI', 'matrix');
print2file(POI11, strcat(pathSavedDoc,'\IM3.11'),'POI', 'matrix');
print2file(POI12, strcat(pathSavedDoc,'\IM3.12'),'POI', 'matrix');
str = datestr(clock);
disp(sprintf('Fine scrittura POI tutti layer ......%s.....',str))



str = datestr(clock);
disp(sprintf('START: Printing OntoMat %s........ ',str))
print2file(ontoMat1, pathSavedDoc, 'ontoMat1', 'matrix');
print2file(ontoMat2, pathSavedDoc, 'ontoMat2', 'matrix');
print2file(ontoMat3, pathSavedDoc, 'ontoMat3', 'matrix');
print2file(ontoMat4, pathSavedDoc, 'ontoMat4', 'matrix');
print2file(ontoMat5, pathSavedDoc, 'ontoMat5', 'matrix');
print2file(ontoMat6, pathSavedDoc, 'ontoMat6', 'matrix');
print2file(ontoMat7, pathSavedDoc, 'ontoMat7', 'matrix');
print2file(ontoMat8, pathSavedDoc, 'ontoMat8', 'matrix');
print2file(ontoMat9, pathSavedDoc, 'ontoMat9', 'matrix');
print2file(ontoMat10, pathSavedDoc, 'ontoMat10', 'matrix');
print2file(ontoMat11, pathSavedDoc, 'ontoMat11', 'matrix');
print2file(ontoMat12, pathSavedDoc, 'ontoMat12', 'matrix');
str = datestr(clock);
disp(sprintf('END: Printing OntoMat %s........ ',str))



str = datestr(clock);
disp(sprintf('..............%s............',str))
disp('...........................TRAINING END...........................');

