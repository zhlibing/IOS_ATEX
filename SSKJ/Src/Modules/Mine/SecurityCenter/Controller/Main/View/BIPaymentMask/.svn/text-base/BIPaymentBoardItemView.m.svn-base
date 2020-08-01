//
//  BIPaymentBoardItemView.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIPaymentBoardItemView.h"

@implementation BIPaymentBoardItemView

- (instancetype)initWithType:(NSInteger)type
{
    self = [super init];
    if (self)
    {
        switch (type)
        {
            case 1:
            {
                [self addSubview:self.titleLabel];
                [self addSubview:self.textField];
            }
                break;
            case 2:
            {
                [self addSubview:self.titleLabel];
                [self addSubview:self.upLoadControl];
               
            }
                break;
            case 3:
            {
                [self addSubview:self.titleLabel];
                [self addSubview:self.optionControl];
            }
                break;
            case 4:
            {
                [self addSubview:self.titleLabel];
                [self addSubview:self.describeLabel];
            }
                break;
        }
    }
    return self;
}


-(void)setTitle:(NSString*)title withPlaceholder:(NSString*)placeholder
{
    [self.titleLabel setText:SSKJLocalized(title, nil)];
    [self.textField setPlaceholder:SSKJLocalized(placeholder, nil)];
}


-(void)setTitle:(NSString*)title withTip:(NSString*)tip withType:(NSInteger)type
{
    [self.titleLabel setText:SSKJLocalized(title, nil)];
    switch (type)
    {
        case 2:
        {
            [self.upLoadControl.tipLabel setText:SSKJLocalized(tip, nil)];
        }
            break;
        case 3:
        {
            [self.optionControl setTip:SSKJLocalized(tip, nil)];
        }
            break;
        case 4:
        {
             [self.describeLabel.describeLabel setText:SSKJLocalized(tip, nil)];
        }
            break;
    }
}


-(void)setTip:(NSString*)tip withType:(NSInteger)type
{
    switch (type)
    {
        case 2:
        {
            [self.upLoadControl.tipLabel setText:SSKJLocalized(tip, nil)];
        }
            break;
        case 3:
        {
            [self.optionControl setTip:SSKJLocalized(tip, nil)];
        }
            break;
    }
}


-(void)resetFrame:(CGRect)frame withType:(NSInteger)type
{
    //!< 一定要重新给当前视图重置Frame
    [self setFrame:frame];
    
    switch (type)
    {
        case 1:
        {
            [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, ScaleW(45))];
            [self.textField setFrame:CGRectMake(0, self.titleLabel.bottom, self.titleLabel.width, ScaleW(40))];
//            [self.textField setValue:RGBCOLOR(142, 148, 163) forKeyPath:@"_placeholderLabel.textColor"];
            [self.textField setLayerBorderWidth:ScaleW(0.5)];
            [self.textField setLayerBorderColor:RGBCOLOR(142, 148, 163)];
        }
            break;
        case 2:
        {
            [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, ScaleW(45))];
            [self.upLoadControl resetFrame:CGRectMake(0, self.titleLabel.bottom, self.titleLabel.width, ScaleW(90))];
        }
            break;
        case 3:
        {
            [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, ScaleW(45))];
            [self.optionControl resetFrame:CGRectMake(0, self.titleLabel.bottom, self.titleLabel.width, ScaleW(40))];
        }
            break;
        case 4:
        {
            
            [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, ScaleW(45))];
            [self.describeLabel resetFrame:CGRectMake(0,self.titleLabel.bottom , self.titleLabel.width,ScaleW(40))];
            [self.describeLabel setLayerBorderWidth:ScaleW(0.5)];
            [self.describeLabel setLayerBorderColor:RGBCOLOR(142, 148, 163)];
        }
            break;
    }
}


-(void)setPickImage:(UIImage*)image
{
    [self.upLoadControl setImage:image];
}




#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:[UIColor whiteColor] font:systemFont(ScaleW(14.0))];
    }
    return _titleLabel;
}

-(BIPaymentLabel*)describeLabel
{
    if (!_describeLabel)
    {
        _describeLabel = [[BIPaymentLabel alloc]init];
        [_describeLabel.describeLabel setFont:systemFont(ScaleW(14.0))];
        [_describeLabel.describeLabel setTextColor:[UIColor whiteColor]];
    }
    return _describeLabel;
}




-(BIPaymentBoardItemTextField *)textField
{
    if (!_textField)
    {
        _textField = [[BIPaymentBoardItemTextField alloc]init];
        [_textField setFont:systemFont(ScaleW(13.0))];
        [_textField setTextColor:[UIColor whiteColor]];
    }
    return _textField;
}

-(BIPaymentUpLoadControl *)upLoadControl
{
    if (!_upLoadControl)
    {
        _upLoadControl = [[BIPaymentUpLoadControl alloc]init];
    }
    return _upLoadControl;
}




-(BIPaymentOptionControl *)optionControl
{
    if (!_optionControl)
    {
        _optionControl = [[BIPaymentOptionControl alloc]init];
    }
    return _optionControl;
}







@end
