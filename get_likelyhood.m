function[likely_skin]=get_likelyhood(filename,rmean,bmean,rbcov)

img = imread(filename);

imycbcr = rgb2ycbcr(img);
[m,n,l] = size(img);

likely_skin = zeros(m,n);
for i = 1:m
for j = 1:n

cr = double(imycbcr(i,j,3));
cb = double(imycbcr(i,j,2));

x = [(cr-rmean);(cb-bmean)];
likely_skin(i,j) = [power(2*pi*power(det(rbcov),0.5),-1)]*exp(-0.5* x'*inv(rbcov)* x);
end
end