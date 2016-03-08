function [ ] = ShowDebug( IS_DEBUG, image )
%SHOWDEBUG Summary of this function goes here
%   Detailed explanation goes here

    if (IS_DEBUG)
         figure;
         imshow(image);
    end
end

