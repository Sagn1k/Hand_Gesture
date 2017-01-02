%%
%mask for skin segmentation:
[rmean,bmean,rbcov]=make_model();
%%
imgPath = 'C:\Users\SAHIB\Documents\MATLAB\hand recognition\dataset\massey university';
dCell = dir('C:\Users\SAHIB\Documents\MATLAB\hand recognition\dataset\massey university'); 
output=zeros(1,length(dCell)-2) ;
for d = 60:90%length(dCell) 
    %a=imread(dCell(d).name);
    %x=imread(dCell(d).name);   
    %figure;imshow(x)
%    rmean;bmean;rbcov;
    [output(d-2)] =num_finger_30_12(dCell(d).name,rmean,bmean,rbcov);
end