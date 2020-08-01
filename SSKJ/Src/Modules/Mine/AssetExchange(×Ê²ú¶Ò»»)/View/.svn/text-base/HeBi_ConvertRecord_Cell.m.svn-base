//
//  HeBi_ConvertRecord_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_ConvertRecord_Cell.h"

@interface HeBi_ConvertRecord_Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *ammountTitleLabel;// 兑换数量
@property (nonatomic, strong) UILabel *ammountLabel;

@property (nonatomic, strong) UILabel *getTitleLabel;// 获得资产
@property (nonatomic, strong) UILabel *getLabel;
@end

@implementation HeBi_ConvertRecord_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kSubBgColor;
        [self setUI];
    }
    return self;
    
}

#pragma mark - UI

-(void)setUI
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.ammountTitleLabel];
    [self.contentView addSubview:self.ammountLabel];
    [self.contentView addSubview:self.getTitleLabel];
    [self.contentView addSubview:self.getLabel];
    
}


-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"HBI兑换USDT", nil) font:systemBoldFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScreenWidth / 2 - ScaleW(15), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:@"2019-09-09 09:09:09" font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2 - ScaleW(15), ScaleW(15)) textAlignment:NSTextAlignmentRight];
        _timeLabel.centerY = self.titleLabel.centerY;
    }
    return _timeLabel;

}

-(UILabel *)ammountTitleLabel
{
    if (nil == _ammountTitleLabel) {
        _ammountTitleLabel = [WLTools allocLabel:SSKJLocalized(@"兑换数量", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), self.titleLabel.bottom + ScaleW(20), ScaleW(60), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _ammountTitleLabel;
    
}

-(UILabel *)ammountLabel
{
    if (nil == _ammountLabel) {
        _ammountLabel = [WLTools allocLabel:SSKJLocalized(@"3000.00 HBI", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.ammountTitleLabel.right + ScaleW(12), self.ammountTitleLabel.y, ScreenWidth - ScaleW(15) - self.ammountTitleLabel.right, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _ammountLabel;
    
}


-(UILabel *)getTitleLabel
{
    if (nil == _getTitleLabel) {
        _getTitleLabel = [WLTools allocLabel:SSKJLocalized(@"获得资产", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), self.ammountTitleLabel.bottom + ScaleW(15), ScaleW(60), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _getTitleLabel;
    
}

-(UILabel *)getLabel
{
    if (nil == _getLabel) {
        _getLabel = [WLTools allocLabel:SSKJLocalized(@"3000.00 USDT", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.ammountLabel.x, self.getTitleLabel.y, self.ammountLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _getLabel;
    
}

-(void)setCellWithModel:(HeBi_ConvertRecord_Index_Model *)model
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@%@",model.baseCode,SSKJLocalized(@"兑换", nil),model.dealCode];
    self.timeLabel.text = [WLTools convertTimestamp:model.createTime.doubleValue / 1000 andFormat:@"yyyy-MM-dd HH:mm"];
    self.ammountLabel.text = [[WLTools noroundingStringWith:model.dealNum.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:model.baseCode]] stringByAppendingString:model.baseCode];
    self.getLabel.text = [[WLTools noroundingStringWith:model.dealMoney.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:model.dealCode]] stringByAppendingString:model.dealCode];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
