clear all;
close all;
MODE_DEBUG_IMSHOW = false;
MODE_WRITE_IMAGE = true;
CURRENT_DATA = 'M1\';
FOLDER_DATA = 'C:\Users\Nhan\Desktop\JAIST\Master\Database\AML_Nomarlization\';
FOLDER_RESULT_CURRENT ='C:\Users\Nhan\Desktop\DEBUG\';
     %% show grey-images
     filename = 'M1_034.tif';
     % get the component of image
     [pathstr, name, ext] = fileparts(filename);
     % display current image which is processing
     disp(name)
     
     %load image
     I = imread(strcat(FOLDER_DATA,CURRENT_DATA,filename));
      
    % create folder for each image
     if exist(strcat(FOLDER_RESULT_CURRENT,name),'dir') == 0
        mkdir(strcat(FOLDER_RESULT_CURRENT,name));
     end
     Igraysc = rgb2gray(I);
     ShowDebug(MODE_DEBUG_IMSHOW, Igraysc);
     WriteImage(MODE_WRITE_IMAGE, Igraysc, strcat(FOLDER_RESULT_CURRENT,name,'\_01_Igraysc','.JPG'));

    %% convert to CMYK
    Igray = ConversionToCMYK(I);

    ShowDebug(MODE_DEBUG_IMSHOW, Igray);
    WriteImage(MODE_WRITE_IMAGE, Igray, strcat(FOLDER_RESULT_CURRENT,name,'\_02_yComponent','.JPG'));

    % [lehisto x]=imhist(Igray);
    % [level]=triangle_th(lehisto,256);
    % I_bw=im2bw(Igray,level);

    % threshold function use Otsu's method
    I_otsu = ThresholdFunction(Igray);
    
    filled = RefinementImage(I_otsu);

    ShowDebug(MODE_DEBUG_IMSHOW, filled);
    WriteImage(MODE_WRITE_IMAGE, filled, strcat(FOLDER_RESULT_CURRENT,name,'\_03_fillHole','.JPG'));
    
%     %% watershed algorithm
%     img = SeparateConnectedCell(filled);

    %% CCA algorithm
    inputI = filled;
    cc = bwconncomp(inputI,4);
    % use for debuging
    labeled = labelmatrix(cc);
    color_binary = label2rgb(labeled, @spring, 'c', 'shuffle');

    ShowDebug(MODE_DEBUG_IMSHOW, color_binary);
    WriteImage(MODE_WRITE_IMAGE, color_binary, strcat(FOLDER_RESULT_CURRENT,name,'\_04_CCA','.JPG'));
    
    %Get feature data of each object which were separated
    featureData = regionprops(cc,'BoundingBox','Area','PixelList');
    toc
    [X Y Z] = size(I);  % X: number of row, Y:number of column
    % inital image has zero pixels
    initalImage = false(size(Igray));
    filteredArr = FilterNoise(featureData, cc, Y, X);
    for k=1:length(filteredArr)
        j= filteredArr{k};
        area = featureData(j).Area;
        aspectRatio = featureData(j).BoundingBox(3)/featureData(j).BoundingBox(4);
        lsPixel = featureData(j).PixelList; %return with format (x, y); x:column, y: row
        initalImage(sub2ind(size(initalImage),lsPixel(:,2), lsPixel(:,1))) = true; %sub2ind(matrixSize, rowSub, colSub)
        image = imcrop(I, featureData(j).BoundingBox);
        
        ShowDebug(MODE_DEBUG_IMSHOW, image);
        WriteImage(MODE_WRITE_IMAGE, image, strcat(FOLDER_RESULT_CURRENT,name,'\_05_rc','area-',num2str(area),'ratio-',num2str(aspectRatio),'.JPG'));
        
    end

    ShowDebug(MODE_DEBUG_IMSHOW, initalImage);
    WriteImage(MODE_WRITE_IMAGE, initalImage, strcat(FOLDER_RESULT_CURRENT,name,'\_06_binary-result','.JPG'));

    figure();
    imshow(I)
    hold on;
    boundaries = bwboundaries(initalImage);
    for k=1:length(boundaries)
       b = boundaries{k};
       plot(b(:,2),b(:,1),'g','LineWidth',1.5);
    end
    if (MODE_WRITE_IMAGE)
        print(strcat(FOLDER_RESULT_CURRENT,name,'_cob'),'-dpng');
    end
    close all;




%% use for report
% %Show results
% %Input image
% subplot(1,3,1); imshow(rgb); axis off;  title('Colour the watershed transform');
% %Binary image
% subplot(1,3,2); imshow(img); axis off; title('result of watershed algorithm');

%graythresh for comparison
% subplot(1,3,3); imshow(I_otsu); axis off; title('Otsu method');

% %%
% %Show results
% %Input image
% subplot(1,3,1); imshow(Igray); axis off;  title('Input image');
% %Binary image
% subplot(1,3,2); imshow(I_bw); axis off; title('Triangle method');
% %graythresh for comparison
% subplot(1,3,3); imshow(im2bw(Igray,graythresh(Igray))); axis off; title('graythresh - Image Toolbox');
% % %Histogram
% % subplot(2,3,[4:6]); bar(x,lehisto); xlim([0 255]);
% % line([73 255],[4264 0],'Color','r','LineWidth',2);
% % line([79 79],[0 max(ylim)],'Color','b','LineWidth',2);
% % hold on;
% % plot(10,50,':w');  %Dummy point to make a 2 line entry in legend
% % line([126 126],[0 max(ylim)],'Color','g','LineWidth',2);
% % hl=legend('Data','Base line used in Triangle Method','Threshold by Triangle Method','(see triangle_th.m for details)','Threshnold by graythresh.m');
% % set(hl,'Interpreter','none');
