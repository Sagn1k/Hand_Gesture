function [count]=NewMethod(image,rmean,bmean,rbcov)
%clc,clear all;
%image='hand2_4_right_seg_5_cropped.png';
%[rmean,bmean,rbcov]=make_model();
img=imread(image);
img=imresize(img,[200,200]);
figure,subplot(2,3,1);imshow(img),title('RGB IMAGE');
%% skin similarity mesurement:
[likely_skin]=get__likelyhood(image,rmean,bmean,rbcov);likely_skin=imresize(likely_skin,[200,200]);
subplot(2,3,2);imshow(uint8(255*likely_skin));
title('Skin Likelihood');
%% Converting to Binary:
level = graythresh(likely_skin);
BW = im2bw(likely_skin,0.1);
a0=imclose(BW,strel('disk',3));
a1=imdilate(a0,strel('disk',2));
a2=imfill(a1,'holes');
subplot(2,3,3);imshow(BW);
title('Segmented Image');
stats=regionprops(a2);
x1=stats.Centroid;
%% Erode
sizea2=size(a2);
se = strel('disk',5);
closeBW = imerode(BW,se);
%subplot(2,3,4); imshow(closeBW);
[Gmag,Gdir] = imgradient(closeBW);
Gmag_bin=Gmag>0;
%% Distance from centroid
Dist=zeros(sizea2(1),sizea2(2));
for i=1:sizea2(1)
    for j=1:sizea2(2)   
        d=0;
        if Gmag_bin(j,i)==1
            D=[j,i;x1(2),x1(1)];
            d = pdist(D,'euclidean');
            Dist(j,i)=d;
        end
    end
end

%% Dist to binary image
Dist_bin=Dist>(max(max(Dist))*0.75);
subtractor=[ones(2*floor(sizea2(1)/3),sizea2(2));zeros(sizea2(1)- 2*floor(sizea2(1)/3),sizea2(2))];
final=and(Dist_bin,subtractor);
subplot(2,3,4);imshow(final);
%% COmputing Gradient
[Gmag1,Gdir1]=imgradient(final);
%figure,imshow(Gmag1);
Gmag_max=max(Gmag1);
for i=3:(sizea2(1)-3)
    Gmag_max(i)=(Gmag_max(i-2)+Gmag_max(i-1)+Gmag_max(i)+Gmag_max(i+1)+Gmag_max(i+2))/5;
end
for i=3:(sizea2(1)-3)
    Gmag_max(i)=(Gmag_max(i-2)+Gmag_max(i-1)+Gmag_max(i)+Gmag_max(i+1)+Gmag_max(i+2))/5;
end
%% count
m=3.5;count=0;
for i=1:(sizea2(1)-1)
    if Gmag_max(i)<m && Gmag_max(i+1)>m
        count=count+1;
    end
end
%% Graph Plot
x=1:1:sizea2(1);
subplot(2,3,5);plot(x,Gmag_max,'color','r'); hold on;plot(x,m,'color','b');
title(['Num of fingers=' num2str(count)]);
%impixelinfo;
