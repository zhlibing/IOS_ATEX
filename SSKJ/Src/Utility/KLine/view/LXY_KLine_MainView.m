//
//  LXY_KLine_MainView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/22.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLine_MainView.h"
#import "LXY_KLinePositionTool.h"
#import "LXY_KLine_CurrentPriceLineView.h"



@interface LXY_KLine_MainView()
// 当前显示的最大价格和最小价格
@property (nonatomic, assign) double maxPrice;
@property (nonatomic, assign) double minPrice;

@property (nonatomic, assign) double maxHighPrice;
@property (nonatomic, assign) double minLowPrice;

@property (nonatomic, assign) NSInteger minPriceIndex;
@property (nonatomic, assign) NSInteger maxPriceIndex;
@property (nonatomic, strong) LXY_KLine_StockChartPositionModel *minPricePositionModel;
@property (nonatomic, strong) LXY_KLine_StockChartPositionModel *maxPricePositionModel;

// 当前显示的成交量的最大值
@property (nonatomic, assign) double maxvolume;
@property (nonatomic, strong) NSMutableArray *positionModelArray;
@end

@implementation LXY_KLine_MainView


-(NSMutableArray *)positionModelArray
{
    if (nil == _positionModelArray) {
        _positionModelArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _positionModelArray;
}

-(void)drawView
{
    // 计算最大值最小值
    [self getCurrenShowDataMaxAndMin];
    
    // 计算位置
    [self getPositionData];
    
    [self setNeedsDisplay];
}



#pragma mark - 计算最大值最小值以及单位转换等方法
/**
 *  计算 价格 成交量 的最大值最小值
 */
- (void)getCurrenShowDataMaxAndMin
{
    if (self.dataSource.count > 0) {
        self.maxPrice = [self.dataSource[self.startDrawIndex].high doubleValue];
        self.maxHighPrice = [self.dataSource[self.startDrawIndex].high doubleValue];
        
        self.minPrice = [self.dataSource[self.startDrawIndex].low doubleValue];
        self.minLowPrice = [self.dataSource[self.startDrawIndex].low doubleValue];
        
        if (self.klineType == LXY_KLINETYPETIME) {
            self.maxPrice = [self.dataSource[self.startDrawIndex].close doubleValue];
            self.maxHighPrice = [self.dataSource[self.startDrawIndex].close doubleValue];
            
            self.minPrice = [self.dataSource[self.startDrawIndex].close doubleValue];
            self.minLowPrice = [self.dataSource[self.startDrawIndex].close doubleValue];
        }
        
        self.maxvolume = [self.dataSource[self.startDrawIndex].volume doubleValue];
        if (self.startDrawIndex + self.countOfShowCandle > self.dataSource.count) return;
        for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i ++) {
            LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
            if (self.klineType == LXY_KLINETYPEKLINE) {
                self.maxPrice = self.maxPrice > [model.high doubleValue] ? self.maxPrice : [model.high doubleValue];
                if (self.maxHighPrice <= [model.high doubleValue]) {
                    self.maxHighPrice = [model.high doubleValue];
                    self.maxPriceIndex = i;
                }
                self.minPrice = self.minPrice <= model.low.doubleValue ? self.minPrice : model.low.doubleValue;
                if (self.minLowPrice > model.low.doubleValue) {
                    self.minLowPrice = model.low.doubleValue;
                    self.minPriceIndex = i;
                }
            }else{
                self.maxPrice = self.maxPrice >= [model.close doubleValue] ? self.maxPrice : [model.close doubleValue];
                if (self.maxHighPrice <= [model.close doubleValue]) {
                    self.maxHighPrice = [model.close doubleValue];
                    self.maxPriceIndex = i;
                }
                self.minPrice = self.minPrice <= model.close.doubleValue ? self.minPrice : model.close.doubleValue;
                if (self.minLowPrice > model.close.doubleValue) {
                    self.minLowPrice = model.close.doubleValue;
                    self.minPriceIndex = i;
                }
            }
            
            self.maxvolume = self.maxvolume > model.volume.doubleValue ? self.maxvolume : model.volume.doubleValue;
            
            if (self.klineType == LXY_KLINETYPEKLINE && self.accessoryType == LXY_KMAINACCESSORYTYPEMA) {
                if (model.ma5 > 0) {
                    self.maxPrice = self.maxPrice > model.ma5 ? self.maxPrice : model.ma5;
                    self.minPrice = self.minPrice < model.ma5 ? self.minPrice : model.ma5;
                }
                if (model.ma10 > 0) {
                    self.maxPrice = self.maxPrice > model.ma10 ? self.maxPrice : model.ma10;
                    self.minPrice = self.minPrice < model.ma10 ? self.minPrice : model.ma10;
                }
                if (model.ma20 > 0) {
                    self.maxPrice = self.maxPrice > model.ma20 ? self.maxPrice : model.ma20;
                    self.minPrice = self.minPrice < model.ma20 ? self.minPrice : model.ma20;
                }
            }else if (self.klineType == LXY_KLINETYPEKLINE && self.accessoryType == LXY_KMAINACCESSORYTYPEBOLL){
                self.maxPrice = self.maxPrice > model.BOLL_MB ? self.maxPrice : model.BOLL_MB;
                self.minPrice = self.minPrice < model.BOLL_MB ? self.minPrice : model.BOLL_MB;
                
                self.maxPrice = self.maxPrice > model.BOLL_UP ? self.maxPrice : model.BOLL_UP;
                self.minPrice = self.minPrice < model.BOLL_UP ? self.minPrice : model.BOLL_UP;
                
                self.maxPrice = self.maxPrice > model.BOLL_DN ? self.maxPrice : model.BOLL_DN;
                self.minPrice = self.minPrice < model.BOLL_DN ? self.minPrice : model.BOLL_DN;
                
            }
            
            
        }
        
//        self.minPrice -= (self.maxPrice - self.minPrice) / 4;
        
        //        if ((self.maxPrice - self.minPrice) < 0.3) {
        //            self.maxPrice += 0.5;
        //            self.minPrice -= 0.5;
        //        }
        
    }
    
    [self.delegate getMaxPrice:self.maxPrice minPirce:self.minPrice lastModel:self.dataSource[self.startDrawIndex + self.countOfShowCandle - 1] lastPositionModel:self.positionModelArray.lastObject];
    
}


