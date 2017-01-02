function [rmean,bmean,rbcov]=make_model()
[cr1, cb1] = get_crcb('sampleset/14.jpg');
[cr2, cb2] = get_crcb('sampleset/15.jpg');
[cr3, cb3] = get_crcb('sampleset/16.jpg');
[cr4, cb4] = get_crcb('sampleset/17.jpg');
[cr5, cb5] = get_crcb('sampleset/18.jpg');
[cr6, cb6] = get_crcb('sampleset/19.jpg');
[cr7, cb7] = get_crcb('sampleset/20.jpg');
[cr8, cb8] = get_crcb('sampleset/21.jpg');
[cr9, cb9] = get_crcb('sampleset/9.jpg');
[cr10, cb10] = get_crcb('sampleset/10.jpg');
[cr11, cb11] = get_crcb('sampleset/11.jpg');
[cr12, cb12] = get_crcb('sampleset/12.jpg');
[cr13, cb13] = get_crcb('sampleset/13.jpg');

cr = [cr1 cr2 cr3 cr4 cr5 cr6 cr7 cr8 cr9 cr10 cr11 cr12 cr13];
cb = [cb1 cb2 cb3 cb4 cb5 cb6 cb7 cb8 cb9 cb10 cb11 cr12 cb13];

rmean = mean(cr);
bmean = mean(cb);
rbcov = cov(cr,cb);

jointchart = zeros(256);
for r = 0:255
for b = 0:255
x = [(r - rmean);(b - bmean)];
jointchart(r+1,b+1) = [power(2*pi*power(det(rbcov),0.5),-1)]*exp(-0.5* x'*inv(rbcov)* x);
end
end