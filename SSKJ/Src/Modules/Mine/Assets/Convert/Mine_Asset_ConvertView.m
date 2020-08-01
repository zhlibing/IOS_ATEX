//
//  Mine_Asset_ConvertView.m
//  SSKJ
//
//  Created by zpz on 2019/12/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_Asset_ConvertView.h"

@interface Mine_Asset_ConvertView ()

@property(nonatomic, strong)UILabel *titleLabel;

@property(nonatomic, strong)UILabel *priceLabel;
@end

@implementation Mine_Asset_ConvertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = ScaleW(5);
    self.layer.borderColor = kLineColor.CGColor;
    self.layer.borderWidth = ScaleW(1);
    
    self.titleLabel = [UILabel createWithText:@"" textColor:kTitleColor font:kFont(12)];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(8)));
        make.width.equalTo(@(ScaleW(50)));
        make.centerY.equalTo(@0);
    }];
    
    self.priceLabel = [UILabel createWithText:@"" textColor:kTitleColor font:kFont(12)];
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(ScaleW(5));
        make.right.equalTo(@(ScaleW(-25)));
        make.centerY.equalTo(@0);
    }];
    [self.priceLabel setContentCompressionResistancePriority:(UILayoutPriorityDefaultLow) forAxis:(UILayoutConstraintAxisHorizontal)];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:UIImageNamed(@"hy_down_gray")];
    [self addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(ScaleW(-5)));
        make.centerY.equalTo(@0);
    }];
    
    
    UIButton *bg = [UIButton buttonWithType:UIButtonTypeCustom];
    [bg addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(@0);
    }];
    
}

- (void)btnClick{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)setCoin:(NSString *)coin{
    _coin = coin;
    self.titleLabel.text = coin;
    self.titleLabel.textColor = kTitleColor;
    self.model = nil;
    self.priceLabel.text = @"";
}

- (void)setModel:(SSKJ_Market_Index_Model *)model{
    _model = model;
    
    UIColor *color;
    NSString *rate;
    if ((![model.change containsString:@"-"] || model.change.doubleValue >= 0)) {
        
        color = kMarketUp;
        rate = @"↑";
        
    }else{
        color = kMarketDown;
        rate = @"↓";
    }
    
    if (model.price.doubleValue) {
        self.priceLabel.text = [NSString stringWithFormat:@"%@%@", [SSTool MarketPname:model.code price:model.price], rate];
        self.priceLabel.textColor = color;
    }
    
    
}



@end
