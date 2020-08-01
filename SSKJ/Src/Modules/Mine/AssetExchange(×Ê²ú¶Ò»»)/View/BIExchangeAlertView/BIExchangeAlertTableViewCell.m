//
//  BIExchangeAlertTableViewCell.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIExchangeAlertTableViewCell.h"

@implementation BIExchangeAlertTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView setBackgroundColor:kBgColor];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}


- (void)setModel:(BIExchangeModel *)model
{
    _model = model;
    
    switch (model.type)
    {
        case BIExchangeModelLeftType:
        {
            [self.titleLabel setText:model.stockCode];
        }
            break;
        case BIExchangeModelRightType:
        {
            [self.titleLabel setText:model.dealCode];
        }
            break;
    }
    
    
    
    
}



#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setTextColor:kTitleColor];
        [_titleLabel setFont:systemFont(18.0)];
        [_titleLabel setText:@"1234"];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.right.bottom.left.equalTo(self.contentView);
         }];
    }
    return _titleLabel;
}







@end
