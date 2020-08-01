//
//  BIPaymentOptionControl.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIPaymentOptionControl.h"

@implementation BIPaymentOptionControl


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.tipLabel];
        [self addSubview:self.iconImageView];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.tipLabel setFrame:CGRectMake(ScaleW(10), 0, frame.size.width-ScaleW(40), frame.size.height)];
    [self.iconImageView setFrame:CGRectMake((frame.size.width-ScaleW(20)), (frame.size.height-ScaleW(10))/2.0, ScaleW(10),ScaleW(10))];
    [self setLayerBorderWidth:ScaleW(0.5)];
    [self setLayerBorderColor:RGBCOLOR(142, 148, 163)];
}



-(void)setTip:(NSString*)tip
{
    [self.tipLabel setText:tip];
}





#pragma mark - Getter / Setter
-(UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc]init];
        [_iconImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_iconImageView setImage:[UIImage imageNamed:@"Mine_jiantou_down"]];
    }
    return _iconImageView;
}



-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:RGBCOLOR(142, 148, 163) font:systemFont(ScaleW(14))];
    }
    return _tipLabel;
}


@end
