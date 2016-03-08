function [ Iout ] = SeparateConnectedCell( Iin )
%SEPARATECONNECTEDCELL Summary of this function goes here
%   Detailed explanation goes here

    img = Iin;

    % show debug the transform distance
    % Distt = bwdist(~img);
    % % figure
    % % imshow(Distt,[],'InitialMagnification','fit')
    % % title('Distance transform ')


    imgDist=-bwdist(~img,'cityblock');
    imgDist(~img)=-inf;
    L=watershed(imgDist);  

    % rgb = label2rgb(L,'jet',[.5 .5 .5]);
    boundaries = L == 0;
    img(boundaries) = 0;
    Iout = img;
end

