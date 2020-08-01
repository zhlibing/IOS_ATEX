//
//  LXY_KLine_TipView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/26.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLine_TipView.h"

@interface LXY_KLine_TipView ()
{
    LXY_KLine_DataModel *_longPressModel;
}
@property (nonatomic, strong) NSArray *titlesArray;
@end

@implementation LXY_KLine_TipView

-(NSArray *)titlesArray
{
    if (nil == _titlesArray) {
        
        _titlesArray  = @[SSKJLanguage(@"时间"),SSKJLanguage(@"最高"),SSKJLanguage(@"最低"),SSKJLanguage(@"开盘"),SSKJLanguage(@"收盘"),SSKJLanguage(@"成交量")];
    }
    return _titlesArray;
}

-(void)showTipViewWith:(LXY_KLine_DataModel *)model
{
    _longPressModel = model;
//    [self setNeedsDisplay];
    
    
    NSArray *subviewArray = self.subviews;
    for (UILabel *label in subviewArray) {
        [label removeFromSuperview];
    }
    
    for (int i = 0; i < self.titlesArray.count; i++) {
        NSString *title = self.titlesArray[i];
        NSString *value = nil;
        UIColor *color = [UIColor lxy_priceColor];
        NSString *formate = [NSString stringWithFormat:@"%%.%ldf",LXY_DecimalNumber];
        
        switch (i) {
            case 0:
                value = model.time;
                break;
            case 1:
                value = [NSString stringWithFormat:formate,model.high.doubleValue];
//                [WLTools noroundingStringWith:model.high.doubleValue afterPointNumber:LXY_DecimalNumber];
                break;
            case 2:
                value = [NSString stringWithFormat:formate,model.low.doubleValue];
//                [WLTools noroundingStringWith:model.low.doubleValue afterPointNumber:LXY_DecimalNumber];
                break;
            case 3:
                value = [NSString stringWithFormat:formate,model.open.doubleValue];
//                [WLTools noroundingStringWith:model.open.doubleValue afterPointNumber:LXY_DecimalNumber];
                break;
            case 4:
            {
                value = [NSString stringWithFormat:formate,model.close.doubleValue];
//                [WLTools noroundingStringWith:model.close.doubleValue afterPointNumber:LXY_DecimalNumber];
                if (model.open.doubleValue < model.close.doubleValue) {
                    color = [UIColor lxy_riseColor];
                }else if (model.open.doubleValue > model.close.doubleValue){
                    color = [UIColor lxy_fallColor];
                }
            }
                break;
            case 5:
                value = [WLTools noroundingStringWith:model.volume.doubleValue afterPointNumber:LXY_DecimalNumber];
                break;
                
            default:
                break;
        }
        
        UILabel *label = [WLTools allocLabel:[NSString stringWithFormat:@"%@:%@",title,value] font:systemFont(10) textColor:color frame:CGRectMake(ScaleW(3), 12 * i + ScaleW(3), self.width, 10) textAlignment:NSTextAlignmentLeft];
        [self addSubview:label];
    }
    
}

//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    UIFont  *font = [UIFont boldSystemFontOfSize:10];//设置字体
//
//    NSString *string = [NSString stringWithFormat:@"时间：%@\n最高：%@\n最低：%@\n开盘：%@\n收盘：%@\n成交：%@",
//                        _longPressModel.time,
//                        [WLTools noroundingStringWith:_longPressModel.high.doubleValue afterPointNumber:4],
//                        [WLTools noroundingStringWith:_longPressModel.low.doubleValue afterPointNumber:4],
//                        [WLTools noroundingStringWith:_longPressModel.open.doubleValue afterPointNumber:4],
//                        [WLTools noroundingStringWith:_longPressModel.close.doubleValue afterPointNumber:4],
//                        [WLTools noroundingStringWith:_longPressModel.volume.doubleValue afterPointNumber:4]];
//
//    NSDictionary *attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor],NSBackgroundColorAttributeName:[UIColor lxy_tipBgColor]};
//
//    [string drawInRect:CGRectMake(0, 0, self.width,self.height) withAttributes:attribute];
//
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
