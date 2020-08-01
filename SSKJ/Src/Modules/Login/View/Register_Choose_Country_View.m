//
//  Register_Choose_Country_View.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/6/25.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "Register_Choose_Country_View.h"

@interface Register_Choose_Country_View()



@end

@implementation Register_Choose_Country_View


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kSubBgColor;
        
        self.layer.cornerRadius = ScaleW(5);
        
        self.layer.masksToBounds = YES;
        
        [self areaLabel];
        
        [self lineView];
        
        [self countryBtn];
        
        [self saoJiaoBtn];
      
        
    }
    return self;
}

- (UILabel *)areaLabel{
    if (_areaLabel == nil) {
        _areaLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"+86", nil) textColor:kTitleColor font:systemFont(ScaleW(14))];
        _areaLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_areaLabel];
        [_areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(@0);
            make.width.equalTo(@(ScaleW(70)));
        }];
    }
    return _areaLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [FactoryUI createViewWithFrame:CGRectZero Color:kTitleColor];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(70)));
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo(@(ScaleW(1)));
            make.height.equalTo(@(ScaleW(20)));
        }];
    }
    return  _lineView;
}

- (UIButton *)countryBtn{
    if (_countryBtn == nil) {
        _countryBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"China", nil) titleColor:kTitleColor imageName:nil backgroundImageName:nil target:self selector:@selector(countryBtnAction) font:systemFont(ScaleW(15))];
        _countryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:_countryBtn];
        [_countryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView.mas_right).offset(ScaleW(10));
            make.top.bottom.equalTo(@0);
            make.right.equalTo(@(ScaleW(-40)));
        }];
    }
    return _countryBtn;
}

- (UIButton *)saoJiaoBtn{
    if (_saoJiaoBtn == nil) {
        _saoJiaoBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"", nil) titleColor:kTitleColor imageName:@"login_down" backgroundImageName:nil target:self selector:@selector(countryBtnAction) font:systemFont(ScaleW(15))];
        [self addSubview:_saoJiaoBtn];
        [_saoJiaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(ScaleW(16.5)));
            make.height.mas_equalTo(ScaleW(9.5));
            make.right.equalTo(self.mas_right).offset(-ScaleW(15));
            make.centerY.equalTo(self);
//            make.top.bottom.right.equalTo(@0);
        }];
    }
    return _saoJiaoBtn;
}

- (void)countryBtnAction{
    if (self.ChooseCountryBlock) {
        self.ChooseCountryBlock();
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
