
# LSSPieChart

[![Ruller](https://img.shields.io/badge/LSSPieChart-1.0.0-ff69b4.svg)](https://github.com/LSSSSL/LSSPieChart)
[![Author](https://img.shields.io/badge/author-LSSSSL-yellowgreen.svg)](https://github.com/LSSSSL)

## 使用
1. + (instancetype)pointItemWithRawX:(NSString *)rawx andRowY:(NSString *)rowy
  
  如：
    //LSSPieChartItem *item1 = [LSSPieChartItem pointItemWithRawX:@"衣服费" andRowY:@"1"];
 
    //......
    
    //LSSPieChartData *data  = [[LSSPieChartData alloc]init];
    
    //data.items = @[item1].mutableCopy;
    
    //data.fillColors = @[[UIColor redColor]].mutableCopy;
    
    //chart.percentOfInnerHoleRadius = 0.75f;
    
    //chart.data = data;
    
    //[chart strokeChart];
    
    
![image](https://github.com/LSSPieChart/PieChart/PieChart/Image.png)
