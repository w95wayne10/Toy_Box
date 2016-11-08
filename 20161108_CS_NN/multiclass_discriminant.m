function [st, D] = multiclass_discriminant(Data, Lebel, LearnCase)

DataSize = size(Data,1);

if strcmp(LearnCase, 'linear')
    TrainData = [Data';ones(1,DataSize)];
    DataDimVar = 3;
end
Lebel = Lebel';
D = zeros(DataDimVar);
Alpha = 1;
Iter = D * TrainData;
Error = [];
IterError = 1;
while IterError > 0
    IterError = 0;
    for i = 1:DataSize
        Iter(:,i) = D * TrainData(:,i);
        ismax = 1;
        for j = 1:3
            if j ~= Lebel(i)
                if Iter(j,i) >= Iter(Lebel(i),i)
                    D(j,:) = D(j,:) - Alpha*TrainData(:,i)';
                    ismax = 0;
                    IterError = IterError + 1;
                end
            end
        end
        if ismax == 0
            D(Lebel(i),:) = D(Lebel(i),:) + Alpha*TrainData(:,i)';
        end
        
    end
    Iter = D * TrainData;
    Error = [Error IterError];
end
close;
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1);

plot(1:length(Error),Error,'-o');

subplot(1,2,2);
st = cell(3,1);
k = 1;
for i = 1:2
    for j = 2:3
        if i ~= j
           st{k} = [num2str(D(i,1)-D(j,1),3) '*x+' ...
                num2str(D(i,2)-D(j,2),3) '*y+' ...
                num2str(D(i,3)-D(j,3),3)];
            k = k + 1;
        end
    end
end

hold on
ezplot(st{1},[-0.5 1.5 -0.5 1.5]);
ezplot(st{2},[-0.5 1.5 -0.5 1.5]);
ezplot(st{3},[-0.5 1.5 -0.5 1.5]);
plot(Data(Lebel==1,1),Data(Lebel==1,2),'r+', ...
    Data(Lebel==2,1),Data(Lebel==2,2),'gx', ...
    Data(Lebel==3,1),Data(Lebel==3,2),'bo');
title('multi-class linear discriminant');
end
