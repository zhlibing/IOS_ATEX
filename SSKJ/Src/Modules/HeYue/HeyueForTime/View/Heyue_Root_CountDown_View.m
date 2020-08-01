//
//  Heyue_Root_CountDown_View.h
//  SSKJ
//
//  Created by cy5566 on 2020/3/21.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Heyue_Root_CountDown_View.h"

#define Halfwidth ScreenWidth / 2

@interface Heyue_Root_CountDown_View()

@property (nonatomic,strong) UIButton * wenhaoBtn;



@end

@implementation Heyue_Root_CountDown_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.wenhaoBtn];
        [self addSubview:self.countDownBtn];

        [self.wenhaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
//            make.right.equalTo(self.countDownBtn.mas_left).offset(-ScaleW(14));
            make.right.equalTo(self.mas_right).offset(ScaleW(-15));
            make.size.mas_equalTo(CGSizeMake(ScaleW(11), ScaleW(11)));
        }];
        [self.countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.wenhaoBtn.mas_left).offset(-ScaleW(14));
        }];
    }
    return self;
}

- (UIButton *)countDownBtn{
    if (_countDownBtn == nil) {
        _countDownBtn = [WLTools allocButton:[NSString stringWithFormat:@"%@:--",SSKJLanguage(@"距本期结束:")] textColor:kSubTitleColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(0), 0, Halfwidth * 0.4 - ScaleW(30), ScaleW(30))];
        [_countDownBtn addTarget:self action:@selector(countDownBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _countDownBtn.titleLabel.font = systemFont(ScaleW(13));
    }
    return _countDownBtn;
}

- (UIButton *)wenhaoBtn{
    if (_wenhaoBtn == nil) {
        _wenhaoBtn = [WLTools allocButton:SSKJLocalized(@"", nil) textColor:kBlueColor nom_bg:nil hei_bg:nil frame:CGRectMake(self.countDownBtn.right + ScaleW(5), 0, ScaleW(20), ScaleW(30))];
        [_wenhaoBtn addTarget:self action:@selector(countDownBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_wenhaoBtn setImage:[UIImage imageNamed:@"hy_wenhao"] forState:UIControlStateNormal];
    }
    return _wenhaoBtn;
}





#pragma mark -- 爆仓率点击方法--
- (void)countDownBtnAction{
    if (self.HeyueCountDownBlock) {
        self.HeyueCountDownBlock();
    }
}

#pragma mark -- 更换小数位数  点击方法 --
- (void)decimalBtnAction{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
