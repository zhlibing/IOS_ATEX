//
//  LXY_KLine_AccessoryView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/29.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLine_AccessoryView.h"
#import "LXY_KLine_StockChartPositionModel.h"

#import "LXY_KLinePositionTool.h"

@interface LXY_KLine_AccessoryView ()
@property (nonatomic, assign) double minValue;
@property (nonatomic, assign) double maxValue;
@property (nonatomic, strong) NSMutableArray <LXY_KLine_StockChartPositionModel *>*positionModelArray;

@end

@implementation LXY_KLine_AccessoryView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lxy_kLineBGColor];
    }
    return self;
}

-(NSMutableArray *)positionModelArray
{
    if (nil == _positionModelArray) {
        _positionModelArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _positionModelArray;
}


-(void)drawView
{
    if (self.accessoryType == LXY_ACCESSORYTYPEMACD) {
        // 计算最大值最小值
        [self getCurrenShowDataMaxAndMinMACD];
        // 计算坐标
        [self getMACDPositionData];
    }else if (self.accessoryType == LXY_ACCESSORYTYPEKDJ){
        // 计算最大值最小值
        [self getCurrenShowDataMaxAndMinKDJ];
        // 计算坐标
        [self getKDJPositionData];
    }else if (self.accessoryType == LXY_ACCESSORYTYPERSI){
        // 计算最大值最小值
        [self getCurrenShowDataMaxAndMinRSI];
        // 计算坐标
        [self getRSIPositionData];
    }else if (self.accessoryType == LXY_ACCESSORYTYPEWR){
        // 计算最大值最小值
        [self getCurrenShowDataMaxAndMinWR];
        // 计算坐标
        [self getWRPositionData];
    }
    
    
    
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
//    [self drawBounds];
//    [self drawLine];
    if (self.accessoryType == LXY_ACCESSORYTYPEMACD) {
        [self drawMACD];
    }else if (self.accessoryType == LXY_ACCESSORYTYPEKDJ) {
        [self drawKDJLine];
    }else if (self.accessoryType == LXY_ACCESSORYTYPERSI){
        [self drawRSILine];
    }else if (self.accessoryType == LXY_ACCESSORYTYPEWR){
        [self drawWRLine];
    }
    
    
    if ([self.delegate respondsToSelector:@selector(getMaxValue:minValue:)]) {
        [self.delegate getMaxValue:self.maxValue minValue:self.minValue];
    }
}
#pragma mark - 边框
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
    
    
    CGFloat lineGap = self.width / (LXY_NumberofTimeLine + 1);
    // 画时间虚线
    for (int i = 0; i < LXY_NumberofTimeLine + 2; i++) {
        if (i == 0 || i == LXY_NumberofTimeLine + 1) {
            continue;
        }
        
        
        [self drawDashLineWith:context movePoint:CGPointMake(lineGap * i, 0) stopPoint:CGPointMake(lineGap * i, self.height) lineColor:[UIColor lxy_kLine_Divider_Color]];
        
    }
    CGContextRestoreGState(context);
    
}

- (void)drawDashLineWith:(CGContextRef)context movePoint:(CGPoint)movePoint stopPoint:(CGPoint)stopPoint lineColor:(UIColor *)lineColor
{
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineWidth(context, 1);
//    CGFloat lengths[] = {4,2};
//    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, movePoint.x, movePoint.y);
    CGContextAddLineToPoint(context, stopPoint.x, stopPoint.y);
    CGContextStrokePath(context);
}
#pragma mark - 画MACD线

-(void)getCurrenShowDataMaxAndMinMACD
{
    if (self.dataSource.count > 0) {
        
        self.maxValue = self.dataSource[self.startDrawIndex].MACD;
        self.minValue = self.dataSource[self.startDrawIndex].MACD;
        
        if (self.startDrawIndex + self.countOfShowCandle > self.dataSource.count) return;
        for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i ++) {
            LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
            self.maxValue = self.maxValue > model.MACD ? self.maxValue : model.MACD;
            self.maxValue = self.maxValue > model.DEA ? self.maxValue : model.DEA;
            self.maxValue = self.maxValue > model.DIF ? self.maxValue : model.DIF;
            
            self.minValue = self.minValue < model.MACD ? self.minValue : model.MACD;
            self.minValue = self.minValue < model.DEA ? self.minValue : model.DEA;
            self.minValue = self.minValue < model.DIF ? self.minValue : model.DIF;

        }
        //        if ((self.maxPrice - self.minPrice) < 0.3) {
        //            self.maxPrice += 0.5;
        //            self.minPrice -= 0.5;
        //        }
        
    }
    
}

