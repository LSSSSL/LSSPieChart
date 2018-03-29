//
//  LSSPieChart.m
//  PieChart
//
//  Created by lss on 2017/10/20.
//  Copyright © 2017年 insight. All rights reserved.
//

#import "LSSPieChart.h"

#pragma mark -LSSPieChartData
@implementation LSSPieChartData

@end

#pragma mark -LSSPieChartItem
@interface LSSPieChartItem()
@property (nonatomic, copy, readwrite) NSString *rawX;
@property (nonatomic, copy, readwrite) NSString *rawY;
@end

@implementation LSSPieChartItem

+ (instancetype)pointItemWithRawX:(NSString *)rawx andRowY:(NSString *)rowy
{
    return [[LSSPieChartItem alloc]initWithX:rawx andY:rowy];
}

#pragma mark -init
- (id)initWithX:(NSString *)x andY:(NSString *)y{
    if (self = [super init]) {
        self.rawX = x;
        self.rawY = y;
    }
    return self;
}

@end


#pragma mark -LSSPieChart
@interface LSSPieChart()
@property (nonatomic, assign) float pieRadius;
@property (nonatomic, strong) CAShapeLayer *innerHoleLayer;
@property (nonatomic, strong) UIBezierPath *innerHolePath;
@property (nonatomic, strong) NSMutableArray <CAShapeLayer *> *pieLayers;
@property (nonatomic, strong) NSMutableArray <UIBezierPath *> *piePaths;
@property (nonatomic, strong) NSMutableArray <CAShapeLayer *> *legendLayers;
@property (nonatomic, strong) NSMutableArray <UIBezierPath *> *legendPaths;
@end

@implementation LSSPieChart

#pragma mark -init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self baseInit];
    }
    return self;
}

#pragma mark -baseInit
- (void)baseInit{
    _percentOfInnerHoleRadius = 0.8f;//控制中间白色部分占的大小
    _startAngle = M_PI *1.5f;
}

#pragma mark -strokeChart
- (void)strokeChart{
    if(_innerHoleLayer)_innerHoleLayer.path = _innerHolePath.CGPath;
    for (int i = 0; i < _piePaths.count; i ++){
        _pieLayers[i].path = _piePaths[i].CGPath;
    }
    
    for (int i = 0; i < _legendPaths.count; i ++){
        _legendLayers[i].path = _legendPaths[i].CGPath;
    }
}

#pragma mark -setData
- (void)setData:(LSSPieChartData *)data{
    if (_data != data) {
        _data = data;
    }
    [self clear];
    if (_data.items.count) {
        _pieRadius = (self.bounds.size.height)/2.0f;
        CGPoint center =CGPointMake(self.bounds.size.width/2.0f, _pieRadius);
        [self calculatePiePathWithData:data inCenter:center];
        [self drawHoleInCenter:center];
    }
}

#pragma mark -clear
- (void)clear{
    if(_pieLayers.count){
        for (CAShapeLayer *layer in _pieLayers) {
            [layer removeFromSuperlayer];
        }
        [_pieLayers removeAllObjects];
    }
    _pieLayers = @[].mutableCopy;
    
    if (_piePaths.count) {
        [_piePaths removeAllObjects];
    }
    _piePaths = @[].mutableCopy;
    
    if (_legendLayers.count) {
        for (CAShapeLayer *layer in _legendLayers) {
            [layer removeFromSuperlayer];
        }
        [_legendLayers removeAllObjects];
    }
    _legendLayers = @[].mutableCopy;
    
    if (_legendPaths.count) {
        [_legendPaths removeAllObjects];
    }
    _legendPaths = @[].mutableCopy;
}

#pragma mark -calculatePiePathWithData:inCenter:
- (void)calculatePiePathWithData:(LSSPieChartData *)data inCenter:(CGPoint)center{
    CGFloat startAngle = _startAngle;
    for (int i = 0; i <data.items.count; i ++) {
        LSSPieChartItem *item = data.items[i];
        CGFloat endAngle = startAngle + [item.rawY floatValue] *M_PI *2.0f;
        //&& endAngle != _startAngle + M_PI *2.0f 当只有一个数据 占比100%时需特殊处理
        if (endAngle >= M_PI *2.0f && endAngle != _startAngle + M_PI *2.0f) {
            endAngle = endAngle - M_PI *2.0f;
        }
        UIBezierPath *path = [[UIBezierPath alloc]init];
        [path moveToPoint:center];
        [path addArcWithCenter:center radius:_pieRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
        [path closePath];
        [_piePaths addObject:path];
        
        startAngle = endAngle;
        
        CAShapeLayer *pieLayer = [CAShapeLayer layer];
        pieLayer.frame = self.bounds;
        pieLayer.fillColor = data.fillColors[i].CGColor;
        [self.layer addSublayer:pieLayer];
        [_pieLayers addObject:pieLayer];
    }
}

- (void)drawHoleInCenter:(CGPoint)center{
    _innerHoleLayer = [CAShapeLayer layer];
    _innerHoleLayer.frame = self.bounds;
    _innerHoleLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:_innerHoleLayer];
    
    _innerHolePath = [UIBezierPath bezierPathWithArcCenter:center radius:_pieRadius*_percentOfInnerHoleRadius startAngle:0 endAngle:M_PI *2.0f clockwise:YES];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!_data.items.count) {
        NSString *emptyDesc = @"暂无数据";
        CGRect descRect = [emptyDesc boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil]
                                                  context:nil];
        [emptyDesc drawAtPoint:CGPointMake(rect.size.width/2.0f - descRect.size.width/2.0f, rect.size.height/2.0f -descRect.size.height/2.0f) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    }
}

@end
