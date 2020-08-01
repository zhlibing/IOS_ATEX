//
//  GoCoin_Login_BGView.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/29.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "GoCoin_Login_BGView.h"

@interface GoCoin_Login_BGView()



@end

@implementation GoCoin_Login_BGView

- (void)dealloc
{
    NSLog(@"");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kSubBgColor;
        
        self.layer.cornerRadius = ScaleW(5);
        
        self.layer.masksToBounds = YES;
        
        [self imgV];
        
        [self rightBtn];
        
        [self textField];
        
    }
    return self;
}

- (UIImageView *)imgV
{
    if (_imgV == nil) {
        
        _imgV = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@""];
        
        [self addSubview:_imgV];
        WS(weakSelf);
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(weakSelf.mas_centerY);
            
            make.left.equalTo(@(ScaleW(20)));
            
            make.height.equalTo(@(ScaleW(20)));
            
            make.width.equalTo(@(ScaleW(20)));
            
        }];
    }
    return _imgV;
}

- (UITextField *)textField
{
    if (_textField == nil) {
        
        _textField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:SSKJLocalized(@"请输入账号", nil)];
        
        _textField.font = systemFont(ScaleW(14));
        
        _textField.textColor = kTitleColor;
        
        [self addSubview:_textField];
        WS(weakSelf);
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(@(0));
            
            make.left.equalTo(weakSelf.imgV.mas_right).offset(ScaleW(20));
            
            make.right.equalTo(weakSelf.rightBtn.mas_left);
            
        }];
        
    }
    return _textField;
}


- (UIButton *)rightBtn
{
    if (_rightBtn == nil) {
        
        _rightBtn = [FactoryUI createButtonWithFrame:CGRectZero title:nil titleColor:nil imageName:@"" backgroundImageName:nil target:self selector:nil font:nil];
        
        [self addSubview:_rightBtn];
        
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.right.equalTo(@0);
            
            make.width.equalTo(@(ScaleW(50)));
            
        }];
        
    }
    return _rightBtn;
}




@end
