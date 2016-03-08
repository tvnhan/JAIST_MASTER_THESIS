function [ Iout ] = ConversionToCMYK( Iin )
%CONVERSIONTOCMYK Summary of this function goes here
%   Detailed explanation goes here

    cform = makecform('srgb2cmyk');
    cmykI = applycform(Iin,cform); 

    yCom = cmykI(:,:,1); 

    Iout = yCom;
end

