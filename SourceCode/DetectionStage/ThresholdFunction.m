function [ Iout ] = ThresholdFunction( Iin )
%THRESHOLDFUNCTION Summary of this function goes here
%   Detailed explanation goes here

    threshold = graythresh(Iin);
    Iout = im2bw(Iin,graythresh(Iin));

end

