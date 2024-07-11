# [ICLAB-LAB01] <br> Lec01 Cell Based Design Methodology
# LAB01 - Code Calculator

:bulb:Lab01 架構較為簡單，實作排序的應用，整體皆為使用 combinational logic ，並沒有涉及 Sequential logic 。


## :beginner: Optimization

### :yellow_heart: Sort
### :yellow_heart: Division

## :blue_book: Sort optimization


因為 Verilog 為硬體描述語言，因此任何在軟體上能夠運行非常快速的排序，在 Verilog 的實作上都表現得非常差，在硬體上最有效率的排序為  ==Sorting Networks== 。
## :feet: Sorting Networks 
Sorting Networks 為交換式排序法，挑選序列中的兩個數字比大小，並進行排序，但比泡沫排序更好的地方在他所交換的次數較少，對於不同的數列大小有對應的網格，此次lab使用網格如下：

![螢幕擷取畫面 2024-07-10 154741](https://hackmd.io/_uploads/S1Vy6njw0.png =400x)

此為排序參考網址，所有lab用到排序都是參考此網站：
[https://bertdobbelaere.github.io/sorting_networks.html](https://bertdobbelaere.github.io/sorting_networks.html)


## :blue_book: Division optimization

除法的優化方式兩種 <br>
1.特別刻一個針對有限制除法最高位數的除法器，因為在 verilog 裡，若直接用 ==/== 來表示除法的話，會產生一個 32bits 的除法器，在後面的lab並沒有太大的引響，但是因為Lab01的電路太小，因此這裡的面積會引響 performance 非常多。.<br><br>
2.較為直觀的方法，使用 lookup table 的形式來取代原本的除法器，代表將所有除法的結果完整列出來，儘管要多寫100行code 帶實際並不會花太多時間，省下的面積也與第一種方法差不多。


## :exclamation: lab 實作流程與注意

在01資料夾中，會將 verilog 打好，並進行驗證，如果沒有錯誤，會在02資料夾中進行合成，代表將寫好的 HDL code 轉換為實際上的電路，此時要在02 檢查有無 timeing viloation 或是latch，並確認 log 檔中無任何error。在03 中再跑一次驗證，確認是否有通過pattern 。


