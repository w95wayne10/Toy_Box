function [Data, Lebel] = DataSet(rngVar, Sigma)
% HW2 dataset making.

if rngVar >= 0
    rng(rngVar);
end

Mu = [0, 0; 1, 0; 0.5, 1];
datanum = 100;
S = [Sigma^2, 0; 0, Sigma^2];
Data = zeros(datanum*3, 2);
Lebel = zeros(datanum*3,1);
for i = 1:3
    Data((i-1)*datanum+1:i*datanum,1:2) = mvnrnd(Mu(i,:),S,datanum);
    Lebel((i-1)*datanum+1:i*datanum,1) = ones(datanum,1)*i;
end

end