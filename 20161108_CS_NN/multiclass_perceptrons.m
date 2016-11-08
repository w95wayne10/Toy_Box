function [st, W] = multiclass_perceptrons(Data, Lebel, Order, ActFunc)

if Order < 1
    print('Not consider in this case.');
end
DataSize = size(Data,1);

X1 = Data(:,1)';
X2 = Data(:,2)';
Const = ones(1,DataSize);
DataDimVar = (Order+1)*(Order+2)/2;
TrainData = [Const; zeros(DataDimVar-1,DataSize)];
k = 2;
for i = 1:Order
    for j = 0:i
        TrainData(k,:) = X1.^(i-j).*X2.^j;
        k = k+1;
    end
end

Lebel = Lebel';
W = zeros(3,DataDimVar);
Alpha = 1;
o = W * TrainData;
if strcmp(ActFunc, 'hardlim')
    dtemp = (repmat(Lebel,3,1) == repmat([1:3]',1,DataSize));
    d = dtemp-~dtemp;
    o = -hardlims(-o);
elseif strcmp(ActFunc, 'sigmoldal')
    d = (repmat(Lebel,DataDimVar,1) == repmat([1:DataDimVar]',1,DataSize));
    o = 1./(1+exp(-o));
end

Error = [];
stoptime = 500;
IterError = 1;
if strcmp(ActFunc, 'hardlim')
    while IterError > 0
        IterError = 0;
        for i = 1:DataSize
            o(:,i) = W * TrainData(:,i);
            o(:,i) = -hardlims(-o(:,i));
            if ~all(d(:,i) == o(:,i))
                W = W +Alpha*(d(:,i) - o(:,i))*TrainData(:,i)';
                IterError = IterError + 1;
            end 
            o(:,i) = W * TrainData(:,i);
            o(:,i) = -hardlims(-o(:,i));
        end
        o = W * TrainData;
        o = -hardlims(-o);

        Error = [Error IterError];
        stoptime = stoptime-1;
        if stoptime == 0
            break;
        end
    end
elseif strcmp(ActFunc, 'sigmoldal')
    while IterError > 0
        IterError = 0;
        for i = 1:DataSize
            o(:,i) = W * TrainData(:,i);
            o(:,i) = 1./(1+exp(-o(:,i)));
            if ~all(abs(d(:,i) - o(:,i)) < 0.5)
                W = W +Alpha*(d(:,i) - o(:,i)).*o(:,i).*(1-o(:,i))*TrainData(:,i)';
                IterError = IterError + 1;
            end 
            o(:,i) = W * TrainData(:,i);
            o(:,i) = 1./(1+exp(-o(:,i)));
        end
        o = W * TrainData;
        o = 1./(1+exp(-o));
        Error = [Error IterError];
        stoptime = stoptime-1;
        if stoptime == 0
            break;
        end
    end
end
close;
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1);
plot(1:length(Error),Error,'-o');

subplot(1,2,2);
st = cell(3,1);
numdetail = 3;
for i = 1:3
    st{i} = num2str(W(i,1),numdetail);
    m = 2;
    for j = 1:Order
        for k = 0:j  
            if W(i,m) < 0
                connect = '-';
            elseif W(i,m) > 0
                connect = '+';
            else
                m = m+1;
                continue;
            end
        
            num = num2str(abs(W(i,m)),numdetail);
        
            if j-k == 0
                if k == 1
                    xyterm = 'y';
                else
                    xyterm = ['y^' num2str(j)];
                end
            elseif j-k == 1
                if k == 0
                    xyterm = 'x';
                elseif k == 1
                    xyterm = 'x*y';
                else
                    xyterm = ['x*y^' num2str(j)];
                end
            else
                xyterm = ['x^' num2str(j-k)];
                if k == 1
                    xyterm = [xyterm '*y'];
                elseif k > 1
                    xyterm = [ xyterm '*y^' num2str(j)];
                end
            end
            st{i} = [st{i} connect num '*' xyterm];
            m = m+1;
        end
    end
end

hold on
Axis = [-0.5 1.5 -0.5 1.5];
ezplot(st{1}, Axis);
ezplot(st{2}, Axis);
ezplot(st{3}, Axis);
plot(Data(Lebel==1,1),Data(Lebel==1,2),'r+', ...
    Data(Lebel==2,1),Data(Lebel==2,2),'gx', ...
    Data(Lebel==3,1),Data(Lebel==3,2),'bo');
title({['Multiclass Perceptrons'];['order: ' num2str(Order) ', actfunc: ' ActFunc]});
end