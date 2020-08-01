//
//  Heyue_Left_NavView.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_Left_NavView.h"

@interface Heyue_Left_NavView()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIButton *backBtn;

@end

@implementation Heyue_Left_NavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.backBtn];
        
        [self setUIFrame];
    }
    return self;
}

- (void)setUIFrame{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(15)));
        make.bottom.equalTo(@(ScaleW(0)));
        make.height.equalTo(@(ScaleW(55)));
    }];
    
//    UILabel *rate = [UILabel createWithText:SSKJLanguage(@"涨跌幅") textColor:kSubTitleColor font:kFont(15)];
//    rate.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:rate];
//    [rate mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@(ScaleW(90)));
//        make.width.equalTo(@(ScaleW(90)));
//        make.centerY.equalTo(self.titleLabel);
//    }];
//
//    UILabel *price = [UILabel createWithText:SSKJLanguage(@"最新价格") textColor:kSubTitleColor font:kFont(15)];
//    [self addSubview:price];
//    [price mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(@(ScaleW(-24)));
//        make.centerY.equalTo(self.titleLabel);
//    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(ScaleW(0)));
        make.top.equalTo(@(Height_StatusBar));
        make.width.equalTo(@(ScaleW(60)));
        make.height.equalTo(@(ScaleW(40)));
    }];
    
    UIImage *left = [UIImage imageNamed:@"hy_zhankai"];
    left = [left imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:left];
    imageV.tintColor = kTitleColor;
    [self addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.backBtn);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = kSubBgColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(@0);
        make.left.equalTo(@(ScaleW(15)));
        make.height.equalTo(@(ScaleW(0.5)));
    }];
}



-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"合约列表", nil) font:systemFont(ScaleW(18)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

- (UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [WLTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectZero];
//        [_backBtn setImage:[UIImage imageNamed:@"hy_zhankai"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)backBtnAction{
    if (self.BackBlock) {
        self.BackBlock();
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
