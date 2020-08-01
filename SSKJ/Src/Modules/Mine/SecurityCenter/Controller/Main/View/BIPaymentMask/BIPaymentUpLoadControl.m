//
//  BIPaymentUpLoadControl.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIPaymentUpLoadControl.h"

@implementation BIPaymentUpLoadControl





- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.iconImageView];
        [self addSubview:self.tipLabel];
        [self addSubview:self.backGroundImageView];
        
    }
    return self;
}




-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.backGroundImageView setFrame:CGRectMake(0, 0, frame.size.width, ScaleW(90))];
    [self.iconImageView setFrame:CGRectMake(0, 0, ScaleW(25), ScaleW(25))];
    [self.iconImageView setCenter:CGPointMake(self.backGroundImageView.centerX, self.backGroundImageView.centerY-(ScaleW(5)))];

    [self.tipLabel setFrame:CGRectMake(0, self.iconImageView.bottom, frame.size.width,ScaleW(30))];
    [self setLayerBorderWidth:ScaleW(0.5)];
    [self setLayerBorderColor:RGBCOLOR(142, 148, 163)];
}




-(void)setImage:(UIImage*)image
{
    [self.backGroundImageView setImage:image];
}

-(void)setImageUrl:(NSString*)url
{
    [self.backGroundImageView sd_setImageWithURL:[NSURL URLWithString:url]];
}







#pragma mark - Getter / Setter
-(UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:RGBCOLOR(142, 148, 163) font:systemFont(11)];
        [_tipLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _tipLabel;
}


-(UIImageView *)backGroundImageView
{
    if (!_backGroundImageView)
    {
        _backGroundImageView = [[UIImageView alloc]init];
        [_backGroundImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_backGroundImageView setMasksToBounds:YES];
        [_backGroundImageView setBackgroundColor:[UIColor clearColor]];
    }
    return _backGroundImageView;
}


-(UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc]init];
        [_iconImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_iconImageView setImage:[UIImage imageNamed:@"mine_img"]];
    }
    return _iconImageView;
}

@end
