//
//  Chooase_AreaCode_Cell.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/6/4.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Chooase_AreaCode_Cell.h"

@interface Chooase_AreaCode_Cell()

@end

@implementation Chooase_AreaCode_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kTitleColor;
        
        [self areaImg];
        
        [self areaName];
        
        [self areaCode];
       
    }
    return self;
}

- (UIImageView *)areaImg{
    if (_areaImg == nil) {
        _areaImg = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"Btn_BG_IMG"];
        [self.contentView addSubview:_areaImg];
        [_areaImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(20)));
            make.width.equalTo(@(ScaleW(30)));
            make.height.equalTo(@(ScaleW(20)));
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return _areaImg;
}

- (UILabel *)areaName{
    if (_areaName == nil) {
        _areaName = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"China", nil) textColor:kTitleColor font:systemFont(15)];
        [self.contentView addSubview:_areaName];
        [_areaName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.areaImg.mas_left).offset(ScaleW(0));
            make.height.equalTo(@(ScaleW(30)));
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return _areaName;
}

- (UILabel *)areaCode{
    if (_areaCode == nil) {
        _areaCode = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"+86", nil) textColor:kTitleColor font:systemFont(15)];
        [self.contentView addSubview:_areaCode];
        [_areaCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(ScaleW(-30)));
            make.height.equalTo(@(ScaleW(30)));
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return _areaCode;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
