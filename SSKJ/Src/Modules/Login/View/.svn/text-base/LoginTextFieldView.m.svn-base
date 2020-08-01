//
//  LoginTextFieldView.m
//  SSKJ
//
//  Created by zpz on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "LoginTextFieldView.h"
@interface LoginTextFieldView()


@property(nonatomic, strong)UIButton *rightBtn;

@property(nonatomic, copy)NSString *placeholder;
@property(nonatomic, copy)NSString *imageName;
@property(nonatomic)BOOL rightBtnShow;
@end

@implementation LoginTextFieldView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName placeholder:(NSString *)placeholder rightBtn:(BOOL)rightBtn{
    
     if (self == [super init]) {
         self.backgroundColor = [UIColor clearColor];
         NSLog(@"123123123");
         self.imageName = imageName;
         self.placeholder = placeholder;
         self.rightBtnShow = rightBtn;
         
         [self iconImageV];
         [self field];
         [self rightBtn];
         [self.field setPlaceHolderColor:kSubTitleColor];
         UIView *line = [UIView new];
         self.lineView = line;
         line.backgroundColor = kLineColor;
         [self addSubview:line];
         [line mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(@0);
             make.right.equalTo(@0);
             make.height.equalTo(@(ScaleW(0.5)));
//             make.bottom.equalTo(@0);
             make.bottom.mas_equalTo(-ScaleW(5));
         }];
     }
    
    return self;
}

- (UIImageView *)iconImageV{
    if (_iconImageV == nil) {
        _iconImageV = [WLTools allocImageView:CGRectZero image:[UIImage imageNamed:self.imageName]];
        [self addSubview:_iconImageV];
        
//        [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.mas_left).offset(ScaleW(15));
//            make.centerY.equalTo(@0);
//        }];
    }
    return _iconImageV;
}

- (UITextField *)field{
    if (_field == nil) {
        _field = [UITextField new];
        _field.font = kFont(16);
//        _field.placeholder = self.placeholder;
        _field.textColor = kTitleColor;
        _field.secureTextEntry = _rightBtnShow;
        [WLTools textField:_field setPlaceHolder:self.placeholder color:kSubTitleColor];
        _field.font = systemFont(ScaleW(14));
        [self addSubview:_field];
//        [_field mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@(ScaleW(40)));
//            make.centerY.equalTo(self.iconImageV).offset(ScaleW(2));
//            if ([self.placeholder containsString:SSKJLanguage(@"验证码")] || [self.placeholder.lowercaseString containsString:@"verification"]) {
//                make.right.equalTo(@(ScaleW(-100)));
//            }else{
//                make.right.equalTo(@(ScaleW(-50)));
//            }
//        }];
        [_field mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.equalTo(self.mas_left).offset(ScaleW(15));
                make.left.equalTo(@(ScaleW(5)));
                make.centerY.equalTo(@0);
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

@end

