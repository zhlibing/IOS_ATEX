//
//  Home_Coin_CollectionViewCell.m
//  SSKJ
//
//  Created by zpz on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Home_Coin_CollectionViewCell.h"

@interface Home_Coin_CollectionViewCell()

@property(nonatomic, strong)UIView *backView;
@property(nonatomic, strong)UIImageView *iconImageView;
@property(nonatomic, strong)UILabel *coinLabel;
@property(nonatomic, strong)UILabel *priceLabel;
@property(nonatomic, strong)UILabel *rateLabel;
@property(nonatomic, strong)UILabel *cnyLabel;

@end

@implementation Home_Coin_CollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backView = [UIView new];
    self.backView.backgroundColor = kBgColor;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = ScaleW(5);
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
    
    self.coinLabel = [UILabel createWithText:@"" textColor:kTitleColor font:kBoldFont(10)];
    [self.backView addSubview:self.coinLabel];
    [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(ScaleW(5)));
        make.centerX.equalTo(@0);
    }];
    
    self.priceLabel = [UILabel createWithText:@"" textColor:kTitleColor font:kBoldFont(17)];
    [self.backView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coinLabel.mas_bottom).offset(ScaleW(7));
        make.centerX.equalTo(@0);
    }];
    
    self.rateLabel = [UILabel createWithText:@"" textColor:kTitleColor font:kBoldFont(12)];
    [self.backView addSubview:self.rateLabel];
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom).offset(ScaleW(6));
        make.centerX.equalTo(@0);
    }];
    self.cnyLabel = [UILabel createWithText:@"" textColor:kGrayColor font:kFont(12)];
    [self.backView addSubview:self.cnyLabel];
    [self.cnyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rateLabel.mas_bottom).offset(ScaleW(6));
        make.centerX.equalTo(@0);
    }];
}

- (void)setModel:(SSKJ_Market_Index_Model *)model{
    _model = model;
    
    self.coinLabel.text = [[model.code uppercaseString] stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    self.priceLabel.text = [SSTool MarketPname:model.code price:model.price];
    
    self.cnyLabel.text = [NSString stringWithFormat:@"≈%@ CNY",[WLTools roundingStringWith:model.cnyPrice.doubleValue afterPointNumber:2]];
    
    UIColor *color = RED_HEX_COLOR;
    NSString *rate = model.changeRate;
    if (![model.changeRate containsString:@"-"] && model.changeRate) {
        rate = [@"+" stringByAppendingString:model.changeRate];
        color = kMarketUp;
    }else{
        rate = model.changeRate;
        color = kMarketDown;
    }
    self.rateLabel.textColor = color;
    self.rateLabel.text = rate;
    self.priceLabel.textColor = color;
}
@end
