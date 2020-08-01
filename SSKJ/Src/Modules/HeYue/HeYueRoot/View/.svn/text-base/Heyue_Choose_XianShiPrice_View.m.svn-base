//
//  Heyue_Choose_XianShiPrice_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_Choose_XianShiPrice_View.h"

@implementation Heyue_Choose_XianShiPrice_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kBgColor;
        
        [self addSubview:self.shijiaBtn];

        [self addSubview:self.lineView];

        [self addSubview:self.xianjiaBtn];
        
        self.layer.cornerRadius = 5;
        self.layer.shadowColor = [UIColor colorWithRed:3.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.1f].CGColor;
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 8;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        
    }
    return self;
}

- (UIButton *)shijiaBtn{
    if (_shijiaBtn == nil) {
        _shijiaBtn = [WLTools allocButton:SSKJLocalized(@"市价交易", nil) textColor:kTitleColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(0), 0, self.width, self.height/2)];
        _shijiaBtn.backgroundColor = kWhiteColor;
        _shijiaBtn.titleLabel.font = systemFont(ScaleW(14));
        [_shijiaBtn addTarget:self action:@selector(shijiaBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shijiaBtn;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(10), ScaleW(45), ScaleW(110), ScaleW(1))];
        _lineView.backgroundColor = kBgColor;
        _lineView.hidden = YES;
    }
    return _lineView;
}

- (UIButton *)xianjiaBtn{
    if (_xianjiaBtn == nil) {
        _xianjiaBtn = [WLTools allocButton:SSKJLocalized(@"限价交易", nil) textColor:kTitleColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(0), _shijiaBtn.bottom, self.width, self.height/2)];
        _xianjiaBtn.backgroundColor = kWhiteColor;
        _xianjiaBtn.titleLabel.font = systemFont(ScaleW(14));
        [_xianjiaBtn addTarget:self action:@selector(xianjiaBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _xianjiaBtn;
}

- (void)shijiaBtnAction{
    if (self.ShiXianPriceBlock) {
        self.ShiXianPriceBlock(SSKJLocalized(@"市价交易", nil), 1);
    }
}

- (void)xianjiaBtnAction{
    if (self.ShiXianPriceBlock) {
        self.ShiXianPriceBlock(SSKJLocalized(@"限价交易", nil), 2);
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
