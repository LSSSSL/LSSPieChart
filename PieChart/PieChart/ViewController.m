//
//  ViewController.m
//  PieChart
//
//  Created by lss on 2017/8/28.
//  Copyright © 2017年 insight. All rights reserved.
//

#import "ViewController.h"

#import "LSSPieChart.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self creatPieChart];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)creatPieChart{
    LSSPieChart *chart = [[LSSPieChart alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)/2,  (self.view.frame.size.height-100)/2, 100, 100)];
    [self.view addSubview:chart];
    
    //比例 100% ；
    LSSPieChartItem *item1 = [LSSPieChartItem pointItemWithRawX:@"衣服费" andRowY:@"1"];
    LSSPieChartItem *item2 = [LSSPieChartItem pointItemWithRawX:@"按摩费" andRowY:@"0.34"];
    LSSPieChartItem *item3 = [LSSPieChartItem pointItemWithRawX:@"吃饭费" andRowY:@"0.23"];
    LSSPieChartItem *item4 = [LSSPieChartItem pointItemWithRawX:@"其他" andRowY:@"0.1"];
    LSSPieChartData *data  = [[LSSPieChartData alloc]init];
    data.items = @[item1,item2,item3,item4].mutableCopy;
    data.fillColors = @[[UIColor redColor],[UIColor purpleColor],[UIColor blueColor],[UIColor yellowColor]].mutableCopy;
    chart.percentOfInnerHoleRadius = 0.75f;
    chart.data = data;
    
    [chart strokeChart];
}
@end
