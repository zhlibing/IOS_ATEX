//
//  SSKJ_TextFieldView.m
//  SSKJ
//
//  Created by zpz on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_TextFieldView.h"
@interface SSKJ_TextFieldView()

@property(nonatomic, strong)UIButton *rightBtn;
@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, copy)NSString *placeholder;
@property(nonatomic, copy)NSString *title;
@property(nonatomic)BOOL rightBtnShow;

@end

@implementation SSKJ_TextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder rightBtn:(BOOL)rightBtn{
    
     if (self == [super init]) {
         self.backgroundColor = [UIColor clearColor];
         
         self.title = title;
         self.placeholder = placeholder;
         self.rightBtnShow = rightBtn;
         
         [self titleLabel];
         [self field];
         [self rightBtn];
         
         UIView *line = [UIView new];
          self.lineView = line;
          line.backgroundColor = kLineColor;
          [self addSubview:line];
          [line mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.equalTo(@0);
              make.right.equalTo(@0);
              make.height.equalTo(@(ScaleW(0.5)));
              make.bottom.equalTo(@0);
          }];
     }
    
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel createWithText:self.title textColor:kTitleColor font:kFont(15)];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.top.equalTo(@0);
        }];
    }
    return _titleLabel;
}

- (UITextField *)field{
    if (_field == nil) {
        _field = [UITextField new];
        _field.font = kFont(15);
        _field.placeholder = self.placeholder;
        _field.textColor = kTitleColor;
        _field.secureTextEntry = _rightBtnShow;
//        [_field setValue:kTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        [_field setPlaceHolderColor:kSubTitleColor];
        [self addSubview:_field];
        [_field mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.bottom.equalTo(@(ScaleW(-15)));
            if ([self.placeholder containsString:SSKJLanguage(@"验证码")] || [self.placeholder.lowercaseString containsString:@"verification"]) {
                make.right.equalTo(@(ScaleW(-100)));
            }else{
                make.right.equalTo(@(ScaleW(-50)));
            }
        }];
        
    }
    return _field;
}

- (UIButton *)rightBtn{
    if (_rightBtn == nil) {
        _rightBtn = [WLTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectZero];
        [self addSubview:_rightBtn];
        _rightBtn.hidden = !_rightBtnShow;
        [_rightBtn setImage:[UIImage imageNamed:@"login_hide"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"login_show"] forState:UIControlStateSelected];
        [_rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@0);
            make.centerY.equalTo(self.field);
            make.height.width.equalTo(@(ScaleW(44)));
        }];
    }
    return _rightBtn;
}

- (void)rightBtnAction{
    self.rightBtn.selected = !self.rightBtn.isSelected;
    self.field.secureTextEntry = !self.rightBtn.isSelected;
}

- (NSString *)valueString{
    return self.field.text;
}
@end
