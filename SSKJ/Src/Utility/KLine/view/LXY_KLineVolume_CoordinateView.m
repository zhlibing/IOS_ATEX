//
//  LXY_KLineVolumeLabel_View.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/25.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLineVolume_CoordinateView.h"

@interface LXY_KLineVolume_CoordinateView ()

@property(nonatomic, strong)UILabel *maxLabel;
@property(nonatomic, strong)UILabel *minLabel;

@end

@implementation LXY_KLineVolume_CoordinateView

- (instancetype)initWithFrame:(CGRect)frame{
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
//    [self setNeedsDisplay];
    
    self.maxLabel.text = [SSTool disposeMaxNum:[SSTool disposeZeroPname:@(0) price:@(self.maxVolume)]];
    self.minLabel.text = [SSTool disposeMaxNum:[SSTool disposeZeroPname:@(0) price:@(self.minVolume)]];
    
}

//-(void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    for (int i = 0; i < LXY_NumberofVolumeLine + 2; i++) {
//
//        double volume_scale = (self.maxVolume - self.maxVolume) / (LXY_NumberofPriceline + 1);
//
//        double volume = self.maxVolume - volume_scale * i;
//
////        NSString *volumeString = [self volumeStringWithVolumeString:volume];
//
//        NSString *volumeString = [SSTool disposeZeroPname:@(Kline_CoinNumber) price:@(volume)];
//
//        CGFloat width = [WLTools getWidthWithText:volumeString font:systemFont(10)];
//
//        [[UIColor clearColor]setFill];//设置填充颜色
//        [[UIColor whiteColor]setStroke];
//        UIFont  *font = [UIFont boldSystemFontOfSize:10];//设置字体
//        CGFloat y = 0;
//        if (i == 0) {
//            y = 0;
//        }else if (i == LXY_NumberofVolumeLine + 1) {
//            y = self.height - 10 - 1;
//        }else{
//            y =  10 + (self.height - 10) / (LXY_NumberofVolumeLine + 1) * i - 10 - 2;
//        }
//        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//        [paragraphStyle setAlignment:NSTextAlignmentRight];
//        NSDictionary *attribute = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor lxy_priceColor],NSParagraphStyleAttributeName:paragraphStyle};
//
//        [volumeString drawInRect:CGRectMake(0, y, self.width,10) withAttributes:attribute];
//
//    }
//}

-(NSString *)volumeStringWithVolumeString:(double)volume
{
    if (volume < 100000) {
        return [WLTools noroundingStringWith:volume afterPointNumber:LXY_DecimalNumber];
    }else if (volume < 1000000){
        return [NSString stringWithFormat:@"%@万",[WLTools noroundingStringWith:volume / 10000 afterPointNumber:2]];
    }else if (volume < 10000000){
        return [NSString stringWithFormat:@"%@万",[WLTools noroundingStringWith:volume / 10000 afterPointNumber:1]];
    }else if (volume < 100000000){
        return [NSString stringWithFormat:@"%ld万",(NSInteger)(volume / 10000)];
    }else if (volume < 10000000000){
        return [NSString stringWithFormat:@"%@亿",[WLTools noroundingStringWith:(volume / 100000000) afterPointNumber:2]];
    }else if (volume < 100000000000){
        return [NSString stringWithFormat:@"%@亿",[WLTools noroundingStringWith:(volume / 100000000) afterPointNumber:1]];
    }  else{
        return [NSString stringWithFormat:@"%ld亿",(NSInteger)(volume / 100000000)];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
