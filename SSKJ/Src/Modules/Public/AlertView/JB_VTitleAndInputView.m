//
//  JB_VTitleAndInputView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/5.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "JB_VTitleAndInputView.h"
@interface JB_VTitleAndInputView ()
{
    CGFloat _leftGap;
    UIFont *_font;
    NSString *_title;
    NSString *_placeHolder;
    UIKeyboardType _keyboardType;
    BOOL _secured;
}
@end
@implementation JB_VTitleAndInputView


@synthesize valueString = _valueString;

-(instancetype)initWithFrame:(CGRect)frame leftGap:(CGFloat)leftGap title:(NSString *)title placeHolder:(NSString *)placeHolder font:(UIFont *)font keyBoardType:(UIKeyboardType)keyBoardType isShowSecured:(BOOL)secured
{
    if (self = [super initWithFrame:frame]) {
        _leftGap = leftGap;
        _font = font;
        _title = title;
        _placeHolder = placeHolder;
        _keyboardType = keyBoardType;
        [self addSubview:self.lineView];
        [self addSubview:self.securedButton];
        [self addSubview:self.textField];
        [self addSubview:self.titleLabel];
        if (secured) {
            self.securedButton.hidden = NO;
            self.textField.secureTextEntry = YES;
        }else{
            self.securedButton.hidden = YES;
            self.textField.secureTextEntry = NO;
        }
        
    }
    return self;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(_leftGap, self.height - 0.5, ScreenWidth - 2 * _leftGap, 0.5)];
        _lineView.backgroundColor = kLightLineColor;
    }
    return _lineView;
}


-(UIButton *)securedButton
{
    if (nil == _securedButton) {
        _securedButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - _leftGap - ScaleW(49), 0, ScaleW(49), ScaleW(33))];
        _securedButton.centerY = self.height / 2 + ScaleW(20);
        [_securedButton setImage:[UIImage imageNamed:@"psd_show"] forState:UIControlStateNormal];
        [_securedButton setImage:[UIImage imageNamed:@"psd_hidden"] forState:UIControlStateSelected];
        _securedButton.selected = YES;
        [_securedButton addTarget:self action:@selector(showSecure:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _securedButton;
}


-(UITextField *)textField
{
    if (nil == _textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(_leftGap, 0, self.securedButton.left - _leftGap, ScaleW(30))];
        _textField.centerY = self.securedButton.centerY;
        _textField.placeholder = _placeHolder;
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_textField.placeholder attributes:@{NSForegroundColorAttributeName:kSubTitleColor}];
        _textField.font = _font;
        _textField.keyboardType = _keyboardType;
        _textField.textColor = kTitleColor;
        _textField.adjustsFontSizeToFitWidth = YES;
    }
    return _textField;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:_title font:_font textColor:kTitleColor frame:CGRectMake(_leftGap, self.textField.y - ScaleW(19), ScreenWidth - 2 * _leftGap, ScaleW(13.5)) textAlignment:NSTextAlignmentLeft];
        _titleLabel.centerY = self.height / 2 - ScaleW(20);
//        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}



-(void)showSecure:(UIButton *)button
{
    button.selected = !button.selected;
    self.textField.secureTextEntry = button.selected;
}

-(void)setValueString:(NSString *)valueString
{
    _valueString = valueString;
    self.textField.text = valueString;
}

-(NSString *)valueString
{
    _valueString = self.textField.text;
    if (_valueString.length == 0) {
        _valueString = @"";
    }
    return _valueString;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
