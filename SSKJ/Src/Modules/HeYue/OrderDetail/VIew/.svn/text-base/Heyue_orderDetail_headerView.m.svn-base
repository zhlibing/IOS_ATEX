//
//  Heyue_orderDetail_headerView.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/30.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_orderDetail_headerView.h"
#import "Heyue_OrderDdetail_Model.h"

@interface Heyue_orderDetail_headerView()

@property (nonatomic,strong) UIView *topLineView;

@property (nonatomic,strong) UILabel *dongtaiquanyiTitle;

@property (nonatomic,strong) UILabel *dongtaiquanyiLabel;

@property (nonatomic,strong) UILabel *keyongTitle;

@property (nonatomic,strong) UILabel *keyongLabel;

@property (nonatomic,strong) UILabel *dongjieTitle;

@property (nonatomic,strong) UILabel *dongjieLabel;

@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UILabel *fudongyingkuiTitle;

@property (nonatomic,strong) UILabel *fudongyingkuiLabel;

@property (nonatomic,strong) UILabel *fengxianlvTitle;

@property (nonatomic,strong) UILabel *fengxianlvLabel;

@property (nonatomic,strong) UIView *yingKuiBgView;

@property(nonatomic, strong)Heyue_OrderInfo_Model *model;
@end

@implementation Heyue_orderDetail_headerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBgColor;
        
        [self addSubview:self.topLineView];
        [self addSubview:self.dongtaiquanyiLabel];
        [self addSubview:self.dongtaiquanyiTitle];
        [self addSubview:self.keyongLabel];
        [self addSubview:self.keyongTitle];
        [self addSubview:self.dongjieLabel];
        [self addSubview:self.dongjieTitle];
        [self addSubview:self.lineView];
        [self addSubview:self.yingKuiBgView];
        [self.yingKuiBgView addSubview:self.fudongyingkuiLabel];
        [self.yingKuiBgView addSubview:self.fudongyingkuiTitle];
        [self addSubview:self.fengxianlvLabel];
        [self addSubview:self.fengxianlvTitle];
        
        UIView *line = [UIView new];
        line.backgroundColor = kSubBgColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(@0);
            make.height.mas_equalTo(ScaleW(10));
        }];
        [self serUIFrame];
    }
    return self;
}

- (void)serUIFrame{
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@(ScaleW(10)));
    }];
    
    [self.dongtaiquanyiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(@(ScaleW(19)));
        make.height.equalTo(@(ScaleW(15)));
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    
    [self.dongtaiquanyiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.top.equalTo(self.dongtaiquanyiLabel.mas_bottom).offset(ScaleW(10));
        make.height.equalTo(@(ScaleW(15)));
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    
    [self.keyongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScreenWidth / 3));
        make.top.equalTo(@(ScaleW(19)));
        make.height.equalTo(@(ScaleW(15)));
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    
    [self.keyongTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScreenWidth / 3));
        make.top.equalTo(self.dongtaiquanyiLabel.mas_bottom).offset(ScaleW(10));
        make.height.equalTo(@(ScaleW(15)));
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    
    [self.dongjieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.top.equalTo(@(ScaleW(19)));
        make.height.equalTo(@(ScaleW(15)));
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    
    [self.dongjieTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(0));
        make.top.equalTo(self.dongtaiquanyiLabel.mas_bottom).offset(ScaleW(10));
        make.height.equalTo(@(ScaleW(15)));
        make.width.equalTo(@(ScreenWidth / 3));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(@(0));
        make.top.equalTo(self.dongtaiquanyiTitle.mas_bottom).offset(ScaleW(15));
        make.height.equalTo(@(ScaleW(10)));
    }];
    
    
    [self.yingKuiBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(ScaleW(10));
        make.left.equalTo(self.mas_left).offset(ScaleW(23));
        make.size.mas_equalTo(CGSizeMake(ScaleW(139), ScaleW(57)));
    }];
    self.yingKuiBgView.clipsToBounds = true;
    self.yingKuiBgView.layer.cornerRadius = ScaleW(5);
    [self.fudongyingkuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.yingKuiBgView);
        make.top.equalTo(self.yingKuiBgView.mas_top).offset(ScaleW(8));
    }];
    
    [self.fudongyingkuiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.yingKuiBgView);
        make.bottom.equalTo(self.yingKuiBgView.mas_bottom).offset(ScaleW(-8));
    }];
    
    [self.fengxianlvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fudongyingkuiLabel.mas_centerY);
        make.centerX.equalTo(self.yingKuiBgView.mas_centerX).offset(ScreenWidth / 2);
    }];
    
    [self.fengxianlvTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.fengxianlvLabel.mas_centerX);
        make.centerY.equalTo(self.fudongyingkuiTitle.mas_centerY);
        make.width.equalTo(@(ScreenWidth / 2 - ScaleW(20)));
    }];
    
}

- (UIView *)topLineView{
    if (_topLineView==nil) {
        _topLineView = [[UIView alloc]init];
        _topLineView.backgroundColor = kBgColor;
    }
    return _topLineView;
}

