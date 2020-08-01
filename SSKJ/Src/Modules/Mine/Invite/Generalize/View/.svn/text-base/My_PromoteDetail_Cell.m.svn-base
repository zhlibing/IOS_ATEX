//
//  My_PromoteDetail_Cell.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2018/11/29.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "My_PromoteDetail_Cell.h"

@interface My_PromoteDetail_Cell ()



@end

@implementation My_PromoteDetail_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = kBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self.contentView addSubview:self.nameLabel];

    [self.contentView addSubview:self.contactLabel];
    [self.contentView  addSubview:self.timeLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left).offset(ScaleW(15));
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(ScaleW(90)));
    }];
    
    [self.contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@(ScaleW(115)));
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(ScaleW(145)));

    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.mas_right).offset(-ScaleW(15));
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(ScaleW(85)));
    }];
}

-(UILabel *)nameLabel
{
    if (nil == _nameLabel) {
        CGFloat width = (ScreenWidth - ScaleW(30)) / 3;
        _nameLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), ScaleW(15), width, ScaleW(30)) textAlignment:NSTextAlignmentLeft];
        _nameLabel.centerY = ScaleW(30);
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}

-(UILabel *)contactLabel
{
    if (nil == _contactLabel) {
        _contactLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(self.nameLabel.right, 0, self.nameLabel.width, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        _contactLabel.adjustsFontSizeToFitWidth = YES;
        _contactLabel.centerY = self.nameLabel.centerY;
    }
    return _contactLabel;
}

-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:@"" font:[UIFont systemFontOfSize:ScaleW(13)] textColor:kTitleColor frame:CGRectMake(self.contactLabel.right+ScaleW(30),0, self.nameLabel.width-ScaleW(30), ScaleW(60)) textAlignment:NSTextAlignmentRight];
        _timeLabel.centerY = self.nameLabel.centerY;
        _timeLabel.numberOfLines = 0;
    }
    return _timeLabel;
}

-(void)setCellWithModel:(My_Promote_Index_Model *)model
{
    self.nameLabel.text = model.name.length > 0 ? model.name:@"--";
    
    if (model.phone.length > 0)
    {
        self.contactLabel.text = [WLTools hidePhoneMiddleNumberWithMobile:model.phone];
        
    }
    else if (model.email.length >0)
    {
        self.contactLabel.text = [WLTools hideEmailWithEmail:model.email];
    }
    else
    {
        [self.contactLabel setText:@"--"];
    }
 
    self.timeLabel.text = model.created_at;
    
}

-(NSString *)dateStringWithTimeInterval:(NSString *)timeInterval
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval.doubleValue];
    return [formatter stringFromDate:date];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
