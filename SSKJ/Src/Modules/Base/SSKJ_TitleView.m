//
//  SSKJ_TitleView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "SSKJ_TitleView.h"

@interface SSKJ_TitleView ()
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation SSKJ_TitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:self.bounds];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = kNavigationTitleColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin ;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titleLabel;
}

-(void)changeTitle:(NSString *)title
{
    self.titleLabel.text = title;
}


-(void)changeTitleColor:(UIColor *)titleColor
{
    self.titleLabel.textColor = titleColor;
}
-(void)changeTitleFont:(UIFont *)font
{
    self.titleLabel.font = font;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