// 获取位置坐标
-(void)getPositionData
{
    [self.positionModelArray removeAllObjects];
    
    CGFloat scale = (self.height - 20) / (self.maxPrice - self.minPrice);
    if (self.maxPrice == self.minPrice) {
        scale = 0;
    }
    CGFloat startY = 10;
    CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
    
    if (self.dataSource.count * klineWidth >= self.width / (LXY_NumberofTimeLine + 1) * LXY_NumberofTimeLine) {
        for (NSInteger i = self.countOfShowCandle + self.startDrawIndex - 1; i >= self.startDrawIndex; i--) {
            LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
            
            LXY_KLine_StockChartPositionModel *positionModel = [[LXY_KLine_StockChartPositionModel alloc]init];
            CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
            
            positionModel.centerX =  self.width - ((self.countOfShowCandle + self.startDrawIndex - i - 1) * klineWidth) - self.scrollGap;
            positionModel.highY = startY + (self.maxPrice - model.high.doubleValue) * scale;
            positionModel.lowY = startY + (self.maxPrice - model.low.doubleValue) * scale;
            positionModel.openY = startY + (self.maxPrice - model.open.doubleValue) * scale;
            positionModel.closeY = startY + (self.maxPrice - model.close.doubleValue) * scale;
            positionModel.buyY = startY + (self.maxPrice - model.buy.doubleValue) * scale;
            positionModel.sellY = startY + (self.maxPrice - model.sell.doubleValue) * scale;
            
            if (self.accessoryType == LXY_KMAINACCESSORYTYPEMA) {
                positionModel.ma5Y = startY + (self.maxPrice - model.ma5) * scale;
                positionModel.ma10Y = startY + (self.maxPrice - model.ma10) * scale;
                positionModel.ma20Y = startY + (self.maxPrice - model.ma20) * scale;
            }else if (self.accessoryType == LXY_KMAINACCESSORYTYPEBOLL){
                positionModel.BOLL_MB_Y = startY + (self.maxPrice - model.BOLL_MB) * scale;
                positionModel.BOLL_UP_Y = startY + (self.maxPrice - model.BOLL_UP) * scale;
                positionModel.BOLL_DN_Y = startY + (self.maxPrice - model.BOLL_DN) * scale;
            }
            
            
            
            [self.positionModelArray insertObject:positionModel atIndex:0];
            
            if (i == self.maxPriceIndex) {
                self.maxPricePositionModel = positionModel;
            }
            
            if (i == self.minPriceIndex) {
                self.minPricePositionModel = positionModel;
            }
        }
    }else{
        for (NSInteger i = self.startDrawIndex; i <= self.startDrawIndex + self.countOfShowCandle - 1; i++) {
            LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
            
            LXY_KLine_StockChartPositionModel *positionModel = [[LXY_KLine_StockChartPositionModel alloc]init];
            CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
            
            positionModel.centerX = (i - self.startDrawIndex) * klineWidth - [LXY_KLinePositionTool kLineWidth] / 2;
            positionModel.highY = startY + (self.maxPrice - model.high.doubleValue) * scale;
            positionModel.lowY = startY + (self.maxPrice - model.low.doubleValue) * scale;
            positionModel.openY = startY + (self.maxPrice - model.open.doubleValue) * scale;
            positionModel.closeY = startY + (self.maxPrice - model.close.doubleValue) * scale;
            positionModel.buyY = startY + (self.maxPrice - model.buy.doubleValue) * scale;
            positionModel.sellY = startY + (self.maxPrice - model.sell.doubleValue) * scale;
            
            if (self.accessoryType == LXY_KMAINACCESSORYTYPEMA) {
                positionModel.ma5Y = startY + (self.maxPrice - model.ma5) * scale;
                positionModel.ma10Y = startY + (self.maxPrice - model.ma10) * scale;
                positionModel.ma20Y = startY + (self.maxPrice - model.ma20) * scale;
            }else if (self.accessoryType == LXY_KMAINACCESSORYTYPEBOLL){
                positionModel.BOLL_MB_Y = startY + (self.maxPrice - model.BOLL_MB) * scale;
                positionModel.BOLL_UP_Y = startY + (self.maxPrice - model.BOLL_UP) * scale;
                positionModel.BOLL_DN_Y = startY + (self.maxPrice - model.BOLL_DN) * scale;
            }
            
            [self.positionModelArray addObject:positionModel];
            
            if (i == self.maxPriceIndex) {
                self.maxPricePositionModel = positionModel;
            }
            
            if (i == self.minPriceIndex) {
                self.minPricePositionModel = positionModel;
            }
        }
    }
    
    
    
    if ([self.delegate respondsToSelector:@selector(drawFinishedWithLastModel:lastPositionModel:lastIndex:)]) {
        [self.delegate drawFinishedWithLastModel:self.dataSource[self.startDrawIndex + self.countOfShowCandle - 1] lastPositionModel:self.positionModelArray.lastObject lastIndex:self.startDrawIndex + self.countOfShowCandle - 1];
    }
        
}



