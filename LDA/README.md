# Linear Discriminant Analysis  

## DataSet
1000 data with 1000 columns 2 classes  

## Operation Process
* 讀入資料 `[K, y]`
* 執行function
```matlab
  [NewComp, Coef, val] = LDA(K, y);  
```
## 繪圖
+ 新產生維度(多一維可忽略)
```matlab
    scatter(NewComp(:,1),NewComp(:,2),y+15,y+2);  
```
<img src="https://github.com/w95wayne10/Toy_Box/blob/master/LDA/picture/checkerNewComp.png" height="300" />

+ 特徵值(前十個值)
```matlab
    scatter(1:length(val),val);  
    plot(1:length(val),val);  
    axis([0 10 -0.5 4]);  
```
<img src="https://github.com/w95wayne10/Toy_Box/blob/master/LDA/picture/checkerEig.png" height="300" />

+ 原維度組成方式
```matlab
    plot(1:length(Coef),sort(Coef(:,1)));  
```
<img src="https://github.com/w95wayne10/Toy_Box/blob/master/LDA/picture/checkerOrgColCoef.png" height="300" />