- (UIView *)yingKuiBgView{
    if (_yingKuiBgView==nil) {
        _yingKuiBgView = [[UIView alloc]init];
        _yingKuiBgView.backgroundColor = kMarketUp;
    }
    return _yingKuiBgView;
}
- (UILabel *)dongtaiquanyiTitle{
    if (_dongtaiquanyiTitle == nil) {
        _dongtaiquanyiTitle = [WLTools allocLabel:SSKJLocalized(@"动态权益", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _dongtaiquanyiTitle.numberOfLines = 1;
        _dongtaiquanyiTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _dongtaiquanyiTitle;
}

- (UILabel *)dongtaiquanyiLabel{
    if (_dongtaiquanyiLabel == nil) {
        _dongtaiquanyiLabel = [WLTools allocLabel:@"0.0000" font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _dongtaiquanyiLabel.numberOfLines = 1;

    }
    return _dongtaiquanyiLabel;
}

- (UILabel *)keyongTitle{
    if (_keyongTitle == nil) {
        _keyongTitle = [WLTools allocLabel:[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"可用", nil),@"USDT"] font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];

        _keyongTitle.numberOfLines = 1;

    }
    return _keyongTitle;
}

- (UILabel *)keyongLabel{
    if (_keyongLabel == nil) {
        _keyongLabel = [WLTools allocLabel:@"0.0000" font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _keyongLabel.numberOfLines = 1;

    }
    return _keyongLabel;
}


- (UILabel *)dongjieTitle{
    if (_dongjieTitle == nil) {
        _dongjieTitle = [WLTools allocLabel:[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"冻结", nil),@"USDT"] font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        


        _dongjieTitle.numberOfLines = 1;

    }
    return _dongjieTitle;
}

- (UILabel *)dongjieLabel{
    if (_dongjieLabel == nil) {
        _dongjieLabel = [WLTools allocLabel:@"0.0000" font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _dongjieLabel.numberOfLines = 1;

    }
    return _dongjieLabel;
}

- (UIView *)lineView{
    if (_lineView==nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kBgColor;
    }
    return _lineView;
}

- (UILabel *)fudongyingkuiTitle{
    if (_fudongyingkuiTitle == nil) {
        _fudongyingkuiTitle = [WLTools allocLabel:SSKJLocalized(@"浮动盈亏", nil) font:systemFont(ScaleW(13)) textColor:kWhiteColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _fudongyingkuiTitle.numberOfLines = 1;

    }
    return _fudongyingkuiTitle;
}

- (UILabel *)fudongyingkuiLabel{
    if (_fudongyingkuiLabel == nil) {
        _fudongyingkuiLabel = [WLTools allocLabel:@"0.0000" font:systemFont(ScaleW(16)) textColor:kWhiteColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _fudongyingkuiLabel.numberOfLines = 1;

    }
    return _fudongyingkuiLabel;
}

- (UILabel *)fengxianlvTitle{
    if (_fengxianlvTitle == nil) {
        _fengxianlvTitle = [WLTools allocLabel:SSKJLocalized(@"风险率", nil) font:systemFont(ScaleW(13)) textColor:kMarketDown frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _fengxianlvTitle.numberOfLines = 1;

    }
    return _fengxianlvTitle;
}

- (UILabel *)fengxianlvLabel{
    if (_fengxianlvLabel == nil) {
        _fengxianlvLabel = [WLTools allocLabel:@"0.0000" font:systemFont(ScaleW(15)) textColor:kMarketDown frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _fengxianlvLabel.numberOfLines = 1;

    }
    return _fengxianlvLabel;
}

- (void)initDataWithOrderInfoModel:(Heyue_OrderInfo_Model *)model{
    self.model = model;
    
    self.dongtaiquanyiLabel.text = [SSTool HeyuePname:@"USDT" price:model.totalusdt];
    self.keyongLabel.text = [SSTool HeyuePname:@"USDT" price:model.keyong_price];
    self.dongjieLabel.text = [SSTool HeyuePname:@"USDT" price:model.totaldeposit];
    self.fudongyingkuiLabel.text = [SSTool HeyuePname:@"USDT" price:model.yingkui];
    self.fengxianlvLabel.text = [NSString stringWithFormat:@"%@%@",[SSTool disposePname:@"2" price:[NSString stringWithFormat:@"%.9f", model.risk.doubleValue]],@"%"];
    
    if ([self.fudongyingkuiLabel.text containsString:@"-"]) {
//        self.fudongyingkuiLabel.textColor = kMarketDown;
//        self.fudongyingkuiTitle.textColor = kMarketDown;
        self.yingKuiBgView.backgroundColor = kMarketDown;
    }else{
//        self.fudongyingkuiLabel.textColor = kMarketUp;
//        self.fudongyingkuiTitle.textColor = kMarketUp;
        self.yingKuiBgView.backgroundColor = kMarketUp;

    }
}

- (void)updateWith:(NSArray *)array{
//    if (!array.count) {
//        return;
//    }
    
    //    总浮动盈亏=所有浮动盈亏相加
    //    动态权益=总浮动盈亏+可用usdt+冻结usdt
    //    爆仓率=动态权益/冻结usdt
    
//    double value = 0.0;
//    for (Heyue_OrderDdetail_Model *subModel in array) {
//        value += subModel.floatingPL.doubleValue;
////        NSLog(@"订单推送浮动盈亏***%f",value);
//    }
//    self.fudongyingkuiLabel.text = [SSTool HeyuePname:@"USDT" price:@(value)];
//    if ([self.fudongyingkuiLabel.text containsString:@"-"]) {
//            self.yingKuiBgView.backgroundColor = kMarketDown;
//    }else{
//            self.yingKuiBgView.backgroundColor = kMarketUp;
//    }
    
//    double dongtaiquanyi = value + self.model.usableFund.doubleValue + self.model.hasUsedFund.doubleValue;
//    self.dongtaiquanyiLabel.text = [SSTool HeyuePname:@"USDT" price:@(dongtaiquanyi)];
//
//    if (self.model.hasUsedFund.doubleValue > 0) {
//        double rate = dongtaiquanyi * 100 /self.model.hasUsedFund.doubleValue;
//        self.fengxianlvLabel.text = [NSString stringWithFormat:@"%@%@",[SSTool disposePname:@"2" price:@(rate)],@"%"];
//    }

}


@end
