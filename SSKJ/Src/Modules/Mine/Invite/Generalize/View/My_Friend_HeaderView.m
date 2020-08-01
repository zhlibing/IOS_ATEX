//
//  My_Friend_HeaderView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Friend_HeaderView.h"

@interface My_Friend_HeaderView ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation My_Friend_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = kSubBgColor;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    
    UIView *view = [UIView new];
    view.backgroundColor = kSubBgColor;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@(ScaleW(5)));
    }];
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.timeLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left).offset(ScaleW(15));
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@(ScaleW(90)));
    }];
    
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
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

        _nameLabel = [WLTools allocLabel:SSKJLocalized(@"名称", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), 0, width, self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel
{
    if (nil == _phoneLabel) {
        
        CGFloat width = (ScreenWidth - ScaleW(30)) / 3;

        _phoneLabel = [WLTools allocLabel:SSKJLocalized(@"账号", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(self.nameLabel.right, 0, width, self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _phoneLabel;
}
-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        
        CGFloat width = (ScreenWidth - ScaleW(30)) / 3;
        
        _timeLabel = [WLTools allocLabel:SSKJLocalized(@"注册时间", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(self.phoneLabel.right, 0, width, self.height) textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