-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //    [self drawBounds];
    
    //    [self drawLine];
    
    if (self.klineType == LXY_KLINETYPETIME) {
        [self drawBrokenLine];
        [self drawBrokenFillColor];
    }else{
        [self drawKlineView];
        
        if (self.accessoryType == LXY_KMAINACCESSORYTYPEMA) {
            [self drawMALine];
        }else if (self.accessoryType == LXY_KMAINACCESSORYTYPEBOLL){
            [self drawBOLLLine];
        }
        [self drawMaxAndMin];
    }
    
}

// 话边框
-(void)drawBounds
{
    //    CGContextRef context = UIGraphicsGetCurrentContext();
    //
    //    CGContextSetLineCap(context, kCGLineCapSquare);
    //
    //    CGContextSetLineWidth(context, 0.5);
    //
    //    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //
    //    CGContextBeginPath(context);
    //
    //    CGContextMoveToPoint(context, 0, 0);
    //
    //    CGContextAddLineToPoint(context, self.width, 0);
    //
    //    CGContextAddLineToPoint(context, self.width, 0);
    
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    
    //指定矩形
    
    
    CGRect rectangle = self.bounds;
    
    
    //将矩形添加到路径中
    
    
    CGPathAddRect(path,NULL,
                  rectangle);
    
    
    //获取上下文
    
    
    CGContextRef currentContext =
    UIGraphicsGetCurrentContext();
    
    
    //将路径添加到上下文
    
    
    CGContextAddPath(currentContext, path);
    
    
    //设置矩形填充色
    
    
    [[UIColor clearColor]
     setFill];
    
    
    //矩形边框颜色
    
    
    [[UIColor lxy_kLineBoundsColor] setStroke];
    
    
    //边框宽度
    
    
    CGContextSetLineWidth(currentContext,1.0f);
    
    
    //绘制
    
    
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    
    CGPathRelease(path);
    
    
}


