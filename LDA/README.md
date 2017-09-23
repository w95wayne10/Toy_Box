# Linear Discriminant Analysis  

## DataSet  
1000 data with 1000 columns 2 classes  

## Operation Process  
* 讀入資料 `[K, y]`  
* 執行function  
```matlab  
  [NewComp, Coef, val] = LDA(K, y);  
```  
* 繪圖：  
  * 繪製新產生維度(多一維可忽略)  
```matlab  
    scatter(NewComp(:,1),NewComp(:,2),y+15,y+2);  
```  
  * 繪製特徵值  
```matlab  
    scatter(1:length(val),val)  
    plot(1:length(val),val)  
    axis([0 10 -0.5 4])  
```  
  * 繪製新產生維度  
```matlab  
    plot(1:length(Coef),sort(Coef(:,1)))  
```  

