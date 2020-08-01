//
//  My_Generalize_Cell.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Generalize_Cell.h"

@interface My_Generalize_Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIImageView *rightImgV;

@end

@implementation My_Generalize_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    self.contentView.backgroundColor = self.backgroundColor = [UIColor clearColor];
    self.bgView.backgroundColor = kSubBgColor;
    self.bgView.layer.cornerRadius = ScaleW(5);
    self.bgView.layer.shadowColor = kLineColor.CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    self.bgView.layer.shadowRadius = ScaleW(0);
    self.bgView.layer.shadowOpacity = 0.0;
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = kTitleColor;
    self.titleLabel.font = systemFont(15);
    
    self.rightImgV = [UIImageView new];
    self.rightImgV.image = MyImage(@"我的-更多");
    
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.rightImgV];

    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScaleW(15));
        make.right.mas_equalTo(self.contentView).offset(ScaleW(-15));
        make.top.mas_equalTo(self.contentView).offset(ScaleW(5));
        make.bottom.mas_equalTo(self.contentView).offset(ScaleW(-5));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView.mas_left).offset(ScaleW(15));
        make.centerY.mas_equalTo(self.bgView);
    }];
    
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).offset(ScaleW(-15));
        make.centerY.mas_equalTo(self.titleLabel);
    }];
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), 0, ScaleW(200), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}


-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}


@end
