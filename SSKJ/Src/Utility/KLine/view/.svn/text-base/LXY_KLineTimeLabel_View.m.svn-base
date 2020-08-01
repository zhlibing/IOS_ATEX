//
//  LXY_KLineTimeLabel_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/25.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLineTimeLabel_View.h"
#import "LXY_KLinePositionTool.h"

@interface LXY_KLineTimeLabel_View ()
{
    BOOL _isLongPress;
    LXY_KLine_DataModel *_longPressModel;
    CGFloat _longPressPositionX;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@end




@implementation LXY_KLineTimeLabel_View

-(NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

-(void)drawView
{
//    [self.dataArray removeAllObjects];
//    for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i++) {
//        [self.dataArray addObject:[self.dataSource objectAtIndex:i]];
//    }
    
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
//    SSLog(@"%.f",self.scrollGap);
    [[UIColor clearColor]setFill];//设置填充颜色
    [[UIColor whiteColor]setStroke];
    UIFont  *font = [UIFont boldSystemFontOfSize:10];//设置字体
    
    for (int i = 0; i < LXY_NumberofTimeLine + 2; i++) {
        
//        NSInteger count = (NSInteger) (self.countOfShowCandle / (LXY_NumberofTimeLine + 1));
        
        CGFloat xx = self.width / (LXY_NumberofTimeLine + 1);
        double aa = (xx - self.scrollGap) / xx;
        if (aa < 0) {
            aa = 0;
        }
        if (self.scrollGap < 0) {
            aa = 1;
        }
        
        CGFloat klineWidth = [LXY_KLinePositionTool kLineWidth] + [LXY_KLinePositionTool kLineGap];
        
//        count =  (self.countOfShowCandle / (LXY_NumberofTimeLine + aa));
        
        CGFloat count = xx / klineWidth;
        
        LXY_KLine_DataModel *model;
        if (i == LXY_NumberofTimeLine + 1) {
            model = self.dataSource[self.startDrawIndex + self.countOfShowCandle - 1];
        }else{
            NSInteger index = MIN(self.startDrawIndex + (count * i), self.dataSource.count - 1);
            model = self.dataSource[index];
        }
        NSString *time = model.time;
        CGFloat width = [WLTools getWidthWithText:time font:systemFont(10)] + 5;
        CGFloat x = 0;
        if (i == 0) {
            x = 0;
        }else if (i == LXY_NumberofTimeLine + 1){
            if (self.scrollGap > [LXY_KLinePositionTool kLineWidth] / 2) {
                continue;
            }
            x = self.width - width;
        }else{
            CGFloat width_scalw = self.width / (LXY_NumberofTimeLine + 1);
            x = width_scalw * i - width / 2;
        }
        
        // 居中
         NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        [paragraphStyle setAlignment:NSTextAlignmentCenter];
        NSDictionary *attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_timeColor],NSParagraphStyleAttributeName:paragraphStyle};
        
        [time drawInRect:CGRectMake(x, 0, width,10) withAttributes:attribute];
        
    }
    
    if (_isLongPress) {
        [self drawLongPressTime];
    }
}

-(void)drawLongPressTime
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor clearColor]setFill];//设置填充颜色
    [[UIColor whiteColor]setStroke];
    UIFont  *font = [UIFont boldSystemFontOfSize:10];//设置字体
    NSDictionary *attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor],NSBackgroundColorAttributeName:[UIColor lxy_kLineBGColor]};
    
    NSString *time = _longPressModel.time;
    CGFloat width = [WLTools getWidthWithText:time font:systemFont(10)] + 5;
    
    [time drawInRect:CGRectMake(_longPressPositionX - width / 2, 0, width,10) withAttributes:attribute];
}


-(void)longPressWithModel:(LXY_KLine_DataModel *)model positionX:(CGFloat)positionX
{
    
    _longPressModel = model;
    _longPressPositionX = positionX;
    
    _isLongPress = YES;
    
    [self setNeedsDisplay];
    
}

-(void)hideLongPressLabel
{
    _isLongPress = NO;
    
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
