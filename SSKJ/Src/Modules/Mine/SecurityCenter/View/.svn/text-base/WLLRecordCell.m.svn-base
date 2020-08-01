//
//  WLLRecordCell.m
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "WLLRecordCell.h"
#import "BLLabel.h"

@interface WLLRecordCell ()

@property (weak, nonatomic) IBOutlet BLLabel *addressLabel;
@property (weak, nonatomic) IBOutlet BLLabel *numberLabel;
@property (weak, nonatomic) IBOutlet BLLabel *addTimeLabel;
@property (weak, nonatomic) IBOutlet BLLabel *checkTimeLabel;
@property (weak, nonatomic) IBOutlet BLLabel *stateLabel;

@property (weak, nonatomic) IBOutlet BLLabel *address;
@property (weak, nonatomic) IBOutlet BLLabel *number;
@property (weak, nonatomic) IBOutlet BLLabel *fee;
@property (weak, nonatomic) IBOutlet BLLabel *feeLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

// 约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *confirmTopConstant;



@end

@implementation WLLRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

// 充值 model
- (void)setChongZhiModel:(WLLChongZhiRecordModel *)chongZhiModel {
    _chongZhiModel = chongZhiModel;
    _recordType = RecordTypeChongZhi;
    _fee.hidden = YES;
    _feeLabel.hidden = YES;
    _address.text = @"充值地址";
    _addressLabel.text = chongZhiModel.chongzhi_url ? : @"--";
    _number.text = @"充值数量";
    _numberLabel.text = chongZhiModel.price;
    _addTimeLabel.text = [self getDateStringWithTimeStr:chongZhiModel.addtime];
    _stateLabel.text = [self status:chongZhiModel.state];
//    _checkTimeLabel.text = [self getDateStringWithTimeStr:chongZhiModel.check_time];
    _checkTimeLabel.text = chongZhiModel.check_time ? [self getDateStringWithTimeStr:chongZhiModel.check_time] : @"--";
}

- (NSString *)status:(NSString *)state {
    NSString *status = @"";
    if (_recordType == RecordTypeChongZhi) {
        if ([state integerValue] == 1) {
            status = @"确认中";
        } else {
            status = @"充值成功";
        }
    } else {
        if ([state integerValue] == 1) {
            status = @"待审核";
        } else if ([state integerValue] == 2) {
            status = @"提现成功";
        } else {
            status = @"提现失败";
            _stateLabel.textColor = kSubTitleColor;
        }
    }
    return status;
}

// 提币 model 赋值
- (void)setTiBiModel:(WLLTiBiRecordModel *)tiBiModel {
    _tiBiModel = tiBiModel;

    _recordType = RecordTypeTiBi;
    _fee.hidden = NO;
    _feeLabel.hidden = NO;
    _addressLabel.text = tiBiModel.walletAddr;
    _numberLabel.text = tiBiModel.usdFee;
    _addTimeLabel.text = [self getDateStringWithTimeStr:tiBiModel.createTime];
    _stateLabel.text = [self status:tiBiModel.inspectStatus];
    _checkTimeLabel.text = tiBiModel.inspectTime ? [self getDateStringWithTimeStr:tiBiModel.createTime] : @"--";
}

// 设置 记录类型
- (void)setRecordType:(RecordType)recordType {
    _recordType = recordType;
    [self layoutIfNeeded];
    if (_recordType == RecordTypeChongZhi) {
        _confirmTopConstant.constant = 10;
    } else {
        _confirmTopConstant.constant = 10 + _fee.height + 10;
    }
}

// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
- (NSString *)getDateStringWithTimeStr:(NSString *)str{
    //    NSTimeInterval time=[str doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSTimeInterval time = [str doubleValue];
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm SS"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
