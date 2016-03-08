clear all;
FOLDER = 'C:\Users\Nhan\Desktop\JAIST\Master\Database\AML_Nomarlization\M5\';
PRE_WORD = 'M5';
dirData = dir('C:\Users\Nhan\Desktop\JAIST\Master\Database\AML_Nomarlization\M5\*.tif');         %# Get the selected file data
fileNames = {dirData.name};     %# Create a cell array of file names
for iFile = 1:numel(fileNames)  %# Loop over the file names
  newName = sprintf('M5_%03d.tif',iFile);  %# Make the new name
  movefile(strcat(FOLDER,fileNames{iFile}), strcat(FOLDER,newName));        %# Rename the file
end