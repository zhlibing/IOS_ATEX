//
//  HeYue_LeftSample_TableViewCell.m
//  SSKJ
//
//  Created by zpz on 2019/12/10.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "HeYue_LeftSample_TableViewCell.h"
@interface HeYue_LeftSample_TableViewCell ()
@property (nonatomic,strong) UILabel *unitLabel;

@end
@implementation HeYue_LeftSample_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    
    self.coinNameLabel = [UILabel createWithText:@"" textColor:kTitleColor font:kBoldFont(16)];
    [self.contentView addSubview:self.coinNameLabel];
    [self.coinNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(15)));
        make.centerY.equalTo(@0);
    }];
    
    UILabel *unit = [UILabel createWithText:@"/USDT" textColor:kSubTitleColor font:kFont(12)];
    self.unitLabel = unit;
    [self.contentView addSubview:unit];
    [unit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coinNameLabel.mas_right).offset(ScaleW(5));
        make.centerY.equalTo(@0);
    }];
    
    
    self.rateLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentRight];
    self.rateLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:self.rateLabel];
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(ScaleW(-10)));
        make.width.mas_equalTo(ScaleW(90));
        make.centerY.equalTo(@0);
    }];
    
    self.priceLabel = [UILabel createWithText:@"" textColor:kTitleColor font:kBoldFont(16)];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rateLabel.mas_left).offset(ScaleW(10));
        make.centerY.equalTo(@0);
    }];
    
}



- (void)setModel:(SSKJ_Market_Index_Model *)model{
    _model = model;
    
    NSArray *codeA = [[model.code uppercaseString] componentsSeparatedByString:@"_"];
    //币种名称
    self.coinNameLabel.text= codeA.firstObject;
    self.priceLabel.text= [SSTool MarketPname:model.code price:model.price];
    self.rateLabel.text = model.changeRate;

    //涨跌幅
    if ([model.changeRate containsString:@"-"])
    {
        self.priceLabel.textColor = kMarketDown;
        self.rateLabel.textColor = kMarketDown;
        
    }
    else
    {
        self.priceLabel.textColor = kMarketUp;
        self.rateLabel.textColor = kMarketUp;
    }
    
    
    
    
}

@end