-(void)getMACDPositionData
{

    
    [self.positionModelArray removeAllObjects];
    
    
    double value = self.maxValue > - self.minValue ? self.maxValue : -self.minValue;
    
    CGFloat scale = (self.height / 2 - 10) / value;

    CGFloat startY = self.height / 2;
    
    for (NSInteger i = self.startDrawIndex; i < self.countOfShowCandle + self.startDrawIndex; i++) {
        LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
        
        LXY_KLine_StockChartPositionModel *positionModel = [[LXY_KLine_StockChartPositionModel alloc]init];
        CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
        
        positionModel.centerX = klineWidth * (i - self.startDrawIndex) + [LXY_KLinePositionTool kLineWidth] / 2;
        
        positionModel.MACDY = startY - scale * (model.MACD);
        
        positionModel.DEAY = startY - scale * (model.DEA);
        if (positionModel.DEAY < 0) {
//            SSLog(@"");
        }

        positionModel.DIFY = startY - scale * (model.DIF);
        if (positionModel.DIFY < 0) {
//            SSLog(@"");
        }

        
        [self.positionModelArray addObject:positionModel];
    }
}

-(void)drawMACD
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i++) {
        LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
        LXY_KLine_StockChartPositionModel *positionModel = [self.positionModelArray objectAtIndex:i - self.startDrawIndex];
        
        LXY_StockState stockState = model.MACD >= 0 ? LXY_StockStateRise : LXY_StockStateFall;
        
        [self drawMACDWith:context starPoint:CGPointMake(positionModel.centerX, positionModel.MACDY) withRise:stockState];
        
        CGFloat star_x = positionModel.centerX;
        
        if (i + 1 < self.startDrawIndex + self.countOfShowCandle) {
            LXY_KLine_StockChartPositionModel *nextPositionModel = [self.positionModelArray objectAtIndex:i+1 - self.startDrawIndex];
            
            
            // DIF线
            [self drawLineWith:context movePoint:CGPointMake(star_x, positionModel.DIFY) stopPoint:CGPointMake(nextPositionModel.centerX, nextPositionModel.DIFY) lineColor:[UIColor lxy_DIFColor]];
            
            // DEA线
            [self drawLineWith:context movePoint:CGPointMake(star_x, positionModel.DEAY) stopPoint:CGPointMake(nextPositionModel.centerX, nextPositionModel.DEAY) lineColor:[UIColor lxy_DEAColor]];
        }
    }
}

- (void)drawMACDWith:(CGContextRef)context starPoint:(CGPoint)starPoint withRise:(LXY_StockState)stockState
{
    
    if (stockState == LXY_StockStateRise) {
        
        // 空心
        //        CGContextSetStrokeColorWithColor(context, [UIColor lxy_riseColor].CGColor);
        //        CGContextSetLineWidth(context, 1.0);
        //        CGContextStrokePath(context);
        //        CGContextStrokeRect(context, CGRectMake(starPoint.x - [LXY_KLinePositionTool kLineWidth] / 2, starPoint.y, [LXY_KLinePositionTool kLineWidth], self.height - starPoint.y));
        // 实心
        CGContextSetFillColorWithColor(context, [UIColor lxy_riseColor].CGColor);
        CGContextFillRect(context, CGRectMake(starPoint.x - [LXY_KLinePositionTool kLineWidth] / 2, starPoint.y, [LXY_KLinePositionTool kLineWidth],  self.height / 2 - starPoint.y));
    }else{
        CGContextSetFillColorWithColor(context, [UIColor lxy_fallColor].CGColor);
        CGContextFillRect(context, CGRectMake(starPoint.x - [LXY_KLinePositionTool kLineWidth] / 2, self.height / 2, [LXY_KLinePositionTool kLineWidth],starPoint.y - self.height / 2 ));
        
        //        CGContextFillRect(context, CGRectMake(starPoint.x - self.candleWidth / 2.0, starPoint.y, self.candleWidth, self.bounds.size.height - self.padding.bottom - self.defaultTextSize - 4 - starPoint.y));
        
    }
}


#pragma mark - 画KDJ线

