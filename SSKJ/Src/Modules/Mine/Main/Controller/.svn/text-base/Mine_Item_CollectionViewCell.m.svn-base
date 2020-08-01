//
//  Mine_Item_CollectionViewCell.m
//  SSKJ
//
//  Created by zpz on 2019/12/7.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_Item_CollectionViewCell.h"

@implementation Mine_Item_CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    self.backView = [UIView new];
    self.backView.backgroundColor = kBgColor;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = ScaleW(5);
    [self addSubview:self.backView];
    
    
    self.iconImageView = [UIImageView new];
    [self.backView addSubview:self.iconImageView];
    
    
    self.titleLabel = [UILabel createWithText:@"" textColor:kTitleColor font:kFont(15)];
    [self.backView addSubview:self.titleLabel];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.rightimgV = [UIImageView new];
    [self.backView addSubview:self.rightimgV];
    self.rightimgV.image = MyImage(@"我的-更多");
    
    
    
    UIView *bottomLineView = [UIView new];
    bottomLineView.backgroundColor = kLightLineColor;
    self.bottomLineView = bottomLineView;
    [self.backView addSubview:bottomLineView];
    
    
    
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView.mas_centerY);
        make.left.mas_equalTo(self.backView.mas_left).offset(ScaleW(15));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(ScaleW(5));
        make.centerY.equalTo(self.iconImageView);
    }];
    
    [self.rightimgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backView).offset(ScaleW(-15));
        make.centerY.mas_equalTo(self.iconImageView);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.backView);
        make.height.mas_equalTo(1);
    }];

}

@end

