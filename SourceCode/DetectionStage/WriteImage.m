function [  ] = WriteImage( IS_WRITE, image, name )
%WRITEIMAGE Summary of this function goes here
%   Detailed explanation goes here
    if (IS_WRITE)
        imwrite(image, name,'JPG');
    end
end

