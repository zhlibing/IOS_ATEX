//
//  BI_PhoneView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/3.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "BI_PhoneView.h"

@interface BI_PhoneView ()
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIButton *areaButton; // 区号选择按钮

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation BI_PhoneView


@synthesize valueString = _valueString;

-(instancetype)initWithFrame:(CGRect )frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kBgColor;
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.areaButton];
        [self addSubview:self.textField];
        [self addSubview:self.lineView];
        
#pragma mark 重置Frame
        [self.titleLabel setFrame:CGRectMake(ScaleW(10), ScaleW(10), frame.size.width-ScaleW(20), ScaleW(30))];
        self.areaButton.y = self.titleLabel.bottom + ScaleW(10);
        [self.textField setFrame:CGRectMake(self.areaButton.right, self.titleLabel.bottom+ScaleW(10), self.titleLabel.right - self.areaButton.right, ScaleW(40))];
//        [self.textField setValue:kSubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        [self.lineView setFrame:CGRectMake(self.titleLabel.left, frame.size.height-ScaleW(0.5), self.titleLabel.width, ScaleW(0.5))];
        
        
#pragma mark 赋值
        [self.titleLabel setText:SSKJLocalized(@"手机号码", nil)];
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

-(UIButton *)areaButton
{
    if (nil == _areaButton) {
        _areaButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(10), self.titleLabel.bottom + ScaleW(10), ScaleW(60), ScaleW(40))];
        [_areaButton setTitle:@"+86" forState:UIControlStateNormal];
        [_areaButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_areaButton setImage:[UIImage imageNamed:@"icon_xiala_blue"] forState:UIControlStateNormal];
        [_areaButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - _areaButton.imageView.image.size.width - ScaleW(5), 0, _areaButton.imageView.image.size.width + ScaleW(5))];
        [_areaButton setImageEdgeInsets:UIEdgeInsetsMake(0, _areaButton.titleLabel.bounds.size.width + ScaleW(5), 0, -_areaButton.titleLabel.bounds.size.width - ScaleW(5))];
        [_areaButton addTarget:self action:@selector(selectArea) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _areaButton;
}

-(UITextField *)textField
{
    if (nil == _textField)
    {
        _textField = [[UITextField alloc]init];
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.textColor = kTitleColor;
        _textField.font = systemFont(ScaleW(15));
        _textField.placeholder = SSKJLocalized(@"请输入您的手机号", nil);
        
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

-(void)setArea:(NSString *)areaCode
{
    [self.areaButton setTitle:[NSString stringWithFormat:@"+%@",areaCode] forState:UIControlStateNormal];
    [_areaButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - _areaButton.imageView.image.size.width - ScaleW(5), 0, _areaButton.imageView.image.size.width + ScaleW(5))];
    [_areaButton setImageEdgeInsets:UIEdgeInsetsMake(0, _areaButton.titleLabel.bounds.size.width + ScaleW(5), 0, -_areaButton.titleLabel.bounds.size.width - ScaleW(5))];
}


-(void)selectArea
{
    return;
    if (self.selectAreaBlock) {
        self.selectAreaBlock();
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
