//
//  My_TitleAndInput_View.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_TitleAndInput_View.h"

@interface Mine_TitleAndInput_View ()<UITextFieldDelegate>



@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *secureButton;
@end

@implementation Mine_TitleAndInput_View

@synthesize valueString = _valueString;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(instancetype)initWithFrame:(CGRect )frame title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType isSecure:(BOOL)isSecure
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kBgColor;
        
        [self addSubview:self.titleLabel];
       
        [self addSubview:self.textField];
        [self addSubview:self.secureButton];
        [self addSubview:self.lineView];
        [self.textField setPlaceholder:placeHolder];
        [self.textField setKeyboardType:keyBoardType];
        self.textField.secureTextEntry = isSecure;
        
        self.secureButton.hidden = !isSecure;
               
        [self.textField setPlaceHolderColor:kSubTitleColor];
        
        [self.textField addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        #pragma mark 赋值
        [self.titleLabel setText:SSKJLocalized(title, nil)];
    }
    return self;
}

- (void)setSpace:(CGFloat)space{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScaleW(15));
        make.top.mas_equalTo(self.mas_top).offset(ScaleW(15));
        make.height.mas_equalTo(ScaleW(15));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(ScaleW(-30));
    }];
}

- (void)setTfWidth:(CGFloat)tfWidth{
    _tfWidth = tfWidth;
    [self.textField setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+ScaleW(10), self.width, ScaleW(40))];
}


-(UILabel *)titleLabel
{
    
    if (nil == _titleLabel)
    {
        _titleLabel  = [[UILabel alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(24), self.width-ScaleW(30), ScaleW(14))];
        [_titleLabel setTextColor:kTitleColor];
        [_titleLabel setFont:systemFont(ScaleW(16.0))];
    }
    return _titleLabel;
}

-(UITextField *)textField
{
    if (nil == _textField)
    {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+ScaleW(4), self.titleLabel.width, ScaleW(34))];
        _textField.textColor = kTitleColor;
        _textField.font = systemFont(ScaleW(12));
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChanged) name:UITextFieldTextDidBeginEditingNotification object:_textField];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChanged) name:UITextFieldTextDidEndEditingNotification object:_textField];
       
    }
    return _textField;
}

-(UIButton *)secureButton
{
    if (nil == _secureButton) {
        _secureButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(47), 0, ScaleW(47), ScaleW(40))];
        _secureButton.centerY = self.textField.centerY;
        [_secureButton setImage:[UIImage imageNamed:@"login_show"] forState:UIControlStateNormal];
        [_secureButton setImage:[UIImage imageNamed:@"login_hide"] forState:UIControlStateSelected];
        [_secureButton addTarget:self action:@selector(showOrHideText) forControlEvents:UIControlEventTouchUpInside];
        _secureButton.selected = YES;
    }
    return _secureButton;
}

-(UIView *)lineView
{
    if (nil == _lineView)
    {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.titleLabel.left, self.height-ScaleW(0.5), self.titleLabel.width, ScaleW(0.5))];
        [_lineView setBackgroundColor:kLightLineColor];
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

- (void) textDidChange:(UITextField *)sender{
    !self.tfValueChange ? : self.tfValueChange(sender.text);
}

-(void)showOrHideText
{
    self.secureButton.selected = !self.secureButton.selected;
    self.textField.secureTextEntry = self.secureButton.selected;
    
}

-(void)textValueChanged
{
    if (self.textField.isEditing) {
        self.lineView.backgroundColor = kBlueColor;
    }else{
        self.lineView.backgroundColor = kLightLineColor;
    }
}


@end
