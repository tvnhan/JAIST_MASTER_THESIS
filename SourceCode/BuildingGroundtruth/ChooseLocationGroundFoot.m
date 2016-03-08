set(gca, 'XLimMode', 'manual');
set(gca, 'YLimMode', 'manual');
FOLDER = 'E:\DataTestLuanVanNHan\Data\Temp';
FOLDER_RENAME = strcat(FOLDER,'_Rename_width_height');
if exist(FOLDER_RENAME,'dir') ==0
    mkdir(FOLDER_RENAME);
end

allFiles = dir(FOLDER);
filename = { allFiles.name };
% fidTotal = fopen(strcat(FOLDER,'\','finalResult.txt'), 'at');

for i=3:length(filename)
        
    filepath = strcat(FOLDER,'\',filename{i});
        chec = 0;
        if (strfind(filename{i},'.JPG')>0)
            chec = 1;
        end
        if (strfind(filename{i},'.jpg')>0)
            chec = 1;
        end
        if (strfind(filename{i},'.bmp')>0)
            chec = 1;
        end
        if (chec==1) 
            [pathstr, name, ext] = fileparts(filepath);
            figure(1); imshow(filepath);  
            title(strcat(num2str(i),'/',num2str(size(filename,2))));
            [x,y] = ginput(2);
            x1 = int64(x(1));
            y1 = int64(y(1));
            x2 = int64(x(2));
            y2 = int64(y(2));
            area = (x2-x1)*(y2-y1);
%             parseresult = strcat('[(%d)(%d)(%d)]');            
%             fprintf(fidTotal, '\n%s[(%d)(%d)(%d)]',name,x1,y1,area);
            strconcat = strcat('(',num2str(x1),')', ...
                                '(',num2str(y1),')', ...
                                '(',num2str(x2-x1),')' , ...
                                '(',num2str(y2-y1),')');
            copyfile(filepath,strcat(FOLDER_RENAME,'\',name, ...
                '[',strconcat,']',ext));
        end
end
% fclose(fidTotal);