// 画虚线
-(void)drawLine
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    double price_gap = (self.maxPrice - self.minPrice) / (LXY_NumberofPriceline + 1);
    
    CGFloat scale = (self.height - 20) / (self.maxPrice - self.minPrice);
    if (self.maxPrice == self.minPrice) {
        scale = 0;
    }
    
    
    CGFloat lineGap = price_gap * scale;
    
    
    // 画价格虚线
    for (int i = 0; i < LXY_NumberofPriceline + 2; i++) {
        if (i == 0 || i == LXY_NumberofPriceline + 1) {
            continue;
        }
        
        
        [self drawDashLineWith:context movePoint:CGPointMake(0, 10 + i * lineGap) stopPoint:CGPointMake(self.width, 10 + i * lineGap) lineColor:[UIColor lxy_kLine_Divider_Color]];
        
    }
    
    lineGap = self.width / (LXY_NumberofTimeLine + 1);
    // 画时间虚线
    for (int i = 0; i < LXY_NumberofTimeLine + 2; i++) {
        if (i == 0 || i == LXY_NumberofTimeLine + 1) {
            continue;
        }
        
        
        [self drawDashLineWith:context movePoint:CGPointMake(lineGap * i, 0) stopPoint:CGPointMake(lineGap * i, self.height) lineColor:[UIColor lxy_kLine_Divider_Color]];
        
    }
    CGContextRestoreGState(context);
    
}



#pragma mark - 画K线图

// 绘制k线图
-(void)drawKlineView
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    //    if (self.dataSource.count == 0 || self.startDrawIndex + self.countOfShowCandle > self.dataSource.count) return;
    // 这两个for循环可以写成一个for循环,但是写在一个for循环里边均线会被遮挡一部分
    for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i ++) {
        LXY_KLine_StockChartPositionModel *model = [self.positionModelArray objectAtIndex:i - self.startDrawIndex];
        
        LXY_StockState stockState = model.openY <= model.closeY ? LXY_StockStateFall : LXY_StockStateRise;
        
        CGFloat star_x = model.centerX;
        // 蜡烛四个关键点纵坐标
        CGFloat p1_y = model.highY;
        CGFloat p2_y = stockState == LXY_StockStateFall ? model.openY : model.closeY;
        CGFloat p3_y = stockState == LXY_StockStateFall ? model.closeY : model.openY;
        CGFloat p4_y = model.lowY;
        CGPoint point1 = CGPointMake(star_x, p1_y);
        CGPoint point2 = CGPointMake(star_x, p2_y);
        CGPoint point3 = CGPointMake(star_x, p3_y);
        CGPoint point4 = CGPointMake(star_x, p4_y);
        // 涨跌幅
        [self drawCandleWith:context maxStartPoint:point1 maxStopPoint:point2 minStartPoint:point3 minStopPoint:point4 stockState:stockState];
    }
    
    CGContextRestoreGState(context);
    
}

