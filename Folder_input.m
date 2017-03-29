%%
%mask for skin segmentation:
[rmean,bmean,rbcov]=make_model();
%%
imgPath = 'C:\Users\nikil mishra\Documents\MATLAB\dataset\Sampledataset\5';
dCell = dir('C:\Users\nikil mishra\Documents\MATLAB\dataset\Sampledataset\5'); 
output=zeros(2,length(dCell)-3) ;
for d = 3:(length(dCell))
    if d==4 || d==5 ||d==6 ||d==17 ||d==11 ||d==12 ||d==13 ||d==14 ||d==15
        [output(1,d-2)] =0;
        [output(2,d-2)] =0;
    else
        [output(1,d-2)] =num_finger_30_12(dCell(d).name,rmean,bmean,rbcov);
        [output(2,d-2)] =NewMethod(dCell(d).name,rmean,bmean,rbcov);
    end
end