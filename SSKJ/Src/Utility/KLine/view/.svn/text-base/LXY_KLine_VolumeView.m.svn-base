//
//  LXY_KLine_VolumeView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/22.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLine_VolumeView.h"
#import "LXY_KLine_StockChartPositionModel.h"
#import "LXY_KLinePositionTool.h"


@interface LXY_KLine_VolumeView ()

// 当前显示的成交量的最大值

@property (nonatomic, assign) double minvolume;
@property (nonatomic, assign) double maxvolume;
@property (nonatomic, strong) NSMutableArray *positionModelArray;

@end

@implementation LXY_KLine_VolumeView


-(void)drawView
{
    // 计算最大值最小值
    [self getCurrenShowDataMaxAndMin];
    
    // 计算位置
    [self getPositionData];
    
    [self setNeedsDisplay];
}

-(NSMutableArray *)positionModelArray
{
    if (nil == _positionModelArray) {
        _positionModelArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _positionModelArray;
}

#pragma mark - 计算最大值最小值以及单位转换等方法
/**
 *  计算 价格 成交量 的最大值最小值
 */
- (void)getCurrenShowDataMaxAndMin
{
    if (self.dataSource.count > 0) {
        
        self.maxvolume = [self.dataSource[self.startDrawIndex].volume doubleValue];
        self.minvolume = [self.dataSource[self.startDrawIndex].volume doubleValue];
        
        if (self.startDrawIndex + self.countOfShowCandle > self.dataSource.count) return;
        for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i ++) {
            LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
            self.maxvolume = self.maxvolume > [model.volume doubleValue] ? self.maxvolume : [model.volume doubleValue];
            self.minvolume = self.minvolume < [model.volume doubleValue] ? self.minvolume : [model.volume doubleValue];
            
            
            
            if (model.volume_MA5 > 0) {
                self.maxvolume = self.maxvolume > model.volume_MA5 ? self.maxvolume : model.volume_MA5;
                self.minvolume = self.minvolume < model.volume_MA5 ? self.minvolume : model.volume_MA5;
            }
            if (model.volume_MA10 > 0) {
                self.maxvolume = self.maxvolume > model.volume_MA10 ? self.maxvolume : model.volume_MA10;
                self.minvolume = self.minvolume < model.volume_MA10 ? self.minvolume : model.volume_MA10;
            }
            //            if (model.ma20 > 0) {
            //                self.maxPrice = self.maxPrice > model.ma20 ? self.maxPrice : model.ma20;
            //                self.minPrice = self.minPrice < model.ma20 ? self.minPrice : model.ma20;
            //            }
        }
        //        if ((self.maxPrice - self.minPrice) < 0.3) {
        //            self.maxPrice += 0.5;
        //            self.minPrice -= 0.5;
        //        }
        
    }
    
    [self.delegate getMaxVolume:self.maxvolume minVolume:self.minvolume];
    
    
}


// 获取位置坐标
-(void)getPositionData
{
    [self.positionModelArray removeAllObjects];
    
    CGFloat scale = (self.height - 10) / (self.maxvolume - self.minvolume);
    
    CGFloat startY = 10;
    CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
    
    if (self.dataSource.count * klineWidth >= self.width / (LXY_NumberofTimeLine + 1) * LXY_NumberofTimeLine) {
        for (NSInteger i = self.countOfShowCandle + self.startDrawIndex - 1; i >= self.startDrawIndex; i--) {
            LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
            
            LXY_KLine_StockChartPositionModel *positionModel = [[LXY_KLine_StockChartPositionModel alloc]init];
            CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
            
            positionModel.centerX =  self.width - ((self.countOfShowCandle + self.startDrawIndex - i - 1) * klineWidth) - self.scrollGap;
            
            positionModel.volumeY = startY + scale * (self.maxvolume - model.volume.doubleValue);
            
            positionModel.volume_MA5Y = startY + scale * (self.maxvolume - model.volume_MA5);
            
            positionModel.volume_MA10Y = startY + scale * (self.maxvolume - model.volume_MA10);
            
            [self.positionModelArray insertObject:positionModel atIndex:0];
        }
    }else{
        for (NSInteger i = self.startDrawIndex; i < self.countOfShowCandle + self.startDrawIndex - 1; i++) {
            LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
            
            LXY_KLine_StockChartPositionModel *positionModel = [[LXY_KLine_StockChartPositionModel alloc]init];
            CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
            
            positionModel.centerX = klineWidth * (i - self.startDrawIndex) + [LXY_KLinePositionTool kLineWidth] / 2;
            
            positionModel.volumeY = startY + scale * (self.maxvolume - model.volume.doubleValue);
            
            positionModel.volume_MA5Y = startY + scale * (self.maxvolume - model.volume_MA5);
            
            positionModel.volume_MA10Y = startY + scale * (self.maxvolume - model.volume_MA10);
            
            
            
            
            [self.positionModelArray addObject:positionModel];
        }
        
        
    }
}

