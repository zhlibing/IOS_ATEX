//
//  GoCoin_System_Cell.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/29.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "News_System_Cell.h"

@interface News_System_Cell()

@property (nonatomic,strong) UIImageView * imageV;

@property (nonatomic,strong) UILabel * contentLabel;

@property (nonatomic,strong) UILabel * timeLabel;

@property (nonatomic,strong) UIView * lineview;

@end

@implementation News_System_Cell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor=kBgColor;
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    [self imageV];
    
    [self contentLabel];
    
    [self timeLabel];
    
    [self lineview];
    
}

-(UIImageView *)imageV
{
    if (_imageV == nil) {
        
        _imageV = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"market_banner"];
        
        [self.contentView addSubview:_imageV];
        _imageV.layer.masksToBounds = YES;
        _imageV.layer.cornerRadius = ScaleW(5);
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.top.equalTo(@(ScaleW(15)));
            
            make.width.equalTo(@(ScaleW(105)));
            
            make.height.equalTo(@(ScaleW(80)));
            
        }];
    }
    return _imageV;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        
        _contentLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kTitleColor font:systemFont(ScaleW(15))];
        
        _contentLabel.numberOfLines = 2;
        
        [self.contentView addSubview:_contentLabel];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.imageV.mas_top);
            
            make.left.equalTo(self.imageV.mas_right).offset(ScaleW(10));
            
            make.right.equalTo(@(ScaleW(-15)));
            
        }];
        
    }
    return _contentLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        
        _timeLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"03-23 12:00" textColor:kSubTitleColor font:systemFont(ScaleW(12))];
        
        [self.contentView addSubview:_timeLabel];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.imageV.mas_bottom);
            
            make.left.equalTo(self.imageV.mas_right).offset(ScaleW(10));
            
            make.right.equalTo(@(ScaleW(-15)));
            
        }];
        
    }
    return _timeLabel;
}

- (UIView *)lineview
{
    if (_lineview == nil) {
        
        _lineview = [FactoryUI createViewWithFrame:CGRectZero Color:kLineColor];
        
        [self.contentView addSubview:_lineview];
        
        [_lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.right.equalTo(@0);
            
            make.left.equalTo(self.contentLabel);
            make.right.equalTo(@(ScaleW(-15)));

            make.height.equalTo(@(ScaleW(0.5)));
            
            
        }];
    }
    return _lineview;
}

- (void)initDataWithModel:(News_Zizun_Index_Model *)model
{
    self.contentLabel.text = model.title;
    
    self.timeLabel.text = model.created_at;
    
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:model.pic_addr]] placeholderImage:[UIImage imageNamed:@"banaer_moren"]];
}

@end
