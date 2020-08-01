//
//  ExtractRecord_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/16.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "ExtractRecord_Cell.h"
@interface ExtractRecord_Cell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *addressTitleLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *numberTitleLabel;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *feeTitleLabel;
@property (nonatomic, strong) UILabel *feeLabel;
@property (nonatomic, strong) UILabel *timeTitleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *checkTitleLabel; // 审核时间
@property (nonatomic, strong) UILabel *checkLabel;

@property (nonatomic, strong) UIView *refuseView;   // 拒绝
@property (nonatomic, strong) UIImageView *refuseImageView;
@property (nonatomic, strong) UILabel *refuseLabel;
@end
@implementation ExtractRecord_Cell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.backView];
        [self.backView addSubview:self.topView];
        [self.topView addSubview:self.addressTitleLabel];
        [self.topView addSubview:self.addressLabel];
        [self.backView addSubview:self.numberTitleLabel];
        [self.backView addSubview:self.numberLabel];
        [self.backView addSubview:self.statusLabel];
        [self.backView addSubview:self.feeTitleLabel];
        [self.backView addSubview:self.feeLabel];
        [self.backView addSubview:self.timeTitleLabel];
        [self.backView addSubview:self.timeLabel];
        [self.backView addSubview:self.checkTitleLabel];
        [self.backView addSubview:self.checkLabel];
        
        [self.backView addSubview:self.refuseView];
        [self.refuseView addSubview:self.refuseImageView];
        [self.refuseView addSubview:self.refuseLabel];
    }
    return self;
}


-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(174))];
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
        
        _addressTitleLabel = [WLTools allocLabel:SSKJLocalized(@"提币地址", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), 0, width, ScaleW(20)) textAlignment:NSTextAlignmentLeft];
        _addressTitleLabel.adjustsFontSizeToFitWidth = YES;
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
        _numberTitleLabel = [WLTools allocLabel:SSKJLocalized(@"提币数量", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.topView.bottom + ScaleW(20), self.addressTitleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _numberTitleLabel.adjustsFontSizeToFitWidth = YES;

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

-(UILabel *)statusLabel
{
    if (nil == _statusLabel) {
        _statusLabel = [WLTools allocLabel:SSKJLocalized(@"提币成功", nil) font:systemFont(ScaleW(14)) textColor:kBlueColor frame:CGRectMake(self.backView.width - ScaleW(15) - ScaleW(80), 0, ScaleW(80), ScaleW(20)) textAlignment:NSTextAlignmentRight];
        _statusLabel.centerY = self.numberLabel.centerY;
        _statusLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _statusLabel;
}

- (UILabel *)feeTitleLabel
{
    if (nil == _feeTitleLabel) {
        _feeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"手续费", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.numberTitleLabel.bottom + ScaleW(13), self.numberTitleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _feeTitleLabel.adjustsFontSizeToFitWidth = YES;

    }
    return _feeTitleLabel;
}


- (UILabel *)feeLabel
{
    if (nil == _feeLabel) {
        _feeLabel = [WLTools allocLabel:SSKJLocalized(@"----", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.addressLabel.x, self.feeTitleLabel.y, self.addressLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _feeLabel.centerY = self.feeTitleLabel.centerY;
    }
    return _feeLabel;
}


- (UILabel *)timeTitleLabel
{
    if (nil == _timeTitleLabel) {
        _timeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"提币时间", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.feeTitleLabel.bottom + ScaleW(13), self.numberTitleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _timeTitleLabel.adjustsFontSizeToFitWidth = YES;

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


- (UILabel *)checkTitleLabel
{
    if (nil == _checkTitleLabel) {
        _checkTitleLabel = [WLTools allocLabel:SSKJLocalized(@"审核时间", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.timeTitleLabel.bottom + ScaleW(13), self.numberTitleLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _checkTitleLabel.adjustsFontSizeToFitWidth = YES;

    }
    return _checkTitleLabel;
}


- (UILabel *)checkLabel
{
    if (nil == _checkLabel) {
        _checkLabel = [WLTools allocLabel:SSKJLocalized(@"--", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.addressLabel.x, self.timeTitleLabel.y, self.addressLabel.width, ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _checkLabel.centerY = self.checkTitleLabel.centerY;
    }
    return _checkLabel;
}

-(UIView *)refuseView
{
    if (nil == _refuseView) {
        _refuseView = [[UIView alloc]initWithFrame:CGRectMake(0, self.checkTitleLabel.bottom + ScaleW(14), self.backView.width, ScaleW(16.5))];
    }
    return _refuseView;
}

-(UIImageView *)refuseImageView
{
    if (nil == _refuseImageView) {
        _refuseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15.5), 0, ScaleW(16.5), ScaleW(16.5))];
        _refuseImageView.image = [UIImage imageNamed:@"mine_error"];
    }
    return _refuseImageView;
}

-(UILabel *)refuseLabel
{
    if (nil == _refuseLabel) {
        _refuseLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(self.refuseImageView.right + ScaleW(7.5), 0, self.refuseView.width - ScaleW(22.5) - self.refuseImageView.right, self.refuseView.height) textAlignment:NSTextAlignmentLeft];
    }
    return _refuseLabel;
}


-(void)setCellWithModel:(ATEX_Extract_IndexModel *)model
{
    self.addressLabel.text = model.address;
    self.numberLabel.text = [NSString stringWithFormat:@"%@ USDT",[WLTools noroundingStringWith:model.money.doubleValue afterPointNumber:2]];
    self.feeLabel.text = [NSString stringWithFormat:@"%@ USDT",[WLTools noroundingStringWith:model.handling_fee.doubleValue afterPointNumber:2]];
    self.timeLabel.text = model.created_at;
    if (model.checked_at.length != 0) {
        self.checkLabel.text = model.checked_at;
    }else{
        self.checkLabel.text = @"--";
    }
    
    NSInteger status = model.status.integerValue;
    
    if (status == 0 || status == 1) {
        self.statusLabel.text = SSKJLocalized(@"审核中", nil);
        self.statusLabel.textColor = UIColorFromRGB(0x2FE091);
    }else  if (status == 3 || status == 5){
        self.statusLabel.text = SSKJLocalized(@"审核失败", nil);
        self.statusLabel.textColor = UIColorFromRGB(0xFF5E66);
    }else if (status == 4){
        self.statusLabel.text = SSKJLocalized(@"提币成功", nil);
        self.statusLabel.textColor = kBlueColor;
    }
    
    
    if (status == 3 || status == 5){
        self.refuseView.hidden = NO;
        self.backView.height = ScaleW(204);
        self.refuseLabel.text = model.refuse_reason;
    }else{
        self.refuseView.hidden = YES;
        self.backView.height = ScaleW(174);

    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
