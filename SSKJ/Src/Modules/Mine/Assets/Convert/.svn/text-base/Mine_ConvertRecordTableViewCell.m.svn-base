//
//  Mine_ConvertRecordTableViewCell.m
//  SSKJ
//
//  Created by zpz on 2019/12/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_ConvertRecordTableViewCell.h"

@implementation Mine_ConvertRecordTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = kSubBgColor;
        
        [self setupSubviews];
    }
    return self;
}


- (void)setupSubviews{
    UIView *left = [self getViewWith:SSKJLanguage(@"兑换资产")];
    [self.contentView addSubview:left];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0);
        make.height.equalTo(@(ScaleW(54)));
    }];
    self.titleLabel = [left viewWithTag:1001];
    
    UIView *right = [self getViewWith:SSKJLanguage(@"兑换数量")];
    [self.contentView addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(left.mas_right);
        make.top.width.height.equalTo(left);
        make.right.equalTo(@(ScaleW(-5)));
    }];
    self.numLabel = [right viewWithTag:1001];
    
    
    UIView *left1 = [self getViewWith:SSKJLanguage(@"到账数量")];
    [self.contentView addSubview:left1];
    [left1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(left.mas_bottom);
        make.left.height.equalTo(left);
    }];
    self.toNumLabel = [left1 viewWithTag:1001];
    
    UIView *right1 = [self getViewWith:SSKJLanguage(@"时间")];
    [self.contentView addSubview:right1];
    [right1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(left1.mas_right);
        make.top.width.height.equalTo(left1);
        make.right.equalTo(right);
    }];
    self.timeLabel = [right1 viewWithTag:1001];
    
    UIView *line = [UIView new];
    line.backgroundColor = kLineColor;
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@(ScaleW(0.5)));
    }];
}


- (UIView *)getViewWith:(NSString *)subTitle{
    UIView *view = [UIView new];
    
    UILabel *sub = [UILabel createWithText:subTitle textColor:kSubTitleColor font:kFont(12)];
    [view addSubview:sub];
    
    UILabel *label = [UILabel createWithText:@"" textColor:kTitleColor font:kFont(13)];
    label.tag = 1001;
    [view addSubview:label];
    
    [sub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(15)));
        make.top.equalTo(@(ScaleW(12)));
        make.right.equalTo(@0);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sub.mas_bottom).offset(ScaleW(10));
        make.right.left.equalTo(sub);
    }];
    
    return view;
}



@end
