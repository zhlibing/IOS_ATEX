//
//  GoCoin_Trading_Cell.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/29.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "News_Trading_Cell.h"

@interface News_Trading_Cell()

@property (nonatomic, strong) UIView *cycleView;

@property (nonatomic,strong) UILabel * contentLabel;

@property (nonatomic,strong) UIView * lineview;

@property (nonatomic,strong) UIImageView * imageV;


@end

@implementation News_Trading_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        self.backgroundColor=kSubBgColor;
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    [self cycleView];
    
    [self contentLabel];
    
    [self imageV];
    
    [self lineview];
}

- (UIView *)cycleView
{
    if (_cycleView == nil) {
        
        _cycleView = [FactoryUI createViewWithFrame:CGRectZero Color:kSubTitleColor];
        
        _cycleView.layer.cornerRadius = ScaleW(5);
        
        _cycleView.layer.masksToBounds = YES;
        
        [self.contentView addSubview:_cycleView];
        
        [_cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(@(ScaleW(15)));
            
            make.centerY.equalTo(self.contentView.mas_centerY);
            
            make.height.width.equalTo(@(ScaleW(10)));
            
        }];
    }
    
    return _cycleView;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        
        _contentLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:kTitleColor font:systemFont(ScaleW(14))];
        
        _contentLabel.numberOfLines = 2;
        
        [self.contentView addSubview:_contentLabel];
        
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.equalTo(@0);
            
            make.left.equalTo(self.cycleView.mas_right).offset(ScaleW(15));
//            make.left.equalTo(@(ScaleW(20)));

            make.right.equalTo(@(ScaleW(-30)));
            
        }];
        
    }
    return _contentLabel;
}

-(UIImageView *)imageV
{
    if (_imageV == nil) {
        
        UIImage *image = [UIImage imageNamed:@"root_next"];
        
        _imageV = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"root_next"];
        
        [self.contentView addSubview:_imageV];
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(@(ScaleW(-15)));
            
            make.centerY.equalTo(self.contentView.mas_centerY);
            
            make.height.equalTo(@(ScaleW(image.size.height)));
            
            make.width.equalTo(@(ScaleW(image.size.width)));
            
        }];
    }
    return _imageV;
}

- (UIView *)lineview
{
    if (_lineview == nil) {
        
        _lineview = [FactoryUI createViewWithFrame:CGRectZero Color:kBgColor];
        
        [self.contentView addSubview:_lineview];
        
        [_lineview mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.right.equalTo(@0);
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.height.equalTo(@(ScaleW(1)));
            
            
        }];
    }
    return _lineview;
}

- (void)initDataWithModel:(Home_NoticeIndex_Model *)Model
{
    
    self.contentLabel.text = Model.title;
        
}

@end
