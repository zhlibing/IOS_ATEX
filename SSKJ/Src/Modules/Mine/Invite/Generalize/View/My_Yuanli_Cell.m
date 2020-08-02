//
//  My_Yuanli_Cell.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Yuanli_Cell.h"

@interface My_Yuanli_Cell ()
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *timeLabel;
//@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation My_Yuanli_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView setBackgroundColor:kBgColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    
    [self addSubview:self.typeLabel];
    [self addSubview:self.numLabel];
    [self addSubview:self.timeLabel];
    
        
}




-(UILabel *)typeLabel
{
    if (nil == _typeLabel) {
        

        _typeLabel = [WLTools allocLabel:SSKJLocalized(@"返佣类型", nil) font:systemFont(ScaleW(15)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), 0, ScaleW(96), ScaleW(47)) textAlignment:NSTextAlignmentLeft];
    }
    return _typeLabel;
}

-(UILabel *)numLabel
{
    if (nil == _numLabel) {

        CGFloat width = ScaleW(180);
        
        _numLabel = [WLTools allocLabel:SSKJLocalized(@"数量", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(self.typeLabel.right, 0, width, ScaleW(47)) textAlignment:NSTextAlignmentLeft];
    }
    return _numLabel;
}
-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        
        CGFloat width = ScaleW(200);

        _timeLabel = [WLTools allocLabel:SSKJLocalized(@"时间", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScreenWidth - ScaleW(15) - width, 0, width, ScaleW(47)) textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}


- (void)setCellWithModel:(My_Yuanli_Model *)model
{
    if (model.type.integerValue == 1)
    {
        self.typeLabel.text = SSKJLocalized(@"邀请返佣", nil);
    }
    else
    {
        self.typeLabel.text = SSKJLocalized(@"自身返佣", nil);
    }
    
    [self.typeLabel setText:model.mark];
    
    self.numLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:model.num.doubleValue afterPointNumber:6],model.code];
    
    self.timeLabel.text = model.created_at;
}
@end