#pragma mark - 画分时图

// 绘制分时图
- (void)drawBrokenLine
{
    if (self.dataSource.count > 0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0f);
        CGContextSetStrokeColorWithColor(context, [UIColor lxy_stockTimeLineColor].CGColor);
        CGFloat dash[] = {1,3};
        CGContextSetLineDash(context, 0, dash, 0);
        // 即时成交价线
        for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i ++) {
            LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
            LXY_KLine_StockChartPositionModel *positionModel = self.positionModelArray[i - self.startDrawIndex];
            CGFloat x = positionModel.centerX;
            CGFloat y = positionModel.closeY;
            if (i == self.startDrawIndex) {
                CGContextMoveToPoint(context, x, y);
            }
            else{
                CGContextAddLineToPoint(context, x, y);
            }
        }
        CGContextStrokePath(context);
    }
}


// 绘制k分时图填充色
- (void)drawBrokenFillColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    CGMutablePathRef fillPath = CGPathCreateMutable();
    
    if (self.dataSource.count > 0) {
        
        // 即时成交价线
        for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i ++) {
            LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
            LXY_KLine_StockChartPositionModel *positionModel = self.positionModelArray[i - self.startDrawIndex];
            CGFloat x = positionModel.centerX;
            CGFloat y = positionModel.closeY;
            if (i == self.startDrawIndex) {
                CGPathMoveToPoint(fillPath, NULL, positionModel.centerX, self.height);
                CGPathAddLineToPoint(fillPath, NULL, positionModel.centerX, positionModel.closeY);
            } else if (i == self.startDrawIndex + self.countOfShowCandle - 1) {
                CGPathAddLineToPoint(fillPath, NULL, positionModel.centerX, positionModel.closeY);
                CGPathAddLineToPoint(fillPath, NULL, positionModel.centerX, self.height);
                
                CGPathCloseSubpath(fillPath);
            }  else{
                CGPathAddLineToPoint(fillPath, NULL, positionModel.centerX, positionModel.closeY);
            }
        }
    }
    
    //    CGPathMoveToPoint(fillPath, NULL, 0, 0);
    //    CGPathAddLineToPoint(fillPath,NULL, self.width / 2, self.height / 2);
    //
    //    CGPathAddLineToPoint(fillPath,NULL, self.width, 0);
    //    CGPathAddLineToPoint(fillPath,NULL, self.width, self.height);
    //    CGPathAddLineToPoint(fillPath,NULL, 0, self.height);
    //    CGPathCloseSubpath(fillPath);
    
    
    [self drawLinearGradient:context path:fillPath alpha:0.5 startColor:[UIColor lxy_stockTimeFillColor].CGColor endColor:[UIColor lxy_kLine_Main_BGColor].CGColor];
    
    
    CGPathRelease(fillPath);
    
    CGContextRestoreGState(context);
}


