//
//  LXY_KLine_AccessoryCoordinateView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/11/9.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLine_AccessoryCoordinateView.h"

@implementation LXY_KLine_AccessoryCoordinateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.maxLabel = [UILabel createWithText:@"" textColor:[UIColor lxy_priceColor] font:kFont(10)];
        self.maxLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.maxLabel];
        [self.maxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@0);
            make.right.equalTo(@(ScaleW(-2)));
        }];
        
        self.minLabel = [UILabel createWithText:@"" textColor:[UIColor lxy_priceColor] font:kFont(10)];
        self.minLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.minLabel];
        [self.minLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(@0);
            make.right.equalTo(@(ScaleW(-2)));
        }];
    }
    return self;
}

-(void)drawView
{
    //    [self.dataArray removeAllObjects];
    //    for (NSInteger i = self.startDrawIndex; i < self.startDrawIndex + self.countOfShowCandle; i++) {
    //        [self.dataArray addObject:[self.dataSource objectAtIndex:i]];
    //    }
    
//    [self setNeedsDisplay];
    
    self.maxLabel.text = [SSTool disposeZeroPname:@(LXY_DecimalNumber) price:@(self.maxValue)];
    self.minLabel.text = [SSTool disposeZeroPname:@(LXY_DecimalNumber) price:@(self.minValue)];
}

//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    for (int i = 0; i < 2; i++) {
//
//        double price_scale = (self.maxValue - self.minValue);
//
//        double price = self.maxValue - price_scale * i;
//
//        NSString *priceString = [WLTools noroundingStringWith:price afterPointNumber:LXY_DecimalNumber];
//
////        CGFloat width = [WLTools getWidthWithText:priceString font:systemFont(10)]  + 10;
//
//        [[UIColor clearColor]setFill];//设置填充颜色
//        [[UIColor whiteColor]setStroke];
//        UIFont  *font = [UIFont boldSystemFontOfSize:10];//设置字体
//        CGFloat y = 0;
//        if (i == 0) {
//            y = 0;
//        }else{
//            y =  self.height - 10;
//        }
//        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//        [paragraphStyle setAlignment:NSTextAlignmentRight];
//        NSDictionary *attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor],NSParagraphStyleAttributeName:paragraphStyle};
//
//        [priceString drawInRect:CGRectMake(0, y, self.width,10) withAttributes:attribute];
//
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
