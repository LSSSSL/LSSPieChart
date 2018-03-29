//
//  LSSPieChart.h
//  PieChart
//
//  Created by lss on 2017/10/20.
//  Copyright © 2017年 insight. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -LSSPieChartItem
@interface LSSPieChartItem : NSObject

@property (nonatomic, copy, readonly) NSString *rawX;
@property (nonatomic, copy, readonly) NSString *rawY;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
+(instancetype)pointItemWithRawX:(NSString *)rawx andRowY:(NSString *)rowy;
@end

#pragma mark -LSSPieChartData
@interface LSSPieChartData : NSObject

@property (nonatomic, strong) NSMutableArray <LSSPieChartItem *> *items;
@property (nonatomic, strong) NSMutableArray <UIColor *> *fillColors;

@end

#pragma mark -LSSPieChart
@interface LSSPieChart : UIView

@property (nonatomic, assign) float percentOfInnerHoleRadius; //default is 0.6
@property (nonatomic, assign) float startAngle; //default is M_PI*1.5f;
@property (nonatomic, strong) LSSPieChartData *data;

- (void)strokeChart;

@end