-(void)getCurrenShowDataMaxAndMinKDJ
{
    if (self.dataSource.count > 0) {
        
        self.maxValue = self.dataSource[self.startDrawIndex].KDJ_K;
        self.minValue = self.dataSource[self.startDrawIndex].KDJ_K;
        
//        if (self.startDrawIndex + self.countOfShowCandle > self.dataSource.count) return;
        for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i ++) {
            if (i >= self.dataSource.count) {
                break;
            }
            LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
            
            if (model.KDJ_K < 0 || model.KDJ_K > 100) {
//                SSLog(@"");
            }
            if (model.KDJ_D < 0 || model.KDJ_D > 100) {
//                SSLog(@"");
            }
            if (model.KDJ_J < 0 || model.KDJ_J > 100) {
//                SSLog(@"");
            }
            self.maxValue = self.maxValue > model.KDJ_K ? self.maxValue : model.KDJ_K;
            self.maxValue = self.maxValue > model.KDJ_D ? self.maxValue : model.KDJ_D;
            self.maxValue = self.maxValue > model.KDJ_J ? self.maxValue : model.KDJ_J;
            
            self.minValue = self.minValue < model.KDJ_K ? self.minValue : model.KDJ_K;
            self.minValue = self.minValue < model.KDJ_D ? self.minValue : model.KDJ_D;
            self.minValue = self.minValue < model.KDJ_J ? self.minValue : model.KDJ_J;
        }
        //        if ((self.maxPrice - self.minPrice) < 0.3) {
        //            self.maxPrice += 0.5;
        //            self.minPrice -= 0.5;
        //        }
        
    }
    
}
-(void)getKDJPositionData
{
    
    [self.positionModelArray removeAllObjects];
    
    
    double value = self.maxValue  - self.minValue;
    
    CGFloat scale = (self.height  - 20) / value;
    
    CGFloat startY = 10 ;
    
    for (NSInteger i = self.startDrawIndex; i < self.countOfShowCandle + self.startDrawIndex; i++) {
        LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
        
        LXY_KLine_StockChartPositionModel *positionModel = [[LXY_KLine_StockChartPositionModel alloc]init];
        CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
        
        positionModel.centerX = klineWidth * (i - self.startDrawIndex) + [LXY_KLinePositionTool kLineWidth] / 2;
        
        positionModel.KDJ_K_Y = startY + scale * (self.maxValue - model.KDJ_K);
        
        positionModel.KDJ_D_Y = startY + scale * (self.maxValue - model.KDJ_D);
        
        positionModel.KDJ_J_Y = startY + scale * (self.maxValue - model.KDJ_J);
        
        [self.positionModelArray addObject:positionModel];
    }
}


-(void)drawKDJLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i++) {
        LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
        LXY_KLine_StockChartPositionModel *positionModel = [self.positionModelArray objectAtIndex:i - self.startDrawIndex];

        CGFloat star_x = positionModel.centerX;
        
        if (i + 1 < self.startDrawIndex + self.countOfShowCandle) {
            LXY_KLine_StockChartPositionModel *nextPositionModel = [self.positionModelArray objectAtIndex:i+1 - self.startDrawIndex];
            
            
            // KDJ_K线
            [self drawLineWith:context movePoint:CGPointMake(star_x, positionModel.KDJ_K_Y) stopPoint:CGPointMake(nextPositionModel.centerX, nextPositionModel.KDJ_K_Y) lineColor:[UIColor lxy_KDJ_KColor]];
            
            // KDJ_D线
            [self drawLineWith:context movePoint:CGPointMake(star_x, positionModel.KDJ_D_Y) stopPoint:CGPointMake(nextPositionModel.centerX, nextPositionModel.KDJ_D_Y) lineColor:[UIColor lxy_KDJ_DColor]];
            
            // KDJ_J线
            [self drawLineWith:context movePoint:CGPointMake(star_x, positionModel.KDJ_J_Y) stopPoint:CGPointMake(nextPositionModel.centerX, nextPositionModel.KDJ_J_Y) lineColor:[UIColor lxy_KDJ_JColor]];
        }
    }
}


#pragma mark - 画RSI线

-(void)getCurrenShowDataMaxAndMinRSI
{
    if (self.dataSource.count > 0) {
        
//        self.maxValue = self.dataSource[self.startDrawIndex].RSI6;
//        self.minValue = self.dataSource[self.startDrawIndex].RSI6;
        self.maxValue = 100;
        self.minValue = 0;
        
        if (self.startDrawIndex + self.countOfShowCandle > self.dataSource.count) return;
//        for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i ++) {
//            LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
//            self.maxValue = self.maxValue > model.RSI6 ? self.maxValue : model.RSI6;
//            self.maxValue = self.maxValue > model.RSI12 ? self.maxValue : model.RSI12;
//            self.maxValue = self.maxValue > model.RSI24 ? self.maxValue : model.RSI24;
//
//            self.minValue = self.minValue < model.RSI6 ? self.minValue : model.RSI6;
//            self.minValue = self.minValue < model.RSI12 ? self.minValue : model.RSI12;
//            self.minValue = self.minValue < model.RSI24 ? self.minValue : model.RSI24;
//
//            if (self.maxValue > 100 || self.minValue < 0) {
//                SSLog(@"");
//            }
//
//        }
        //        if ((self.maxPrice - self.minPrice) < 0.3) {
        //            self.maxPrice += 0.5;
        //            self.minPrice -= 0.5;
        //        }
        
    }
    
}

