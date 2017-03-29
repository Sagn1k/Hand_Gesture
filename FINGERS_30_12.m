function [a2,width]=FINGERS(image,rmean,bmean,rbcov)
%%
%image=image;
img=imread(image);
img=imresize(img,[200,200]);
figure,subplot(2,2,1);imshow(img),title('RGB IMAGE');
RGB=double(img);
%skin detection:
%%
%mask for skin segmentation:
%[rmean,bmean,rbcov]=make_model();
%%
%skin similarity mesurement:
[likely_skin]=get__likelyhood(image,rmean,bmean,rbcov);likely_skin=imresize(likely_skin,[200,200]);
subplot(2,2,2);imshow(uint8(255*likely_skin));
title('Skin Likelihood');
%%
%[skinBW, opt_th]=segment_adaptive(likely_skin);
level = graythresh(likely_skin);
BW = im2bw(likely_skin,0.1);

%%
%z5=graythresh(z4);
%z6=~im2bw(z4,z5-0.05);
%figure;imshow(z6);
%z1=bwareaopen(z6,50);
%z3=imerode(z1,strel('disk',4));
%figure;imshow(z3)
%z2=imdilate(z3,strel('disk',4));
%a2=imfill(z2,'holes');
%figure;imshow(a2)
%%
%substracting the background:
%[pks,loc]=findpeaks(imhist(BW));
%w=find(pks==max(pks));
%ints=loc(w)/255;
%z1=BW-ints;
%z5=(z1>0.01) ;
%z3=z1 < -0.010;
%z=z3+z5;
%figure;imshow(z)
%%
%z7=size(z);
%z6=zeros(z7(1),z7(2),3);
%z6(:,:,1) = z;
%z6(:,:,2) = z;
%z6(:,:,3) = z;
%final=double(z6).*double(img);
%figure,imshow(uint8(final))
%% Converting to Binary:
%a=graythresh(z);
%a3=(im2bw(z,a));
a0=imclose(BW,strel('disk',3));
a1=imdilate(a0,strel('disk',2));
a2=imfill(a1,'holes');
subplot(2,2,3);imshow(BW);
title('Segmented Image');
%figure,imshow(a2)
%a2=imresize(a1,[200 200]);
stats=regionprops(a2);
x1=stats.Centroid;
%%
sizea2=size(a2);count=0;bound1=0;
for j=floor(x1(1)):-1:1  
    diff=abs(a2(floor(x1(2)),floor(x1(1)))-a2(floor(x1(2)),j));
    if diff >0;
        count=count+1;
    else count=0;
    end
    if count > 10
        bound1=j+10;break;
    end;
end
bound1=abs(floor(x1(1)-bound1));
% bound2
for j=floor(x1(1)):sizea2(2)
         diff=abs(a2(floor(x1(2)),floor(x1(1)))-a2(floor(x1(2)),j));
    if diff>0;
        count=count+1 ;
    else count=0;
    end
    if count > 10
        bound2=j-10;
        bound2=abs(floor(x1(1)-bound2));
        break;
    else bound2=0;
    end
end
width=2*max(bound1,bound2);