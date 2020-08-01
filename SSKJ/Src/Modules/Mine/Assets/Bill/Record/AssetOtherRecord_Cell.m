//
//  AssetOtherRecord_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/16.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "AssetOtherRecord_Cell.h"

@interface AssetOtherRecord_Cell ()
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *timeTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *numberTitleLabel;
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UILabel *remarkTitleLabel;
@property (nonatomic, strong) UILabel *remarkLabel;

@end
@implementation AssetOtherRecord_Cell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.backView];
        [self.backView addSubview:self.timeTitleLabel];
        [self.backView addSubview:self.timeLabel];

        [self.backView addSubview:self.numberTitleLabel];
        [self.backView addSubview:self.numberLabel];
        
        [self.backView addSubview:self.remarkTitleLabel];
        [self.backView addSubview:self.remarkLabel];

    }
    return self;
}


-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(95))];
        _backView.backgroundColor = kSubBgColor;
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = ScaleW(5);
    }
    return _backView;
}



- (UILabel *)timeTitleLabel
{
    if (nil == _timeTitleLabel) {
        _timeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"时间", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), ScaleW(15), ScaleW(60), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _timeTitleLabel;
}


- (UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:SSKJLocalized(@"----", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.timeTitleLabel.right + ScaleW(10), self.timeTitleLabel.y, self.backView.width - ScaleW(25) - self.timeTitleLabel.right, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _timeLabel.centerY = self.timeTitleLabel.centerY;
    }
    return _timeLabel;
}

- (UILabel *)numberTitleLabel
{
    if (nil == _numberTitleLabel) {
        _numberTitleLabel = [WLTools allocLabel:SSKJLocalized(@"数量", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.timeTitleLabel.bottom + ScaleW(15), ScaleW(60), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _numberTitleLabel;
}


- (UILabel *)numberLabel
{
    if (nil == _numberLabel) {
        _numberLabel = [WLTools allocLabel:SSKJLocalized(@"----", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.timeLabel.x, self.numberTitleLabel.y, self.timeLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _numberLabel.centerY = self.numberTitleLabel.centerY;
    }
    return _numberLabel;
}



- (UILabel *)remarkTitleLabel
{
    if (nil == _remarkTitleLabel) {
        _remarkTitleLabel = [WLTools allocLabel:SSKJLocalized(@"备注", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.numberTitleLabel.bottom + ScaleW(15), ScaleW(60), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _remarkTitleLabel;
}


- (UILabel *)remarkLabel
{
    if (nil == _remarkLabel) {
        _remarkLabel = [WLTools allocLabel:SSKJLocalized(@"----", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.numberLabel.x, self.remarkTitleLabel.y, self.numberLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _remarkLabel.centerY = self.remarkTitleLabel.centerY;
        _remarkLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _remarkLabel;
}


-(void)setCellWithModel:(ATEX_AssetOtherRecord_IndexModel *)model
{
    self.timeLabel.text = model.created_at;
    self.numberLabel.text = [NSString stringWithFormat:@"%@ USDT",[WLTools noroundingStringWith:model.money.doubleValue afterPointNumber:6]];
    self.remarkLabel.text = model.mark;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
