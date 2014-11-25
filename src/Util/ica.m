function [icasig, icaA, icaW] = stICAzzi(sig)
%[icasig, A(de-whitened), W(whitened)] , rows sig = maxNumIC
epsilon = 0.00001;
maxNumIterations = 10000;

[Dim, NumOfSampl] = size(sig);
NumIC = 0;

% Remove the mean and check the data
mixedsig = zeros(size(sig));

%if ((NumIC == 0) || (NumIC > size(mixedsig,1)))
 %               NumIC = size(mixedsig,1);

mixedmean = mean(sig')';
mixedsig = sig - mixedmean * ones(1,size(sig, 2));

%Calculate the covariance matrix.
%opts.maxit = 10;

covarianceMatrix = cov(mixedsig');
[E, D] = eig(covarianceMatrix);
%[E, D, ci] = svd(covarianceMatrix);
%D=flipud(D);
%D=fliplr(D);
%E=fliplr(E);

tempL = rand(size(D,1),1) > 1;

%%%%%%%%%%%%%%%%%%%%%reduce dimension of Ic if under thr
for i=1:size(D,1)
    if(NumIC < size(mixedsig,1) && D(i,i) > epsilon)
        tempL(i,1) = 1;
        NumIC = NumIC + 1;
    end
end

dNew = zeros(NumIC);
eNew = zeros(size(E,1), NumIC);

cont = 1;
for i=1:size(tempL,1)
    if (tempL(i))
        dNew (cont,cont) = D(i,i);
        for k=1:size(D,1)
            eNew(k,cont) = E(k,i);
        end
        cont = cont + 1;
    end
end

D = dNew;
E = eNew;


%%%%%%%%%%%%%%%%%%%%%%%% Whitening %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
whiteningMatrix = (sqrt (D)) \ E';
dewhiteningMatrix = E * sqrt (D);
whitesig =  whiteningMatrix * mixedsig;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ICA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dim = size(whitesig, 1);
vectorSize = Dim;
icaA = zeros(vectorSize, NumIC);
orthB = orth (randn (vectorSize, NumIC));
BOld = zeros(size(orthB));
for round = 1:maxNumIterations + 1
    % Symmetric orthogonalization.  orthB = orthB * real(inv(orthB' * orthB)^(1/2));
    
    %Gram Smith Ortho
    
    for k=1:size(orthB,2)
        norm = 0;
        for i=1:size(orthB,1)
            norm = norm + orthB(i,k)*orthB(i,k);
        end
        norm = sqrt(norm);
        if (norm == 0)
            disp ('NORM = 0, rank deficent');
            exit;
        end
        for i=1:size(orthB,1)
            orthB(i,k)=orthB(i,k)/norm;
        end
        %double(orthB);
        for j = k+1:size(orthB,2)
            k1 =k;
            j1=j;
            dot = 0;
            for index=1:size(orthB,1)
                dot=dot+ orthB(index,k1)*orthB(index,j1);
            end
            for i=1:size(orthB,1)
                value = orthB(i,j) - (orthB(i,k)*dot);
                orthB(i,j)=value;
            end
        end
    end
    %FINE gram smith
    
    % Test for termination condition.
    minAbsCos = min(abs(diag(orthB' * BOld)));
    minAbsCos;
    if (1 - minAbsCos < epsilon)
        fprintf('Convergence ok\n');
        % Calculate the de-whitened vectors.
        icaA = dewhiteningMatrix * orthB;
        break;
    end
    BOld = orthB;
    orthB = (whitesig * (( whitesig' * orthB) .^ 3)) / NumOfSampl - 3 * orthB;
end

% Calculate ICA filters.
icaW = orthB' * whiteningMatrix;
icasig = icaW * mixedsig + (icaW * mixedmean) * ones(1, NumOfSampl);
end