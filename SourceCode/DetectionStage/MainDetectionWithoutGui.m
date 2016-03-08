FOLDER = 'C:\Users\Nhan\Desktop\JAIST\Master\Database\AML_Nomarlization\M1\';
%% GET ALL FILE IN THE FOLDER
allFiles = dir(strcat(FOLDER,'*.tif')); % only get file which the extension is .tif
filename = { allFiles.name };

%% Process file
for i=3:length(filename)
    
end