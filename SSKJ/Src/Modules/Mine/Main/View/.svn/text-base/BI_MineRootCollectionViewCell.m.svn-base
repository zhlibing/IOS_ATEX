//
//  BI_MineRootCollectionViewCell.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BI_MineRootCollectionViewCell.h"

@interface BI_MineRootCollectionViewCell ()

@property (nonatomic,strong) UILabel *titleLabel; //!< 标题
@property (nonatomic,strong) UIImageView *iconImageView; //!< 标题


@end

@implementation BI_MineRootCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView setBackgroundColor:kSubBgColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView.layer setBorderWidth:0.5];
        [self.contentView.layer setBorderColor:[[UIColor blackColor] CGColor]];
        
        [self.iconImageView setFrame:CGRectMake((frame.size.width-ScaleW(36))/2.0, (frame.size.width/2.0-ScaleW(36))+10, ScaleW(36), ScaleW(36))];
        [self.titleLabel setFrame:CGRectMake(0, ScaleW(self.iconImageView.bottom+5.0), frame.size.width, ScaleW(30))];
        
        
        [self setItemColor:NO];
    }
    return self;
}





#pragma mark - Public Method
-(void)setItemObject:(Mine_Item_Model*)model
{
    [self.titleLabel setText:SSKJLocalized(model.title, nil)];
    [self.iconImageView setImage:[UIImage imageNamed:model.icon]];
}



#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"标题",nil) textColor:kTitleColor font:systemFont(ScaleW(16.0))];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc]init];
        [_iconImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _iconImageView;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.iconImageView setBackgroundColor:[UIColor redColor]];
        [self.titleLabel setBackgroundColor:[UIColor blueColor]];
    }
}




@end

