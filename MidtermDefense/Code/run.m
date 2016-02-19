clear all;
I = imread('M3_75.tif');
% Igray = rgb2gray(I);
% imshow(~im2bw(Igray,graythresh(Igray)))

tic
cform = makecform('srgb2cmyk');
cmykI = applycform(I,cform); 

yCom = cmykI(:,:,1);

Igray = yCom;
[lehisto x]=imhist(Igray);
[level]=triangle_th(lehisto,256);
I_bw=im2bw(Igray,level);

I_otsu = im2bw(Igray,graythresh(Igray));
c = imclose(I_otsu,ones(6));
filled = imfill(c, 'holes');

%% watershed algorithm
img = filled;

% Distt = bwdist(~img);
% % figure
% % imshow(Distt,[],'InitialMagnification','fit')
% % title('Distance transform ')


imgDist=-bwdist(~img,'cityblock');
imgDist(~img)=-inf;
L=watershed(imgDist);  

rgb = label2rgb(L,'jet',[.5 .5 .5]);


boundaries = L == 0;
img(boundaries) = 0;

%% CCA algorithm
inputI = img;
cc = bwconncomp(inputI,4);
% labeled = labelmatrix(cc);
% color_binary = label2rgb(labeled, @spring, 'c', 'shuffle');
% imshow(color_binary);
featureData = regionprops(cc,'BoundingBox');
toc
[X Y Z] = size(I);
for i=1:cc.NumObjects    
    image = imcrop(I, featureData(i).BoundingBox);
    imshow(image);
end
%%
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
