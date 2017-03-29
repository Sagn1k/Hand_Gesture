function [cr, cb] = get_crcb(InputImage)
img=imread(InputImage);
imycbcr = rgb2ycbcr(img);
a=size(img);
m=a(1);n=a(2);
for i = 1:m
for j = 1:n

cr = double(imycbcr(i,j,3));
cb = double(imycbcr(i,j,2));
end
end