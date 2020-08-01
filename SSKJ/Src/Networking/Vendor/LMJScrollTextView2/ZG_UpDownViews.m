//
//  ZG_UpDownViews.m
//  zgxygj
//
//  Created by james on 2018/4/22.
//  Copyright © 2018年 WeiLv Technology. All rights reserved.
//

#import "ZG_UpDownViews.h"

@implementation ZG_UpDownViews

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createUI];
    }
    return self;
}

#pragma mark - 创建UI
- (void)createUI
{
    //[self titleLabel];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
    self.titleLabel.font = systemFont(14.0);
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@5);
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
    
}

//-(UILabel *)titleLabel
//{
//    if (_titleLabel==nil)
//    {
//        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.textColor = [UIColor whiteColor];
//        _titleLabel.numberOfLines = 1;
//        _titleLabel.lineBreakMode=NSLineBreakByTruncatingTail;
//        _titleLabel.font = systemFont(14.0);
//        [self addSubview:_titleLabel];
//
//        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@5);
//            make.centerY.equalTo(self.mas_centerY);
//            make.right.equalTo(self.mas_right).offset(-5);
//        }];
//    }
//
//    return _titleLabel;
//}



-(void)setViewWithTitle:(NSString *)title
{
    self.titleLabel.text=title;
}
@end
