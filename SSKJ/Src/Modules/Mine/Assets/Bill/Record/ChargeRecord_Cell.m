//
//  ChargeRecord_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/16.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "ChargeRecord_Cell.h"

@interface ChargeRecord_Cell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *addressTitleLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *numberTitleLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *timeTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *describeTitleLabel;
@property (nonatomic, strong) UILabel *describeLabel;

@end

@implementation ChargeRecord_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = kBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.backView];
        [self.backView addSubview:self.topView];
        [self.topView addSubview:self.addressTitleLabel];
        [self.topView addSubview:self.addressLabel];
        [self.backView addSubview:self.numberTitleLabel];
        [self.backView addSubview:self.numberLabel];
        [self.backView addSubview:self.timeTitleLabel];
        [self.backView addSubview:self.timeLabel];
        [self.backView addSubview:self.describeTitleLabel];
        [self.backView addSubview:self.describeLabel];
    }
    return self;
}


-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(138))];
        _backView.backgroundColor = kSubBgColor;
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = ScaleW(5);
    }
    return _backView;
}
-(UIView *)topView
{
    if (nil == _topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.backView.width, ScaleW(39))];
        _topView.backgroundColor = UIColorFromRGB(0x1C2C44);
    }
    return _topView;
}

- (UILabel *)addressTitleLabel
{
    if (nil == _addressTitleLabel) {
        
        NSString *lan = [[SSKJLocalized sharedInstance]currentLanguage];
        CGFloat width = ScaleW(60);
        if ([lan containsString:@"en"]) {
            width = ScaleW(100);
        }

        
        _addressTitleLabel = [WLTools allocLabel:SSKJLocalized(@"充币地址", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), 0, width, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _addressTitleLabel.centerY = self.topView.height / 2;
    }
    return _addressTitleLabel;
}


- (UILabel *)addressLabel
{
    if (nil == _addressLabel) {
        _addressLabel = [WLTools allocLabel:SSKJLocalized(@"----", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.addressTitleLabel.right + ScaleW(10), 0, self.topView.width - ScaleW(25) - self.addressTitleLabel.right, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _addressLabel.centerY = self.addressTitleLabel.centerY;
        _addressLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _addressLabel;
}


- (UILabel *)numberTitleLabel
{
    if (nil == _numberTitleLabel) {
        _numberTitleLabel = [WLTools allocLabel:SSKJLocalized(@"充币数量", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.topView.bottom + ScaleW(20),self.addressTitleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _numberTitleLabel;
}


- (UILabel *)numberLabel
{
    if (nil == _numberLabel) {
        _numberLabel = [WLTools allocLabel:SSKJLocalized(@"----", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.addressLabel.x, self.numberTitleLabel.y, self.addressLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _numberLabel.centerY = self.numberTitleLabel.centerY;
    }
    return _numberLabel;
}


- (UILabel *)timeTitleLabel
{
    if (nil == _timeTitleLabel) {
        _timeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"充币时间", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.numberTitleLabel.bottom + ScaleW(13), self.addressTitleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _timeTitleLabel;
}


- (UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:SSKJLocalized(@"----", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.addressLabel.x, self.timeTitleLabel.y, self.addressLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _timeLabel.centerY = self.timeTitleLabel.centerY;
    }
    return _timeLabel;
}



- (UILabel *)describeTitleLabel
{
    if (nil == _describeTitleLabel)
    {
        _describeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"充值说明", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.timeTitleLabel.bottom + ScaleW(13), self.addressTitleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _describeTitleLabel;
}


- (UILabel *)describeLabel
{
    if (nil == _describeLabel)
    {
        _describeLabel = [WLTools allocLabel:SSKJLocalized(@"----", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.addressLabel.x, self.describeTitleLabel.y, self.addressLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _describeLabel.centerY = self.describeTitleLabel.centerY;
    }
    return _describeLabel;
}


-(void)setCellWithModel:(ATEX_Charge_IndexModel *)model
{
    
    NSInteger type = model.type.integerValue;
    if (type == 1)
    {
        self.addressTitleLabel.text = SSKJLocalized(@"后台充值", nil);
        self.addressLabel.text = nil;
    }
    else if (type == 2)
    {
        self.addressTitleLabel.text = SSKJLocalized(@"在线充值", nil);
        self.addressLabel.text = nil;
    }
    else
    {
        self.addressTitleLabel.text = SSKJLocalized(@"充币地址", nil);
        self.addressLabel.text = model.wallet_address;
    }
    
    self.numberLabel.text = [[WLTools noroundingStringWith:model.money.doubleValue afterPointNumber:2] stringByAppendingFormat:@" USDT"];
    
    self.timeLabel.text = model.arrival_at;
    [self.describeLabel setText:model.mark];

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
