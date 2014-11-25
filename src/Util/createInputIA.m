function [ imgVect ] = createInputIA( vect, flag )
%CREATEINPUTIA [ imgVect ] = createInputIA( vect, flag ) flag:
%0-rgb,1-BW,2-sat, 3-canny, 4-amplitude,5-phase
%   Detailed explanation goes here
vect = double(vect);

if (flag == 0)
    cont = 1;
    for i=1:size(vect,1)
        for j=1:size(vect,2)
            imgVect(cont) = vect(i,j,1)/255;
            cont = cont + 1;
            imgVect(cont) = vect(i,j,2)/255;
            cont = cont + 1;
            imgVect(cont) = vect(i,j,3)/255;
            cont = cont + 1;
        end
    end
elseif (flag==1)
    
    if( 3 == length(size(vect)))
        vect = rgb2hsv(vect);
        vect = vect (:,:,3);
    end
    
    cont = 1;
    for i=1:size(vect,1)
        for j=1:size(vect,2)
            imgVect(cont) = vect(i,j)/255;
            cont = cont + 1;
        end
    end
elseif (flag == 2)
    
    if( 3 == length(size(vect)))
        vect = rgb2hsv(vect);
        vect = vect (:,:,2);
    end
    
    cont = 1;
    for i=1:size(vect,1)
        for j=1:size(vect,2)
            imgVect(cont) = vect(i,j);
            cont = cont + 1;
        end
    end
elseif (flag == 3)
    
   if( 3 == length(size(vect)))
        vect = rgb2hsv(vect);
        vect = vect (:,:,3);
    end
    vect = edge(vect,'canny');
    cont = 1;
    for i=1:size(vect,1)
        for j=1:size(vect,2)
            imgVect(cont) = vect(i,j);
            cont = cont + 1;
        end
    end
elseif (flag == 4)
    fs = 100;                          % Sample frequency (Hz)
    t = 0:1/fs:10-1/fs;                % 10 sec sample
    m = length(vect);          % Window length
    n = pow2(nextpow2(m));  % Transform length
    y = fft(vect,n);           % DFT
    f = (0:n-1)*(fs/n);     % Frequency range
    power = y.*conj(y)/n;   % Power of the DFT
    imgVect = power';

%     imgVect = y';
    
elseif (flag == 5)
    fs = 100;                          % Sample frequency (Hz)
    t = 0:1/fs:10-1/fs;                % 10 sec sample
    m = length(vect);          % Window length
    n = pow2(nextpow2(m));  % Transform length
    y = fft(vect,n);           % DFT
    f = (0:n-1)*(fs/n);     % Frequency range
    power = y.*conj(y)/n;   % Power of the DFT
    y0 = fftshift(y);          % Rearrange y values
    f0 = (-n/2:n/2-1)*(fs/n);  % 0-centered frequency range
    power0 = y0.*conj(y0)/n;   % 0-centered power
    phase = unwrap(angle(y0));
    imgVect=phase';
end

imgVect = double(imgVect)'; %Deve esssre un vettore colonna
end