- (void)drawVolumeWith:(CGContextRef)context starPoint:(CGPoint)starPoint withRise:(LXY_StockState)stockState
{
    
    if (stockState == LXY_StockStateRise) {
        
        // 空心
        //        CGContextSetStrokeColorWithColor(context, [UIColor lxy_riseColor].CGColor);
        //        CGContextSetLineWidth(context, 1.0);
        //        CGContextStrokePath(context);
        //        CGContextStrokeRect(context, CGRectMake(starPoint.x - [LXY_KLinePositionTool kLineWidth] / 2, starPoint.y, [LXY_KLinePositionTool kLineWidth], self.height - starPoint.y));
        // 实心
        CGContextSetFillColorWithColor(context, [UIColor lxy_riseColor].CGColor);
        CGContextFillRect(context, CGRectMake(starPoint.x - [LXY_KLinePositionTool kLineWidth] / 2, starPoint.y, [LXY_KLinePositionTool kLineWidth], self.height - starPoint.y));
    }else{
        CGContextSetFillColorWithColor(context, [UIColor lxy_fallColor].CGColor);
        CGContextFillRect(context, CGRectMake(starPoint.x - [LXY_KLinePositionTool kLineWidth] / 2, starPoint.y, [LXY_KLinePositionTool kLineWidth], self.height - starPoint.y));
        
        //        CGContextFillRect(context, CGRectMake(starPoint.x - self.candleWidth / 2.0, starPoint.y, self.candleWidth, self.bounds.size.height - self.padding.bottom - self.defaultTextSize - 4 - starPoint.y));
        
    }
}


-(void)drawVolume
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i++) {
        LXY_KLine_DataModel *model = [self.dataSource objectAtIndex:i];
        LXY_KLine_StockChartPositionModel *positionModel = [self.positionModelArray objectAtIndex:i - self.startDrawIndex];
        
        LXY_StockState stockState = model.open.doubleValue >= model.close.doubleValue ? LXY_StockStateFall : LXY_StockStateRise;
        
        [self drawVolumeWith:context starPoint:CGPointMake(positionModel.centerX, positionModel.volumeY) withRise:stockState];
        
    }
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //    [self drawBounds];
    
    //    [self drawLine];
    
    [self drawVolume];
    
    [self drawMALine];
    //    [self drawMALine];
    
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

-(void)drawLine
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    double price_gap = (self.maxvolume - self.minvolume) / (LXY_NumberofVolumeLine + 1);
    
    CGFloat scale = (self.height - 10) / (self.maxvolume - self.minvolume);
    if (self.maxvolume == self.minvolume) {
        scale = 0;
    }
    
    
    CGFloat lineGap = price_gap * scale;
    
    
    // 画价格虚线
    for (int i = 0; i < LXY_NumberofVolumeLine + 2; i++) {
        if (i == 0 || i == LXY_NumberofVolumeLine + 1) {
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


-(void)drawMALine
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    // 价格均线
    for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i ++) {
        LXY_KLine_StockChartPositionModel *model = [self.positionModelArray objectAtIndex:i - self.startDrawIndex];
        CGFloat star_x = model.centerX;
        
        //        if (self.accessoryType == LXY_KMAINACCESSORYTYPEMA) {
        if (i + 1 < self.startDrawIndex + self.countOfShowCandle) {
            LXY_KLine_StockChartPositionModel *nextModel = [self.positionModelArray objectAtIndex:i+1 - self.startDrawIndex];
            if (i >= 4) {
                // 画五日均线
                [self drawAvgLineWith:context movePoint:CGPointMake(star_x, model.volume_MA5Y) stopPoint:CGPointMake(nextModel.centerX, nextModel.volume_MA5Y) lineColor:[UIColor lxy_MA5Color]];
            }
            if (i >= 9) {
                // 画十日均线
                [self drawAvgLineWith:context movePoint:CGPointMake(star_x, model.volume_MA10Y) stopPoint:CGPointMake(nextModel.centerX, nextModel.volume_MA10Y) lineColor:[UIColor lxy_MA10Color]];
            }
            
        }
        //        }else if (self.accessoryType == LXY_KMAINACCESSORYTYPEBOLL){
        //
        //        }
        
        
    }
    
    CGContextRestoreGState(context);
    
}

- (void)drawAvgLineWith:(CGContextRef)context movePoint:(CGPoint)movePoint stopPoint:(CGPoint)stopPoint lineColor:(UIColor *)lineColor
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
