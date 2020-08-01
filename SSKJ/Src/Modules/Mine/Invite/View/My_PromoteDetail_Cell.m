//
//  My_PromoteDetail_Cell.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2018/11/29.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "My_PromoteDetail_Cell.h"

@interface My_PromoteDetail_Cell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contactLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation My_PromoteDetail_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.nameLabel];
    [self addSubview:self.contactLabel];
    [self addSubview:self.timeLabel];
 
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth , 11)];
    style.layer.backgroundColor = [[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:250.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 1;
    [self.contentView addSubview:style];

    [style mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.bottom.equalTo(self.contentView);
        
        make.height.mas_equalTo(1);
        
    }];
    
    
    
}

-(UILabel *)nameLabel
{
    if (nil == _nameLabel) {
        CGFloat width = (ScreenWidth - ScaleW(30)) / 3;
        _nameLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(15), width, ScaleW(30)) textAlignment:NSTextAlignmentLeft];
        _nameLabel.centerY = ScaleW(30);
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}

-(UILabel *)contactLabel
{
    if (nil == _contactLabel) {
        _contactLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(self.nameLabel.right, 0, self.nameLabel.width, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
        _contactLabel.adjustsFontSizeToFitWidth = YES;
        _contactLabel.centerY = self.nameLabel.centerY;
    }
    return _contactLabel;
}

-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:@"" font:[UIFont systemFontOfSize:ScaleW(13)] textColor:RGBCOLOR(18,18,18) frame:CGRectMake(self.contactLabel.right+ScaleW(30),0, self.nameLabel.width-ScaleW(30), ScaleW(60)) textAlignment:NSTextAlignmentRight];
        _timeLabel.centerY = self.nameLabel.centerY;
        _timeLabel.numberOfLines = 0;
    }
    return _timeLabel;
}

-(void)setCellWithModel:(My_Promote_Index_Model *)model
{
    self.nameLabel.text = model.userUid.length > 0 ? model.userUid:@"--";
    
//    self.contactLabel.text = [WLTools hidePhoneMiddleNumberWithMobile:model.tel];
//    if ([model.tel isEqual:[NSNull null]] || model.tel.length == 0) {
//        self.contactLabel.text = model.email;
//
//        if ([model.email isEqual:[NSNull null]]) {
//            self.contactLabel.text = nil;
//        }
//    }
    if ([model.level isEqualToString:@"1"]){
        self.contactLabel.text = SSKJLocalized(@"直推",nil);
    }else{
        self.contactLabel.text = SSKJLocalized(@"间推",nil);
    }
 
//    if (model.level.integerValue ==0) {
//
//        self.contactLabel.text= SSKJLocalized(@"普通用户",  nil);
//
//    }
//    else{
//         self.contactLabel.text =[ NSString stringWithFormat:@"%@ %@",model.level,SSKJLocalized(@"级", nil)];
//    }
    
    NSString *newTime=[model.createTime stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    
    self.timeLabel.text = newTime;
    
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
