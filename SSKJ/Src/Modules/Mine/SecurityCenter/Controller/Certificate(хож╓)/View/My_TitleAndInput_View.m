//
//  My_TitleAndInput_View.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_TitleAndInput_View.h"

@interface My_TitleAndInput_View ()



@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation My_TitleAndInput_View

@synthesize valueString = _valueString;

-(instancetype)initWithFrame:(CGRect )frame title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kBgColor;
        
        [self addSubview:self.titleLabel];
       
        [self addSubview:self.textField];
        [self addSubview:self.lineView];
        [self.textField setPlaceholder:placeHolder];
        [self.textField setKeyboardType:keyBoardType];
        
        #pragma mark 重置Frame
        [self.titleLabel setFrame:CGRectMake(ScaleW(10), ScaleW(10), frame.size.width-ScaleW(20), ScaleW(30))];
       
        [self.textField setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+ScaleW(10), self.titleLabel.width, ScaleW(40))];
        
        if (title==nil) {
            
            [self.titleLabel setFrame:CGRectMake(ScaleW(10), ScaleW(10), frame.size.width-ScaleW(20), ScaleW(0))];
            [self.textField setFrame:CGRectMake(self.titleLabel.left, ScaleW(10), self.titleLabel.width, ScaleW(40))];
        }
//         [self.textField setValue:UIColorFromRGB(0x898d98) forKeyPath:@"_placeholderLabel.textColor"];
        [self.lineView setFrame:CGRectMake(self.textField.left, frame.size.height-ScaleW(0.5), self.textField.width, ScaleW(0.5))];
        
        
        #pragma mark 赋值
        [self.titleLabel setText:SSKJLocalized(title, nil)];
    }
    return self;
}


-(UILabel *)titleLabel
{
    
    if (nil == _titleLabel)
    {
        _titleLabel  = [[UILabel alloc]init];
        [_titleLabel setTextColor:kTitleColor];
        [_titleLabel setFont:systemFont(ScaleW(16.0))];
    }
    return _titleLabel;
}

-(UITextField *)textField
{
    if (nil == _textField)
    {
        _textField = [[UITextField alloc]init];
        _textField.textColor = kTitleColor;
        _textField.font = systemFont(ScaleW(15));

       
    }
    return _textField;
}

-(UIView *)lineView
{
    if (nil == _lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:kLineColor];
    }
    return _lineView;
}

-(NSString *)valueString
{
    return self.textField.text;
}

-(void)setValueString:(NSString *)valueString
{
    self.textField.text = valueString;
}


@end
