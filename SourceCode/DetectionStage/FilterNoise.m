function [ resultIndexArr ] = FilterNoise( featureData, cc, maxColumn, maxRow )
%FILTERNOISE Summary of this function goes here
%   Detailed explanation goes here
    resultIndexArr = {};
    resultIndexArrTemp = {};
    lsArrayArea = [];
    for j=1:cc.NumObjects    
        %% filtering the noise
        aspectRatio = featureData(j).BoundingBox(3)/featureData(j).BoundingBox(4);
        area = featureData(j).Area;

        if (aspectRatio<1.7 && area > 500)   
            idex = length(resultIndexArrTemp)+1;
            lsArrayArea = [lsArrayArea area];   
            resultIndexArrTemp{idex} = j;
        end
    end
    
    threshold = max(lsArrayArea)/3;
    for k = 1:length(resultIndexArrTemp)
        indexBinary = resultIndexArrTemp{k};
        area = featureData(indexBinary).Area;
        
        if (area >= threshold)
            lsPixel = featureData(indexBinary).PixelList;
            minPos = min(min(lsPixel));
            maxColumnPos = max(lsPixel(:,1));
            maxRowPos = max(lsPixel(:,end));
            threshold = 5;
            if (minPos>5 && (maxColumn-maxColumnPos)>5 && (maxRow-maxRowPos)>5)
                idex = length(resultIndexArr)+1;
                resultIndexArr{idex} = indexBinary;
            end
        end
    end
end

