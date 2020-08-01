//
//  ATEX_SafeCenter_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/14.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "ATEX_SafeCenter_Cell.h"

@interface ATEX_SafeCenter_Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *enterImageView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIImageView *statusImageView;

@end

@implementation ATEX_SafeCenter_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.titleLabel];
        [self addSubview:self.enterImageView];
        [self addSubview:self.statusLabel];
        [self addSubview:self.statusImageView];

    }
    return self;
}


-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), 0, ScaleW(200), ScaleW(49)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIImageView *)enterImageView
{
    if (nil == _enterImageView) {
        _enterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(5), 0, ScaleW(5), ScaleW(9))];
        _enterImageView.image = [UIImage imageNamed:@"我的-更多"];
        _enterImageView.centerY = self.titleLabel.centerY;
    }
    return _enterImageView;
}


-(UILabel *)statusLabel
{
    if (nil == _statusLabel) {
        _statusLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kSubTitleColor frame:CGRectMake(self.enterImageView.x - ScaleW(10) - ScaleW(100), 0, ScaleW(100), ScaleW(49)) textAlignment:NSTextAlignmentRight];
        _statusLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _statusLabel;
}

-(UIImageView *)statusImageView
{
    if (nil == _statusImageView) {
        _statusImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(11.5), 0, ScaleW(11.5), ScaleW(11.5))];
        _statusImageView.image = [UIImage imageNamed:@"safe_status"];
        _statusImageView.centerY = self.titleLabel.centerY;
    }
    return _statusImageView;
}

- (void)setTitle:(NSString *)title statusString:(NSString *)statusString isShowImage:(BOOL)isShowImage
{
    self.titleLabel.text = title;
    self.statusLabel.text = statusString;
    self.statusImageView.hidden = !isShowImage;
    CGFloat width = [WLTools getWidthWithText:statusString font:self.statusLabel.font];
   self.statusLabel.width = width;
   self.statusLabel.right = self.enterImageView.x - ScaleW(10);
    if (isShowImage) {
        self.statusLabel.textColor = UIColorFromRGB(0xFF5E66);
        self.statusImageView.right = self.statusLabel.x - ScaleW(5);
    }else{
        self.statusLabel.textColor = kSubTitleColor;
    }
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
