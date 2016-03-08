function [ Iout ] = RefinementImage( Iin )
%REFINEMENTIMAGE Summary of this function goes here
%   Detailed explanation goes here

    c = imclose(Iin,ones(6));
    Iout = imfill(c, 'holes');

end

