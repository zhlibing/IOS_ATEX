//
//  LXY_KLine_VolumeMALabelView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/11/9.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLine_VolumeMALabelView.h"

@interface LXY_KLine_VolumeMALabelView ()
@property (nonatomic, strong) UILabel *label;

@end

@implementation LXY_KLine_VolumeMALabelView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label];
    }
    return self;
}

-(UILabel *)label
{
    if (nil == _label) {
        _label = [WLTools allocLabel:@"" font:systemFont(10) textColor:[UIColor lxy_MACDColor] frame:CGRectMake(0, 0, self.width, self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _label;
}

-(void)showLabelWithModel:(LXY_KLine_DataModel *)model
{
    self.hidden = NO;

    NSString *volString = [@"VOL:" stringByAppendingString:[SSTool disposeMaxNum:[SSTool disposeZeroPname:@(Kline_CoinNumber) price:model.volume]]];
    NSString *ma5String = [@"MA5:" stringByAppendingString:[SSTool disposeMaxNum:[SSTool disposeZeroPname:@(Kline_CoinNumber) price:@(model.volume_MA5)]]];
    NSString *ma10String = [@"MA10:" stringByAppendingString:[SSTool disposeMaxNum:[SSTool disposeZeroPname:@(Kline_CoinNumber) price:@(model.volume_MA10)]]];
    
    NSString *totalString = [NSString stringWithFormat:@"%@    %@    %@",volString,ma5String,ma10String];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:totalString];
    
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_MACDColor] range:NSMakeRange(0, volString.length)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_MA5Color] range:NSMakeRange(volString.length + 4, ma5String.length)];
    
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_MA10Color] range:NSMakeRange(totalString.length - ma10String.length, ma10String.length)];
    self.label.attributedText = attributeString;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