-(void)getRSIPositionData
{
    
    
    [self.positionModelArray removeAllObjects];
    
    
    double value = 100;
    
    CGFloat scale = (self.height  - 20) / value;
    
    CGFloat startY = 10;
    
    for (NSInteger i = self.startDrawIndex; i < self.countOfShowCandle + self.startDrawIndex; i++) {
        LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
        
        LXY_KLine_StockChartPositionModel *positionModel = [[LXY_KLine_StockChartPositionModel alloc]init];
        CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
        
        positionModel.centerX = klineWidth * (i - self.startDrawIndex) + [LXY_KLinePositionTool kLineWidth] / 2;
        
        positionModel.RSI6_Y = startY + scale * (100.0 - model.RSI6);
        
        positionModel.RSI12_Y = startY + scale * (100.0 - model.RSI12);
        
        positionModel.RSI24_Y = startY + scale * (100.0 - model.RSI24);

        
        
        [self.positionModelArray addObject:positionModel];
    }
}


-(void)drawRSILine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i++) {
        LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
        LXY_KLine_StockChartPositionModel *positionModel = [self.positionModelArray objectAtIndex:i - self.startDrawIndex];
        
        CGFloat star_x = positionModel.centerX;
        
        if (i + 1 < self.startDrawIndex + self.countOfShowCandle) {
            LXY_KLine_StockChartPositionModel *nextPositionModel = [self.positionModelArray objectAtIndex:i+1 - self.startDrawIndex];
            
            if (i >= 6) {
                // RSI6线
                [self drawLineWith:context movePoint:CGPointMake(star_x, positionModel.RSI6_Y) stopPoint:CGPointMake(nextPositionModel.centerX, nextPositionModel.RSI6_Y) lineColor:[UIColor lxy_RSI6Color]];
                
            }
            if (i >= 12) {

                // RSI12线
                [self drawLineWith:context movePoint:CGPointMake(star_x, positionModel.RSI12_Y) stopPoint:CGPointMake(nextPositionModel.centerX, nextPositionModel.RSI12_Y) lineColor:[UIColor lxy_RSI12Color]];
            }
            if (i >= 24) {

                // RSI24线
                [self drawLineWith:context movePoint:CGPointMake(star_x, positionModel.RSI24_Y) stopPoint:CGPointMake(nextPositionModel.centerX, nextPositionModel.RSI24_Y) lineColor:[UIColor lxy_RSI24Color]];
            }
        }
    }
}


#pragma mark - 画WR线
-(void)getCurrenShowDataMaxAndMinWR
{
    if (self.dataSource.count > 0) {
        
        self.maxValue = self.dataSource[self.startDrawIndex].WR14;
        self.minValue = self.dataSource[self.startDrawIndex].WR14;
        
        if (self.startDrawIndex + self.countOfShowCandle > self.dataSource.count) return;
        for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i ++) {
            LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
            self.maxValue = self.maxValue > model.RSI6 ? self.maxValue : model.WR14;
            self.minValue = self.minValue < model.RSI24 ? self.minValue : model.WR14;
            
        }
    }
    
}

-(void)getWRPositionData
{
    
    
    [self.positionModelArray removeAllObjects];
    
    
    double value = 100.0f;
    
    CGFloat scale = (self.height  - 20) / value;
    
    CGFloat startY = 10;
    
    for (NSInteger i = self.startDrawIndex; i < self.countOfShowCandle + self.startDrawIndex; i++) {
        LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
        
        LXY_KLine_StockChartPositionModel *positionModel = [[LXY_KLine_StockChartPositionModel alloc]init];
        CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
        
        positionModel.centerX = klineWidth * (i - self.startDrawIndex) + [LXY_KLinePositionTool kLineWidth] / 2;
        
        positionModel.WR14_Y = startY + scale * (100.0 - model.WR14);
        
        [self.positionModelArray addObject:positionModel];
    }
}

-(void)drawWRLine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i++) {
        LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
        LXY_KLine_StockChartPositionModel *positionModel = [self.positionModelArray objectAtIndex:i - self.startDrawIndex];
        
        CGFloat star_x = positionModel.centerX;
        
        if (i + 1 < self.startDrawIndex + self.countOfShowCandle) {
            LXY_KLine_StockChartPositionModel *nextPositionModel = [self.positionModelArray objectAtIndex:i+1 - self.startDrawIndex];
            
            if (i >= 13) {
                // WR14线
                [self drawLineWith:context movePoint:CGPointMake(star_x, positionModel.WR14_Y) stopPoint:CGPointMake(nextPositionModel.centerX, nextPositionModel.WR14_Y) lineColor:[UIColor lxy_WR14Color]];
                
            }
            
        }
    }
}
// 划线
- (void)drawLineWith:(CGContextRef)context movePoint:(CGPoint)movePoint stopPoint:(CGPoint)stopPoint lineColor:(UIColor *)lineColor
{
    CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextMoveToPoint(context, movePoint.x, movePoint.y);
    CGContextAddLineToPoint(context, stopPoint.x, stopPoint.y);
    CGContextStrokePath(context);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
