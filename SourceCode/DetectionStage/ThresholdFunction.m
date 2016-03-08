function [ Iout ] = ThresholdFunction( Iin )
%THRESHOLDFUNCTION Summary of this function goes here
%   Detailed explanation goes here

    Iout = im2bw(Iin,graythresh(Iin));

end

