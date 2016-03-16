function [ Iout ] = RefinementImage( Iin )
%REFINEMENTIMAGE Summary of this function goes here
%   Detailed explanation goes here

     c = imclose(Iin,ones(4));
    Iout = imfill(c, 'holes');

end