// 绘制最大值和最小值
-(void)drawMaxAndMin
{
    LXY_KLine_DataModel *maxPriceModel = self.dataSource[self.maxPriceIndex];
    LXY_KLine_DataModel *minPriceModel = self.dataSource[self.minPriceIndex];
    
    
    // 画最大值
    NSString *maxPriceString = [WLTools noroundingStringWith:maxPriceModel.high.doubleValue afterPointNumber:LXY_DecimalNumber];
    
    NSString *showString = [@"←" stringByAppendingString:maxPriceString];
    
    CGFloat width = [WLTools getWidthWithText:showString font:systemFont(10)] + ScaleW(2);
    
    CGFloat x = self.maxPricePositionModel.centerX;
    
    if (self.maxPricePositionModel.centerX + width > self.width) {
        showString = [maxPriceString stringByAppendingString:@"→"];
        x = self.maxPricePositionModel.centerX - width;
    }
    
    UIFont  *font = [UIFont boldSystemFontOfSize:10];//设置字体
    
    NSDictionary *attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor],NSBackgroundColorAttributeName:[UIColor clearColor]};
    
    [showString drawInRect:CGRectMake(x, self.maxPricePositionModel.highY - 5 , width,10) withAttributes:attribute];
    
    
    //画最小值
    NSString *minPriceString = [WLTools noroundingStringWith:minPriceModel.low.doubleValue afterPointNumber:LXY_DecimalNumber];
    
    showString = [@"←" stringByAppendingString:minPriceString];
    
    width = [WLTools getWidthWithText:showString font:systemFont(10)] + ScaleW(2);
    
    x = self.minPricePositionModel.centerX;
    
    if (self.minPricePositionModel.centerX + width > self.width) {
        showString = [minPriceString stringByAppendingString:@"→"];
        x = self.minPricePositionModel.centerX - width;
    }
    
    
    [showString drawInRect:CGRectMake(x, self.minPricePositionModel.lowY - 5 , width,10) withAttributes:attribute];
    
    
    
}


- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                     alpha:(CGFloat)alpha
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextSetAlpha(context, 0.5);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}


-(void)drawMALine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    // 价格均线
    for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i ++) {
        LXY_KLine_StockChartPositionModel *model = [self.positionModelArray objectAtIndex:i - self.startDrawIndex];
        CGFloat star_x = model.centerX;
        
        if (self.accessoryType == LXY_KMAINACCESSORYTYPEMA) {
            if (i + 1 < self.startDrawIndex + self.countOfShowCandle) {
                LXY_KLine_StockChartPositionModel *nextModel = [self.positionModelArray objectAtIndex:i+1 - self.startDrawIndex];
                if (i >= 4) {
                    // 画五日均线
                    [self drawAvgLineWith:context movePoint:CGPointMake(star_x, model.ma5Y) stopPoint:CGPointMake(nextModel.centerX, nextModel.ma5Y) lineColor:[UIColor lxy_MA5Color]];
                }
                if (i >= 9) {
                    // 画十日均线
                    [self drawAvgLineWith:context movePoint:CGPointMake(star_x, model.ma10Y) stopPoint:CGPointMake(nextModel.centerX, nextModel.ma10Y) lineColor:[UIColor lxy_MA10Color]];
                }
                if (i >= 19) {
                    // 画二十日均线
                    [self drawAvgLineWith:context movePoint:CGPointMake(star_x, model.ma20Y) stopPoint:CGPointMake(nextModel.centerX, nextModel.ma20Y) lineColor:[UIColor lxy_MA20Color]];
                }
            }
        }else if (self.accessoryType == LXY_KMAINACCESSORYTYPEBOLL){
            
        }
        
        
    }
    
    CGContextRestoreGState(context);
    
}


