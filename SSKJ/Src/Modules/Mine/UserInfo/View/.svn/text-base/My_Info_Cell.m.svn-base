//
//  My_Info_Cell.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Info_Cell.h"

@interface My_Info_Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIView *lineView; //!< 分割线
@end

@implementation My_Info_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self.contentView setBackgroundColor:kBgColor];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.valueLabel];
        [self.contentView addSubview:self.lineView];
        

    }
    return self;
}

-(void)setItemObject:(Mine_UserInfoModel *)model
{
    [self.titleLabel setText:SSKJLocalized(model.title, nil)];
    [self.valueLabel setText:model.describe];
}


-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kTitleColor font:systemFont(ScaleW(14))];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        _titleLabel.centerY = ScaleW(25);
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
         { make.left.equalTo(self.contentView.mas_left).offset(ScaleW(10));
             make.width.equalTo(@(ScaleW(60)));
             make.height.equalTo(self);
         }];
        
    }
    return _titleLabel;
}

-(UILabel *)valueLabel
{
    if (nil == _valueLabel) {
        _valueLabel  = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kTitleColor font:systemFont(ScaleW(14))];
        [_valueLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_valueLabel];
        [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.titleLabel.mas_right);
        make.right.equalTo(self.contentView.mas_right).offset(-(ScaleW(10)));
            make.height.equalTo(self.titleLabel.mas_height);
         }];
        _valueLabel.centerY = self.titleLabel.centerY;
    }
    return _valueLabel;
}

-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:kLineColor];
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(ScaleW(10));
            make.right.equalTo(self.contentView.mas_right).offset(ScaleW(-10));
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.height.equalTo(@(ScaleW(0.5)));
        }];
    }
    return _lineView;
}









@end