// 画boll线
-(void)drawBOLLLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    // 价格均线
    for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i ++) {
        LXY_KLine_StockChartPositionModel *model = [self.positionModelArray objectAtIndex:i - self.startDrawIndex];
        CGFloat star_x = model.centerX;
        
        if (self.accessoryType == LXY_KMAINACCESSORYTYPEMA) {
            if (i + 1 < self.startDrawIndex + self.countOfShowCandle) {
                LXY_KLine_StockChartPositionModel *nextModel = [self.positionModelArray objectAtIndex:i+1 - self.startDrawIndex];
                if (i >= 4) {
                    // 画五日均线
                    [self drawAvgLineWith:context movePoint:CGPointMake(star_x, model.ma5Y) stopPoint:CGPointMake(nextModel.centerX, nextModel.ma5Y) lineColor:[UIColor lxy_MA5Color]];
                }
                if (i >= 9) {
                    // 画十日均线
                    [self drawAvgLineWith:context movePoint:CGPointMake(star_x, model.ma10Y) stopPoint:CGPointMake(nextModel.centerX, nextModel.ma10Y) lineColor:[UIColor lxy_MA10Color]];
                }
                if (i >= 19) {
                    // 画二十日均线
                    [self drawAvgLineWith:context movePoint:CGPointMake(star_x, model.ma20Y) stopPoint:CGPointMake(nextModel.centerX, nextModel.ma20Y) lineColor:[UIColor lxy_MA20Color]];
                }
            }
        }else if (self.accessoryType == LXY_KMAINACCESSORYTYPEBOLL){
            if (i + 1 < self.startDrawIndex + self.countOfShowCandle) {
                LXY_KLine_StockChartPositionModel *nextModel = [self.positionModelArray objectAtIndex:i+1 - self.startDrawIndex];
                if (i >= 19) {
                    // 画BOLL_MB 标准线
                    [self drawAvgLineWith:context movePoint:CGPointMake(star_x, model.BOLL_MB_Y) stopPoint:CGPointMake(nextModel.centerX, nextModel.BOLL_MB_Y) lineColor:[UIColor lxy_BollMBColor]];
                }
                if (i >= 19) {
                    // 画BOLL_UP 线
                    [self drawAvgLineWith:context movePoint:CGPointMake(star_x, model.BOLL_UP_Y) stopPoint:CGPointMake(nextModel.centerX, nextModel.BOLL_UP_Y) lineColor:[UIColor lxy_BollUPColor]];
                }
                if (i >= 19) {
                    // 画BOLL_DN线
                    [self drawAvgLineWith:context movePoint:CGPointMake(star_x, model.BOLL_DN_Y) stopPoint:CGPointMake(nextModel.centerX, nextModel.BOLL_DN_Y) lineColor:[UIColor lxy_BollDNColor]];
                }
            }
        }
        
        
    }
    
    CGContextRestoreGState(context);
}


/**
 *  画线段
 *
 *  @param context   当前上下文
 *  @param movePoint 开始点
 *  @param stopPoint 结束点
 *  @param lineColor 线段颜色
 */
- (void)drawAvgLineWith:(CGContextRef)context movePoint:(CGPoint)movePoint stopPoint:(CGPoint)stopPoint lineColor:(UIColor *)lineColor
{
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, movePoint.x, movePoint.y);
    CGContextAddLineToPoint(context, stopPoint.x, stopPoint.y);
    CGContextStrokePath(context);
}

/**
 *  画虚线
 *
 *  @param context   当前上下文
 *  @param movePoint 开始点
 *  @param stopPoint 结束点
 *  @param lineColor 线段颜色
 */
- (void)drawDashLineWith:(CGContextRef)context movePoint:(CGPoint)movePoint stopPoint:(CGPoint)stopPoint lineColor:(UIColor *)lineColor
{
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGFloat lengths[] = {4,2};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, movePoint.x, movePoint.y);
    CGContextAddLineToPoint(context, stopPoint.x, stopPoint.y);
    CGContextStrokePath(context);
}


#pragma mark - 画点
/**
 *  画K线点(蜡烛)
 *
 *  @param context       当前上下文
 *  @param maxStartPoint 上影线最高点
 *  @param maxStopPoint  上影线最低点
 *  @param minStartPoint 下影线最高点
 *  @param minStopPoint  下影线最低点
 *  @param stockState    涨跌幅
 */
- (void)drawCandleWith:(CGContextRef)context maxStartPoint:(CGPoint)maxStartPoint maxStopPoint:(CGPoint)maxStopPoint minStartPoint:(CGPoint)minStartPoint minStopPoint:(CGPoint)minStopPoint stockState:(LXY_StockState)stockState
{
    if (stockState == LXY_StockStateRise) {
        // 空心
        //        CGContextSetStrokeColorWithColor(context, [UIColor lxy_riseColor].CGColor);
        //        CGContextSetLineWidth(context, 1.0);
        //        CGContextMoveToPoint(context, maxStartPoint.x, maxStartPoint.y);
        //        CGContextAddLineToPoint(context, maxStopPoint.x, maxStopPoint.y);
        //        CGContextMoveToPoint(context, minStartPoint.x, minStartPoint.y);
        //        CGContextAddLineToPoint(context, minStopPoint.x, minStopPoint.y);
        //        CGContextStrokePath(context);
        //        CGContextStrokeRect(context, CGRectMake(maxStopPoint.x - [LXY_KLinePositionTool kLineWidth] / 2.0, maxStopPoint.y, [LXY_KLinePositionTool kLineWidth], minStartPoint.y - maxStopPoint.y));
        
        // 实心
        CGContextSetStrokeColorWithColor(context, [UIColor lxy_riseColor].CGColor);
        CGContextSetLineWidth(context, 1.0);
        CGContextMoveToPoint(context, maxStartPoint.x, maxStartPoint.y);
        CGContextAddLineToPoint(context, minStopPoint.x, minStopPoint.y);
        CGContextStrokePath(context);
        CGContextSetFillColorWithColor(context, [UIColor lxy_riseColor].CGColor);
        CGContextFillRect(context, CGRectMake(maxStartPoint.x - [LXY_KLinePositionTool kLineWidth] / 2.0, maxStopPoint.y, [LXY_KLinePositionTool kLineWidth], minStartPoint.y - maxStopPoint.y));
    }else{
        CGContextSetStrokeColorWithColor(context, [UIColor lxy_fallColor].CGColor);
        CGContextSetLineWidth(context, 1.0);
        CGContextMoveToPoint(context, maxStartPoint.x, maxStartPoint.y);
        CGContextAddLineToPoint(context, minStopPoint.x, minStopPoint.y);
        CGContextStrokePath(context);
        CGContextSetFillColorWithColor(context, [UIColor lxy_fallColor].CGColor);
        CGContextFillRect(context, CGRectMake(maxStartPoint.x - [LXY_KLinePositionTool kLineWidth] / 2.0, maxStopPoint.y, [LXY_KLinePositionTool kLineWidth], minStartPoint.y - maxStopPoint.y));
    }
}
-(LXY_KLine_StockChartPositionModel *)positionModelWithIndex:(NSInteger)index
{
    if (index < 0 || index > self.dataSource.count - 1) {
        return nil;
    }
    return self.positionModelArray[index - self.startDrawIndex];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 1.判断当前控件能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) return nil;
    // 2. 判断点在不在当前控件
    if ([self pointInside:point withEvent:event] == NO) return nil;
    // 3.从后往前遍历自己的子控件
    NSInteger count = self.subviews.count;
    for (NSInteger i = count - 1; i >= 0; i--) {
        UIView *childView = self.subviews[i];
        // 把当前控件上的坐标系转换成子控件上的坐标系
        CGPoint childP = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) { // 寻找到最合适的view
            return fitView;
        }
    }
    
    
    NSArray *array = self.superview.subviews;
    for (UIView *view in array) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            return view;
        }
    }
    // 循环结束,表示没有比自己更合适的view
    return self;
}

-(NSInteger)indexWithPositionX:(CGFloat)positionX
{
    for (int i = 0; i < self.positionModelArray.count; i++) {
        LXY_KLine_StockChartPositionModel *positionModel = [self.positionModelArray objectAtIndex:i];
        if (positionModel.centerX > positionX) {
            return self.startDrawIndex + i;
        }
    }
    
    return self.startDrawIndex + self.countOfShowCandle - 1;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
